Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CB6C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F6A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201079;
	bh=I5NEqjUH5eHmMFIlF9a4vO0wCDNHBH7imRYFsG9qCUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g24VvL+I0ZBPKBN1oS8Mk620d4GoPODfxozeAU7rE/JFhOpKKuMi4N7r8/Gl9xUJj
	 gnDoRygIJuPq++D2/UkPxYpwNfgJhJueVLTwVRbLxFL2P9wyCgawJl9KGsyFl+1B6L
	 zQ/y2B+kZGpQCiqLn03DfURir1eeq4Z0giXhuxFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbgAPRGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:06:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388658AbgAPRGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCCC321582;
        Thu, 16 Jan 2020 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194399;
        bh=I5NEqjUH5eHmMFIlF9a4vO0wCDNHBH7imRYFsG9qCUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUlE5zytm4MeBjK4MEBa4cYL55RJt30N1+mCjgkucT33FBeXefYhF6H9qJ2DNhIaj
         vQ2bj66+X+YmgPFia3SfRLuWcCH+oYTNlumfEp00GYeQRas/OmFJiCLXQQeSWwT+Bc
         hq8hxUIFDoTCq7VrvxatqbbubTjMlrQj4KJijruI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 325/671] usb: gadget: fsl: fix link error against usb-gadget module
Date:   Thu, 16 Jan 2020 11:59:23 -0500
Message-Id: <20200116170509.12787-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 2100e3ca3676e894fa48b8f6f01d01733387fe81 ]

The dependency to ensure this driver links correctly fails since
it can not be a loadable module:

drivers/usb/phy/phy-fsl-usb.o: In function `fsl_otg_set_peripheral':
phy-fsl-usb.c:(.text+0x2224): undefined reference to `usb_gadget_vbus_disconnect'

Make the option 'tristate' so it can work correctly.

Fixes: 5a8d651a2bde ("usb: gadget: move gadget API functions to udc-core")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 91ea3083e7ad..affb5393c4c6 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -20,7 +20,7 @@ config AB8500_USB
 	  in host mode, low speed.
 
 config FSL_USB2_OTG
-	bool "Freescale USB OTG Transceiver Driver"
+	tristate "Freescale USB OTG Transceiver Driver"
 	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM=y && PM
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
 	select USB_PHY
-- 
2.20.1

