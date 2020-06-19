Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F7DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E6D2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583161;
	bh=uv2kvTbckQQzxzS5LFDIVglVH5WrWYKtxASxfY7wk0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u4q/BZZx5Im1LvhcV72ay4ZvGLEPe7ZKJ+ADJg0ne4NMVA+SdIOvR+u+QE0Ra9OCH
	 EQHAqT5iyFKep0vMbE3k7QkE+8Na8RYbB5HXWHeAz5iQP0QJ+2/YZ1VuI2kdRRpfc9
	 OZH3eLZS8EEIQgbBpKtQvPQVTmQ8KhnB/AxOv2ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394067AbgFSQMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391181AbgFSPEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3B92193E;
        Fri, 19 Jun 2020 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579084;
        bh=uv2kvTbckQQzxzS5LFDIVglVH5WrWYKtxASxfY7wk0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=daK4elVxZArq9WO9Dwh5uRB+hig2b/wrxS13y2EDfa1DKZWCfNfxlv5c5Kfv6t6cu
         rV2Yv7p2HKUBqJZJwfqGFlE28It3LxvG9ko4TDiEtsgcfeRrLsb5b4rHMii69KueTU
         DZgMyIOGEOHbvBxotVPCLSXFN1nYof66bhhv3mNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.19 253/267] ARM: dts: at91: sama5d2_ptc_ek: fix vbus pin
Date:   Fri, 19 Jun 2020 16:33:58 +0200
Message-Id: <20200619141700.808815896@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

commit baa998aecb75c04d62be0a4ab6b724af6d73a0f9 upstream.

The gpio property for the vbus pin doesn't match the pinctrl and is
not correct.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Fixes: 42ed535595ec "ARM: dts: at91: introduce the sama5d2 ptc ek board"
Cc: stable@vger.kernel.org # 4.19 and later
Link: https://lore.kernel.org/r/20200401221947.41502-1-ludovic.desroches@microchip.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -40,7 +40,7 @@
 
 	ahb {
 		usb0: gadget@300000 {
-			atmel,vbus-gpio = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
+			atmel,vbus-gpio = <&pioA PIN_PB11 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";


