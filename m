Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E90FC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C59206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1TCrN7a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y78QWRZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgGTP5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731582AbgGTP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0330C061794;
        Mon, 20 Jul 2020 08:56:59 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uclKhm3C3HWRsWu3kv+xtaxPcHBGBDKRm9M/IiUD/fg=;
        b=v1TCrN7a6i4F79ocfMgeLLNWWn5H2ouDIUUyWyMVYnZYY8GvS7F7f7uGgAa5V45kS4yeUl
        /a48BhDUtDvVOM6456JHge7Lw3Db6HZhoCmFtYeQv9g/wrRV187NQngN35/XP2K/MM2Y66
        2Nml72hcndYDeyoTlkuus1LtzqFMLq5wws6zOfXIKauMSYyV1b9R0shDW9+zwD59UcSLiR
        oyGqWgPPC6V7igT8Z5uvGdzuGeffdJkaNSBWdfyt0j3lSHDDUJJ42KJ4WFxVRRo0XwYEyC
        t0GJA7Mf1R1eQ3/yQIJrQ8CkQmKO484A1SYlxQW5rdvTzP6PB87jrTBfMiFs7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uclKhm3C3HWRsWu3kv+xtaxPcHBGBDKRm9M/IiUD/fg=;
        b=Y78QWRZnhKYxklESsDYd76ZuXXIFBDKATthEsq0dxV74+o0RZ2QM1RmkzhmTKDHyzIhzGJ
        s1kapUUFht/uFMBw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 18/24] vfs: Use sequence counter with associated spinlock
Date:   Mon, 20 Jul 2020 17:55:24 +0200
Message-Id: <20200720155530.1173732-19-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 fs/dcache.c               | 2 +-
 fs/fs_struct.c            | 4 ++--
 include/linux/dcache.h    | 2 +-
 include/linux/fs_struct.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 361ea7ab30ea..ea0485861d93 100644
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
index ca639ed967b7..04b3f5b9c629 100644
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
index a81f0c3cf352..65d975bf9390 100644
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
index cf1015abfbf2..783b48dedb72 100644
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
-- 
2.20.1

