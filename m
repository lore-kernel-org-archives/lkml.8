Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C232EC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A188E208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738100;
	bh=X+6DQQwxrlMpZOktNA8X8yfgAVfn5DHDR4Qqs3Eg1bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tcR78LSusl+aCzOgVjUQjuFjSiFpysPh80O7qdVI9dOZKV5+ZfUPuhBS3ahozPPLp
	 QaFMuSKZQGfiQQ6q/afLKDjMx6A44VRpe4xfbT0nBrFd7f0D/qaTwc7104zFGtJSMt
	 cK/EAj/mFAzoUs3M+QgcAdBys8LMdVkb17JrlUc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2Hlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:41:40 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40294 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgE2HlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id s88so259110pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EMTldmiu4HpdS3+bhynB06GHRs/PyLwICOClb2SLlV8=;
        b=RnzM3uFMkAqlWZiSMtrYDinXNUr+IS56YDkVXynZVaz10TM3Z5yfHW029v5PrP3j7K
         LlJmFBhTkmPIvyipIXwMTkuw3/iGsCEMZGaS/in4IqZ8JZbETa3TXiYNYZP3pVJ35RWR
         VRbOhWRLgfUn4nkciuWPzbAKl+E6Rniu2xvBx2maCs/6Ew89s5wXM6p+SnGV4EsSjkma
         XqIuu4iUr6VKHkgYP4AlQaKuqaSxl0oiLlgBr8BRCL/H9Ykcce8kfuFB8j4PX52nFhbR
         BSNejf8oasGbt+YOj1OKzj0kxPQV5HJ+L64soAZbOGB6FQneF3zwX3PW+0JoQexfZPOz
         3FLw==
X-Gm-Message-State: AOAM533WCRrXQxu2Elwcu0g+mu29F2zpxOPRuGWDKvdnoOR5sna7vYuU
        /BYOf+NB2+FThteqcMGv7RM=
X-Google-Smtp-Source: ABdhPJw+tLCz0Ai55w1J/TSc/SJ1hmAb/QR0nXrNQObS7m5mw2Mpybr+mAQiJMcxaaq1sxYWrYa58A==
X-Received: by 2002:a17:902:7281:: with SMTP id d1mr7887571pll.78.1590738081442;
        Fri, 29 May 2020 00:41:21 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gd8sm101244pjb.28.2020.05.29.00.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E7F0642380; Fri, 29 May 2020 07:41:10 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        benh@kernel.crashing.org, rdna@fb.com, viro@zeniv.linux.org.uk,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        vbabka@suse.cz, sfr@canb.auug.org.au, jack@suse.cz,
        amir73il@gmail.com, rafael@kernel.org, tytso@mit.edu
Cc:     julia.lawall@lip6.fr, akpm@linux-foundation.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 10/13] eventpoll: simplify sysctl declaration with register_sysctl_subdir()
Date:   Fri, 29 May 2020 07:41:05 +0000
Message-Id: <20200529074108.16928-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200529074108.16928-1-mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

Move epoll_table sysctl to fs/eventpoll.c and remove the
clutter out of kernel/sysctl.c by using register_sysctl_subdir()..

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/eventpoll.c         | 10 +++++++++-
 include/linux/poll.h   |  2 --
 include/linux/sysctl.h |  1 -
 kernel/sysctl.c        |  7 -------
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 12eebcdea9c8..957ebc9700e3 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -299,7 +299,7 @@ static LIST_HEAD(tfile_check_list);
 static long long_zero;
 static long long_max = LONG_MAX;
 
-struct ctl_table epoll_table[] = {
+static struct ctl_table epoll_table[] = {
 	{
 		.procname	= "max_user_watches",
 		.data		= &max_user_watches,
@@ -311,6 +311,13 @@ struct ctl_table epoll_table[] = {
 	},
 	{ }
 };
+
+static void __init epoll_sysctls_init(void)
+{
+	register_sysctl_subdir("fs", "epoll", epoll_table);
+}
+#else
+#define epoll_sysctls_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
 static const struct file_operations eventpoll_fops;
@@ -2422,6 +2429,7 @@ static int __init eventpoll_init(void)
 	/* Allocates slab cache used to allocate "struct eppoll_entry" */
 	pwq_cache = kmem_cache_create("eventpoll_pwq",
 		sizeof(struct eppoll_entry), 0, SLAB_PANIC|SLAB_ACCOUNT, NULL);
+	epoll_sysctls_init();
 
 	return 0;
 }
diff --git a/include/linux/poll.h b/include/linux/poll.h
index 1cdc32b1f1b0..a9e0e1c2d1f2 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -8,12 +8,10 @@
 #include <linux/wait.h>
 #include <linux/string.h>
 #include <linux/fs.h>
-#include <linux/sysctl.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/poll.h>
 #include <uapi/linux/eventpoll.h>
 
-extern struct ctl_table epoll_table[]; /* for sysctl */
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
 #ifdef __clang__
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index aa01f54d0442..e5364b69dd95 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -217,7 +217,6 @@ extern int no_unaligned_warning;
 
 extern struct ctl_table sysctl_mount_point[];
 extern struct ctl_table random_table[];
-extern struct ctl_table epoll_table[];
 
 #else /* CONFIG_SYSCTL */
 static inline struct ctl_table_header *register_sysctl_table(struct ctl_table * table)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e007375c8a11..5c116904feb7 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3001,13 +3001,6 @@ static struct ctl_table fs_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_EPOLL
-	{
-		.procname	= "epoll",
-		.mode		= 0555,
-		.child		= epoll_table,
-	},
-#endif
 #endif
 	{
 		.procname	= "protected_symlinks",
-- 
2.26.2

