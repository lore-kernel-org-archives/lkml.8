Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0F0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314BF2468E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410194;
	bh=Icfs7dzmGLlT+hgorSORj+xu364BUM8vtKrQpAU/dAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h00VeTWCc7PYHIQh3iwS9275k/DRiCzm5J9oaLz5/BP6gYJaq1rWttlGAAYgLISlI
	 fwz11j4MJsLIrSLZxb5zSzUUwQKgUvYdhXylHtuB4PoMF0SK9c/rvUhVVdrtNp5xnE
	 jMOHJWttnTXT6gseGw6OnjZ//0NGwNpo9Os+fIVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbgA3Sru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731428AbgA3Srq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:47:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8F2205F4;
        Thu, 30 Jan 2020 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410064;
        bh=Icfs7dzmGLlT+hgorSORj+xu364BUM8vtKrQpAU/dAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0gSChXRtguDA6a1ugbq9I8WBW5ejasrp2sItSEdU3qMjqtyO4bh6T6syRjcrHnct
         3+NUyZ1XRXw4Wxom+3HvH0kCc5i/cKlUetMoQtrBniBdNWvxvebe1KJlyNU96rwN9r
         LfqPw6vHejxFS1JA8bTkvCGiDSsZABiqoDuvngqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 32/55] phy: cpcap-usb: Prevent USB line glitches from waking up modem
Date:   Thu, 30 Jan 2020 19:39:13 +0100
Message-Id: <20200130183614.470977612@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
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



