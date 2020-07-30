Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8E0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D23206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgG3OIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:08:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38039 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgG3OH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:07:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id x9so29039574ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4GjGtlMybVSB0ZL/vAbrz8hzmPOHmkRXNFAvsQ5qlU=;
        b=eVQgvh3B7QET6VPrJQTjFKUkuwTPZ8BwBIwlnbUz6A1azikrL73YKh2Xxrj3r6/gte
         iWI+hVhbTg46NIId2JoTSAPHpW/LzKeIuVfhj+t29fLo444XQx5qQlvtbpXydVvYctdF
         YTxWu6XrYJhYC3vsgI0HLGD+Vv5L1h9A9DFDcFP2g/W9/XEekCd6KAK9Uj1RF35qlNPW
         LP0tUV7isgMpg83Cr3asLE7urpV1MTOITchHTZlVcPMJT8+QDkIToed9mVwaxGqS6qvB
         JJIkpkcN5fTrQp4iMAaAoT9lPaAQNCekU7nr3AWF9bavVQrDt5QCHWluvUip2QhzYQ4i
         6CUg==
X-Gm-Message-State: AOAM533SrE+4ICEERjVpZ4Ye1XPbW8UL9JB6Mil43PZqpjrG36IsAXJZ
        YOWmBEDbIBXSrrAnCk526g4=
X-Google-Smtp-Source: ABdhPJyhRu/IQKvo9ytF6XuktRAfzXw8siuI3vjm4JdOJJjHdhFyhv4PUQimM/cRdydYrV0xa31o/Q==
X-Received: by 2002:a2e:a583:: with SMTP id m3mr1544125ljp.135.1596118073614;
        Thu, 30 Jul 2020 07:07:53 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id b16sm1063559ljp.124.2020.07.30.07.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 07:07:52 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] coccinelle: api: add kvfree script
Date:   Thu, 30 Jul 2020 17:07:51 +0300
Message-Id: <20200730140751.8635-1-efremov@linux.com>
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

 scripts/coccinelle/api/kvfree.cocci | 227 ++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvfree.cocci

diff --git a/scripts/coccinelle/api/kvfree.cocci b/scripts/coccinelle/api/kvfree.cocci
new file mode 100644
index 000000000000..d73578c5549c
--- /dev/null
+++ b/scripts/coccinelle/api/kvfree.cocci
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check that kvmalloc'ed memory is freed by kfree functions,
+/// vmalloc'ed by vfree functions and kvmalloc'ed by kvfree
+/// functions.
+///
+// Confidence: Medium
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual patch
+virtual report
+virtual org
+virtual context
+
+@initialize:python@
+@@
+# low-level memory api
+filter = frozenset(['__vmalloc_area_node'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
+@choice@
+expression E, E1;
+position kok, vok;
+@@
+
+(
+  if (...) {
+    ...
+    E = \(kmalloc@kok\|kzalloc@kok\|krealloc@kok\|kcalloc@kok\|
+          kmalloc_node@kok\|kzalloc_node@kok\|kmalloc_array@kok\|
+          kmalloc_array_node@kok\|kcalloc_node@kok\)(...)
+    ...
+  } else {
+    ...
+    E = \(vmalloc@vok\|vzalloc@vok\|vmalloc_user@vok\|vmalloc_node@vok\|
+          vzalloc_node@vok\|vmalloc_exec@vok\|vmalloc_32@vok\|
+          vmalloc_32_user@vok\|__vmalloc@vok\|__vmalloc_node_range@vok\|
+          __vmalloc_node@vok\)(...)
+    ...
+  }
+|
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)
+  ... when != E = E1
+      when any
+  if (\(!E\|E == NULL\)) {
+    ...
+    E = \(vmalloc@vok\|vzalloc@vok\|vmalloc_user@vok\|vmalloc_node@vok\|
+          vzalloc_node@vok\|vmalloc_exec@vok\|vmalloc_32@vok\|
+          vmalloc_32_user@vok\|__vmalloc@vok\|__vmalloc_node_range@vok\|
+          __vmalloc_node@vok\)(...)
+    ...
+  }
+)
+
+@opportunity depends on !patch@
+expression E, E1, size;
+position p : script:python() { relevant(p) };
+@@
+
+(
+* if (\(size <= E1\|size < E1\|size = E1\|size > E1\) || ...)@p {
+    ...
+    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+          kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+    ...
+  } else {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+          vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+          __vmalloc_node_range\|__vmalloc_node\)(..., size, ...)
+    ...
+  }
+|
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+  ... when != E = E1
+      when != size = E1
+      when any
+* if (\(!E\|E == NULL\))@p {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+          vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+          __vmalloc_node_range\|__vmalloc_node\)(..., size, ...)
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
+* E = \(kmalloc@k\|kzalloc@k\|krealloc@k\|kcalloc@k\|kmalloc_node@k\|
+        kzalloc_node@k\|kmalloc_array@k\|kmalloc_array_node@k\|
+        kcalloc_node@k\)(...)
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+* \(vfree\|vfree_atomic\|kvfree\)(E)@p
+
+@pvfree depends on patch exists@
+expression E;
+position k != choice.kok;
+@@
+
+  E = \(kmalloc@k\|kzalloc@k\|krealloc@k\|kcalloc@k\|kmalloc_node@k\|
+        kzalloc_node@k\|kmalloc_array@k\|kmalloc_array_node@k\|
+        kcalloc_node@k\)(...)
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
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
+* E = \(vmalloc@v\|vzalloc@v\|vmalloc_user@v\|vmalloc_node@v\|vzalloc_node@v\|
+        vmalloc_exec@v\|vmalloc_32@v\|vmalloc_32_user@v\|__vmalloc@v\|
+        __vmalloc_node_range@v\|__vmalloc_node@v\)(...)
+  ... when != !is_vmalloc_addr(E)
+      when any
+* \(kfree\|kzfree\|kvfree\)(E)
+
+@pkfree depends on patch exists@
+expression E;
+position v != choice.vok;
+@@
+
+  E = \(vmalloc@v\|vzalloc@v\|vmalloc_user@v\|vmalloc_node@v\|vzalloc_node@v\|
+        vmalloc_exec@v\|vmalloc_32@v\|vmalloc_32_user@v\|__vmalloc@v\|
+        __vmalloc_node_range@v\|__vmalloc_node@v\)(...)
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
+* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+        kvmalloc_array\)(...)@k
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@p
+
+@pkvfree depends on patch exists@
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

