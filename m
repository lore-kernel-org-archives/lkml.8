Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC452C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8024E206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hl/hVPBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgA2SKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:10:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37712 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726245AbgA2SKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580321402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PuvkLv/oIw9Q/DG8YMeMuQ1BSWZb/tsSFT2ktsDil9M=;
        b=Hl/hVPBWdsZZk5TS1atlZvrrZPqpoxZul2Cd1vE8NgIUWnx/UWUdG4LS+G/tGBOJ1blUMs
        SNVncC0VwPvYF1v1p50iD43z9YK9kJpRkezJO1UT/+MR0sTe6q8SCnPt7n4bJIeEmanpek
        4+ZNr4KFY/XA9vNiPWLu9PPudAsdE5s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-xJAqJsZCNHqfzy0nODL8wA-1; Wed, 29 Jan 2020 13:09:44 -0500
X-MC-Unique: xJAqJsZCNHqfzy0nODL8wA-1
Received: by mail-wr1-f70.google.com with SMTP id f15so262997wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuvkLv/oIw9Q/DG8YMeMuQ1BSWZb/tsSFT2ktsDil9M=;
        b=C/NFLN5DBF/oWYK+t3NtNQwEBR+a1r8pjFYdk8uCncX182CqluIniLwUCSvn87KQGy
         JkYvw0fVI2gZmvfOYrSfQFuM60w6awRORU8zTVEszPwkS9cHcTo1NNhg6uVe83F6G+Ar
         MFQQmmInIuClVLNah15P/ciZ3ol9wXbADzUAtNyg/8JqOD21AdUcTMacSdtE0qEABSPe
         S+Expcb6hncJgicLu/469HeszxDS2RuJyFXFbQ+C42BsGAJ2ovF7Q8HK5zi8E7WOd1SA
         cQ3vUaK0HuaVI1LB8sD0NKj71mxXD4ve074Qa0n5tvXgObIQUzlcA209qAWPLm05WzNA
         FN+g==
X-Gm-Message-State: APjAAAUfOaMHxVc+gSMmeN9YScx8aWRmwVMJyRT93qltq4I+9r5r4Jh/
        LSKlfIo8AlzoYlmJejKxrA+fb1MqwUWp7U05XYQrVy7WKuvGsxIOHH1LpWx9fGyvKFw5qxQC9RM
        gGp2CbT8XTuuEYYZSq+VN9mkD
X-Received: by 2002:a1c:2089:: with SMTP id g131mr436995wmg.63.1580321382602;
        Wed, 29 Jan 2020 10:09:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1RpprGonPlEm6g7ZSIDmngGnsx8ltMy/qtsYuE7+BQkwzMwemGOvhlG6C+tZ+eVipbvkanw==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr436956wmg.63.1580321382243;
        Wed, 29 Jan 2020 10:09:42 -0800 (PST)
Received: from dhcp-1-195.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.googlemail.com with ESMTPSA id m7sm3695976wrr.40.2020.01.29.10.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 10:09:41 -0800 (PST)
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
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Qian Cai <cai@lca.pw>
Subject: [PATCH 1/1] mm: sysctl: add panic_on_inconsistent_mm sysctl
Date:   Wed, 29 Jan 2020 19:08:51 +0100
Message-Id: <20200129180851.551109-1-ghalat@redhat.com>
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

Add a new sysctl - panic_on_inconsistent_mm. If the sysctl is set then the
kernel will be crashed when an inconsistency is detected by memory
management. This currently means panic when bad page or bad PTE
is detected(this may be extended to other places in MM).

Another use case of this sysctl may be in security-wise environments,
it may be more desired to crash machine than continue to run with
potentially damaged data structures.

Changes since v1 [2]:
- rename the sysctl to panic_on_inconsistent_mm
- move the sysctl from kernel to vm table
- print modules in print_bad_pte() only before calling panic

[1] https://lore.kernel.org/linux-mm/1426495021-6408-1-git-send-email-borntraeger@de.ibm.com/
[2] https://lore.kernel.org/lkml/20200127101100.92588-1-ghalat@redhat.com/

Signed-off-by: Grzegorz Halat <ghalat@redhat.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 14 ++++++++++++++
 include/linux/kernel.h                  |  1 +
 kernel/sysctl.c                         |  9 +++++++++
 mm/memory.c                             |  8 ++++++++
 mm/page_alloc.c                         |  4 +++-
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 64aeee1009ca..57f7926a64b8 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -61,6 +61,7 @@ Currently, these files are in /proc/sys/vm:
 - overcommit_memory
 - overcommit_ratio
 - page-cluster
+- panic_on_inconsistent_mm
 - panic_on_oom
 - percpu_pagelist_fraction
 - stat_interval
@@ -741,6 +742,19 @@ extra faults and I/O delays for following faults if they would have been part of
 that consecutive pages readahead would have brought in.
 
 
+panic_on_inconsistent_mm
+========================
+
+Controls the kernel's behaviour when inconsistency is detected
+by memory management code, for example bad page state or bad PTE.
+
+0: try to continue operation.
+
+1: panic immediately.
+
+The default value is 0.
+
+
 panic_on_oom
 ============
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0d9db2a14f44..b3bd94c558ab 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -518,6 +518,7 @@ extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
+extern int panic_on_inconsistent_mm;
 extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
 extern int panic_on_warn;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 70665934d53e..a9733311e3a1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1303,6 +1303,15 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
+	{
+		.procname	= "panic_on_inconsistent_mm",
+		.data		= &panic_on_inconsistent_mm,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "panic_on_oom",
 		.data		= &sysctl_panic_on_oom,
diff --git a/mm/memory.c b/mm/memory.c
index 45442d9a4f52..b29a18077a6a 100644
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
 
+int panic_on_inconsistent_mm __read_mostly;
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 /* use the per-pgdat data instead for discontigmem - mbligh */
 unsigned long max_mapnr;
@@ -543,6 +546,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
 		 mapping ? mapping->a_ops->readpage : NULL);
+
+	if (panic_on_inconsistent_mm) {
+		print_modules();
+		panic("Bad page map detected");
+	}
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d047bf7d8fd4..a20cd3ece5ba 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -643,9 +643,11 @@ static void bad_page(struct page *page, const char *reason,
 	if (bad_flags)
 		pr_alert("bad because of flags: %#lx(%pGp)\n",
 						bad_flags, &bad_flags);
-	dump_page_owner(page);
 
+	dump_page_owner(page);
 	print_modules();
+	if (panic_on_inconsistent_mm)
+		panic("Bad page state detected");
 	dump_stack();
 out:
 	/* Leave bad fields for debug, except PageBuddy could make trouble */
-- 
2.21.1

