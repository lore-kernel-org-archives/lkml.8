Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230C1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034232068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590505144;
	bh=dZeLXoUBQtKDHLLwUZOY5erPD//Mcj+l4J+EmoZeztE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6Lx2wSCgEpULuzmIXkpm803GzalG+s0TIrr5m1eRDOOElyjZLkqRfKuydDdyJOx6
	 Z2w2okUnhLD1hdhnx31uYa/8POgBUmJIAMv3Cw2MhRZJUuxRuL4kMxh0GL9jWjjUhZ
	 tCdXgi329P2PO0bvtMMMap1E2bIAksTX+Aw8T1M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgEZO7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:59:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35705 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgEZO60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:58:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id n18so10287302pfa.2;
        Tue, 26 May 2020 07:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXRYeaDc02XdMrQZXPWL4bjUJlIpwN0dvTWzE8/MMVk=;
        b=ebUzDq04TLB6YRPKA5vxkAHPSzIbrz0qtegTHzbwLilDT/7T+ZHLXyuh/AQik3zkHj
         r4BFLWOy9nOaRGeSqivwfrE4CnwXe9ptyECl2YYoMc1vnIv6gU+yMyrGch+le8X0zAWf
         kCtg2o2OnaFUXFllg4ZxUP5nrniwaQcuNN+eUmKk0axYHuTSlTvWsuGYL5EgDyUrg3Hp
         BHbLmuZTsmMdD1ln2BCUQnvw+h+7VZBgh59Dxrr/1JcWqOzwA75g1qcqb1/ZeBrzRm+P
         XDReQvuT9CklWbuG8fDuPPiorqqzP90Uhl5zKVS20YbaNMghnM1EAel0aRv62AFJzKJb
         OX5A==
X-Gm-Message-State: AOAM5312GB5WZwDvA5cXxGJ8uOEZgYDtEvzKFwSxrFHuLgtmazc6+624
        IWZA9JwxfLiWZ1lvEmfpL46k83DvMEpJYw==
X-Google-Smtp-Source: ABdhPJxBAlF1xJ1w59CSnXxL2XBmkLpEHhZLXaYmbdgLSEehHHgbirJog0XFXMNI5RxzlfyWBEXMqQ==
X-Received: by 2002:a63:cf03:: with SMTP id j3mr1447611pgg.24.1590505104761;
        Tue, 26 May 2020 07:58:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d2sm26656pgp.56.2020.05.26.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:58:22 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6982C41D12; Tue, 26 May 2020 14:58:18 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     michael.chan@broadcom.com, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com, aelior@marvell.com,
        GR-everest-linux-l2@marvell.com, kvalo@codeaurora.org,
        johannes@sipsolutions.net, akpm@linux-foundation.org,
        arnd@arndb.de, rostedt@goodmis.org, mingo@redhat.com,
        aquini@redhat.com, cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, derosier@gmail.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, vkoul@kernel.org,
        mchehab+huawei@kernel.org, robh@kernel.org, mhiramat@kernel.org,
        sfr@canb.auug.org.au, linux@dominikbrodowski.net,
        glider@google.com, paulmck@kernel.org, elver@google.com,
        bauerman@linux.ibm.com, yamada.masahiro@socionext.com,
        samitolvanen@google.com, yzaikin@google.com, dvyukov@google.com,
        rdunlap@infradead.org, corbet@lwn.net, dianders@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 4/8] panic: make taint data type clearer
Date:   Tue, 26 May 2020 14:58:11 +0000
Message-Id: <20200526145815.6415-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200526145815.6415-1-mcgrof@kernel.org>
References: <20200526145815.6415-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let us be clearer about the the data type for the taint flag.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/asm-generic/bug.h | 4 ++--
 include/linux/kernel.h    | 4 ++--
 kernel/panic.c            | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index c94e33ae3e7b..87dbe57301f4 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -80,7 +80,7 @@ struct bug_entry {
  */
 #ifndef __WARN_FLAGS
 extern __printf(4, 5)
-void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
+void warn_slowpath_fmt(const char *file, const int line, unsigned int taint,
 		       const char *fmt, ...);
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...) do {				\
@@ -110,7 +110,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 struct warn_args;
 struct pt_regs;
 
-void __warn(const char *file, int line, void *caller, unsigned taint,
+void __warn(const char *file, int line, void *caller, unsigned int taint,
 	    struct pt_regs *regs, struct warn_args *args);
 
 #ifndef WARN_ON
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index a1974907c320..d154844eb9cd 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -563,8 +563,8 @@ enum lockdep_ok {
 	LOCKDEP_STILL_OK,
 	LOCKDEP_NOW_UNRELIABLE
 };
-extern void add_taint(unsigned flag, enum lockdep_ok);
-extern int test_taint(unsigned flag);
+extern void add_taint(unsigned int flag, enum lockdep_ok);
+extern int test_taint(unsigned int flag);
 extern unsigned long get_taint(void);
 extern int root_mountflags;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index cb1c5619e983..3cfe84318ecf 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -421,7 +421,7 @@ const char *print_tainted(void)
 	return buf;
 }
 
-int test_taint(unsigned flag)
+int test_taint(unsigned int flag)
 {
 	return test_bit(flag, &tainted_mask);
 }
@@ -440,7 +440,7 @@ unsigned long get_taint(void)
  * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
  * some notewortht-but-not-corrupting cases, it can be set to true.
  */
-void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
+void add_taint(unsigned int flag, enum lockdep_ok lockdep_ok)
 {
 	if (lockdep_ok == LOCKDEP_NOW_UNRELIABLE && __debug_locks_off()) {
 		pr_warn("Disabling lock debugging due to kernel taint\n");
@@ -579,7 +579,7 @@ struct warn_args {
 	va_list args;
 };
 
-void __warn(const char *file, int line, void *caller, unsigned taint,
+void __warn(const char *file, int line, void *caller, unsigned int taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
 	disable_trace_on_warning();
@@ -622,7 +622,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 }
 
 #ifndef __WARN_FLAGS
-void warn_slowpath_fmt(const char *file, int line, unsigned taint,
+void warn_slowpath_fmt(const char *file, int line, unsigned int taint,
 		       const char *fmt, ...)
 {
 	struct warn_args args;
-- 
2.26.2

