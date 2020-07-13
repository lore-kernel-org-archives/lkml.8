Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4428AC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B41720702
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e67OPwf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgGMJMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:12:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD3C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:12:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so5714285pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+P8dd4dsLzR3swPupkVuVT/gmICFutJbXFpV5NolUAQ=;
        b=e67OPwf1HIbj3XR4EOfuTCpxuygeGjjAfXvsgSif0nsuT/tPms6AxxDckXWU9kQ4el
         HVxOOk1iLRoQoAHU1WwmubXO5KyvzzdzXKmHm2RMInBlI1sC1gw6YiMKd4GHMPeZjcyk
         CxiYiu9iHJ53DICoiCsewCTgy6pX9Yf2fElGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+P8dd4dsLzR3swPupkVuVT/gmICFutJbXFpV5NolUAQ=;
        b=R0JtQ/gQ+qxvUETJJjERqxG3AJechXXp6cwMow0cvYvnY+OmNbtTkM1lcZO5JTR8xy
         IKc5n9M+mrTNmnYLaHDwGrztf4fPAyzDTLkKrX6G1zKFDGWL9vZAz+obOluU5rNjnbVM
         HgzuLauLGqlKHaAn6xqYbyC9AxV/NSJY8cpeWmkAAY3I+zVSuph+/qrzcHBaP62P6x22
         6+hbeWjhVILguir38s4RdoJi+XeM0CN2Tyx2duRwA2EiguxBNwoTz9A/Hf6GUHDDZE4b
         U4f9ovMuloRBz1JOksT5HZylAe0wwXqZv7PRhn3T5hMnC8xtDxgDyY8vOQaZ0WOABlCg
         sB1A==
X-Gm-Message-State: AOAM530vjvcWORcO5pQ9I8AYr+0pvSAnjfRliEgtCzuzA8k+KzuLVXOX
        nJWWNxoDGiVfnn2o1aH9HKYpIw==
X-Google-Smtp-Source: ABdhPJwiVcgRHj8QaLGk5eyRoZthzOPp5a/LkxFv7ElLZgecHc8H4MvmE9E/lcRqY9ykY343uYMmDg==
X-Received: by 2002:a63:1104:: with SMTP id g4mr66811073pgl.369.1594631569568;
        Mon, 13 Jul 2020 02:12:49 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id i132sm13807520pfe.9.2020.07.13.02.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 02:12:48 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     treding@nvidia.com, gregkh@linuxfoundation.org,
        saravanak@google.com, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        tfiga@chromium.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH 3/4] dt-bindings: of: Add plumbing for bounced DMA pool
Date:   Mon, 13 Jul 2020 17:12:10 +0800
Message-Id: <20200713091211.2183368-4-tientzu@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713091211.2183368-1-tientzu@chromium.org>
References: <20200713091211.2183368-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the new compatible string, bounced-dma-pool, for bounced DMA.
One can specify the address and length of the bounced memory region by
bounced-dma-pool in the device tree.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 .../reserved-memory/reserved-memory.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index 4dd20de6977f..45b3134193ea 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -51,6 +51,24 @@ compatible (optional) - standard definition
           used as a shared pool of DMA buffers for a set of devices. It can
           be used by an operating system to instantiate the necessary pool
           management subsystem if necessary.
+        - bounced-dma-pool: This indicates a region of memory meant to be used
+          as a pool of DMA bounce buffers for a given device. When using this,
+          the no-map and reusable properties must not be set, so the operating
+          system can create a virtual mapping that will be used for
+          synchronization. Also, there must be a bounced-dma property in the
+          device node to specify the indexes of reserved-memory nodes. One can
+          specify two reserved-memory nodes in the device tree. One with
+          shared-dma-pool to handle the coherent DMA buffer allocation, and
+          another one with bounced-dma-pool for regular DMA to/from system
+          memory, which would be subject to bouncing. The main purpose for
+          bounced DMA is to mitigate the lack of DMA access control on systems
+          without an IOMMU, which could result in the DMA accessing the system
+          memory at unexpected times and/or unexpected addresses, possibly
+          leading to data leakage or corruption. The feature on its own provides
+          a basic level of protection against the DMA overwriting buffer
+          contents at unexpected times. However, to protect against general data
+          leakage and system memory corruption, the system needs to provide a
+          way to restrict the DMA to a predefined memory region.
         - vendor specific string in the form <vendor>,[<device>-]<usage>
 no-map (optional) - empty property
     - Indicates the operating system must not create a virtual mapping
@@ -117,6 +135,17 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 			compatible = "acme,multimedia-memory";
 			reg = <0x77000000 0x4000000>;
 		};
+
+		wifi_bounced_dma_mem_region: wifi_bounced_dma_mem_region {
+			compatible = "bounced-dma-pool";
+			reg = <0x50000000 0x4000000>;
+		};
+
+		wifi_coherent_mem_region: wifi_coherent_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0x54000000 0x400000>;
+		};
+
 	};
 
 	/* ... */
@@ -135,4 +164,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 		memory-region = <&multimedia_reserved>;
 		/* ... */
 	};
+
+	pcie_wifi: pcie_wifi@0,0 {
+		memory-region = <&wifi_bounced_dma_mem_region>,
+			 <&wifi_coherent_mem_region>;
+		bounced-dma = <0>, <1>;
+		/* ... */
+	};
 };
-- 
2.27.0.383.g050319c2ae-goog

