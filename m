Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D019C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FD62053B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0I1ifQad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgAQDvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:51:11 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56330 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgAQDvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:51:07 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B4CDD891AF;
        Fri, 17 Jan 2020 16:51:05 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579233065;
        bh=fRH1fOtTq3nwhWeBJY9OSVBx1/bx+wOXC/1lsHlEf+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=0I1ifQadS3Jx1N6SMXLWI8wK6VaBbmMKKLM45B+DcWd0FXtm91Feeqo3YIKGr+D3j
         27OuYHT3y5n2Zd9EYwp8vVb6WB3d8Q3dV5D6BSWzzRWehz0LDgRPoLJpNUQ7jwA/0M
         ZXTWp6abAq6YJsYYR7n7eo4vDzwwISDvnRnjGSuHdKjCPavcNY/oIlCzQtco4tfs/d
         74sRlE8VesA/oyIhIpSAMWHzJk2fTWQTcjPTr9RARw4Zc35NpUZUQrq3zBzIdK9QQ+
         nXpT3115tOX3YihKHxSt7w+ggSVUiChYnNGGbAjI2/XpShUu8soo1WMsroTMGw12ja
         6Zm3FP6AE1Opg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e212f290001>; Fri, 17 Jan 2020 16:51:05 +1300
Received: from logans-dl.ws.atlnz.lc (logans-dl.ws.atlnz.lc [10.33.25.61])
        by smtp (Postfix) with ESMTP id DD91E13EEFE;
        Fri, 17 Jan 2020 16:51:04 +1300 (NZDT)
Received: by logans-dl.ws.atlnz.lc (Postfix, from userid 1820)
        id 5DBE1C1A8B; Fri, 17 Jan 2020 16:51:05 +1300 (NZDT)
From:   Logan Shaw <logan.shaw@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz, logan.shaw@alliedtelesis.co.nz
Subject: [PATCH v3 2/2] hwmon: (adt7475) Added attenuator bypass support
Date:   Fri, 17 Jan 2020 16:50:18 +1300
Message-Id: <20200117035018.11985-3-logan.shaw@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117035018.11985-1-logan.shaw@alliedtelesis.co.nz>
References: <20200117035018.11985-1-logan.shaw@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a new file documenting the adt7475 devicetree and added the four
new properties to it.

Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
---
---
 .../devicetree/bindings/hwmon/adt7475.yaml    | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
new file mode 100644
index 000000000000..e201948beb35
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/adt7475.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADT7475 hwmon sensor
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+
+description: |
+  The ADT7473, ADT7475, ADT7476, and ADT7490 are thermal monitors and mu=
ltiple
+  PWN fan controllers.
+
+  They support monitoring and controlling up to four fans (the ADT7490 c=
an only
+  control up to three). They support reading a single on chip temperatur=
e
+  sensor and two off chip temperature sensors (the ADT7490 additionally
+  supports measuring up to three current external temperature sensors wi=
th
+  series resistance cancellation (SRC)).
+
+  Datasheets:
+  https://www.onsemi.com/pub/Collateral/ADT7473-D.PDF
+  https://www.onsemi.com/pub/Collateral/ADT7475-D.PDF
+  https://www.onsemi.com/pub/Collateral/ADT7476-D.PDF
+  https://www.onsemi.com/pub/Collateral/ADT7490-D.PDF
+
+  Description taken from omsemiconductors specification sheets, with min=
or
+  rephrasing.
+
+properties:
+  compatible:
+    enum:
+      - adi,adt7473
+      - adi,adt7475
+      - adi,adt7476
+      - adi,adt7490
+
+  reg:
+    maxItems: 1
+
+  bypass-attenuator-in0:
+    description: |
+      Configures bypassing the individual voltage input
+      attenuator, on in0. This is supported on the ADT7476 and ADT7490.
+      If set to a non-zero integer the attenuator is bypassed, if set to
+      zero the attenuator is not bypassed. If the property is absent the=
n
+      the config register is not modified.
+    maxItems: 1
+
+  bypass-attenuator-in1:
+    description: |
+      Configures bypassing the individual voltage input
+      attenuator, on in1. This is supported on the ADT7473, ADT7475,
+      ADT7476 and ADT7490. If set to a non-zero integer the attenuator
+      is bypassed, if set to zero the attenuator is not bypassed. If the
+      property is absent then the config register is not modified.
+    maxItems: 1
+
+  bypass-attenuator-in3:
+    description: |
+      Configures bypassing the individual voltage input
+      attenuator, on in3. This is supported on the ADT7476 and ADT7490.
+      If set to a non-zero integer the attenuator is bypassed, if set to
+      zero the attenuator is not bypassed. If the property is absent the=
n
+      the config register is not modified.
+    maxItems: 1
+
+  bypass-attenuator-in4:
+    description: |
+      Configures bypassing the individual voltage input
+      attenuator, on in4. This is supported on the ADT7476 and ADT7490.
+      If set to a non-zero integer the attenuator is bypassed, if set to
+      zero the attenuator is not bypassed. If the property is absent the=
n
+      the config register is not modified.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    hwmon@2e {
+      compatible =3D "adi,adt7476";
+      reg =3D <0x2e>;
+      bypass-attenuator-in1 =3D <1>;
+      bypass-attenuator-in1 =3D <0>;
+    };
+...
--=20
2.25.0

