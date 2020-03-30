Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C139C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628F32078B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgC3CWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:22:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728972AbgC3CWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:22:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7EF28356851A8F446328;
        Mon, 30 Mar 2020 10:22:33 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 10:22:24 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>,
        <dja@axtens.net>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v5 6/6] powerpc/fsl_booke/kaslr: rename kaslr-booke32.rst to kaslr-booke.rst and add 64bit part
Date:   Mon, 30 Mar 2020 10:20:23 +0800
Message-ID: <20200330022023.3691-7-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200330022023.3691-1-yanaijie@huawei.com>
References: <20200330022023.3691-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we support both 32 and 64 bit KASLR for fsl booke. Add document for
64 bit part and rename kaslr-booke32.rst to kaslr-booke.rst.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Scott Wood <oss@buserror.net>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
---
 Documentation/powerpc/index.rst               |  2 +-
 .../{kaslr-booke32.rst => kaslr-booke.rst}    | 35 ++++++++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)
 rename Documentation/powerpc/{kaslr-booke32.rst => kaslr-booke.rst} (59%)

diff --git a/Documentation/powerpc/index.rst b/Documentation/powerpc/index.rst
index 0d45f0fc8e57..3bad36943b22 100644
--- a/Documentation/powerpc/index.rst
+++ b/Documentation/powerpc/index.rst
@@ -20,7 +20,7 @@ powerpc
     hvcs
     imc
     isa-versions
-    kaslr-booke32
+    kaslr-booke
     mpc52xx
     papr_hcalls
     pci_iov_resource_on_powernv
diff --git a/Documentation/powerpc/kaslr-booke32.rst b/Documentation/powerpc/kaslr-booke.rst
similarity index 59%
rename from Documentation/powerpc/kaslr-booke32.rst
rename to Documentation/powerpc/kaslr-booke.rst
index 8b259fdfdf03..27a862963242 100644
--- a/Documentation/powerpc/kaslr-booke32.rst
+++ b/Documentation/powerpc/kaslr-booke.rst
@@ -1,15 +1,18 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-===========================
-KASLR for Freescale BookE32
-===========================
+=========================
+KASLR for Freescale BookE
+=========================
 
 The word KASLR stands for Kernel Address Space Layout Randomization.
 
 This document tries to explain the implementation of the KASLR for
-Freescale BookE32. KASLR is a security feature that deters exploit
+Freescale BookE. KASLR is a security feature that deters exploit
 attempts relying on knowledge of the location of kernel internals.
 
+KASLR for Freescale BookE32
+-------------------------
+
 Since CONFIG_RELOCATABLE has already supported, what we need to do is
 map or copy kernel to a proper place and relocate. Freescale Book-E
 parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
@@ -38,5 +41,29 @@ bit of the entropy to decide the index of the 64M zone. Then we chose a
 
                               kernstart_virt_addr
 
+
+KASLR for Freescale BookE64
+---------------------------
+
+The implementation for Freescale BookE64 is similar to BookE32. One
+difference is that Freescale BookE64 set up a TLB mapping of 1G during
+booting. Another difference is that ppc64 needs the kernel to be
+64K-aligned. So we can randomize the kernel in this 1G mapping and make
+it 64K-aligned. This can save some code to creat another TLB map at early
+boot. The disadvantage is that we only have about 1G/64K = 16384 slots to
+put the kernel in::
+
+    KERNELBASE
+
+          64K                     |--> kernel <--|
+           |                      |              |
+        +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
+        |  |  |  |....|  |  |  |  |  |  |  |  |  |....|  |  |
+        +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
+        |                         |                        1G
+        |----->   offset    <-----|
+
+                              kernstart_virt_addr
+
 To enable KASLR, set CONFIG_RANDOMIZE_BASE = y. If KASLR is enable and you
 want to disable it at runtime, add "nokaslr" to the kernel cmdline.
-- 
2.17.2

