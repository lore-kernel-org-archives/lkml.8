Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D50206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgFEUmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:42:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44454 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgFEUmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:42:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id c17so13312792lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+Qxu7jwc9vtNGc45fOkzO2t1GpoNWOK9fZhBu4fsGQ=;
        b=CLboJXkHstV+ogaDgdp3bx5AqcBnL6nUTK4Z57ZOT58jGZkRI/X3nz2zStmUq7UD1V
         VmAc68i7KUwiZPMEArPyMa9/mWovNSYI/A6rt7zlOx3OEF4R82IiT1ZO4x1U5Un4UX0/
         MeA9ttSuwrD7IAr0U7IOvhFfygP5FfWVtzA1Wan98S8unI9N2111R7Y+5arZFQxkasBv
         R9MPA8xcHWfTWGPFbd5Tsap+ndxjtcVha4H6fyDugcMPrhHIrro/+9S47PtJx4Fo5piA
         8UmjJM/nUuR97rzKGzN+/8vWx2JIb31pJu7tKxTxjYRK9hO/5virXgU+bKY9Uz0BRMAU
         4o4g==
X-Gm-Message-State: AOAM533WnZVXk6t0aHMcNHpCSD50ohAoOLWQiJtB/vJzhSbuyTfu9E2n
        LGGRqH1ec9dkRQ/pYmFN3nk=
X-Google-Smtp-Source: ABdhPJxHnz5aHifVlOzWxpgBa6bo2Fo2AmWvr7ballKe65tU22AcmJC2+6IU7fx+JJEjwF9cD/TBKg==
X-Received: by 2002:a2e:8047:: with SMTP id p7mr5700633ljg.173.1591389766133;
        Fri, 05 Jun 2020 13:42:46 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id 15sm1171730ljr.104.2020.06.05.13.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 13:42:45 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: api: add kvfree script
Date:   Fri,  5 Jun 2020 23:42:37 +0300
Message-Id: <20200605204237.85055-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that alloc and free types of functions match each other.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
List of patches to stable:
- https://lkml.org/lkml/2020/6/1/713
- https://lkml.org/lkml/2020/6/5/200
- https://lkml.org/lkml/2020/6/5/838
- https://lkml.org/lkml/2020/6/5/887

Other patches:
- https://lkml.org/lkml/2020/6/1/701
- https://lkml.org/lkml/2020/6/5/839
- https://lkml.org/lkml/2020/6/5/864
- https://lkml.org/lkml/2020/6/5/865
- https://lkml.org/lkml/2020/6/5/895
- https://lkml.org/lkml/2020/6/5/901

There is a false positive that I can't beat:
fs/btrfs/send.c:1119:11-12: WARNING: kmalloc is used to allocate
this memory at line 1036

 scripts/coccinelle/api/kvfree.cocci | 196 ++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvfree.cocci

diff --git a/scripts/coccinelle/api/kvfree.cocci b/scripts/coccinelle/api/kvfree.cocci
new file mode 100644
index 000000000000..e3fa3d0fd2fd
--- /dev/null
+++ b/scripts/coccinelle/api/kvfree.cocci
@@ -0,0 +1,196 @@
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
+
+@choice@
+expression E, E1;
+position kok, vok;
+@@
+
+(
+  if (...) {
+    ...
+    E = \(kmalloc@kok\|kzalloc@kok\|krealloc@kok\|kcalloc@kok\|kmalloc_node@kok\|kzalloc_node@kok\|kmalloc_array@kok\|kmalloc_array_node@kok\|kcalloc_node@kok\)(...)
+    ...
+  } else {
+    ...
+    E = \(vmalloc@vok\|vzalloc@vok\|vmalloc_user@vok\|vmalloc_node@vok\|vzalloc_node@vok\|vmalloc_exec@vok\|vmalloc_32@vok\|vmalloc_32_user@vok\|__vmalloc@vok\|__vmalloc_node_range@vok\|__vmalloc_node@vok\)(...)
+    ...
+  }
+|
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)
+  ... when != E = E1
+      when any
+  if (\(!E\|E == NULL\)) {
+    ...
+    E = \(vmalloc@vok\|vzalloc@vok\|vmalloc_user@vok\|vmalloc_node@vok\|vzalloc_node@vok\|vmalloc_exec@vok\|vmalloc_32@vok\|vmalloc_32_user@vok\|__vmalloc@vok\|__vmalloc_node_range@vok\|__vmalloc_node@vok\)(...)
+    ...
+  }
+)
+
+// exclude mm/vmalloc.c because of kvmalloc* definitions
+@opportunity depends on !patch && !(file in "mm/vmalloc.c")@
+expression E, E1, size;
+position p;
+@@
+
+(
+* if (\(size <= E1\|size < E1\|size = E1\|size > E1\) || ...)@p {
+    ...
+    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+    ...
+  } else {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(..., size, ...)
+    ...
+  }
+|
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+  ... when != E = E1
+      when != size = E1
+      when any
+* if (\(!E\|E == NULL\))@p {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(..., size, ...)
+    ...
+  }
+)
+
+@vfree depends on !patch@
+expression E;
+position k != choice.kok;
+position p;
+@@
+
+* E = \(kmalloc@k\|kzalloc@k\|krealloc@k\|kcalloc@k\|kmalloc_node@k\|kzalloc_node@k\|kmalloc_array@k\|kmalloc_array_node@k\|kcalloc_node@k\)(...)
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\|kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|kvmalloc_array\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+* \(vfree\|vfree_atomic\|kvfree\)(E)@p
+
+@pvfree depends on patch exists@
+expression E;
+position k != choice.kok;
+@@
+
+  E = \(kmalloc@k\|kzalloc@k\|krealloc@k\|kcalloc@k\|kmalloc_node@k\|kzalloc_node@k\|kmalloc_array@k\|kmalloc_array_node@k\|kcalloc_node@k\)(...)
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\|kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|kvmalloc_array\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+- \(vfree\|vfree_atomic\|kvfree\)(E)
++ kfree(E)
+
+@kfree depends on !patch@
+expression E;
+position v != choice.vok;
+position p;
+@@
+
+* E = \(vmalloc@v\|vzalloc@v\|vmalloc_user@v\|vmalloc_node@v\|vzalloc_node@v\|vmalloc_exec@v\|vmalloc_32@v\|vmalloc_32_user@v\|__vmalloc@v\|__vmalloc_node_range@v\|__vmalloc_node@v\)(...)
+  ... when != !is_vmalloc_addr(E)
+      when any
+* \(kfree\|kzfree\|kvfree\)(E)
+
+@pkfree depends on patch exists@
+expression E;
+position v != choice.vok;
+@@
+
+  E = \(vmalloc@v\|vzalloc@v\|vmalloc_user@v\|vmalloc_node@v\|vzalloc_node@v\|vmalloc_exec@v\|vmalloc_32@v\|vmalloc_32_user@v\|__vmalloc@v\|__vmalloc_node_range@v\|__vmalloc_node@v\)(...)
+  ... when != !is_vmalloc_addr(E)
+      when any
+- \(kfree\|kvfree\)(E)
++ vfree(E)
+
+@kvfree depends on !patch@
+expression E;
+position p, k;
+@@
+
+* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|kvmalloc_array\)(...)@k
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@p
+
+@pkvfree depends on patch exists@
+expression E;
+@@
+
+  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|kvmalloc_array\)(...)
+  ... when != is_vmalloc_addr(E)
+      when any
+- \(kfree\|vfree\)(E)
++ kvfree(E)
+
+@script: python depends on report@
+k << vfree.k;
+p << vfree.p;
+@@
+
+msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (k[0].line)
+coccilib.report.print_report(p[0], msg)
+
+@script: python depends on org@
+k << vfree.k;
+p << vfree.p;
+@@
+
+msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (k[0].line)
+coccilib.org.print_todo(p[0], msg)
+
+@script: python depends on report@
+v << kfree.v;
+p << kfree.p;
+@@
+
+msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (v[0].line)
+coccilib.report.print_report(p[0], msg)
+
+@script: python depends on org@
+v << kfree.v;
+p << kfree.p;
+@@
+
+msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (v[0].line)
+coccilib.org.print_todo(p[0], msg)
+
+@script: python depends on report@
+k << kvfree.k;
+p << kvfree.p;
+@@
+
+msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (k[0].line)
+coccilib.report.print_report(p[0], msg)
+
+@script: python depends on org@
+k << kvfree.k;
+p << kvfree.p;
+@@
+
+msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (k[0].line)
+coccilib.org.print_todo(p[0], msg)
+
+@script: python depends on report@
+p << opportunity.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for kvmalloc")
+
+@script: python depends on org@
+p << opportunity.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: opportunity for kvmalloc")
-- 
2.26.2

