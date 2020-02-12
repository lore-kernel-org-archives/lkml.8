Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429DBC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F61F2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="QmeLXajW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgBLDG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:06:28 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:39391 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgBLDG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:06:27 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DD9B0891A9;
        Wed, 12 Feb 2020 16:06:25 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581476785;
        bh=wzVDWD1jSWue8uIc83BSf3hD3sfh6Kd3M5RcGfClNfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QmeLXajWG0s9jfkkkPOA6nHTF+sB4z4EMpxU+6r9E7jjhv4+ESg+KYUp7BtKf9v9k
         ngBGeZaRgAyxnq5KYQpqU2a8oR/LYP6uT7r62CVU+lsNi4CFfmFj9V+ZFS/3wjZ1ga
         hAll8nNvTArRpd8HXdmsBaJqjHedeoZtRvpPiNx7WVsqhoApRxNIhmMqgjnBUWohsB
         bNDt/E1zQp6IrXJvVIPTIJtkvFnvw3HD80Yc9hq+bp1ew/kxoI5UF/6hyfnFyMImSn
         3ApZGImpsGw/le5mFQDjzMmrhHJjBCu7pkx6xsSK04uhen5xTn78QeBS/3RW0nh0jA
         58AI/2BRVJutA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e436bb00000>; Wed, 12 Feb 2020 16:06:25 +1300
Received: from henrys-dl.ws.atlnz.lc (henrys-dl.ws.atlnz.lc [10.33.23.26])
        by smtp (Postfix) with ESMTP id B744B13EED4;
        Wed, 12 Feb 2020 16:06:24 +1300 (NZDT)
Received: by henrys-dl.ws.atlnz.lc (Postfix, from userid 1052)
        id DFAE14E1463; Wed, 12 Feb 2020 16:06:24 +1300 (NZDT)
From:   Henry Shen <henry.shen@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        guillaume.ligneul@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        trivial@kernel.org, venture@google.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Henry Shen <henry.shen@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] dt-bindings: Add TI LM73 as a trivial device
Date:   Wed, 12 Feb 2020 16:06:14 +1300
Message-Id: <20200212030615.28537-2-henry.shen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212030615.28537-1-henry.shen@alliedtelesis.co.nz>
References: <20200212030615.28537-1-henry.shen@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Texas Instruments LM73 is a digital temperature sensor with 2-wire
interface. Add LM73 as a trivial device.

Signed-off-by: Henry Shen <henry.shen@alliedtelesis.co.nz>
---
Changes in v2:
- add missing sign-off

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
index 978de7d37c66..20e6bae68fec 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -350,6 +350,8 @@ properties:
           - ti,ads7830
             # Temperature Monitoring and Fan Control
           - ti,amc6821
+            # Temperature sensor with 2-wire interface
+          - ti,lm73
             # Temperature sensor with integrated fan control
           - ti,lm96000
             # I2C Touch-Screen Controller
--=20
2.25.0

