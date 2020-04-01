Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF36C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ABB2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759432;
	bh=GToXniXT+TcobdymTSjFYMLoF1tRlgZ/NIKKH8vjf6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mo3tM/ES8dq725fqxXft5CBK2NeMS1jX4H9MpwuUI+jlQZbjBfDW0pYSGlP1awIFa
	 fm5nmC//ZV6ROGKaZ8WvRCjbIiraIrvzwR2nljEarp8+pcHZZLqKbzUYiXwmtgx/w1
	 SbkTQnBG1oL3qU6ciVq8CrllTGD/mcp66dCWV6fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbgDAQnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732793AbgDAQnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:43:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E3732063A;
        Wed,  1 Apr 2020 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759429;
        bh=GToXniXT+TcobdymTSjFYMLoF1tRlgZ/NIKKH8vjf6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1muohoGadTXyeSADhBPRKxPcrC1PPFoGASneYb6ZUKNvjORL+lKh71EAB4MnoCla
         z/gQRhLIZqN4/AdfCE1AX4btJrvLsYcMn0a23o7a5+PKEAVvvJeQT7yUJZ1/IUuCG/
         M/fv8skUvb/zANp7RiIgIdVnxat5RMi2qEW4Bucw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 074/148] cgroup-v1: cgroup_pidlist_next should update position index
Date:   Wed,  1 Apr 2020 18:17:46 +0200
Message-Id: <20200401161600.483221116@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit db8dd9697238be70a6b4f9d0284cd89f59c0e070 ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

 # mount | grep cgroup
 # dd if=/mnt/cgroup.procs bs=1  # normal output
...
1294
1295
1296
1304
1382
584+0 records in
584+0 records out
584 bytes copied

dd: /mnt/cgroup.procs: cannot skip to specified offset
83  <<< generates end of last line
1383  <<< ... and whole last line once again
0+1 records in
0+1 records out
8 bytes copied

dd: /mnt/cgroup.procs: cannot skip to specified offset
1386  <<< generates last line anyway
0+1 records in
0+1 records out
5 bytes copied

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a2c05d2476ac5..d148965180893 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -501,6 +501,7 @@ static void *cgroup_pidlist_next(struct seq_file *s, void *v, loff_t *pos)
 	 */
 	p++;
 	if (p >= end) {
+		(*pos)++;
 		return NULL;
 	} else {
 		*pos = *p;
-- 
2.20.1



