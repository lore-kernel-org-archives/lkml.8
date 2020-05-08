Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D352DC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56F121582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941469;
	bh=fYXk5tLXrY5Ne9OCEbjiZqspyWxW9J8rLtKW48bn7ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GiiAp8Zompb/Ugg+6AHZKTAGzfFxQt/gHlgejzJnDnyF4lU25e4w8g+dY+suF77Pz
	 avYxVvvJ8EAIZQ1aKG8Ht4GFxs7ra8QgZnCYeHTUzVD9dBUB4wZdJ1vLXX8h2PzscX
	 zHDQ2+KeKUuHgqYbjYhBcxIG8oDEwKnOFQh2RFBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgEHMho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgEHMhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:37:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A722D221F7;
        Fri,  8 May 2020 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941457;
        bh=fYXk5tLXrY5Ne9OCEbjiZqspyWxW9J8rLtKW48bn7ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRBZFZ+sEsatyyjgTK3vhm+QQY6zc32laGFyZRcs2yV1A1T79MIxtDhyMCmozbpsY
         LSYS8S6o7wPWHyc5QG4KK8GFTs88VGZ47zk8CQYSutkp2kwjY/F4asYA/b0KkyLbgU
         rihOyvEhvUlo0Ro/Dyj2sVEzeimDP0B3HMYRPK4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Shimizu <rogershimizu@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 4.4 039/312] ARM: dts: kirkwood: gpio-leds fixes for linkstation ls-wvl/vl
Date:   Fri,  8 May 2020 14:30:30 +0200
Message-Id: <20200508123127.263789100@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Shimizu <rogershimizu@gmail.com>

commit 0418138e2ffd90f4a00b263593f2e199db87321d upstream.

The GPIOs controlling the LEDs, listed below, are active high, not low:
  - gpio-leds: "lswvl:red:alarm" pin
  - gpio-leds: "lswvl:red:func" pin
  - gpio-leds: "lswvl:amber:info" pin
  - gpio-leds: "lswvl:blue:func" pin
  - gpio-leds: "lswvl:red:hdderr{0,1}" pin

Fixes: c43379e150aa ("ARM: dts: add buffalo linkstation ls-wvl/vl")
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/kirkwood-lswvl.dts |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/arm/boot/dts/kirkwood-lswvl.dts
+++ b/arch/arm/boot/dts/kirkwood-lswvl.dts
@@ -186,22 +186,22 @@
 
 		led@1 {
 			label = "lswvl:red:alarm";
-			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 		};
 
 		led@2 {
 			label = "lswvl:red:func";
-			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		};
 
 		led@3 {
 			label = "lswvl:amber:info";
-			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 		};
 
 		led@4 {
 			label = "lswvl:blue:func";
-			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
 
 		led@5 {
@@ -212,12 +212,12 @@
 
 		led@6 {
 			label = "lswvl:red:hdderr0";
-			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 		};
 
 		led@7 {
 			label = "lswvl:red:hdderr1";
-			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
 		};
 	};
 


