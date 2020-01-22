Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9641EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8B824688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699581;
	bh=MqHk9ws1zC4KJqEe/qedh29q88AsQZjUKviXXMv9T14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TgYAfVcSxv+nMlMAGwOLyDZea7o9m77MqD+1kYBO8B81tR71bPv9JZmIokvXaiXB6
	 cF7fQRSlukd+qd0LoGBcVDNdkctW83EJvcgchTE5wopqQb0XS8KwypNweLIqBQJFFD
	 mJMtbyRA15VSo1ORebSpBR445E2pBFtjB1ey76mI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgAVN0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:26:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbgAVN0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:26:18 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4812467F;
        Wed, 22 Jan 2020 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699577;
        bh=MqHk9ws1zC4KJqEe/qedh29q88AsQZjUKviXXMv9T14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/RsWG0Dh58dTqRLPeZVF7Bw6FYabVGowEPfhm8D809ioxL3XYk1LnWwVQivQTEOC
         dGAI2Z4HUCK0z+kpOcN5v8IJC+rXUagm1q1Zztu+JE1RlayhldeZDKryta046DAk8n
         ebZWBNlIYUxxpEHQlTylV8LzTtoA3RjL2FStFW7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5.4 184/222] arm64: dts: renesas: r8a774a1: Remove audio port node
Date:   Wed, 22 Jan 2020 10:29:30 +0100
Message-Id: <20200122092846.861792313@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

commit a381325812691f57aece60aaee76938ac8fc6619 upstream.

This patch removes audio port node from SoC device tree and
fixes the below dtb warning

    Warning (unit_address_vs_reg): /soc/sound@ec500000/ports/port@0: node has a unit name, but no reg property

Fixes: e2f04248fcd4 ("arm64: dts: renesas: r8a774a1: Add audio support")
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1570200761-884-1-git-send-email-biju.das@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi |   22 ++++++++++------------
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi      |   11 -----------
 2 files changed, 10 insertions(+), 23 deletions(-)

--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -86,7 +86,7 @@
 
 		label = "rcar-sound";
 
-		dais = <&rsnd_port0>;
+		dais = <&rsnd_port>;
 	};
 
 	vbus0_usb2: regulator-vbus0-usb2 {
@@ -191,7 +191,7 @@
 		port@2 {
 			reg = <2>;
 			dw_hdmi0_snd_in: endpoint {
-				remote-endpoint = <&rsnd_endpoint0>;
+				remote-endpoint = <&rsnd_endpoint>;
 			};
 		};
 	};
@@ -327,17 +327,15 @@
 	/* Single DAI */
 	#sound-dai-cells = <0>;
 
-	ports {
-		rsnd_port0: port@0 {
-			rsnd_endpoint0: endpoint {
-				remote-endpoint = <&dw_hdmi0_snd_in>;
-
-				dai-format = "i2s";
-				bitclock-master = <&rsnd_endpoint0>;
-				frame-master = <&rsnd_endpoint0>;
+	rsnd_port: port {
+		rsnd_endpoint: endpoint {
+			remote-endpoint = <&dw_hdmi0_snd_in>;
+
+			dai-format = "i2s";
+			bitclock-master = <&rsnd_endpoint>;
+			frame-master = <&rsnd_endpoint>;
 
-				playback = <&ssi2>;
-			};
+			playback = <&ssi2>;
 		};
 	};
 };
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1726,17 +1726,6 @@
 				      "ssi.1", "ssi.0";
 			status = "disabled";
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				port@0 {
-					reg = <0>;
-				};
-				port@1 {
-					reg = <1>;
-				};
-			};
-
 			rcar_sound,ctu {
 				ctu00: ctu-0 { };
 				ctu01: ctu-1 { };


