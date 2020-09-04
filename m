Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A23EC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F0D2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgIDPe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:34:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45035 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726133AbgIDPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:34:20 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-yRV-NtpSMI2vUUN7CwMlBw-1; Fri, 04 Sep 2020 11:34:17 -0400
X-MC-Unique: yRV-NtpSMI2vUUN7CwMlBw-1
Received: by mail-ed1-f72.google.com with SMTP id c3so2838694edm.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zp25PJXZJmLzi/YG+rLvA4Ne+i/fMSHVG+Gz6qFfk/U=;
        b=C6+pUC8DVah7t2TvN1qfqvhtwPzRiBKOM98aQ4V/AmjPT/JNnrCb83idu0gkcYWQAR
         j9Q+ttWp2tC65/EzW9VJj1kP/gjg44GAwYmoUmOTBfMZFw4PorCOt83r0+g1p4WVx0U8
         7ePFVC9NfRiCezz8JyVaIgmfW6gCp9aZZcXp++5eIocHsTjatbMOmz1c8uVvrT9Sjb6+
         mFnDAOwFhOuDJyuHPR3/3Ihc9tmlmvpb9GGgRMVAPWko9cnD4R5N+BrdNANLWNBfB/LH
         fnKZZX2Yy9mj/jE6alhtVu06/HIxSW42u1VhkomEQACjkN+XWPchiVK55aC98XyduGKk
         z9Cw==
X-Gm-Message-State: AOAM532DoY8fLH68g9asM+2C3UeISJJ2nM4xum05WhcOVNMU43uQICOS
        3xyNSS1uyrpCDiqpCFz0TUubFHpHI3yp5LJoWxapbvmPXfyTiN5s7QKSKZUaJ/t7PtoGxYwpr16
        zA1fvuunfElzxl7snHLyr6NmC
X-Received: by 2002:a05:6402:b45:: with SMTP id bx5mr9428588edb.22.1599233655818;
        Fri, 04 Sep 2020 08:34:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy704sUu7sJgjrolJNTiPBt89HfejW1hd5XF8q0Nja9ll1NI/l1yN+Popd+lrmjy+m0job6Cw==
X-Received: by 2002:a05:6402:b45:: with SMTP id bx5mr9428562edb.22.1599233655615;
        Fri, 04 Sep 2020 08:34:15 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id z17sm182797edi.90.2020.09.04.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:34:15 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 07/10] headers: Rename frame.h
Date:   Fri,  4 Sep 2020 16:30:25 +0100
Message-Id: <20200904153028.32676-8-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header frame.h is getting more code annotations to help objtool analyze
object files.

Rename the file to objtool.h.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 arch/x86/kernel/kprobes/core.c       | 2 +-
 arch/x86/kernel/kprobes/opt.c        | 2 +-
 arch/x86/kernel/reboot.c             | 2 +-
 arch/x86/kvm/svm/svm.c               | 2 +-
 arch/x86/kvm/vmx/nested.c            | 2 +-
 arch/x86/kvm/vmx/vmx.c               | 2 +-
 arch/x86/xen/enlighten_pv.c          | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c  | 3 +--
 include/linux/{frame.h => objtool.h} | 6 +++---
 kernel/bpf/core.c                    | 2 +-
 kernel/kexec_core.c                  | 2 +-
 12 files changed, 14 insertions(+), 15 deletions(-)
 rename include/linux/{frame.h => objtool.h} (93%)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index e7752b4038ff..86651e86289d 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -4,7 +4,7 @@
 #define _ASM_X86_NOSPEC_BRANCH_H_
 
 #include <linux/static_key.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index fdadc37d72af..ae2488643029 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -38,9 +38,9 @@
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
-#include <linux/frame.h>
 #include <linux/kasan.h>
 #include <linux/moduleloader.h>
+#include <linux/objtool.h>
 #include <linux/vmalloc.h>
 #include <linux/pgtable.h>
 
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 40f380461e6d..f39ce3f67863 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -16,7 +16,7 @@
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/pgtable.h>
 
 #include <asm/text-patching.h>
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0ec7ced727fe..603f33645e75 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -10,7 +10,7 @@
 #include <linux/sched.h>
 #include <linux/tboot.h>
 #include <linux/delay.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/pgtable.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 03dd7bac8034..2ff0152ae6c2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -19,7 +19,7 @@
 #include <linux/trace_events.h>
 #include <linux/slab.h>
 #include <linux/hashtable.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/psp-sev.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 23b58c28a1c9..ae4ff7c624a4 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/percpu.h>
 
 #include <asm/debugreg.h>
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 46ba2e03a892..e1f24749fa67 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -13,7 +13,6 @@
  *   Yaniv Kamay  <yaniv@qumranet.com>
  */
 
-#include <linux/frame.h>
 #include <linux/highmem.h>
 #include <linux/hrtimer.h>
 #include <linux/kernel.h>
@@ -22,6 +21,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mm.h>
+#include <linux/objtool.h>
 #include <linux/sched.h>
 #include <linux/sched/smt.h>
 #include <linux/slab.h>
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 22e741e0b10c..58382d26f153 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -32,7 +32,7 @@
 #include <linux/pci.h>
 #include <linux/gfp.h>
 #include <linux/edd.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index e9f448a5ebb3..15b5bde69324 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -24,7 +24,7 @@
  *
  */
 
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -599,4 +599,3 @@ int vmw_msg_ioctl(struct drm_device *dev, void *data,
 
 	return -EINVAL;
 }
-
diff --git a/include/linux/frame.h b/include/linux/objtool.h
similarity index 93%
rename from include/linux/frame.h
rename to include/linux/objtool.h
index 303cda600e56..358175c9c2b5 100644
--- a/include/linux/frame.h
+++ b/include/linux/objtool.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_FRAME_H
-#define _LINUX_FRAME_H
+#ifndef _LINUX_OBJTOOL_H
+#define _LINUX_OBJTOOL_H
 
 #ifdef CONFIG_STACK_VALIDATION
 /*
@@ -32,4 +32,4 @@
 
 #endif /* CONFIG_STACK_VALIDATION */
 
-#endif /* _LINUX_FRAME_H */
+#endif /* _LINUX_OBJTOOL_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ed0b3578867c..03e284873644 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -25,7 +25,7 @@
 #include <linux/moduleloader.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/rbtree_latch.h>
 #include <linux/kallsyms.h>
 #include <linux/rcupdate.h>
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0dad1ebe..c5e5e5a11535 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -36,7 +36,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
-- 
2.21.3

