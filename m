Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E5CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD5822B40
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgHCSex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:34:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40816 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgHCSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:34:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id 185so30535436ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdMJ/kZbjayYZu6hB78fKbxhGiXLwV0qHCv1i8H0pn8=;
        b=EkJUa5VokX6/r3A8jqfjOO6D3gV9sD3kVhfChxE1M0V+JZZ+KXI2om/1m88x2JX+v0
         QiFonV70eUdssTB1z1mjAmYvFSWrUA/8LheyKaHLxtDIyKcLmP5wSeJDZLtpKX6KEV5a
         DnkhfuAji+K/dxpTrRLQ7Lt8Y/82jznjvWeuZTYL1Az067Qz77y+KYw0mJNpt5CGVPK1
         eUjp0L4H0y8lm/FS/keQTQ4x0hSNfahFZ0TA5deZz6feuiAX4/L+unMAlle4f0gS9Vrk
         rIX27e1IDYiyBBbRbcUdrF3ZDMZvvCG7AH6tV4+ZW1UKKaaPDFcwcNvOevLwkC+pDY/2
         rDSg==
X-Gm-Message-State: AOAM531pehLzVfDqjq9XC67b5iPGcnBkSWT+cTM/9N+vGyl8z0PlmQWN
        bRw89SxvQgg0BlheLSRpeSK7ltEw
X-Google-Smtp-Source: ABdhPJwWjIJr6jLOAW1ZWCdwRVf3k+rpfZEqx/7VBxSzHaj2UBghqfm7f5wJQ92sqA7GwGDK9vsssA==
X-Received: by 2002:a2e:9996:: with SMTP id w22mr9050733lji.446.1596479689156;
        Mon, 03 Aug 2020 11:34:49 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id a16sm5150029ljj.108.2020.08.03.11.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:34:48 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7] coccinelle: api: add kfree_mismatch script
Date:   Mon,  3 Aug 2020 21:34:38 +0300
Message-Id: <20200803183438.34685-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605204237.85055-1-efremov@linux.com>
References: <20200605204237.85055-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that alloc and free types of functions match each other.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - Lines are limited to 80 characters where possible
 - Confidence changed from High to Medium because of 
   fs/btrfs/send.c:1119 false-positive
 - __vmalloc_area_node() explicitly excluded from analysis
   instead of !(file in "mm/vmalloc.c") condition
Changes in v3:
 - prints style in org && report modes changed for python2
Changes in v4:
 - missing msg argument to print_todo fixed
Changes in v5:
 - fix position p in kfree rule
 - move @kok and @v positions in choice rule after the arguments
 - remove kvmalloc suggestions
Changes in v6:
 - more asterisks added in context mode
 - second @kok added to the choice rule
Changes in v7:
 - file renamed to kfree_mismatch.cocci
 - python function relevant() removed
 - additional rule for filtering free positions added
 - btrfs false-positive fixed
 - confidence level changed to high
 - kvfree_switch rule added
 - names for position variables changed to @a (alloc) and @f (free)

 scripts/coccinelle/api/kfree_mismatch.cocci | 229 ++++++++++++++++++++
 1 file changed, 229 insertions(+)
 create mode 100644 scripts/coccinelle/api/kfree_mismatch.cocci

diff --git a/scripts/coccinelle/api/kfree_mismatch.cocci b/scripts/coccinelle/api/kfree_mismatch.cocci
new file mode 100644
index 000000000000..9e9ef9fd7a25
--- /dev/null
+++ b/scripts/coccinelle/api/kfree_mismatch.cocci
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check that kvmalloc'ed memory is freed by kfree functions,
+/// vmalloc'ed by vfree functions and kvmalloc'ed by kvfree
+/// functions.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual patch
+virtual report
+virtual org
+virtual context
+
+@alloc@
+expression E, E1;
+position kok, vok;
+@@
+
+(
+  if (...) {
+    ...
+    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|
+          kmalloc_node\|kzalloc_node\|kmalloc_array\|
+          kmalloc_array_node\|kcalloc_node\)(...)@kok
+    ...
+  } else {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
+          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
+          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
+          __vmalloc_node\)(...)@vok
+    ...
+  }
+|
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)@kok
+  ... when != E = E1
+      when any
+  if (E == NULL) {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
+          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
+          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
+          __vmalloc_node\)(...)@vok
+    ...
+  }
+)
+
+@free@
+expression E;
+position fok;
+@@
+
+  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+        kvmalloc_array\)(...)
+  ...
+  kvfree(E)@fok
+
+@vfree depends on !patch@
+expression E;
+position a != alloc.kok;
+position f != free.fok;
+@@
+
+* E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
+*       kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
+*       kcalloc_node\)(...)@a
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+* \(vfree\|vfree_atomic\|kvfree\)(E)@f
+
+@depends on patch exists@
+expression E;
+position a != alloc.kok;
+position f != free.fok;
+@@
+
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
+        kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
+        kcalloc_node\)(...)@a
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+- \(vfree\|vfree_atomic\|kvfree\)(E)@f
++ kfree(E)
+
+@kfree depends on !patch@
+expression E;
+position a != alloc.vok;
+position f != free.fok;
+@@
+
+* E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+*       vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+*       __vmalloc_node_range\|__vmalloc_node\)(...)@a
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kzfree\|kvfree\)(E)@f
+
+@depends on patch exists@
+expression E;
+position a != alloc.vok;
+position f != free.fok;
+@@
+
+  E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+        vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+        __vmalloc_node_range\|__vmalloc_node\)(...)@a
+  ... when != is_vmalloc_addr(E)
+      when any
+- \(kfree\|kvfree\)(E)@f
++ vfree(E)
+
+@kvfree depends on !patch@
+expression E;
+position a, f;
+@@
+
+* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+*       kvmalloc_array\)(...)@a
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@f
+
+@depends on patch exists@
+expression E;
+@@
+
+  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+        kvmalloc_array\)(...)
+  ... when != is_vmalloc_addr(E)
+      when any
+- \(kfree\|vfree\)(E)
++ kvfree(E)
+
+@kvfree_switch depends on !patch@
+expression alloc.E;
+position f != free.fok;
+@@
+
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@f
+
+@depends on patch exists@
+expression alloc.E;
+position f != free.fok;
+@@
+
+  ... when != is_vmalloc_addr(E)
+      when any
+(
+- \(kfree\|vfree\)(E)@f
++ kvfree(E)
+|
+- kzfree(E)@f
++ kvfree_sensitive(E)
+)
+
+@script: python depends on report@
+a << vfree.a;
+f << vfree.f;
+@@
+
+msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+a << vfree.a;
+f << vfree.f;
+@@
+
+msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.org.print_todo(f[0], msg)
+
+@script: python depends on report@
+a << kfree.a;
+f << kfree.f;
+@@
+
+msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+a << kfree.a;
+f << kfree.f;
+@@
+
+msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.org.print_todo(f[0], msg)
+
+@script: python depends on report@
+a << kvfree.a;
+f << kvfree.f;
+@@
+
+msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+a << kvfree.a;
+f << kvfree.f;
+@@
+
+msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.org.print_todo(f[0], msg)
+
+@script: python depends on report@
+ka << alloc.kok;
+va << alloc.vok;
+f << kvfree_switch.f;
+@@
+
+msg = "WARNING: kmalloc (line %s) && vmalloc (line %s) are used to allocate this memory" % (ka[0].line, va[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+ka << alloc.kok;
+va << alloc.vok;
+f << kvfree_switch.f;
+@@
+
+msg = "WARNING: kmalloc (line %s) && vmalloc (line %s) are used to allocate this memory" % (ka[0].line, va[0].line)
+coccilib.org.print_todo(f[0], msg)
+
-- 
2.26.2

