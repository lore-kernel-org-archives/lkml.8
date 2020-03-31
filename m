Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3383C2D0F3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8992072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645729;
	bh=WQHpfKaZPBdYes8iwGGue/GugwF0UOPV/iy+iJzXrlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FixqXUh9ALk/49bDNQXNOs5uODWstFhdjJfFr8Lfm5bA5W86dh/33osVxM9x9HWui
	 fBBR64h/V477Su6i6dnV8i2RLbMlKOqhish9sRFoLRVy189kVfFLRHd82VmTx8f8S2
	 s9q4La9wuuPIFU5Yk/kNXYaGCdu+mqt+Sm6qF91E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbgCaJIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731352AbgCaJIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:08:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7E42072E;
        Tue, 31 Mar 2020 09:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645726;
        bh=WQHpfKaZPBdYes8iwGGue/GugwF0UOPV/iy+iJzXrlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFzYNMyHJMBqU2FjLpetKb5EdCPgTuoLh07XABVjRNHnRusHHGEiKrn725XFe9dOr
         858HIC4dzwy3qmVi1FQp0FTTrifyvpL9R9tdzpR51G5cOxhKNme1jfVL3Wj5epmkml
         c1JZRk+P0CPvoHEmmR2+NvhiMaaFNkqrpiTCNsXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 5.5 144/170] ARM: dts: sun8i-a83t-tbs-a711: Fix USB OTG mode detection
Date:   Tue, 31 Mar 2020 10:59:18 +0200
Message-Id: <20200331085438.666848167@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

commit b642d4825441bf30c72b72deb739bd2d5f53af08 upstream.

USB-ID signal has a pullup on the schematic, but in reality it's not
pulled up, so add a GPIO pullup. And we also need a usb0_vbus_power-supply
for VBUS detection.

This fixes OTG mode detection and charging issues on TBS A711 tablet.
The issues came from ID pin reading 0, causing host mode to be enabled,
when it should not be, leading to DRVVBUS being enabled, which disabled
the charger.

Fixes: f2f221c7810b824e ("ARM: dts: sun8i: a711: Enable USB OTG")
Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -498,7 +498,8 @@
 };
 
 &usbphy {
-	usb0_id_det-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+	usb0_id_det-gpios = <&pio 7 11 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH11 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_vmain>;
 	usb2_vbus-supply = <&reg_vmain>;


