Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55142C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0FA24653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0T5/Ac8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgBUPgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:36:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45958 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgBUPgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:36:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id g3so2519809wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqEQ5jIvmw/mgMvZjaDSuL/3Rd6IGcOEgjWBEmD6jMI=;
        b=0T5/Ac8pG7SCsz1cnqyRMc5cIe8ygGAkotY1PXusnbjm2tsypcs42va2MNYIt+jzo9
         fFCnrYMJUF63MuM3G0CSFskZDpMHle3oiotewtYHh4W5k3vtQcz2iqRcO1aHRoFISH5Y
         UnjzTndrHEMh0uxLwF/XWDyIaQaracyyLucz4qj7vFEcRTZoRB85sgec+5ZQtcK8Tiwv
         GYnbwnpsrUxGRlhbqVQnq8y6zNPsMrULb4Lhh4hI6/ASo2Lc8w7inycVZHkrH6RH9y+t
         A7L6O49B8hCYUkdcvlh9t/0nx1Qbxmw1teBjfu0X0QRJzGBg4UBAMbtltS3hW3VFysWd
         IKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqEQ5jIvmw/mgMvZjaDSuL/3Rd6IGcOEgjWBEmD6jMI=;
        b=QFBiw8Lo3BVnlPYQesyWeDI0IQVeHra/WNkMmBZGv/o1tPqMsyDqrNSgSDbJ1lkJty
         WzS5KMrbpsI4gck5XVDVGhNM8pAfAQEbGom1Lw4c/MHwIZCs4wStbaKMlwX07ROIXYmM
         r1X3fkNW/rnLPj4l2JmSD9rETLoja3H54DuTs5kJ8vkuyzwyVQxnLCNcpLZ9YblnRiDN
         MlYORpUUEWvRpFuR53R72llYCPYudfGTLW5jCWBvSNIksGafmRoCKUaZGxYJHeG2uUOp
         u+Lv/VqsoleSYVIA1JcjomJGjw8e3VgzWTIlGtRvhwUqqhG5RoXS2B+g3pAlkOxindt8
         361A==
X-Gm-Message-State: APjAAAUn9XNgB5twYyB2H1ZgE8jMF80nrcME474Uf4ZcUnHkBioFSCd2
        1scGOApHcvq4j8YxSrLe1QxbAg==
X-Google-Smtp-Source: APXvYqw1G4TbUaW+Wcge3OpS17t14liivURN0gi87EFAbocCrA/IOohQfIWFsXyFdpZDZilJgBztOA==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr47970495wrp.236.1582299375762;
        Fri, 21 Feb 2020 07:36:15 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id z25sm4198782wmf.14.2020.02.21.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:36:15 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 1/3] ASoC: meson: g12a: add toacodec dt-binding documentation
Date:   Fri, 21 Feb 2020 16:36:05 +0100
Message-Id: <20200221153607.1585499-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221153607.1585499-1-jbrunet@baylibre.com>
References: <20200221153607.1585499-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT bindings and documentation of the internal audio DAC glue found
on Amlogic g12a and sm1 SoC families

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,g12a-toacodec.yaml | 51 +++++++++++++++++++
 .../dt-bindings/sound/meson-g12a-toacodec.h   | 10 ++++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
 create mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h

diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
new file mode 100644
index 000000000000..f778d3371fde
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,g12a-toacodec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic G12a Internal DAC Control Glue
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller@.*"
+
+  "#sound-dai-cells":
+    const: 1
+
+  compatible:
+    oneOf:
+      - items:
+        - const:
+            amlogic,g12a-toacodec
+      - items:
+        - enum:
+          - amlogic,sm1-toacodec
+        - const:
+            amlogic,g12a-toacodec
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
+
+    toacodec: audio-controller@740 {
+        compatible = "amlogic,g12a-toacodec";
+        reg = <0x0 0x740 0x0 0x4>;
+        #sound-dai-cells = <1>;
+        resets = <&clkc_audio AUD_RESET_TOACODEC>;
+    };
diff --git a/include/dt-bindings/sound/meson-g12a-toacodec.h b/include/dt-bindings/sound/meson-g12a-toacodec.h
new file mode 100644
index 000000000000..69d7a75592a2
--- /dev/null
+++ b/include/dt-bindings/sound/meson-g12a-toacodec.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_MESON_G12A_TOACODEC_H
+#define __DT_MESON_G12A_TOACODEC_H
+
+#define TOACODEC_IN_A	0
+#define TOACODEC_IN_B	1
+#define TOACODEC_IN_C	2
+#define TOACODEC_OUT	3
+
+#endif /* __DT_MESON_G12A_TOACODEC_H */
-- 
2.24.1

