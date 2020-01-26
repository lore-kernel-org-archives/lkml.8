Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA335C35246
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6CB206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="BGznTRfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAZWKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:10:37 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40323 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgAZWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 17:10:34 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2F37A891A9;
        Mon, 27 Jan 2020 11:10:33 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580076633;
        bh=zeFePKo6fhbCcfDQ2OhTCgA3upjarST3rYiHMVEi89M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BGznTRfO5sN7M+oQ88oLAP30KKUOxLXp5Cc7yKuPsgpvnzJckq2ILigXesgN0jbWB
         9hlE+YiZ/nzw3IAXbSYKetDEpWrDfZVOak4OLoNh7vZDgt+YlQACBYwMru76vO7jM7
         WK2Fvr8PE2foQtchitXxllYlOQIhaO4LrkK89qvbZCg9g8qQ9tb6/ei2ps6Nyj/xwg
         LParGQ7Vco5LxGxqUtLkrcHHSAmETp0N+1MaAqCQo7j85XVVUZXtk6Lvqa5tLGmYC+
         NW4eOtxBybY38cIV4fhGnHzQudbmM+EVk1nfNWtM260H4MH9KMUe0TbwpKTs3c+FpB
         XdgvrmNEJlfUg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e2e0e580000>; Mon, 27 Jan 2020 11:10:32 +1300
Received: from logans-dl.ws.atlnz.lc (logans-dl.ws.atlnz.lc [10.33.25.61])
        by smtp (Postfix) with ESMTP id B6CDA13EEB9;
        Mon, 27 Jan 2020 11:10:31 +1300 (NZDT)
Received: by logans-dl.ws.atlnz.lc (Postfix, from userid 1820)
        id CD3DEC0DF6; Mon, 27 Jan 2020 11:10:32 +1300 (NZDT)
From:   Logan Shaw <logan.shaw@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz, logan.shaw@alliedtelesis.co.nz
Subject: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing adt7475 documentation
Date:   Mon, 27 Jan 2020 11:10:14 +1300
Message-Id: <20200126221014.2978-3-logan.shaw@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
References: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
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
 .../devicetree/bindings/hwmon/adt7475.yaml    | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
new file mode 100644
index 000000000000..450da5e66e07
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -0,0 +1,95 @@
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
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      hwmon@2e {
+        compatible =3D "adi,adt7476";
+        reg =3D <0x2e>;
+        bypass-attenuator-in0 =3D <1>;
+        bypass-attenuator-in1 =3D <0>;
+      };
+    };
+...
--=20
2.25.0

