Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31D3C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32852080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338480;
	bh=bHaMhX1tvxA/60def+nunnvadde+KFgA86uUNS53eCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0hF0otLXcp7QFWD2gCUCUI8NvCI9MsZO8IMVOmDOJyTZ2Qz0srBgF5NUoe+eRPqVz
	 cJWYP6i5c5kTam5w8YBFeq3cHnpBEGlmhHtx6OlCy9+GgQF5DyuD9sr8NyI8V9ppFb
	 krjl3kfY+azXD0lvTGwnzwD/KUpwI5UpC4v99hZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgBJMlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgBJMin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1418020733;
        Mon, 10 Feb 2020 12:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338322;
        bh=bHaMhX1tvxA/60def+nunnvadde+KFgA86uUNS53eCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3a0dz10x7MQw0Op2XXBn0eK6vQnOkv5hqgkfLtTxiFG5qbrDWYvo7zPibuIftAX6
         bNgtQj+/9MtwaHff1+QS1VYaIY0mnyJlu+qwILQs4h+O6i/eM6oEVHY86JejhQMMeD
         /tXgi6gggCKZRv0qYaqem2l8dhmSHY8CxVumXrsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.4 254/309] nfsd: fix jiffies/time_t mixup in LRU list
Date:   Mon, 10 Feb 2020 04:33:30 -0800
Message-Id: <20200210122430.960560410@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
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
@@ -6550,7 +6550,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	}
 
 	if (fl_flags & FL_SLEEP) {
-		nbl->nbl_time = jiffies;
+		nbl->nbl_time = get_seconds();
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
 		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -605,7 +605,7 @@ static inline bool nfsd4_stateid_generat
 struct nfsd4_blocked_lock {
 	struct list_head	nbl_list;
 	struct list_head	nbl_lru;
-	unsigned long		nbl_time;
+	time_t			nbl_time;
 	struct file_lock	nbl_lock;
 	struct knfsd_fh		nbl_fh;
 	struct nfsd4_callback	nbl_cb;


