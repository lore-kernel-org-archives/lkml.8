Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036C7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D025120775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055545;
	bh=Qb3WFXji45qyPaTvm2PnxhbwUJAHncNwwNgYzamZ68Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FJXn7jrSlAjYLdXzJt+L5O9uunK7ZVBsbAMPmxhxLYnR9VsskltrQPTow4o1sdpEZ
	 y3lCSVZuSjiMHWEP1bjNcsJy9DoG7oxYWbJyPk3Krq2jMtpW5fa6nAAA7LRIao9jxo
	 +WTKAlYc9PxHcGAYp+1LqeLgSGconkQ127e6U7Is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCXNMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbgCXNMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:12:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DBD320775;
        Tue, 24 Mar 2020 13:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055540;
        bh=Qb3WFXji45qyPaTvm2PnxhbwUJAHncNwwNgYzamZ68Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3JI7aDZA9/fJ6s9icGQELPkjepRl8zSi+e6y5+SgG7sjz9gaBZQ2k0IWJjxFHtEj
         dP7mGmlNPZqR2D0pa3wios15nk+ECNUvWOt33A6psW1b3DP2qHxmdzDQOKPak5SVpK
         fk8mqw9JyV3xZlUgeI/vXCXSyX0xSyFMm8Zf5R2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kwon Je Oh <kwonje.oh2@gmail.com>,
        Carlo Nonato <carlo.nonato95@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/65] block, bfq: fix overwrite of bfq_group pointer in bfq_find_set_group()
Date:   Tue, 24 Mar 2020 14:10:39 +0100
Message-Id: <20200324130759.289173084@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlo Nonato <carlo.nonato95@gmail.com>

[ Upstream commit 14afc59361976c0ba39e3a9589c3eaa43ebc7e1d ]

The bfq_find_set_group() function takes as input a blkcg (which represents
a cgroup) and retrieves the corresponding bfq_group, then it updates the
bfq internal group hierarchy (see comments inside the function for why
this is needed) and finally it returns the bfq_group.
In the hierarchy update cycle, the pointer holding the correct bfq_group
that has to be returned is mistakenly used to traverse the hierarchy
bottom to top, meaning that in each iteration it gets overwritten with the
parent of the current group. Since the update cycle stops at root's
children (depth = 2), the overwrite becomes a problem only if the blkcg
describes a cgroup at a hierarchy level deeper than that (depth > 2). In
this case the root's child that happens to be also an ancestor of the
correct bfq_group is returned. The main consequence is that processes
contained in a cgroup at depth greater than 2 are wrongly placed in the
group described above by BFQ.

This commits fixes this problem by using a different bfq_group pointer in
the update cycle in order to avoid the overwrite of the variable holding
the original group reference.

Reported-by: Kwon Je Oh <kwonje.oh2@gmail.com>
Signed-off-by: Carlo Nonato <carlo.nonato95@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-cgroup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fe5952d117d5..ecd3d0ec2f3b6 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -525,12 +525,13 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 	 */
 	entity = &bfqg->entity;
 	for_each_entity(entity) {
-		bfqg = container_of(entity, struct bfq_group, entity);
-		if (bfqg != bfqd->root_group) {
-			parent = bfqg_parent(bfqg);
+		struct bfq_group *curr_bfqg = container_of(entity,
+						struct bfq_group, entity);
+		if (curr_bfqg != bfqd->root_group) {
+			parent = bfqg_parent(curr_bfqg);
 			if (!parent)
 				parent = bfqd->root_group;
-			bfq_group_set_parent(bfqg, parent);
+			bfq_group_set_parent(curr_bfqg, parent);
 		}
 	}
 
-- 
2.20.1



