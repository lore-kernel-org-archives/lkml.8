Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B73C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9238D2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgCZLD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:03:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgCZLD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:03:29 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWzwP-1ikoIo1wN7-00XNkL for <linux-kernel@vger.kernel.org>; Thu, 26 Mar
 2020 12:03:27 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 36DC26502CC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LcUoUfN6j31E for <linux-kernel@vger.kernel.org>;
        Thu, 26 Mar 2020 12:03:26 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id CA5C664CA32
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:03:26 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.79) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Mar 2020 12:03:26 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id A12B180505; Thu, 26 Mar 2020 11:35:43 +0100 (CET)
Date:   Thu, 26 Mar 2020 11:35:43 +0100
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
Subject: [PATCH v4 8/9] dt-bindings: adv748x: add information about serial
 audio interface (I2S/TDM)
Message-ID: <37482bdfc6d6c6e231c58550b6bc4582aa29dde0.1585218857.git.alexander.riesen@cetitec.com>
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
References: <cover.1585218857.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585218857.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.79]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7C67
X-Provags-ID: V03:K1:dVwMkS/YYimA0Fx4x7TlpQe8zOx0tqQ0qxOi0/UrlgQTYhlRTCo
 H8L/iyheS3aTT6rBGxufKbsR5hcZqq7iHZsmUhIkxcgoEFUiWy5PEZwHp5rYT08ECIRKEZ6
 TMcLAq6Y/Yd5MS1QJjzVz0E92ZzLYSUyVDUYIgkmR/HxUMFbqOYpT5spxjjGZUuSUqAgozW
 hwbqdwZ9SjRS5jQkonUaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oEobVFJxd94=:JIrU6Ala9Pj6c1hpsLLORm
 DJpZhhxiIaRKACbwJH844PTtw7oLA6ixxLUS/sd5ZRn/TrqbGpHdcac7WqfLx7VbtgKyBcNRR
 7P+HvG/4DPajmcaS+Bp4ymoVdOFcA5HXc6aVCXxgj+m1LKs1vuL0KSFBZnhnXYEsjeSV9JPHA
 LKPbzBwgv5sEo0KEWtEfMOLlQ+46JreKPbbJgWD5lAyg3/+t1H1v0Xo0OoHDmqmT6AqFTOGdz
 TW8h4PFpQTKCIIBDUOynneOtwtX/tpoKtYzsXo7eBy1UYdLXXVhl+lD56UQe7nK4SBB6jjbP+
 e593iB4K8a6RByfdBsPLYN/2QA9VZzvPabD0xxsBZQXrmZe8SiElUAZ1iqcoSHEFYy9MYzBFk
 6lB6fz8Rg3NYKwgTtSCdkKsK7BKYDN3igVyaUGTgBakp/M2vwTA7mW3AJTf76b3zTplXK4MaB
 cD3lw8tTGcBThsaYlgIC8YlEcz0txQHyVMnR+/ki2Jy2GwFkKYqafo3CM4T/jjDxOKls3+PPn
 qei5LKOGw+hYXSl5B7J1usDV8IaSkIhPuvLPg9vPcW754BzamrDdBd/VO/3OAUgu+2EYGkI6K
 syletu49YgGZV0bP/TYM9pikVP6k66PYBG0IFkRClZmfM0tFcKCExf7smNGG79DdzpS66fa+4
 LzZQFOkW4WptUOptWKIt+V1ygmR0vyXKFNtKThh1LiMFO4LZbvrwG47N6BgDWKjOEUnSST+0Z
 vCrvVPDbVshe/3Xt4HAwF/BHtvBpeueI89x47/vyR9SAsjpkAGNFNJVWSdI8cDE0r4Q0k1AeW
 q9edlG6GVpu/8ua4MRHbNF6yyQCTvOm8ghoDsXze8/dl7QZ7OjSs+7MfaIvD/G2ir+Pu+0R
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


