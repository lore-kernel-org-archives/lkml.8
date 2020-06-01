Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D19C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D60B207D0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034884;
	bh=UhDtEsXZBfYTv8NOSw/TS1Z9nSFflnCIyoBgaZZekUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NP/ViZYHyH8dk3kBUwFlrm7fEiGvWnsiBWcT15yksSl0IN36yGhpwPJTxE1H0IuIe
	 SugEM1G/g5d+L3siWbnNUjQDRkB069lI/asgj/5VxAy7tqNWqm74TBXR9IksS5lKKj
	 VyPF4AWFZY+JAlxzKe5UFkNALPEJ9GIgQi8pWBR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgFASID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbgFASHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:07:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC49520872;
        Mon,  1 Jun 2020 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034854;
        bh=UhDtEsXZBfYTv8NOSw/TS1Z9nSFflnCIyoBgaZZekUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trKx6/5xoBeQPMDoAie3gwPlS9lDmvDDt4TbHE5/cEShAx9noYvmfMgtpygmxOU02
         eCjv3diNk0C/EEvj5DzbGB+gT3idFUe68zDoyHBPvwRaJF9nXqBPu69RI+IWhzKgX8
         i6eCeA5MIOjXlntmW+bXkx6yhiqlHI428+Y2kurs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 042/142] gfs2: dont call quota_unhold if quotas are not locked
Date:   Mon,  1 Jun 2020 19:53:20 +0200
Message-Id: <20200601174042.295739367@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit c9cb9e381985bbbe8acd2695bbe6bd24bf06b81c ]

Before this patch, function gfs2_quota_unlock checked if quotas are
turned off, and if so, it branched to label out, which called
gfs2_quota_unhold. With the new system of gfs2_qa_get and put, we
no longer want to call gfs2_quota_unhold or we won't balance our
gets and puts.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/quota.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index cbee745169b8..91ca4920bf03 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1113,7 +1113,7 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 	int found;
 
 	if (!test_and_clear_bit(GIF_QD_LOCKED, &ip->i_flags))
-		goto out;
+		return;
 
 	for (x = 0; x < ip->i_qadata->qa_qd_num; x++) {
 		struct gfs2_quota_data *qd;
@@ -1150,7 +1150,6 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 			qd_unlock(qda[x]);
 	}
 
-out:
 	gfs2_quota_unhold(ip);
 }
 
-- 
2.25.1



