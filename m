Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED30C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47792086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748318;
	bh=Icfs7dzmGLlT+hgorSORj+xu364BUM8vtKrQpAU/dAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PXxlUtQCVf0dZr6jk9K9jDQ4JumWmZnf3fXzq/4dxcSpruc71BMTIPIEID3JAWBpO
	 3YC7X40znrE1nuw3zyf32HOUdROVWcR/yPNtk28E8kjHXaGynYTYSdTvWqT72V3Vnq
	 2WoBx/HUUe/F8oD9fvg+D4etyqSZtr5FEkIupqdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgBCQaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbgBCQaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:30:17 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D382051A;
        Mon,  3 Feb 2020 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747416;
        bh=Icfs7dzmGLlT+hgorSORj+xu364BUM8vtKrQpAU/dAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6mU7zjjrPCJ5OwhmeVCqlumck2aQfcg2jnS8EjAGesMqbC4wpbFFIuieh9kHE5p3
         FqMQl3bRZxp0CBaTkW/xaiM0tkAYBNJQWw3gGr/L/oc/nuFAMu+HfoynmPqJZlVWl9
         iisFUFLcZoeXrrMsEn61Lmum6l9jqy0ukX/kMXwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 20/89] phy: cpcap-usb: Prevent USB line glitches from waking up modem
Date:   Mon,  3 Feb 2020 16:19:05 +0000
Message-Id: <20200203161919.622920947@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 63078b6ba09e842f09df052c5728857389fddcd2 ]

The micro-USB connector on Motorola Mapphone devices can be muxed between
the SoC and the mdm6600 modem. But even when used for the SoC, configuring
the PHY with ID pin grounded will wake up the modem from idle state. Looks
like the issue is probably caused by line glitches.

We can prevent the glitches by using a previously unknown mode of the
GPIO mux to prevent the USB lines from being connected to the moden while
configuring the USB PHY, and enable the USB lines after configuring the
PHY.

Note that this only prevents waking up mdm6600 as regular USB A-host mode,
and does not help when connected to a lapdock. The lapdock specific issue
still needs to be debugged separately.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 4ba3634009afc..593c77dbde2eb 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -115,7 +115,7 @@ struct cpcap_usb_ints_state {
 enum cpcap_gpio_mode {
 	CPCAP_DM_DP,
 	CPCAP_MDM_RX_TX,
-	CPCAP_UNKNOWN,
+	CPCAP_UNKNOWN_DISABLED,	/* Seems to disable USB lines */
 	CPCAP_OTG_DM_DP,
 };
 
@@ -379,7 +379,8 @@ static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 {
 	int error;
 
-	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
+	/* Disable lines to prevent glitches from waking up mdm6600 */
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
 	if (error)
 		goto out_err;
 
@@ -406,6 +407,11 @@ static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 	if (error)
 		goto out_err;
 
+	/* Enable UART mode */
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
+	if (error)
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -418,7 +424,8 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
 {
 	int error;
 
-	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_OTG_DM_DP);
+	/* Disable lines to prevent glitches from waking up mdm6600 */
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
 	if (error)
 		return error;
 
@@ -458,6 +465,11 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
 	if (error)
 		goto out_err;
 
+	/* Enable USB mode */
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_OTG_DM_DP);
+	if (error)
+		goto out_err;
+
 	return 0;
 
 out_err:
-- 
2.20.1



