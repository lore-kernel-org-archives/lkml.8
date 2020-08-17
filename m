Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDDCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2020A20772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650661;
	bh=FiVFRusfj9DjxEECqrLRwnPwn3v/1jVkijJ8N2ump8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QEaOSeUNfXTDqP2fBem1P5MCJ+XovwMap3R9G4LyGlFZ6fF5BZHY51lgyOT+/z67Y
	 rnHrEG6hesteZE6rfky0uPl3ZtNoYcKzI06n/7uALbsUrpAllIoIEOa785mktdgwKM
	 hRwGS/DMeO69iHC0Y4tlZntE42rh/y+hUKO88v6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHQHul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgHQHu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:26 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C71A22CAD;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=FiVFRusfj9DjxEECqrLRwnPwn3v/1jVkijJ8N2ump8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhMMGunmpgK8vFWnOdTQ2I8t9MbghOejJRSb+BTP9jycrNykrJQP3kz4Br4sXCn0s
         4wwBV/Lx6SIIapFKypuni/Kbn41IlmBg7YFmeu7+n7UCekd4w/Oh6G6JMLRekvyPwg
         LRgUpuTisRQGkhsAJDrp8QBMM9mEU6AgEfstMrh4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00BfcU-FM; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] dt: add an spec for the Kirin36x0 SMMU
Date:   Mon, 17 Aug 2020 09:50:13 +0200
Message-Id: <0fa3a11f63e68fdef3a8aa8d45f1df4d0832dcac.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the properties expected by the IOMMU driver used on
Hikey960 and Hikey970 boards.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../iommu/hisilicon,kirin36x0-smmu.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml b/Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml
new file mode 100644
index 000000000000..ec4c98faf3a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/hisilicon,kirin36x0-smmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon support for HI3660/HI3670 SMMU
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description: |+
+  Huawei's Hisilicon Kirin 3660/3670 contains a System MMU that enables
+  scattered physical memory chunks visible as a contiguous region to
+  DMA-capable peripheral devices like GPU and ISP.
+
+  The IOMMU domains are described via iommu_info settings.
+
+properties:
+  compatible:
+    const: hisilicon,hisi-smmu-lpae
+
+  iommu_info:
+    type: object
+
+    properties:
+      start-addr:
+        maxItems: 1
+        description: Memory start address (32 bits)
+
+      size:
+        maxItems: 1
+        description: size of the I/O MMU block (32 bits)
+
+      iova-align:
+        minItems: 2
+        maxItems: 2
+        description: DMA address alignment of the mapped memory (64 bits)
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    smmu_lpae {
+      compatible = "hisilicon,smmu-lpae";
+
+      iommu_info {
+        start-addr = <0x40000>;
+        size = <0xbffc0000>;
+        iova-align = <0x0 0x8000>;
+      };
+    };
-- 
2.26.2

