Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A11C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96492087F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcXfBBjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgA0KLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:11:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43111 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726743AbgA0KLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580119868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c9UaqAcMbOuX1fIscx2ic00TzOMEBUExJGLWfLI7Q0c=;
        b=GcXfBBjS9rUPD0ucHvwi8sFvG247ywDkxLtiKCLQG91lLUySvnkbmvKDv19d8vJ72TkWvI
        1vpNnwYezc2Gaw826czL9yTO1z+X3IkiJ9BT63CU2+/H4MXK5jXwgXiw2jlyezgnayn0op
        VE9saKObGRfY0qx3Cp5LZoJ7Kqo3XzI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-RyWRgTFWPAitLNDNN21yUw-1; Mon, 27 Jan 2020 05:11:05 -0500
X-MC-Unique: RyWRgTFWPAitLNDNN21yUw-1
Received: by mail-wr1-f70.google.com with SMTP id j13so5822828wrr.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 02:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9UaqAcMbOuX1fIscx2ic00TzOMEBUExJGLWfLI7Q0c=;
        b=JAvkSRfbd8ERq7cz7ZIIpCw/jUIbAwiKMd4atGQx/C2qzo7vM+uKNqy0FDI8Qc5dVM
         eYlH0Zp3AulPsH0EtIyiAaubr5X7LdamLKb9G8ygDa6CfjCui6qfNoDXI8E/bGnu+Wtv
         NQ2NFXeUEG8N1TxzLsUk54wika0tD9VqXHtbu96pOvKe5mihBdlzUve1WSjHtwHGQGgR
         KrQbwEqr1ZuLFFy9M95rIzEeP7L37Zr42UoSCwP9mRHkAm9t10TNmiiNAbAczajdZTa4
         MIBCirTda4lD5ttIPb/Yd4qCsdDV2E0F/jsvXkfydoqXYW8NSx740Z9ySKwB9WjL7Kvy
         WWmA==
X-Gm-Message-State: APjAAAXAhRaQOEYzj2xUKtjHKpxVvYIRsYw1sRktEJrN9Q0jysAhx/Rn
        EUzIpgxpPyaIAHnyCF+QcdSbKRqMoMdCJHlzkyJRgHO6kEmSRyxwSy1aZzOtE2YtdLCBFBLxXOA
        T0Btvage+ssIKwziv0biRZj3r
X-Received: by 2002:a5d:6390:: with SMTP id p16mr21640821wru.170.1580119863378;
        Mon, 27 Jan 2020 02:11:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRFDgX75y1Oys657k+F9y3i7KtXY+JRn/oj1oaSQ5mKVpI3zaXERF8eL4tQtDCAb8XlqRYiw==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr21640760wru.170.1580119863068;
        Mon, 27 Jan 2020 02:11:03 -0800 (PST)
Received: from dhcp-1-195.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.googlemail.com with ESMTPSA id o1sm19961256wrn.84.2020.01.27.02.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:11:02 -0800 (PST)
From:   Grzegorz Halat <ghalat@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, ghalat@redhat.com, ssaner@redhat.com,
        atomlin@redhat.com, oleksandr@redhat.com, vbendel@redhat.com,
        kirill@shutemov.name, khlebnikov@yandex-team.ru,
        borntraeger@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/1] mm: sysctl: add panic_on_mm_error sysctl
Date:   Mon, 27 Jan 2020 11:11:00 +0100
Message-Id: <20200127101100.92588-1-ghalat@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory management subsystem performs various checks at runtime,
if an inconsistency is detected then such event is being logged and kernel
continues to run. While debugging such problems it is helpful to collect
memory dump as early as possible. Currently, there is no easy way to panic
kernel when such error is detected.

It was proposed[1] to panic the kernel if panic_on_oops is set but this
approach was not accepted. One of alternative proposals was introduction of
a new sysctl.

The patch adds panic_on_mm_error sysctl. If the sysctl is set then the
kernel will be crashed when an inconsistency is detected by memory
management. This currently means panic when bad page or bad PTE
is detected(this may be extended to other places in MM).

Another use case of this sysctl may be in security-wise environments,
it may be more desired to crash machine than continue to run with
potentially damaged data structures.

[1] https://marc.info/?l=linux-mm&m=142649500728327&w=2

Signed-off-by: Grzegorz Halat <ghalat@redhat.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++++++++
 include/linux/kernel.h                      |  1 +
 kernel/sysctl.c                             |  9 +++++++++
 mm/memory.c                                 |  7 +++++++
 mm/page_alloc.c                             |  4 +++-
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index def074807cee..2fecd6b2547e 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -61,6 +61,7 @@ show up in /proc/sys/kernel:
 - overflowgid
 - overflowuid
 - panic
+- panic_on_mm_error
 - panic_on_oops
 - panic_on_stackoverflow
 - panic_on_unrecovered_nmi
@@ -611,6 +612,17 @@ an IO error.
    and you can use this option to take a crash dump.
 
 
+panic_on_mm_error:
+==============
+
+Controls the kernel's behaviour when inconsistency is detected
+by memory management code, for example bad page state or bad PTE.
+
+0: try to continue operation.
+
+1: panic immediately.
+
+
 panic_on_oops:
 ==============
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0d9db2a14f44..5f9d408512ff 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -518,6 +518,7 @@ extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
+extern int panic_on_mm_error;
 extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
 extern int panic_on_warn;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 70665934d53e..6477e1cce28b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1238,6 +1238,15 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "panic_on_mm_error",
+		.data		= &panic_on_mm_error,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	{
 		.procname	= "timer_migration",
diff --git a/mm/memory.c b/mm/memory.c
index 45442d9a4f52..cce74ff39447 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -71,6 +71,7 @@
 #include <linux/dax.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/module.h>
 
 #include <trace/events/kmem.h>
 
@@ -88,6 +89,8 @@
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
 #endif
 
+int panic_on_mm_error __read_mostly;
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 /* use the per-pgdat data instead for discontigmem - mbligh */
 unsigned long max_mapnr;
@@ -543,6 +546,10 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
 		 mapping ? mapping->a_ops->readpage : NULL);
+
+	print_modules();
+	if (panic_on_mm_error)
+		panic("Bad page map detected");
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d047bf7d8fd4..2ea6a65ba011 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -643,9 +643,11 @@ static void bad_page(struct page *page, const char *reason,
 	if (bad_flags)
 		pr_alert("bad because of flags: %#lx(%pGp)\n",
 						bad_flags, &bad_flags);
-	dump_page_owner(page);
 
+	dump_page_owner(page);
 	print_modules();
+	if (panic_on_mm_error)
+		panic("Bad page state detected");
 	dump_stack();
 out:
 	/* Leave bad fields for debug, except PageBuddy could make trouble */
-- 
2.21.1

