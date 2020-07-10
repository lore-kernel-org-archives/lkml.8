Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F15DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5DB72078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="M4g7tke+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgGJH4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgGJH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:56:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E352CC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:56:40 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d21so2684080lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXcbxwgnNdN6AgFOPfHDAbPj/lmoR2tjjqmqpya8o/k=;
        b=M4g7tke+QMNS6x69qNRAFRRs2OoINGT4rqJVDko7GDKiHHusV9GiXnYqVIxiQp51x2
         M/fXV8G16zmHM57h6KEORDkR8Iis4QYoObo7XjmhehmLjOI+InV7Eig/X/axf2d6m/DN
         BgAyP9luxsKIJPW9ZEa9RkDRgeqdwe2IeW0yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXcbxwgnNdN6AgFOPfHDAbPj/lmoR2tjjqmqpya8o/k=;
        b=LDZw/UsH3+5TLVZY9ItstKqNt2wmV/euMhBSnbSOm53Z7zvbbYNCIICiyNuhf0yWZX
         Pv1gLJ61Biel/lXGw2wjVirVevoXLlmkvj96yNxZG6LcNkHOk6AhYMtvDzzphjDZ+8Hm
         YNWV9KOG90ZfThx6sFHawTDJHBRRYbex7eT6NFWBEVGImvITDCRlnxlt0SyyANweIb9M
         CD8ByR3vLj6fveYR/tTi4Nt3G0uNTmQIJdQFJNyu/WdnusdHuHR5d78mxNeKvNKfS/qU
         IjdjCGB8EnPQ8Hie/11z603l+SPTpMfL2XqS2Qe4bbrSFy8miZf1rUgoMf5y+h4dzyQH
         dpMg==
X-Gm-Message-State: AOAM532zZWlUpNVtLe+r6tHbukeDKeJUBM0N6XXt/CLrOXOeXPh0/VlH
        7HfGLNKwr7Adcg0RSgmkeZ4VUA==
X-Google-Smtp-Source: ABdhPJwLXd9N89jj8OkZWkL9WrDn9m+IDjaPdKXVOLaUH/xRC7rpgvaiSvc5ePtH3hMM3iAG0b0UgQ==
X-Received: by 2002:a19:8307:: with SMTP id f7mr42333880lfd.174.1594367799309;
        Fri, 10 Jul 2020 00:56:39 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f18sm1634609ljn.73.2020.07.10.00.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 00:56:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kcmp: add separate Kconfig symbol for kcmp syscall
Date:   Fri, 10 Jul 2020 09:56:31 +0200
Message-Id: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ability to check open file descriptions for equality (without
resorting to unreliable fstat() and fcntl(F_GETFL) comparisons) can be
useful outside of the checkpoint/restore use case - for example,
systemd uses kcmp() to deduplicate the per-service file descriptor
store.

Make it possible to have the kcmp() syscall without the full
CONFIG_CHECKPOINT_RESTORE.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
I deliberately drop the ifdef in the eventpoll.h header rather than
replace with KCMP_SYSCALL; it's harmless to declare a function that
isn't defined anywhere.

 fs/eventpoll.c            |  4 ++--
 include/linux/eventpoll.h |  2 --
 init/Kconfig              | 11 +++++++++++
 kernel/Makefile           |  2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 12eebcdea9c8..b0313ce2df73 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1064,7 +1064,7 @@ static struct epitem *ep_find(struct eventpoll *ep, struct file *file, int fd)
 	return epir;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
+#ifdef CONFIG_KCMP_SYSCALL
 static struct epitem *ep_find_tfd(struct eventpoll *ep, int tfd, unsigned long toff)
 {
 	struct rb_node *rbp;
@@ -1106,7 +1106,7 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
 
 	return file_raw;
 }
-#endif /* CONFIG_CHECKPOINT_RESTORE */
+#endif /* CONFIG_KCMP_SYSCALL */
 
 /**
  * Adds a new entry to the tail of the list in a lockless way, i.e.
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 8f000fada5a4..aa799295e373 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -18,9 +18,7 @@ struct file;
 
 #ifdef CONFIG_EPOLL
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
 struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long toff);
-#endif
 
 /* Used to initialize the epoll bits inside the "struct file" */
 static inline void eventpoll_init_file(struct file *file)
diff --git a/init/Kconfig b/init/Kconfig
index 0498af567f70..95e9486d4217 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1158,9 +1158,20 @@ config NET_NS
 
 endif # NAMESPACES
 
+config KCMP_SYSCALL
+	bool "kcmp system call"
+	help
+	  Enable the kcmp system call, which allows one to determine
+	  whether to tasks share various kernel resources, for example
+	  whether they share address space, or if two file descriptors
+	  refer to the same open file description.
+
+	  If unsure, say N.
+
 config CHECKPOINT_RESTORE
 	bool "Checkpoint/restore support"
 	select PROC_CHILDREN
+	select KCMP_SYSCALL
 	default n
 	help
 	  Enables additional kernel features in a sake of checkpoint/restore.
diff --git a/kernel/Makefile b/kernel/Makefile
index f3218bc5ec69..3daedba2146a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -49,7 +49,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 
-obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
+obj-$(CONFIG_KCMP_SYSCALL) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
 obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-- 
2.23.0

