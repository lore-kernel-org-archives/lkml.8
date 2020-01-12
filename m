Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB8C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 11:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F3621744
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 11:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="wsfy+6bD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbgALLaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 06:30:16 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52861 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732675AbgALLaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 06:30:14 -0500
Received: by mail-wm1-f48.google.com with SMTP id p9so6586378wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 03:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0KuYFijWaSqVKsGb6hmrEpwICKO2Gc2adNnWdcjJlw=;
        b=wsfy+6bDlh8NItsWdLenHANbaQDJ/2Q/5oprrJQtdFmANH1Q3SN8JIOmXYHl5KVUkt
         Ku23Cv9TL2TMIuPQzIQN24suhDKs+fMn0554AP915uEc6x7fnAbqwXxIkZ93X8zM7DSA
         zRlCumyKb94KeJv9550up9JEmMdnuY9m94bn4Nfy8PKeGYS7IyYOjM/whydqMV7awaMm
         YRrxRGxsZF8tkdDeGEakURR4ExAeXl5J985xWbtQtYoPA+OKogpGeS0YT3h8wprVqsnz
         jEsL7zMl13Awf/ty791Gb70L4rzSHIf9dGU0JuXZ1a8AhtZOEbgkjB970B2pQ2tdI1M4
         K/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0KuYFijWaSqVKsGb6hmrEpwICKO2Gc2adNnWdcjJlw=;
        b=MA7WBzDgujPv5PcsUls3FQ7sbNlBrgg+LBMlNPgVSO3ZN96i59U9AqRHFIEeOgm8gE
         SUUkX862a5EhoqQhUHkjtP5stzRsEm9uORRBegHVy6l0bYIo117wAlPhliSPsFw2QT5g
         kDGFi3yrmWV+r86V7mbe/zWA30SV2FDO9WaFkJD8kA71cd3+93y6J+qn9TtaWHGqhiXq
         PVeFQTjRZ5NFzidFBKb4Cui9bXhv0Mw+l9INRaQgfAgFwnXzntI7noTUTF7q8vxWYiVJ
         tI9nX/xtBpctstWrHv69WE+JDxCZLT4mozAh48JM2DFIAReUbkBcxPdnIEF7nlfIvcyq
         wtfQ==
X-Gm-Message-State: APjAAAVzIa+E9bUeoIyVkO3wYjWf+3KVQLcfnZtGAHdx37zlYKBwdFBs
        LCEtEBjGCAJ/vmZ8HV7TkJcWEQ==
X-Google-Smtp-Source: APXvYqwZGTZ91ANJOl2LHDtI9FWkubYYOQQnYfUMMCvb50Z0DB4yd63j1mXbqM5okBU99AVs/6B90Q==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr14679045wmg.38.1578828612726;
        Sun, 12 Jan 2020 03:30:12 -0800 (PST)
Received: from localhost.localdomain (dh207-5-115.xnet.hr. [88.207.5.115])
        by smtp.googlemail.com with ESMTPSA id y17sm9943045wma.36.2020.01.12.03.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 03:30:12 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/3] dt-bindings: vqmmc-ipq4019-regulator: add binding document
Date:   Sun, 12 Jan 2020 12:30:02 +0100
Message-Id: <20200112113003.11110-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112113003.11110-1-robert.marko@sartura.hr>
References: <20200112113003.11110-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for the Qualcomm IPQ4019 VQMMC SD LDO driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../regulator/vqmmc-ipq4019-regulator.yaml    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml b/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
new file mode 100644
index 000000000000..d4d9b618d351
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/vqmmc-ipq4019-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ4019 VQMMC SD LDO regulator
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+properties:
+  $nodename:
+    pattern: "regulator(@.*)?$"
+  compatible:
+    const: qcom,vqmmc-ipq4019-regulator
+
+  regulator-name: true
+
+  reg:
+    maxItems: 1
+
+  regulator-min-microvolt:
+    description: smallest voltage consumers may set
+
+  regulator-max-microvolt:
+    description: largest voltage consumers may set
+
+  regulator-always-on:
+    description: boolean, regulator should never be disabled
+    type: boolean
+
+  additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulator-name
+  - regulator-min-microvolt
+  - regulator-max-microvolt
+  - regulator-always-on
+
+examples:
+  - |
+    regulator@1948000 {
+      compatible = "qcom,vqmmc-ipq4019-regulator";
+      reg = <0x01948000 0x4>;
+      regulator-name = "vqmmc";
+      regulator-min-microvolt = <1500000>;
+      regulator-max-microvolt = <3000000>;
+      regulator-always-on;
+      status = "disabled";
+    };
+...
-- 
2.24.1

