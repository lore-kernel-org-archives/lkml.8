Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30622C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0840E20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI+DrXub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgBGGQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:16:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42586 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgBGGQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:16:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id e8so562717plt.9;
        Thu, 06 Feb 2020 22:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLDRXPEmr92tJ/zW0EJ5LnXwFmsRZHZ9agSKK3TRvMc=;
        b=kI+DrXub+Bc0HwoHIQ/uBOvcuKrRA4Jte58ps5rM6l0GEkIoMVuiEtEnp+CyoWLngP
         n4TPr3qIyOzs5/zPH4o12NuMH0zQPmCYN5hNUuucVJl22IgI3vPHKzqhyiENFGuWq4fH
         PZ/PjB6KIZc0awYqwR0nS6Jb/H+5WVSj0WHD5ZRzdYMBdkHkCuUevuXB6uhSB+4f9IVL
         rDxpLNvNz7GJY+6ZOMe1p5M2oxaK5hGeKq/4V9phQkjt0dzRW5Z6D3xa/lKfDCCfT1jR
         1aZE1JQiYsn2DMZraNN379M0eLcWesDNR1gDjNsx4ZjBjT+LbpJrJn+fUcsPySmpXZ9v
         7dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLDRXPEmr92tJ/zW0EJ5LnXwFmsRZHZ9agSKK3TRvMc=;
        b=ceW++m0rMwsCP+STPizJuvMbmQxA/Lx/4PnxVLGarI1A9f6gJw5IzsFmrQudYM3mKg
         cTUSPMhP9Ba3et53d51lc9QWzOgxvi8f9BBtXPhLq+V/oux4RTOzokmgybLpWbJTeW1m
         tFbc1GnhyGqAnjlFcBVHdDY34EaAeUDYobR3fwRF9ZQbNaZpq8dlnMpY0APjNkDF0AZq
         upGOUPr5oxK6mO7IBw0vrWJE18Wfgn7gFCXzs/XhUJhWWUVYJ6lN3evVeTsOvOjrnFwe
         zcvF3qw3ymKY1gCw3rpuicVxgtrXhBQZLOLd4SKziT5iiG3FtG7NB5yfilClJpOHlED/
         ckLg==
X-Gm-Message-State: APjAAAXTaon7HJ+9s9nxw8fn5GEzcP7JXDXBSuGbwWO7Nx3jHedXrZxn
        JerT4Pgm2B5Rg26MkcE7TMsdE+obF8dQDg==
X-Google-Smtp-Source: APXvYqwkksJiPrNoPYwkBTejCkMOLN/C7NY720tvLxZhpVs1IQU1uqOY4TULZaCNouWXMf7IotdSCA==
X-Received: by 2002:a17:902:9b93:: with SMTP id y19mr8090102plp.89.1581056171645;
        Thu, 06 Feb 2020 22:16:11 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id gc1sm1127414pjb.20.2020.02.06.22.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 22:16:11 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH v3 2/2] dt-binding: spi: add bindings for spi-ar934x
Date:   Fri,  7 Feb 2020 14:14:06 +0800
Message-Id: <20200207061406.1735079-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207061406.1735079-1-gch981213@gmail.com>
References: <20200207061406.1735079-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for SPI controller in Qualcomm Atheros
AR934x/QCA95xx SoCs.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Change since v2:
replace clock binding in example with a bogus spi_clock to fix dt
binding check error.
Change since v1: none
 .../bindings/spi/qca,ar934x-spi.yaml          | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml b/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
new file mode 100644
index 000000000000..d90c81d4127d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/qca,ar934x-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros AR934x/QCA95xx SoC SPI controller
+
+maintainers:
+  - Chuanhong Guo <gch981213@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: qca,ar934x-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    spi: spi@1f000000 {
+        compatible = "qca,ar934x-spi";
+        reg = <0x1f000000 0x1c>;
+        clocks = <&spi_clock>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.24.1

