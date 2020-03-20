Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C9BC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DD520753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgCTQlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:41:00 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57943 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgCTQlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:41:00 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0FE1-1jS2Oc1aYJ-00xJPk for <linux-kernel@vger.kernel.org>; Fri, 20 Mar
 2020 17:40:57 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 2E9386502D9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MabASmG0uCLe for <linux-kernel@vger.kernel.org>;
        Fri, 20 Mar 2020 17:40:56 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id C82E564CB8E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:40:56 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.41) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Mar 2020 17:40:56 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 33D6A80505; Fri, 20 Mar 2020 17:12:04 +0100 (CET)
Date:   Fri, 20 Mar 2020 17:12:04 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH v3 08/11] dt-bindings: adv748x: add information about serial
 audio interface (I2S/TDM)
Message-ID: <5e7da04cd003778cf525eac96d8bacdf4a245a13.1584720678.git.alexander.riesen@cetitec.com>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1584720678.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1584720678.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.41]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7660
X-Provags-ID: V03:K1:8Y745pdoH28M2HrAV7mYoMeSTsJLObM1DmquN/zMt9LOzW0YSxK
 rpW0Y9VexUPNJ69tbua8nb5ZiMR5wpkE9mdD42+a/AY6nF8qsU94P2sYCiyVU0GLdCAyWXJ
 2m+4BComffRVAz+nmC46v4oC7jOgYqgQz5ydZ7wqWHKNpJcTTOb58mVIkNOM6576YrJ9biW
 sDGIFv0cbfdHXCZ83xIYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4RhivKJB2oA=:LVRKJQDRDgDd0lDTEGa6x6
 kGGE52DLP61t8uxKEDHO7QNU+E9VSbDoI4+N5xmhkBCuvisFy6C36Ur4bYHPN95kZ1P54okIr
 XxgVwOmNGg4t236qXC/LF+ezPb9kTVbhRsmgjbWE4XjSZJ9FZR6d9fkeAbPx6F2EvIKaOGEUr
 6JUy2GkpW8BXaS+jeiEbv8Dx+NCYUY1zcP9VlM+/P+tno/UkXRp3SEdcvING5kBgkpn+qTSs/
 KmDii2dwGZAjmOA1kr08ldFNpYqmuSoLhug/uqs9dsSMYiLmDxA7tnV6QOnh2/ug2Z0+D6sam
 10y1v0OHuK5KYuDnsCcRBbnX5SnshgM9hfPoFsQguSmkfhQWaMbgQZD9ECCAf4cDJ+M9e+Fnm
 tvnR45IZpRVtyiYZdroIKS57lZ87sjcOUEeR1FpFBgHCPU2B0XTkzRcCI/v/vHuDmdm23R3wQ
 IAkye4J6UAt7/hZDnz1RUj7f+v6XAhiU+dkSxA48ZS/koK/SLshQ8Kp7OSF78BnTD93IDRpG2
 BTZJtQNw0EsGxFbYK4BSQCF3XZX5SSjN1Vu8vaggC/exGzwPVSGN+iX0nFE87OzuwbSFALfn8
 ySv8wpzZpbjy9g/Qqe3xMF+3kEUhGbOojczW7jWvv2u1odSBmk9Z5N3zizyYBweApfP5RVzAP
 Ns+2AOhxFVtFTqee4d/dkR/PyyMxyfyqiT3qYJ+XMSQUbuiUYHW+0oFFVpCO+K/ie1fx4Oeho
 wZ++clooJ1n9Dn4aDrJYY5JYvk2LoY8MkRyqqAVvlkQS9HsnEGfcGLIEPcJmGlNefJjMvXsUj
 VoO8c1cqz0iTPNbbLIOZml0p6OmxqsdYHLXtdwxUEDTV0xQqQ5xr0+OhOjp7Dcsic5UCgHhNH
 Wbm14MTLxYpVxcYCgkWk3iT5vZgF7lCwwfUULdx/p89QTOY0c3b8+nngQEwChVcaIo3t0KL9c
 JbbhXy+RoH9KtGLe0R3M3ZMTaVTli4vc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the driver has some support for the audio interface of the device,
the bindings file should mention it.

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

--

v3: remove optionality off MCLK clock cell to ensure the description
    matches the hardware no matter if the line is connected.
    Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .../devicetree/bindings/media/i2c/adv748x.txt    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/adv748x.txt b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
index 4f91686e54a6..50a753189b81 100644
--- a/Documentation/devicetree/bindings/media/i2c/adv748x.txt
+++ b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
@@ -2,7 +2,9 @@
 
 The ADV7481 and ADV7482 are multi format video decoders with an integrated
 HDMI receiver. They can output CSI-2 on two independent outputs TXA and TXB
-from three input sources HDMI, analog and TTL.
+from three input sources HDMI, analog and TTL. There is also support for an
+I2S-compatible interface connected to the audio processor of the HDMI decoder.
+The interface has TDM capability (8 slots, 32 bits, left or right justified).
 
 Required Properties:
 
@@ -16,6 +18,8 @@ Required Properties:
     slave device on the I2C bus. The main address is mandatory, others are
     optional and remain at default values if not specified.
 
+  - #clock-cells: must be <0>
+
 Optional Properties:
 
   - interrupt-names: Should specify the interrupts as "intrq1", "intrq2" and/or
@@ -47,6 +51,7 @@ are numbered as follows.
 	  TTL		sink		9
 	  TXA		source		10
 	  TXB		source		11
+	  I2S		source		12
 
 The digital output port nodes, when present, shall contain at least one
 endpoint. Each of those endpoints shall contain the data-lanes property as
@@ -72,6 +77,7 @@ Example:
 
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#clock-cells = <0>;
 
 		interrupt-parent = <&gpio6>;
 		interrupt-names = "intrq1", "intrq2";
@@ -113,4 +119,12 @@ Example:
 				remote-endpoint = <&csi20_in>;
 			};
 		};
+
+		port@c {
+			reg = <12>;
+
+			adv7482_i2s: endpoint {
+				remote-endpoint = <&i2s_in>;
+			};
+		};
 	};
-- 
2.25.1.25.g9ecbe7eb18


