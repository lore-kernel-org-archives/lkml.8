Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F92FC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A45221734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609906;
	bh=0pEzPoCTeYjThqcKzV2tyUJwmwX8AZJVEuaYRuF5qF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qIX9zpVarhJQo3D4kTh8dkfuDLE/m1mLWKhS9r0HWKcdBvJMcbrxh7Dswqr8YYLDd
	 Cekp+0l/OULy8L0FdAkSC8Ivnf4m3f83Q15W/DJljBm8J/G2iKFWHL3BYSIbbfvUck
	 hz/gy/Muv5X59HwuLL1RizkmCziYp7aVX3muTzrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbgBMQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgBMPXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:54 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30E9424699;
        Thu, 13 Feb 2020 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607434;
        bh=0pEzPoCTeYjThqcKzV2tyUJwmwX8AZJVEuaYRuF5qF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09ZfDz94r7VW/hG0E2PLSj73+euA2ptg81WmDSRAlv8wxSopFlDHlqpuJk8fep2zG
         EWFxu2n/hlyA8WImqE0J6n6j9x5p9bF29yPQ9HF4xkWWXy2v8l/ZKdiuTCo2RINzvm
         qgaMMScuqcmdR8ttsGE5LemEsfkg0H9eJ+mqZ7Uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.9 069/116] nfsd: fix jiffies/time_t mixup in LRU list
Date:   Thu, 13 Feb 2020 07:20:13 -0800
Message-Id: <20200213151909.736323117@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 9594497f2c78993cb66b696122f7c65528ace985 upstream.

The nfsd4_blocked_lock->nbl_time timestamp is recorded in jiffies,
but then compared to a CLOCK_REALTIME timestamp later on, which makes
no sense.

For consistency with the other timestamps, change this to use a time_t.

This is a change in behavior, which may cause regressions, but the
current code is not sensible. On a system with CONFIG_HZ=1000,
the 'time_after((unsigned long)nbl->nbl_time, (unsigned long)cutoff))'
check is false for roughly the first 18 days of uptime and then true
for the next 49 days.

Fixes: 7919d0a27f1e ("nfsd: add a LRU list for blocked locks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4state.c |    2 +-
 fs/nfsd/state.h     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6034,7 +6034,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	}
 
 	if (fl_flags & FL_SLEEP) {
-		nbl->nbl_time = jiffies;
+		nbl->nbl_time = get_seconds();
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
 		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -591,7 +591,7 @@ static inline bool nfsd4_stateid_generat
 struct nfsd4_blocked_lock {
 	struct list_head	nbl_list;
 	struct list_head	nbl_lru;
-	unsigned long		nbl_time;
+	time_t			nbl_time;
 	struct file_lock	nbl_lock;
 	struct knfsd_fh		nbl_fh;
 	struct nfsd4_callback	nbl_cb;


