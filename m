Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A7DC11D29
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606E124676
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="JznCo4/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgBUEQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:16:46 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58145 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbgBUEQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:16:45 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E27A0891AA;
        Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1582258603;
        bh=uyQ2DBeRxZwKGi/wDcdyCc4BoWSFgZunk5Ddx35iWJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JznCo4/JdMKLdLlPnPztkV4QM8i3v4C9UKH5cecmxx9fRvMXJ0cAIDIThJVvvpd7i
         YHZcrHKKsV7r8Ga+YO/96oIAk45/AHL7D75yfOgrGPBxmDqVnbYFmzI97fYgwqlYFK
         gl+WNdw8Z2o/0szrySBVivRj8QCUtbrEAnxny/7bIIw+EJgD5v6zUW+MZ1EzRGWwmd
         u5znsyCEwqYgAkmyZm95fuVdpOgaZDzehSVw/Dlf6UDDkt09qiC+1KZoeA6GTYI6zP
         xiCglm2ABeik7fZYMro9slur8T5VGvRGdSgWEI9dKGBYhhN89kXP3FVpXdrokcMPu0
         4qcdl9IFyKS+g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4f59ac0002>; Fri, 21 Feb 2020 17:16:44 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 211A613EECD;
        Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A818728006D; Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, logan.shaw@alliedtelesis.co.nz,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 3/5] dt-bindings: hwmon: Document adt7475 invert-pwm property
Date:   Fri, 21 Feb 2020 17:16:29 +1300
Message-Id: <20200221041631.10960-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz>
References: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding information for the invert-pwm property.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v4:
    - use $ref uint32 and enum
    - add adi vendor prefix
   =20
    Cahnges in v3:
    - new

 Documentation/devicetree/bindings/hwmon/adt7475.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index e40612ee075f..6a358b30586c 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -50,6 +50,17 @@ patternProperties:
      - $ref: /schemas/types.yaml#/definitions/uint32
      - enum: [0, 1]
=20
+  "^adi,invert-pwm[1-3]$":
+    description: |
+      Configures the pwm output to use inverted logic. If set to 1
+      the pwm uses a logic low output for 100% duty cycle. If set
+      to 0 the pwm uses a logic high output for 100% duty cycle.
+      If the property is absent the pwm retains it's configuration
+      from the bios/bootloader.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1]
+
 required:
   - compatible
   - reg
@@ -65,6 +76,7 @@ examples:
         reg =3D <0x2e>;
         adi,bypass-attenuator-in0 =3D <1>;
         adi,bypass-attenuator-in1 =3D <0>;
+        adi,invert-pwm1 =3D <1>;
       };
     };
=20
--=20
2.25.0

