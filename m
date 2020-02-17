Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D94C34032
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C78320801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="R39e78dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBQXrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:47:05 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48787 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgBQXrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:47:04 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3C9AE886BF;
        Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581983220;
        bh=LCdEDn9KJ4fwe8poCq2FY9dzyr8T+/O5ezxx8nHK8bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R39e78dJootCQTeSVSI1wDXS/baejRZdPkqj17MC5gc505Fp7INNxb62OLUo3bNQQ
         MzWJ/dhAgeer545B+cyLS5BDpCo3gY2DkUZ69CHzYTb8q9GWTqx3jdqXR9HYDrJ15Q
         v1jvAwXgDEj9Ei5LNuVBpik2u9JBLXUjez6PKEa9yWCuQU1YmMWdmt2NohkYe+wx0d
         VLEctjnOfOqR8khXdbVybKMVX8Q1vvtCEyvx+KzRCs7BnLtFO6S+kyzTRt9VrZh0dI
         1Qy++8crwWT8vEVjM2msz0l3JzZu4w0lQaoA6Qmu8Vnsk3vktThhtqrdklc23QPLfd
         q1PwuNNf90Qfw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4b25f30001>; Tue, 18 Feb 2020 12:46:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 85E8713EED4;
        Tue, 18 Feb 2020 12:46:59 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 01FA428006C; Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/5] dt-bindings: hwmon: Document adt7475 binding
Date:   Tue, 18 Feb 2020 12:46:53 +1300
Message-Id: <20200217234657.9413-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
References: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>

Add binding for adi,adt7475 and variants.
Remove from trivial-devices.

Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/hwmon/adt7475.yaml    | 57 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  8 ---
 2 files changed, 57 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
new file mode 100644
index 000000000000..2252499ea201
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
+  Description taken from onsemiconductors specification sheets, with min=
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
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      hwmon@2e {
+        compatible =3D "adi,adt7476";
+        reg =3D <0x2e>;
+      };
+    };
+
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
index 978de7d37c66..57173ec41c30 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -34,14 +34,6 @@ properties:
           - adi,adt7461
             # +/-1C TDM Extended Temp Range I.C
           - adt7461
-            # +/-1C TDM Extended Temp Range I.C
-          - adi,adt7473
-            # +/-1C TDM Extended Temp Range I.C
-          - adi,adt7475
-            # +/-1C TDM Extended Temp Range I.C
-          - adi,adt7476
-            # +/-1C TDM Extended Temp Range I.C
-          - adi,adt7490
             # Three-Axis Digital Accelerometer
           - adi,adxl345
             # Three-Axis Digital Accelerometer (backward-compatibility v=
alue "adi,adxl345" must be listed too)
--=20
2.25.0

