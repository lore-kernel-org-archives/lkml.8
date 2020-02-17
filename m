Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF45C34031
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C3A2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DEEc8jKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgBQXrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:47:04 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48794 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgBQXrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:47:03 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 681C3891A9;
        Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581983220;
        bh=lIKEtIoXS2FCD30rLdTZz7ER2jiWy8CL5ADzRqw2N9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DEEc8jKRKxzXG/g+Vo8jWELD/gqdXXkQ5boV1iHyUd9DKRIGXP3ywKHH/AKCGQqdf
         zAZWEZyVUumHPzu9N6gyLrU4n+nxOHjWsKJh67f1zEcQLsZywGpLb1vTUvqh17Kspm
         fo66LXjXR74v9ipM3vD3sYAvquC2lfGj/V7Or3UEYoZxexqUGQ6qaIRw6DHOODWe3h
         NogAfSjGkjbHMsDb5TnWMEqLiVSOqdGdP2A8DrfnIT+G46LweTdnd+4hoqKvWxOm2s
         1OSwOX5oKXy1IHM4bEHpYaE6NlEVRuJwTp+BBc2YZA3vcLsh08VG0j4kuRxN4eitfJ
         eg9AkPR3c9vFQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4b25f30002>; Tue, 18 Feb 2020 12:46:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id A90A913EED4;
        Tue, 18 Feb 2020 12:46:59 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 253E928006C; Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/5] dt-bindings: hwmon: Document adt7475 bypass-attenuator property
Date:   Tue, 18 Feb 2020 12:46:54 +1300
Message-Id: <20200217234657.9413-3-chris.packham@alliedtelesis.co.nz>
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

Add documentation for the bypass-attenuator-in[0-4] property.

Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/hwmon/adt7475.yaml          | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 2252499ea201..61da90c82649 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -39,6 +39,17 @@ properties:
   reg:
     maxItems: 1
=20
+patternProperties:
+  "^bypass-attenuator-in[0-4]$":
+    maxItems: 1
+    minimum: 0
+    maximum: 1
+    description: |
+      Configures bypassing the individual voltage input attenuator. If
+      set to 1 the attenuator is bypassed if set to 0 the attenuator is
+      not bypassed. If the property is absent then the attenuator
+      retains it's configuration from the bios/bootloader.
+
 required:
   - compatible
   - reg
@@ -52,6 +63,8 @@ examples:
       hwmon@2e {
         compatible =3D "adi,adt7476";
         reg =3D <0x2e>;
+        bypass-attenuator-in0 =3D <1>;
+        bypass-attenuator-in1 =3D <0>;
       };
     };
=20
--=20
2.25.0

