Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E4EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF83207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941459;
	bh=9A13lgWfAGyAcQTnH4eiNroOK/ohXSAdg/JEG5Tx3oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VlxAOkxGtjRlCDbz7GLdL8Gjrszvx0pSJpaqpxRudTdAazduXPhbiKuYb+QWqSNsg
	 BOAQgrZzLdpcMok9TE4s37sfSTX3uYRVHty3ec11A0d/C2mUvwwIqT+sD4onb0N+El
	 1E9G8A/RXjiIxwBaoEbCNT1VjVCqeem/iU3Q1GoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgEHMhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgEHMhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:37:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3671E21582;
        Fri,  8 May 2020 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941454;
        bh=9A13lgWfAGyAcQTnH4eiNroOK/ohXSAdg/JEG5Tx3oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwvobsDRRwlAH+av22Zx+5fC9V7u24VU4fKrYUBwBnqiwx7Kmh+WKK6MAjuETR7jb
         siP2bRyCM9/LVQGSBUi51T0ve2eKGkggzBlvN18mtBM9sJwiA+3gjFjvUuJdygtNyb
         qRf6ECXF9/iHigvSowvB1fBIE71NhZ0cuDagesTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Shimizu <rogershimizu@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 4.4 038/312] ARM: dts: kirkwood: gpio-leds fixes for linkstation ls-wxl/wsxl
Date:   Fri,  8 May 2020 14:30:29 +0200
Message-Id: <20200508123127.187598817@linuxfoundation.org>
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

commit e98bd707e39d52d8bef8622e6e7b0ab4bd0ed8d0 upstream.

The GPIOs controlling the LEDs, listed below, are active high, not low:
  - gpio-leds: "lswxl:blue:power" pin
  - gpio-leds: "lswxl:red:func" pin
  - gpio-leds: "lswxl:red:hdderr{0,1}" pin

Fixes: e54e4b1b622e ("ARM: dts: add buffalo linkstation ls-wxl/wsxl")
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/kirkwood-lswxl.dts |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm/boot/dts/kirkwood-lswxl.dts
+++ b/arch/arm/boot/dts/kirkwood-lswxl.dts
@@ -201,23 +201,23 @@
 
 		led@4 {
 			label = "lswxl:blue:power";
-			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
 		};
 
 		led@5 {
 			label = "lswxl:red:func";
-			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
-			default-state = "keep";
+			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 		};
 
 		led@6 {
 			label = "lswxl:red:hdderr0";
-			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
 		};
 
 		led@7 {
 			label = "lswxl:red:hdderr1";
-			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 		};
 	};
 


