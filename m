Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3035FC43458
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE8421D95
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FFJEqir1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgG1FCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgG1FCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:02:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE345C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:02:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so11209684pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quJpJ8MFVCXxN2uUe5uCTDrzupsmhmPuwJ3x/xpP/Nw=;
        b=FFJEqir1hVkStEtfk+rEgzo8ZUuB5JUH7sJuO0JVeZhFlRfq6eDnq0M4SOi7xAzJNL
         Lg/B3hHFlX31yqXoVUvS53JbUcgSOfKFc9jlDruvAYag4p2p8uxI5CayvTuyOTxTzb2Y
         CmbNlaHf7A4Fl7V3TquMd4DohiBBSI7zhVcCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quJpJ8MFVCXxN2uUe5uCTDrzupsmhmPuwJ3x/xpP/Nw=;
        b=BrzigtoeJRphYe4x3PkbPM4+n81MEOmTIhVMHciJD/Qx6TA10Da9Iz4kY5c0qxa+nn
         fqw1jCq4GLuVQpE5KBXU8+KdVkPsBQ4pNZjYNdCKPJIgSLHzj6keKcGmB2w+Wp8ZbDpK
         8RliktJFHJBpH02nWbJ63DSRA9eknkUpwWRugSOtl8yUtFDT5V7yzQsi9IAorp7jwVUD
         IK22enrfyRjxrGTEW2v5g90wyxcepu5BNXDEOMip24SrVL819b3YXFpTe6Nails2r4AW
         zseKyKptd4lTSnqA+I2CAH/M8RPWoJ//x2LQlokoeXclAWffJhl5e1fXEBaKHoFcTd1n
         n55A==
X-Gm-Message-State: AOAM530QcBDGDmHUrf57o9irJNOux2+m7fjj2ipMU7uL8t56EbdWDD0V
        ijk+OcICxLgb7Sz+RpGLeonscg==
X-Google-Smtp-Source: ABdhPJxRMJ3gCBUPChJ2eZ/7cp0FgFLdngDiw44ugrhRF2b1gUjV2mSJdfqzvUQMjkMMzXOG1e/voQ==
X-Received: by 2002:a65:428d:: with SMTP id j13mr23297111pgp.211.1595912526277;
        Mon, 27 Jul 2020 22:02:06 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id a26sm17578156pgm.20.2020.07.27.22.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 22:02:05 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     treding@nvidia.com, gregkh@linuxfoundation.org,
        saravanak@google.com, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        drinkcat@chromium.org, tfiga@chromium.org, tientzu@chromium.org
Subject: [RFC v2 4/5] dt-bindings: of: Add plumbing for restricted DMA pool
Date:   Tue, 28 Jul 2020 13:01:39 +0800
Message-Id: <20200728050140.996974-5-tientzu@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728050140.996974-1-tientzu@chromium.org>
References: <20200728050140.996974-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the new compatible string, device-swiotlb-pool, for restricted
DMA. One can specify the address and length of the device swiotlb memory
region by device-swiotlb-pool in the device tree.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 .../reserved-memory/reserved-memory.txt       | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index 4dd20de6977f..78850896e1d0 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -51,6 +51,24 @@ compatible (optional) - standard definition
           used as a shared pool of DMA buffers for a set of devices. It can
           be used by an operating system to instantiate the necessary pool
           management subsystem if necessary.
+        - device-swiotlb-pool: This indicates a region of memory meant to be
+          used as a pool of device swiotlb buffers for a given device. When
+          using this, the no-map and reusable properties must not be set, so the
+          operating system can create a virtual mapping that will be used for
+          synchronization. Also, there must be a restricted-dma property in the
+          device node to specify the indexes of reserved-memory nodes. One can
+          specify two reserved-memory nodes in the device tree. One with
+          shared-dma-pool to handle the coherent DMA buffer allocation, and
+          another one with device-swiotlb-pool for regular DMA to/from system
+          memory, which would be subject to bouncing. The main purpose for
+          restricted DMA is to mitigate the lack of DMA access control on
+          systems without an IOMMU, which could result in the DMA accessing the
+          system memory at unexpected times and/or unexpected addresses,
+          possibly leading to data leakage or corruption. The feature on its own
+          provides a basic level of protection against the DMA overwriting buffer
+          contents at unexpected times. However, to protect against general data
+          leakage and system memory corruption, the system needs to provide a
+          way to restrict the DMA to a predefined memory region.
         - vendor specific string in the form <vendor>,[<device>-]<usage>
 no-map (optional) - empty property
     - Indicates the operating system must not create a virtual mapping
@@ -117,6 +135,16 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 			compatible = "acme,multimedia-memory";
 			reg = <0x77000000 0x4000000>;
 		};
+
+		wifi_coherent_mem_region: wifi_coherent_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0x50000000 0x400000>;
+		};
+
+		wifi_device_swiotlb_region: wifi_device_swiotlb_region {
+			compatible = "device-swiotlb-pool";
+			reg = <0x50400000 0x4000000>;
+		};
 	};
 
 	/* ... */
@@ -135,4 +163,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 		memory-region = <&multimedia_reserved>;
 		/* ... */
 	};
+
+	pcie_wifi: pcie_wifi@0,0 {
+		memory-region = <&wifi_coherent_mem_region>,
+			 <&wifi_device_swiotlb_region>;
+		restricted-dma = <0>, <1>;
+		/* ... */
+	};
 };
-- 
2.28.0.rc0.142.g3c755180ce-goog

