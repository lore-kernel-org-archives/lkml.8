Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3B7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23BB20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbgDBTLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:11:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53467 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbgDBTLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:11:13 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3sZs-1jBSIA2UhE-00zrLn for <linux-kernel@vger.kernel.org>; Thu, 02 Apr
 2020 21:11:10 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 60302650ABB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 19:11:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PqD0mzTw_S-i for <linux-kernel@vger.kernel.org>;
        Thu,  2 Apr 2020 21:11:10 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id ED07164F42F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 21:11:09 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.8.5.12) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 21:03:28 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 34C0C80505; Thu,  2 Apr 2020 20:35:06 +0200 (CEST)
Date:   Thu, 2 Apr 2020 20:35:06 +0200
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
Subject: [PATCH v5 8/9] dt-bindings: adv748x: add information about serial
 audio interface (I2S/TDM)
Message-ID: <337b689519806178458ab77385c8ac6f510cb0da.1585852001.git.alexander.riesen@cetitec.com>
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
References: <cover.1585852001.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585852001.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.12]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6C7266
X-Provags-ID: V03:K1:uXmSOEeWxjENeLzNG37bmgZXIhC9qqxb8Cn87kUsd3Wv813VwGp
 g/LEuKnz8vq87lcpE/V2I0Mc0MiaYCzt18jDSWfKOgsK0DAU7QYCT8uOrZ+CDuy8B+V0H/G
 0AMm9Up3eFoz1QJcUGQ6V4cVxbi2IEzFD5o0pKvflC8Iqbu59v387XP0SCY/dgV+mfdIN+U
 bP4F1wzh/QCzXR+4LHFzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2GcvtRSA4uU=:Ls8q79UMBernvm5joxg6ys
 xM2os70+hT0cdQesFjM8zNwCid5g8jC3jl3+7kudXITH0/uk/iXgdQM+kaABrv8HEzPzKGJC/
 sl6fjB18d4Ue1yU8JWsClWsD2IuZhfjOdPDTbEofA+Ezg9OTnqY6IMi1t7OxXgXK0Q6XP3nM3
 508i18gic9324rcA51T7rsTAtdz1e9U/vL3ngTaA/oRy2P8HPNKmeFu9TEEzY52U9gIDhhOXL
 QrMi1JYQMLUeDRNO1rp2TTz9NKkpgGrJaW7QxoZuy4IoFjQOwMORiYAsRACaKT57bM9L/wd4O
 oul+1e9ZLFc6eLw8Az0hyoxQ8+f27/uHC7bER5InCa30nEYJ93t82NKBzBNwxnFuuvqLunGma
 TZhwZ5RC5eD1AlGIAjb5Hcq0TS6nxoPLF0cop25CN3JluY7SOjkkRbuMUGNoMiI6BZve2PSyx
 w8HF/6rGn7QKzAzfaivuNHSJjsx9KFFE7MeaPuQSwFiqny9/ujrmv4EC6yvwceoHsrKxD2vkb
 jrZaqqBuaZ8iDSF2YLYscj2yOLPT2UVexPb3AORhG8Btn1xz3pBeskXX/g9CCsMN0qU2T/+vy
 UFAIvfMPzfQywKFk4lrnVOqaKvk5zgpBcEy4Hu9pG8fHkCJWoBiclA+Bc/dd3Jl1SFhmVhkwm
 WxiYgcj0VNRNdX7hMFdJUjOhvLELrg4M10R9Nm327EtkyU6xRVdmo29YNceIz2acLiZMZiyw9
 4raNPvttRpcF3tBLTcsZehk9+M3Jbu+TeTYG0DsZ9aLxtyOSVmWt/NpWWf6gATHNS7DR1fGPa
 lsx4DxZBh5TMgcdCS3xHYg1UNNtN4V2+wCJQd2VRvuefjqIQfBFZ9k4kNyy+Yrgfrsqy8dU
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


