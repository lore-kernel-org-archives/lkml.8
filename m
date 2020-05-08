Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C51C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3477C208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944235;
	bh=7vB9hhcXIVBwWUlxGzxE1A+id2L01b0gae6v7od6caI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bDjLIDjT003lBcfSoOKjuLjZf70bcSoX938OTCj4B5An0ybzus2qAmusJRF0iO5PD
	 Z7ZmJ4qiFGcWSXEX5zUnpvgd5lw1iz9GJdH64SQCYDFa2XBpSbjqpU50Jy+FZbbJGG
	 b3DvMf1fv5IvaCY7IeLDsIpt/gRLGKFJ0Qs0HvJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgEHNXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgEHMhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:37:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A2521473;
        Fri,  8 May 2020 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941459;
        bh=7vB9hhcXIVBwWUlxGzxE1A+id2L01b0gae6v7od6caI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKC4yJkH4hwElInOkG1KFCr4mgj/39LkObFFowIj93Wkl6fQXoRID/TWTLpIhg7MD
         4mwjOzro9+OxlRjIS9iu0HEQTgnfumBdK5KVUoF+uvk+f3kUzp/py4kjCbIpCdni/J
         yzbij8ybk9Z74NcfLpYWKM2KeughM1UiZAY30DOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Shimizu <rogershimizu@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 4.4 040/312] ARM: dts: orion5x: gpio pin fixes for linkstation lswtgl
Date:   Fri,  8 May 2020 14:30:31 +0200
Message-Id: <20200508123127.353443687@linuxfoundation.org>
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

commit ff61ee84e7aa5842d9e33c0b442f0b43a6a44eaf upstream.

Here're a few gpio pin related fixes:
  - remove pinctrl-0 definition from pinctrl, since those pins are used
    in other places such as gpio-fan and regulators.
  - keep initial state of power led
  - fix for alarm pin of gpio-fan.

Fixes: dc57844a736f ("ARM: dts: orion5x: add buffalo linkstation ls-wtgl")
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
+++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
@@ -1,7 +1,8 @@
 /*
  * Device Tree file for Buffalo Linkstation LS-WTGL
  *
- * Copyright (C) 2015, Roger Shimizu <rogershimizu@gmail.com>
+ * Copyright (C) 2015, 2016
+ * Roger Shimizu <rogershimizu@gmail.com>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -69,8 +70,6 @@
 
 		internal-regs {
 			pinctrl: pinctrl@10000 {
-				pinctrl-0 = <&pmx_usb_power &pmx_power_hdd
-					&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
 				pinctrl-names = "default";
 
 				pmx_led_power: pmx-leds {
@@ -162,6 +161,7 @@
 		led@1 {
 			label = "lswtgl:blue:power";
 			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
 		};
 
 		led@2 {
@@ -188,7 +188,7 @@
 				3250 1
 				5000 0>;
 
-		alarm-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 	};
 
 	restart_poweroff {


