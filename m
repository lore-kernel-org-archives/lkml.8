Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA7C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B72206F7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDELYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:24:33 -0400
Received: from outgoing2.flk.host-h.net ([188.40.0.84]:45339 "EHLO
        outgoing2.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgDELYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:24:33 -0400
X-Greylist: delayed 1197 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Apr 2020 07:24:32 EDT
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam3-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1jL34p-0007Uu-IF; Sun, 05 Apr 2020 13:04:33 +0200
Received: from [130.255.73.16] (helo=v01.28459.vpscontrol.net)
        by www31.flk1.host-h.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1jL34m-00027v-EM; Sun, 05 Apr 2020 13:04:28 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Justin Swartz <justin.swartz@risingedge.co.za>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: enable WLAN for Mecer Xtreme Mini S6
Date:   Sun,  5 Apr 2020 11:00:21 +0000
Message-Id: <20200405110022.3849-1-justin.swartz@risingedge.co.za>
X-Mailer: git-send-email 2.11.0
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00700465061722)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0VxB0mWeGZk2wSOLROvd+japSDasLI4SayDByyq9LIhVCODMyKVUA5BF
 Hq9af7rAaUTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K7uDjV/sFUXQr+CDrNQuIHgQg
 mAX8Bxy/iUu0ThNZg0jxJtcVJProrT987X1VDPOqN+OoDzRTdku7DidYUZdNf38Sp7Of4wP429AA
 f49baR+f3He7jw4SoVhmTJ/3eP9ORQWVx8ds1M4qmk3/bYr2p8zbg4Paoa3pNVQ0zl7t/+UfQLYB
 qEPnp1U88kqVD8AM2G81dFO0E3gi+MOI1foZYzDggRXhpvoPtF3cVkniFXU3qJSqpdJudO6+rkiw
 E5i8Wl78Q18OeOfsy4h7jF1Uv9lnibl3vcBqVmvQB4A18adRHDV3Cg2VtHDZHoZSNr/jAVXirbLu
 Jjy3NtnGWLbnBGfrUBEXB2fYGLNieGQuoHtJvp0r29Rf3ZjFwL+MhHEWw/0qBlNDp8uABz3dkWV+
 ttWGem52QLIiDo2hv5/Q58JTycYLFeAN4+MGwnsp7SkU6CLbyF0Zq4b1/7rjUzETJrWks4pbbQJq
 6gWopI3ep45X19ZysgQ+31LcAX8eoFXAhohfegXGH2GIVQVglJFbK771YV8YbC29CtmpcTqTfSIf
 CWq9oj7OiT8GwpAriB+3/81I3rvR8KJ2fK9jiDYgiuaWjWJ1lPr1Ev5xNW3FQUl1thv0hd9gZGlV
 L/SEDgzCxVAfo0TfAdBm88UU/z2X2IjokNqZVv3KMEb5yncp4Gliqy40Rbjn7L/aSJSlbL1zKyEL
 KRIlJqopKieSGgZIDDCaOnYR+e17nmKXMy4iUno/l2R44/7at9DP1rQ8e6dbF/Yfz7ZwWRFpJHQn
 mVbGJJcMBQM8xFcyypgGsWJnLxUf4D3bkY2u9P2maVhPXuiOVOc6XrA4vsvWFPzHwIQ6neDt/vDy
 PLUXN2ILHndC4hwbA2fIdq9z/kUhYTDkDb9GLLhZsgdKPiGhHoIVmEgc3vQE4bdGRg51xWZ402gC
 TyXPOOUgfrQ68NrwMFh7KSObGsS+toWgXfk8WFHb2sU11qA6HXMtTTYLhUej0Yho17o8CVsONrMJ
 uGzuoGnKTKcyMAVhaIz/fGNqyRYsGJ0LJeBqPlwuAReGWkPdwxr2XgmbPrJVQzt6iVRPsiDvDuTj
 4oYwO9PC4N2NoF8mn/qyLT9gcYZ23l4P3JrzWS8jWh8xuwZvHnAADkIPtamKuAZddoNrr+WHg4o5
 S3beb97n9J0N63F3lSElipbV7k/tzvRn13OWvSfGlZ4x16b3bGBx
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mecer Xtreme Mini S6 features a wireless module, based on a
Realtek 8723BS, which provides WLAN and Bluetooth connectivity via
SDIO and UART interfaces respectively.

Define a simple MMC power sequence that declares the GPIO pins
connected to the module's WLAN Disable and Bluetooth Disable pins
as active low reset signals, because both signals must be deasserted
for WLAN radio operation.

Configure the host's SDIO interface for High Speed mode with 1.8v
I/O signalling and IRQ detection over a 4-bit wide bus.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/arm/boot/dts/rk3229-xms6.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-xms6.dts b/arch/arm/boot/dts/rk3229-xms6.dts
index 679fc2b00..cdfcef41b 100644
--- a/arch/arm/boot/dts/rk3229-xms6.dts
+++ b/arch/arm/boot/dts/rk3229-xms6.dts
@@ -39,6 +39,12 @@
 		};
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio2 26 GPIO_ACTIVE_LOW>,
+		              <&gpio2 29 GPIO_ACTIVE_LOW>;
+	};
+
 	vcc_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -202,6 +208,18 @@
 	status = "okay";
 };
 
+&sdio {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	vqmmc-supply = <&vccio_1v8>;
+	status = "okay";
+};
+
 &sdmmc {
 	cap-mmc-highspeed;
 	disable-wp;
-- 
2.11.0

