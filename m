Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7826C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB216206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooDjGoJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHGHnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:43:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA6BC061574;
        Fri,  7 Aug 2020 00:43:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p25so963207qkp.2;
        Fri, 07 Aug 2020 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DS659TpjF1aXjYwKa2Fv13Xo5TR0g/N9nXHw5zWBL0g=;
        b=ooDjGoJL2L+bPxFixL6sb6lDnPHljW9OLmAzV9LGBQePaqMorseL0xCqh1afho6NCO
         g5shzHvb8NHPcaB4zQAQJ6IomvGzRA1INrWGXxZRlOgouKknZIEEotOspp+cJ5ULTZng
         IrPYa5aBQ83f3TrSs8J82WP3fvnbz30rr6xi5ekBYXtdce2qP5zFgtSZqBp0CXA4pVdG
         ByRxL01ymQP/noAo+jeQFjhZgQYouwxPu60lWTG5MQRUZZip5BlhX8N+ZjfTiNzk8apo
         9drhs6rs/X8+NeXAvdZD9oaqfjPT5thUP7StSJhqUeafUOquhe5TJ4nqyGXQYAwzbStV
         J+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DS659TpjF1aXjYwKa2Fv13Xo5TR0g/N9nXHw5zWBL0g=;
        b=Xek6uO/IfDb6414Ne/kd35joTHMqcnzU4Xy2+ywSr2QKWBWr38O2zghKG8TFXh4ft7
         DPYxzGWRkPwKWYIHVeV8ABvZ5WnIWqkFk1YmoaQSAdas8sCek2pUxFDIwNROoQ5RsEYs
         zow49FUXZyO9frrFKlmYbDgQT+2mvmczkMUw49G3EnfDu/wUM9Zs/9qv9ecb2fqxEd8U
         4OOd1HlYeqd2HevYR4KvL9yrhSLz/aphfnr4sWZoT92enEX/VTV7mvDa045jsbpvJSJX
         kZLilK+dbNWrFG0roWoEoelE2NQsQIQKdG3BUhf35tQ3OUUEW/e7oB66lPEf2rV6yce8
         +gBQ==
X-Gm-Message-State: AOAM533g8WZAbT8N8oq8i4G5fDPYUSkiAaJN0jZlkxyQId9BAv71gyUe
        PjK0GwZDvh8xvh4L4fcjtL0=
X-Google-Smtp-Source: ABdhPJzXSohPXQ1TUZwWi/Z4zGvQBVCizLeV7T4Q27Dfs2vZv4pZmHp61cjAKEkB+/H+TcQKgednMg==
X-Received: by 2002:a05:620a:22e8:: with SMTP id p8mr12754396qki.491.1596786186454;
        Fri, 07 Aug 2020 00:43:06 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c22sm6207883qke.2.2020.08.07.00.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:43:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8923827C0054;
        Fri,  7 Aug 2020 03:43:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:43:05 -0400
X-ME-Sender: <xms:CQYtX8vmroraAZVaC-y19iZ2PX9sckMjPaoTMH9X7QtjcHXzybw5eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:CQYtX5fC7ETiE637bL0isEGuRuSYLsWCUSFVbF8IozRQofjaVeoc8Q>
    <xmx:CQYtX3zcNlx92AHLRa25MbGSzNhbb3VjIiM68jV8jXfYf0NSrEImLw>
    <xmx:CQYtX_O0ppx9scz0gD_Wszz9-XAp1gMv_SzC6Df5ec-W1PsRpuqLZQ>
    <xmx:CQYtXwZjx2xnr5vERuswxyye6byt1aAPllnix7EK_zo7qZfGg8vCig>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C3D930600A3;
        Fri,  7 Aug 2020 03:43:04 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 01/19] locking: More accurate annotations for read_lock()
Date:   Fri,  7 Aug 2020 15:42:20 +0800
Message-Id: <20200807074238.1632519-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
read lock, actually it's only recursive if in_interrupt() is true. So
change the annotation accordingly to catch more deadlocks.

Note we used to treat read_lock() as pure recursive read locks in
lib/locking-seftest.c, and this is useful, especially for the lockdep
development selftest, so we keep this via a variable to force switching
lock annotation for read_lock().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  | 23 ++++++++++++++++++++++-
 kernel/locking/lockdep.c | 14 ++++++++++++++
 lib/locking-selftest.c   | 11 +++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 8fce5c98a4b0..6b7cb390f19f 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -640,6 +640,20 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 }
 #endif
 
+/* Variable used to make lockdep treat read_lock() as recursive in selftests */
+#ifdef CONFIG_DEBUG_LOCKING_API_SELFTESTS
+extern unsigned int force_read_lock_recursive;
+#else /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
+#define force_read_lock_recursive 0
+#endif /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
+
+#ifdef CONFIG_LOCKDEP
+extern bool read_lock_is_recursive(void);
+#else /* CONFIG_LOCKDEP */
+/* If !LOCKDEP, the value is meaningless */
+#define read_lock_is_recursive() 0
+#endif
+
 /*
  * For trivial one-depth nesting of a lock-class, the following
  * global define can be used. (Subsystems with multiple levels
@@ -661,7 +675,14 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 #define spin_release(l, i)			lock_release(l, i)
 
 #define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define rwlock_acquire_read(l, s, t, i)		lock_acquire_shared_recursive(l, s, t, NULL, i)
+#define rwlock_acquire_read(l, s, t, i)					\
+do {									\
+	if (read_lock_is_recursive())					\
+		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
+	else								\
+		lock_acquire_shared(l, s, t, NULL, i);			\
+} while (0)
+
 #define rwlock_release(l, i)			lock_release(l, i)
 
 #define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 29a8de4c50b9..fbcbb6350ce7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4921,6 +4921,20 @@ static bool lockdep_nmi(void)
 	return true;
 }
 
+/*
+ * read_lock() is recursive if:
+ * 1. We force lockdep think this way in selftests or
+ * 2. The implementation is not queued read/write lock or
+ * 3. The locker is at an in_interrupt() context.
+ */
+bool read_lock_is_recursive(void)
+{
+	return force_read_lock_recursive ||
+	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
+	       in_interrupt();
+}
+EXPORT_SYMBOL_GPL(read_lock_is_recursive);
+
 /*
  * We are not always called with irqs disabled - do that here,
  * and also avoid lockdep recursion:
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 14f44f59e733..caadc4dd3368 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -28,6 +28,7 @@
  * Change this to 1 if you want to see the failure printouts:
  */
 static unsigned int debug_locks_verbose;
+unsigned int force_read_lock_recursive;
 
 static DEFINE_WD_CLASS(ww_lockdep);
 
@@ -1978,6 +1979,11 @@ void locking_selftest(void)
 		return;
 	}
 
+	/*
+	 * treats read_lock() as recursive read locks for testing purpose
+	 */
+	force_read_lock_recursive = 1;
+
 	/*
 	 * Run the testsuite:
 	 */
@@ -2073,6 +2079,11 @@ void locking_selftest(void)
 
 	ww_tests();
 
+	force_read_lock_recursive = 0;
+	/*
+	 * queued_read_lock() specific test cases can be put here
+	 */
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
-- 
2.28.0

