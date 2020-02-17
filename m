Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732E3C3402F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CFC207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="diM4mqD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgBQXrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:47:04 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48798 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgBQXrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:47:03 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6EEBF891AA;
        Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581983220;
        bh=1a/51WDLn9XkdpMM9d1aDZunsHAxv048R7hDlfT3FEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=diM4mqD6s1TuhntWRO9wJmnVRCDRUpti2kBmaE8UQ0XjxJ4lcGEHhfQ7x8uWyDpTs
         cpgSNlhWR69TYY+Y+2PM5pHkJLq+maXIge/t3Nctrh4c6SyrN5SfSxKwzeD2Db/Fl1
         YN/XD6iFbWgFFHZn34z0HNQfRHSw/YxGtZ4ULHU/SfK+YKDQAvNC7ViugGMfENsMFT
         Dh2EJF69VbwiOrHXhL74KrJOyGwtmeJU55XlJ2YVq1eNC9EoH0r2imEyCLg2ZYYYBj
         D5E6rT16ULfUVE7/YzM4RWHOjno7yLlpkfUzCfEMd3M5bOKNV5Uu0UouOC2kWn0u9I
         8FvxMcDLStoXA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4b25f30003>; Tue, 18 Feb 2020 12:46:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id CAF9E13EED4;
        Tue, 18 Feb 2020 12:46:59 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4745D28006C; Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 3/5] dt-bindings: hwmon: Document adt7475 invert-pwm property
Date:   Tue, 18 Feb 2020 12:46:55 +1300
Message-Id: <20200217234657.9413-4-chris.packham@alliedtelesis.co.nz>
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

Add binding information for the invert-pwm property.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/devicetree/bindings/hwmon/adt7475.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 61da90c82649..c11c9a3d9a64 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -50,6 +50,17 @@ patternProperties:
       not bypassed. If the property is absent then the attenuator
       retains it's configuration from the bios/bootloader.
=20
+  "^invert-pwm[1-3]$":
+    maxItems: 1
+    minimum: 0
+    maximum: 1
+    description: |
+      Configures the pwm output to use inverted logic. If set to 1
+      the pwm uses a logic low output for 100% duty cycle. If set
+      to 0 the pwm uses a logic high output for 100% duty cycle.
+      If the property is absent the pwm retains it's configuration
+      from the bios/bootloader.
+
 required:
   - compatible
   - reg
@@ -65,6 +76,7 @@ examples:
         reg =3D <0x2e>;
         bypass-attenuator-in0 =3D <1>;
         bypass-attenuator-in1 =3D <0>;
+        invert-pwm1 =3D <1>;
       };
     };
=20
--=20
2.25.0

