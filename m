Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCAC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9DA20714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgELA0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:26:16 -0400
Received: from retiisi.org.uk ([95.216.213.190]:40554 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgELA0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:26:16 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 9795A634C87;
        Tue, 12 May 2020 03:25:18 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1jYIjW-0001lF-GJ; Tue, 12 May 2020 03:25:18 +0300
Date:   Tue, 12 May 2020 03:25:18 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>, Ben Kao <ben.kao@intel.com>
Subject: Re: [PATCH v8 2/3] media: ov8856: Add devicetree support
Message-ID: <20200512002518.GX867@valkosipuli.retiisi.org.uk>
References: <20200511110350.11565-1-robert.foss@linaro.org>
 <20200511110350.11565-3-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511110350.11565-3-robert.foss@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Mon, May 11, 2020 at 01:03:49PM +0200, Robert Foss wrote:
> Add match table, enable ov8856_probe() to support
> both ACPI and DT modes.
> 
> ACPI and DT modes are primarily distinguished from
> by checking for ACPI mode and by having resource like
> be NULL.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Applied with this small diff --- please check with checkpatch.pl on the
next time. Thanks!

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 1657e03d9a9d..4ca27675cc5a 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -1226,8 +1226,7 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856, struct device *dev)
 	if (!fwnode)
 		return -ENXIO;
 
-	ret = fwnode_property_read_u32(fwnode, "clock-frequency",
-		&xvclk_rate);
+	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &xvclk_rate);
 	if (ret)
 		return ret;
 
@@ -1244,10 +1243,11 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856, struct device *dev)
 	}
 
 	if (xvclk_rate != OV8856_XVCLK_19_2)
-		dev_warn(dev, "external clock rate %d is unsupported", xvclk_rate);
+		dev_warn(dev, "external clock rate %u is unsupported",
+			 xvclk_rate);
 
 	ov8856->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-		GPIOD_OUT_LOW);
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(ov8856->reset_gpio))
 		return PTR_ERR(ov8856->reset_gpio);
 
-- 
Kind regards,

Sakari Ailus
