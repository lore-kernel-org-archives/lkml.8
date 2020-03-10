Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F363C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1678820674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844846;
	bh=u1tL22Oa8Lt3kR4tVCpS9TqfnburU/QugzCbNdKVgIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXZW8jH01olwpPYvQWPj/PgPqkBkIfCPPSmw4p7PeUdqzssc3z0q4otIDIeb4vu79
	 OhM2HJ1pzzp7YR1umPdmkflMrgxOoCgpbHucpBTB4w1aud+ditWBW5yrRilFu8ogEJ
	 NP01hkHIhwgDvyR7AVV1LyagssqFGMdwvAyN5AvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgCJMyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbgCJMyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B026320674;
        Tue, 10 Mar 2020 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844841;
        bh=u1tL22Oa8Lt3kR4tVCpS9TqfnburU/QugzCbNdKVgIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6+jCOu0bQy4qdASIrBXlRZvETF9jDDssCLRdtIudgPU5D+88hAo7xuYDE5MUSwDB
         Ak3t3h9dgRPCRo+izneglXZBUZltrDPvgYVbuwGl2h/fR7WUYEL/xnPPBcMP/03vKP
         4Fa/UeGPI0z5sjLzk0rlOYzmT5lBrQ4V2lAV/RzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5.4 137/168] phy: mapphone-mdm6600: Fix timeouts by adding wake-up handling
Date:   Tue, 10 Mar 2020 13:39:43 +0100
Message-Id: <20200310123649.365414852@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

commit be4e3c737eebd75815633f4b8fd766defaf0f1fc upstream.

We have an interrupt handler for the wake-up GPIO pin, but we're missing
the code to wake-up the system. This can cause timeouts receiving data
for the UART that shares the wake-up GPIO pin with the USB PHY.

All we need to do is just wake the system and kick the autosuspend
timeout to fix the issue.

Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on Droid 4")
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/motorola/phy-mapphone-mdm6600.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -243,10 +243,24 @@ static irqreturn_t phy_mdm6600_wakeirq_t
 {
 	struct phy_mdm6600 *ddata = data;
 	struct gpio_desc *mode_gpio1;
+	int error, wakeup;
 
 	mode_gpio1 = ddata->mode_gpios->desc[PHY_MDM6600_MODE1];
-	dev_dbg(ddata->dev, "OOB wake on mode_gpio1: %i\n",
-		gpiod_get_value(mode_gpio1));
+	wakeup = gpiod_get_value(mode_gpio1);
+	if (!wakeup)
+		return IRQ_NONE;
+
+	dev_dbg(ddata->dev, "OOB wake on mode_gpio1: %i\n", wakeup);
+	error = pm_runtime_get_sync(ddata->dev);
+	if (error < 0) {
+		pm_runtime_put_noidle(ddata->dev);
+
+		return IRQ_NONE;
+	}
+
+	/* Just wake-up and kick the autosuspend timer */
+	pm_runtime_mark_last_busy(ddata->dev);
+	pm_runtime_put_autosuspend(ddata->dev);
 
 	return IRQ_HANDLED;
 }


