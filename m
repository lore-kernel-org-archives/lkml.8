Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AC3C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EEC20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgCXJRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44145 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgCXJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgR-0008KE-9r; Tue, 24 Mar 2020 10:17:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 34C691C0805;
        Tue, 24 Mar 2020 10:16:57 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:56 -0000
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] nfs: Fix nfs_access_get_cached_rcu() sparse error
Cc:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141683.28353.10903354125274508416.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9f01eb5d4936f12d57da84cdfbc2a3623e23a7eb
Gitweb:        https://git.kernel.org/tip/9f01eb5d4936f12d57da84cdfbc2a3623e23a7eb
Author:        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
AuthorDate:    Tue, 10 Dec 2019 11:16:39 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:21 -08:00

nfs: Fix nfs_access_get_cached_rcu() sparse error

This patch fixes the following sparse error:
fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
fs/nfs/dir.c:2353:14:    struct list_head *

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1320288..55a29b0 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2383,7 +2383,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	rcu_read_lock();
 	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
 		goto out;
-	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
+	lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
 	cache = list_entry(lh, struct nfs_access_entry, lru);
 	if (lh == &nfsi->access_cache_entry_lru ||
 	    cred_fscmp(cred, cache->cred) != 0)
