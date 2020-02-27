Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25D2C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760A92467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CjbJo2R2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgB0IrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:47:10 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40273 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgB0Iqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:46:54 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2D16A891AD;
        Thu, 27 Feb 2020 21:46:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1582793212;
        bh=EVlEwiS/TFFN1q66aMSFRrpHv5REOLeczvMuwQi/uGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CjbJo2R2MQonW8SHlpPrWcGrqNEX21yj5DWeIK1/xIJPI4Ya6juJoMDc+VzGgj4fn
         8H/pN32ifgz69atfxNnkxKcu3NkikGMsEV6aEf7wkaYdLUdQPkPLYIPYod6iLYfVJF
         50ElomjbzXUYZpOQ2b3l82yrSTwOxKwUu5R9Qb5F8OSIa0FjTtXPpB8+SKymPSdv8d
         TVEOzUdmemh9pEfU42HsUJDqZdcAChfNgQw1lIIKDIHGFN4ZCupwFIJsaZtGCB1ypz
         m9NXc34Wj+dLi0wouBZaRppFTNOPh9pHnj5LdiGr0qkmLyie5JACws8L1+DPS62OVk
         Xw6Vduc+4v8lQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e5781fb0003>; Thu, 27 Feb 2020 21:46:51 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 3F63313EECD;
        Thu, 27 Feb 2020 21:46:51 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 0581F280072; Thu, 27 Feb 2020 21:46:52 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 3/5] dt-bindings: hwmon: Document adt7475 pwm-active-state property
Date:   Thu, 27 Feb 2020 21:46:40 +1300
Message-Id: <20200227084642.7057-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
References: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding information for the adi,pwm-active-state property.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v5:
    - change to adi,pwm-active-state
    - uint32 array
   =20
    Changes in v4:
    - use $ref uint32 and enum
    - add adi vendor prefix
   =20
    Cahnges in v3:
    - new

 .../devicetree/bindings/hwmon/adt7475.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index e40612ee075f..76985034ea73 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -50,6 +50,19 @@ patternProperties:
      - $ref: /schemas/types.yaml#/definitions/uint32
      - enum: [0, 1]
=20
+  "^adi,pwm-active-state$":
+    description: |
+      Integer array, represents the active state of the pwm outputs If s=
et to 0
+      the pwm uses a logic low output for 100% duty cycle. If set to 1 t=
he pwm
+      uses a logic high output for 100% duty cycle.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 3
+        maxItems: 3
+        items:
+          enum: [0, 1]
+          default: 1
+
 required:
   - compatible
   - reg
@@ -65,6 +78,7 @@ examples:
         reg =3D <0x2e>;
         adi,bypass-attenuator-in0 =3D <1>;
         adi,bypass-attenuator-in1 =3D <0>;
+        adi,pwm-active-state =3D <1 0 1>;
       };
     };
=20
--=20
2.25.1

