Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774BEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1A520FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5F1Ank+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/AinGAow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgG2Oe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:34:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgG2Odf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:35 -0400
Date:   Wed, 29 Jul 2020 14:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033211;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCrbashZS+HSCZHxD5G64f7BndOsUUOX8ViWnkPDyUI=;
        b=Y5F1Ank+E8LbKcS3r21WtRsht67bkw0t/h/DkKGExUfV6VjjIpzbIRP/GIUDb86a9G2sBT
        Umek9bMh4D+6/Yg9iK+avfJSb0pV33Oi+vyoKn7E8TJdJL215aR9NWd2pKUt1IoZvNgtYD
        h6XdiFFOFVXSDJAIDgjDwB74GQvuMyM2l1FMTOJZRRGY+JQ7IqNmCGPDays/17sUf5Y4pE
        5dv7VdbTw2/r6xe0DYNYei0L1QkY1Y/Rl1zM0Zc9SEmjkYNGfp0L3gg+iIhvOlaKNIsH0l
        NkSghKgV7jhxvYBpfgwYwjqbSpaHS35BxNhzC+OC65430nllgEQOSd2pNRoSPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033211;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCrbashZS+HSCZHxD5G64f7BndOsUUOX8ViWnkPDyUI=;
        b=/AinGAowmcOgHYsCca0GyA/fD2M4uC+EKwvsbj+tOHVE/ct5iZQLND13gSk92z9bsCE7mi
        aE4rDvPivgtodBCA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] vfs: Use sequence counter with associated spinlock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-19-a.darwish@linutronix.de>
References: <20200720155530.1173732-19-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321115.4006.2959071495422039396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     26475371976c69489d3a8e6c8bbf35afbbc25055
Gitweb:        https://git.kernel.org/tip/26475371976c69489d3a8e6c8bbf35afbbc25055
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:27 +02:00

vfs: Use sequence counter with associated spinlock

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-19-a.darwish@linutronix.de
---
 fs/dcache.c               | 2 +-
 fs/fs_struct.c            | 4 ++--
 include/linux/dcache.h    | 2 +-
 include/linux/fs_struct.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 361ea7a..ea04858 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1746,7 +1746,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	dentry->d_lockref.count = 1;
 	dentry->d_flags = 0;
 	spin_lock_init(&dentry->d_lock);
-	seqcount_init(&dentry->d_seq);
+	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
 	dentry->d_inode = NULL;
 	dentry->d_parent = dentry;
 	dentry->d_sb = sb;
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index ca639ed..04b3f5b 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -117,7 +117,7 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 		fs->users = 1;
 		fs->in_exec = 0;
 		spin_lock_init(&fs->lock);
-		seqcount_init(&fs->seq);
+		seqcount_spinlock_init(&fs->seq, &fs->lock);
 		fs->umask = old->umask;
 
 		spin_lock(&old->lock);
@@ -163,6 +163,6 @@ EXPORT_SYMBOL(current_umask);
 struct fs_struct init_fs = {
 	.users		= 1,
 	.lock		= __SPIN_LOCK_UNLOCKED(init_fs.lock),
-	.seq		= SEQCNT_ZERO(init_fs.seq),
+	.seq		= SEQCNT_SPINLOCK_ZERO(init_fs.seq, &init_fs.lock),
 	.umask		= 0022,
 };
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index a81f0c3..65d975b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -89,7 +89,7 @@ extern struct dentry_stat_t dentry_stat;
 struct dentry {
 	/* RCU lookup touched fields */
 	unsigned int d_flags;		/* protected by d_lock */
-	seqcount_t d_seq;		/* per dentry seqlock */
+	seqcount_spinlock_t d_seq;	/* per dentry seqlock */
 	struct hlist_bl_node d_hash;	/* lookup hash list */
 	struct dentry *d_parent;	/* parent directory */
 	struct qstr d_name;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index cf1015a..783b48d 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -9,7 +9,7 @@
 struct fs_struct {
 	int users;
 	spinlock_t lock;
-	seqcount_t seq;
+	seqcount_spinlock_t seq;
 	int umask;
 	int in_exec;
 	struct path root, pwd;
