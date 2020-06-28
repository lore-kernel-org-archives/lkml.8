Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2017FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F237F20674
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgF1Oaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:30:39 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40688 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbgF1Oai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:30:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U0vmxff_1593354617;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0U0vmxff_1593354617)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 28 Jun 2020 22:30:32 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: fix incorrent references to DMA APIs
Date:   Sun, 28 Jun 2020 22:30:17 +0800
Message-Id: <20200628143017.17399-1-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma-api
dma-api-howto
dma-attributes
dma-isa-lpc

The above 4 documents have been renamed and moved to
Documentation/core-api/, but there are still some old references
refer to the old files, this patch tries to correct them.

Fixes: 728c1471b544 ("docs: move DMA kAPI to Documentation/core-api")
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 Documentation/PCI/pci.rst                            | 6 +++---
 Documentation/block/biodoc.rst                       | 2 +-
 Documentation/bus-virt-phys-mapping.txt              | 2 +-
 Documentation/core-api/dma-api-howto.rst             | 2 +-
 Documentation/core-api/dma-api.rst                   | 6 +++---
 Documentation/core-api/dma-isa-lpc.rst               | 2 +-
 Documentation/driver-api/usb/dma.rst                 | 6 +++---
 Documentation/memory-barriers.txt                    | 6 +++---
 Documentation/translations/ko_KR/memory-barriers.txt | 6 +++---
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 8c016d8c9862..b9b81b48a1f9 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -265,7 +265,7 @@ Set the DMA mask size
 ---------------------
 .. note::
    If anything below doesn't make sense, please refer to
-   Documentation/DMA-API.txt. This section is just a reminder that
+   Documentation/core-api/dma-api.rst. This section is just a reminder that
    drivers need to indicate DMA capabilities of the device and is not
    an authoritative source for DMA interfaces.
 
@@ -291,7 +291,7 @@ Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
 Setup shared control data
 -------------------------
 Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
-memory.  See Documentation/DMA-API.txt for a full description of
+memory.  See Documentation/core-api/dma-api.rst for a full description of
 the DMA APIs. This section is just a reminder that it needs to be done
 before enabling DMA on the device.
 
@@ -421,7 +421,7 @@ owners if there is one.
 
 Then clean up "consistent" buffers which contain the control data.
 
-See Documentation/DMA-API.txt for details on unmapping interfaces.
+See Documentation/core-api/dma-api.rst for details on unmapping interfaces.
 
 
 Unregister from other subsystems
diff --git a/Documentation/block/biodoc.rst b/Documentation/block/biodoc.rst
index b964796ec9c7..711c92bbe40a 100644
--- a/Documentation/block/biodoc.rst
+++ b/Documentation/block/biodoc.rst
@@ -196,7 +196,7 @@ a virtual address mapping (unlike the earlier scheme of virtual address
 do not have a corresponding kernel virtual address space mapping) and
 low-memory pages.
 
-Note: Please refer to Documentation/DMA-API-HOWTO.txt for a discussion
+Note: Please refer to Documentation/core-api/dma-api-howto.rst for a discussion
 on PCI high mem DMA aspects and mapping of scatter gather lists, and support
 for 64 bit PCI.
 
diff --git a/Documentation/bus-virt-phys-mapping.txt b/Documentation/bus-virt-phys-mapping.txt
index 4bb07c2f3e7d..c72b24a7d52c 100644
--- a/Documentation/bus-virt-phys-mapping.txt
+++ b/Documentation/bus-virt-phys-mapping.txt
@@ -8,7 +8,7 @@ How to access I/O mapped memory from within device drivers
 
 	The virt_to_bus() and bus_to_virt() functions have been
 	superseded by the functionality provided by the PCI DMA interface
-	(see Documentation/DMA-API-HOWTO.txt).  They continue
+	(see Documentation/core-api/dma-api-howto.rst).  They continue
 	to be documented below for historical purposes, but new code
 	must not use them. --davidm 00/12/12
 
diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index 358d495456d1..9acedc207ce8 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -8,7 +8,7 @@ Dynamic DMA mapping Guide
 
 This is a guide to device driver writers on how to use the DMA API
 with example pseudo-code.  For a concise description of the API, see
-DMA-API.txt.
+Documentation/core-api/dma-api.rst.
 
 CPU and DMA addresses
 =====================
diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 2d8d2fed7317..61c8945a6b62 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -5,7 +5,7 @@ Dynamic DMA mapping using the generic device
 :Author: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
 
 This document describes the DMA API.  For a more gentle introduction
-of the API (and actual examples), see Documentation/DMA-API-HOWTO.txt.
+of the API (and actual examples), see Documentation/core-api/dma-api-howto.rst.
 
 This API is split into two pieces.  Part I describes the basic API.
 Part II describes extensions for supporting non-consistent memory
@@ -471,7 +471,7 @@ without the _attrs suffixes, except that they pass an optional
 dma_attrs.
 
 The interpretation of DMA attributes is architecture-specific, and
-each attribute should be documented in Documentation/DMA-attributes.txt.
+each attribute should be documented in Documentation/core-api/dma-attributes.rst.
 
 If dma_attrs are 0, the semantics of each of these functions
 is identical to those of the corresponding function
@@ -484,7 +484,7 @@ for DMA::
 
 	#include <linux/dma-mapping.h>
 	/* DMA_ATTR_FOO should be defined in linux/dma-mapping.h and
-	* documented in Documentation/DMA-attributes.txt */
+	* documented in Documentation/core-api/dma-attributes.rst */
 	...
 
 		unsigned long attr;
diff --git a/Documentation/core-api/dma-isa-lpc.rst b/Documentation/core-api/dma-isa-lpc.rst
index b1ec7b16c21f..17b193603f0a 100644
--- a/Documentation/core-api/dma-isa-lpc.rst
+++ b/Documentation/core-api/dma-isa-lpc.rst
@@ -17,7 +17,7 @@ To do ISA style DMA you need to include two headers::
 	#include <asm/dma.h>
 
 The first is the generic DMA API used to convert virtual addresses to
-bus addresses (see Documentation/DMA-API.txt for details).
+bus addresses (see Documentation/core-api/dma-api.rst for details).
 
 The second contains the routines specific to ISA DMA transfers. Since
 this is not present on all platforms make sure you construct your
diff --git a/Documentation/driver-api/usb/dma.rst b/Documentation/driver-api/usb/dma.rst
index 59d5aee89e37..20ba7f19b331 100644
--- a/Documentation/driver-api/usb/dma.rst
+++ b/Documentation/driver-api/usb/dma.rst
@@ -10,7 +10,7 @@ API overview
 
 The big picture is that USB drivers can continue to ignore most DMA issues,
 though they still must provide DMA-ready buffers (see
-``Documentation/DMA-API-HOWTO.txt``).  That's how they've worked through
+``Documentation/core-api/dma-api-howto.rst``).  That's how they've worked through
 the 2.4 (and earlier) kernels, or they can now be DMA-aware.
 
 DMA-aware usb drivers:
@@ -60,7 +60,7 @@ and effects like cache-trashing can impose subtle penalties.
   force a consistent memory access ordering by using memory barriers.  It's
   not using a streaming DMA mapping, so it's good for small transfers on
   systems where the I/O would otherwise thrash an IOMMU mapping.  (See
-  ``Documentation/DMA-API-HOWTO.txt`` for definitions of "coherent" and
+  ``Documentation/core-api/dma-api-howto.rst`` for definitions of "coherent" and
   "streaming" DMA mappings.)
 
   Asking for 1/Nth of a page (as well as asking for N pages) is reasonably
@@ -91,7 +91,7 @@ Working with existing buffers
 Existing buffers aren't usable for DMA without first being mapped into the
 DMA address space of the device.  However, most buffers passed to your
 driver can safely be used with such DMA mapping.  (See the first section
-of Documentation/DMA-API-HOWTO.txt, titled "What memory is DMA-able?")
+of Documentation/core-api/dma-api-howto.rst, titled "What memory is DMA-able?")
 
 - When you're using scatterlists, you can map everything at once.  On some
   systems, this kicks in an IOMMU and turns the scatterlists into single
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index eaabc3134294..0e4947a8282d 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -546,8 +546,8 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	[*] For information on bus mastering DMA and coherency please read:
 
 	    Documentation/driver-api/pci/pci.rst
-	    Documentation/DMA-API-HOWTO.txt
-	    Documentation/DMA-API.txt
+	    Documentation/core-api/dma-api-howto.rst
+	    Documentation/core-api/dma-api.rst
 
 
 DATA DEPENDENCY BARRIERS (HISTORICAL)
@@ -1932,7 +1932,7 @@ There are some more advanced barrier functions:
      here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
-     relaxed I/O accessors and the Documentation/DMA-API.txt file for more
+     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for more
      information on consistent memory.
 
 
diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 34d041d68f78..604cee350e53 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -570,8 +570,8 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 	[*] 버스 마스터링 DMA 와 일관성에 대해서는 다음을 참고하시기 바랍니다:
 
 	    Documentation/driver-api/pci/pci.rst
-	    Documentation/DMA-API-HOWTO.txt
-	    Documentation/DMA-API.txt
+	    Documentation/core-api/dma-api-howto.rst
+	    Documentation/core-api/dma-api.rst
 
 
 데이터 의존성 배리어 (역사적)
@@ -1907,7 +1907,7 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
 
      writel_relaxed() 와 같은 완화된 I/O 접근자들에 대한 자세한 내용을 위해서는
      "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
-     위해선 Documentation/DMA-API.txt 문서를 참고하세요.
+     위해선 Documentation/core-api/dma-api.rst 문서를 참고하세요.
 
 
 =========================
-- 
2.19.1.3.ge56e4f7

