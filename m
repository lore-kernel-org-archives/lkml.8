Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAF0C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E62224676
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfmemPcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgBMQkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:40:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33228 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgBMQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:40:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so7538275wrt.0;
        Thu, 13 Feb 2020 08:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2uFK6KKYdYtPUVDDYy0uzQtv76HpgnZNeuTDoj+jDo=;
        b=EfmemPcpI15FP/1eISeFgDAvHIXtZK3NjmSai3nK0kaddNyEb3kwxnYrMueDFUUeu5
         QZXPsxXUeKhm+I1xCUtqKpNbEFUrRG+W0xnv9+iBYhvw1HpaDj0XzuMIuU/41vpkdzJy
         2Zj7VZOOpDYX3rwrl969E0vMCN1vCDTSoomL1riWQ8I/nfkbsyPpQPHk/9t4CKyWXdOt
         8tnkI+e1GwURyuaF0LvmZJ5sU7PJHVxEG0McRg1k/sEyxCUcu6IlSzj+OQI2ZYRB6jLx
         npIlIBX0yaq9tDFy67rke6kHOCkCnJTuIipXoJgzFEzoUgiqxbw9615ulXtKQT3DQhXK
         /EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2uFK6KKYdYtPUVDDYy0uzQtv76HpgnZNeuTDoj+jDo=;
        b=VNkB1hZqxkLqMRoktoVozXMTfpaZ/NWI2hC2CvXvM1P5baHYM2tuIKwhFDAFj5et1L
         JM7xrnUzUp+Oxjj6nP22eT0XVsFb37n+Il+jR/lcpNyOAecCSAQAPN4XGQGJW2BKHIc4
         3qCYnUH9ON9/4xr59GwjrDJQaaww1r3w4OtdxPmDj1YkJrYmqbhYJG0wirZhj+KuncVk
         STOnRetYwVE2bEA2JOo/HP7fdvPdYWYmoxuylJLoDoSOdib7uvohuT2CMLw/ydS+jqho
         csYo+c8u6WXx+vwdxioV4L1pUWnp1xOcrjW8W9lgc1DiEr5+7on1SVypJjtKT0491eAS
         YzYg==
X-Gm-Message-State: APjAAAWdTJxb94hVAbX2Pq5u47tQj2zBshm0uTy10ucuINQj0x5dYVV0
        QGOwl8Zxri9x+TrrAJUwxVQ=
X-Google-Smtp-Source: APXvYqx8VQjaga8fOGZZT0G2o0Kvfo0ucpKfM5avVBwqi0khvmBAtSsPumSuFOqEEXt3q4LjhRwyEg==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr23784994wrv.302.1581612010365;
        Thu, 13 Feb 2020 08:40:10 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id o4sm3454944wrx.25.2020.02.13.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:40:08 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Olof Johansson <olof@lixom.net>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: Add memory controller bindings
Date:   Thu, 13 Feb 2020 17:39:55 +0100
Message-Id: <20200213163959.819733-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add the DT schema for memory controller and consumer bindings.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/memory-controllers/consumer.yaml | 14 ++++++++
 .../memory-controllers/memory-controller.yaml | 32 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/consumer.yaml b/Documentation/devicetree/bindings/memory-controllers/consumer.yaml
new file mode 100644
index 000000000000..7b71a6110c51
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/consumer.yaml
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common memory controller consumer binding
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+
+properties:
+  memory-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
diff --git a/Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml b/Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml
new file mode 100644
index 000000000000..26257a666c3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/memory-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common memory controller binding
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  The memory access hierarchy in a modern device can be fairly complicated.
+  Accesses to system memory typically end up going through a memory controller
+  that ensures that data is stored. Along the way, these accesses can undergo
+  classification and be prioritized and/or arbitrated.
+
+  The interconnect bindings (see ../interconnect/interconnect.txt) provides a
+  way of describing the data paths between devices and system memory. However
+  these interconnect paths, in order to be most flexible, describe the paths
+  in a very fine-grained way, so situations can arise where it is no longer
+  possible to derive a unique memory parent for any given device.
+
+  In order to remove such potential ambiguities, a memory controller can be
+  specified in device tree. A memory controller specified in this way will be
+  used as the DMA parent for a given device. The memory controller defines a
+  memory bus via the "dma-ranges" property, which will in turn be used to set
+  the range of memory accessible to DMA children of the memory controller.
+
+properties:
+  "#memory-controller-cells": true
+  dma-ranges: true
-- 
2.24.1

