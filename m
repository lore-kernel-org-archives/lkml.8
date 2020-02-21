Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C64AC11D2B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1050F20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2YXdz4oF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgBUEQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:16:46 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58141 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgBUEQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:16:45 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E1674891A9;
        Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1582258603;
        bh=1IbgMe7uSVweJ14EZmRPTWbfcngs93L74TZLpxRax5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=2YXdz4oFn2Rx6FydDlGzQynCoKZn4jiq2vCjsoR7YBclpDLJdItEDpDTI4wMShrkY
         AQ7PEiwmRYCjq5KgcNuyGCeIS5nCnazBFbx86l1eVcy7ZeG/hyQ7vU18fbJDX6/VtO
         7mjNw3w1JHBSiZCvQGAhfD9EQAvGDJ3DZH/wfEP07pcZ5KNZi3E2J3RA16rwfz5gy9
         wyTsMCoUFFeWQpd1IT8mNlYox3FRzDsrY4DlM6avHYrwCOd9E4F5+O2JPfhkIArJdQ
         jfYkOL+k0MmSCKhLABNoWvt/xgtHbn46zFjsNzhcMzQvCGVFCtkK57I/P8IXPolUXY
         ngiK/zyIRM1Lg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4f59ac0001>; Fri, 21 Feb 2020 17:16:44 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 01D4513EECD;
        Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8954E28006D; Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, logan.shaw@alliedtelesis.co.nz,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 2/5] dt-bindings: hwmon: Document adt7475 bypass-attenuator property
Date:   Fri, 21 Feb 2020 17:16:28 +1300
Message-Id: <20200221041631.10960-3-chris.packham@alliedtelesis.co.nz>
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

From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>

Add documentation for the bypass-attenuator-in[0-4] property.

Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v4:
    - use $ref uint32 and enum
    - add 'adi' vendor prefix
   =20
    Changes in v3:
    - separated addition of new properties from conversion to yaml

 .../devicetree/bindings/hwmon/adt7475.yaml          | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 2252499ea201..e40612ee075f 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -39,6 +39,17 @@ properties:
   reg:
     maxItems: 1
=20
+patternProperties:
+  "^adi,bypass-attenuator-in[0-4]$":
+    description: |
+      Configures bypassing the individual voltage input attenuator. If
+      set to 1 the attenuator is bypassed if set to 0 the attenuator is
+      not bypassed. If the property is absent then the attenuator
+      retains it's configuration from the bios/bootloader.
+    allOf:
+     - $ref: /schemas/types.yaml#/definitions/uint32
+     - enum: [0, 1]
+
 required:
   - compatible
   - reg
@@ -52,6 +63,8 @@ examples:
       hwmon@2e {
         compatible =3D "adi,adt7476";
         reg =3D <0x2e>;
+        adi,bypass-attenuator-in0 =3D <1>;
+        adi,bypass-attenuator-in1 =3D <0>;
       };
     };
=20
--=20
2.25.0

