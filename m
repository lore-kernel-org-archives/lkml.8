Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885EAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655D22054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S4pcjGYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgH0Oso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgH0Os3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:48:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727FCC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:48:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y8so3891570wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=US0rKLWi0Ij67svDuIlZzqQZrRksxzdQhyeGx2i0lHA=;
        b=S4pcjGYXLbtMtCdpP90WCSGT29fBBzW7vj9f/R0GaIuYOTidERM3wLubMrY4hB2pbg
         blCZiFzfpu7LOlZm6YLit8h2vBenAXIDzbDKpM1nyGz68tCsEf6aFR2LSVWXDA7UQFCi
         WdYhRjw+1HzPQng1fIkDEVMVYcChzzL2se2+/0o39WTH6pL6dzkjK9YOX3zfOt59Hpov
         GFIB09ihBviRr0RBGQ/59DE1I0zW9GY3AXKRJmmsRdkAzy83fGSOOEGX4+VsQReIfA77
         o1ay6NYxCmZ3A6ZpgyPhpvuXQanBmWwCd5U0T9nIpgxp/O7eFuV6j2CmKkNpXrP58sHC
         l3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=US0rKLWi0Ij67svDuIlZzqQZrRksxzdQhyeGx2i0lHA=;
        b=ManngnA3+2aax20bi7XkSY35N0/8cREyQhD1C6yk8CN40IQWEZLrl4SDjC/y/IpWjC
         Ypo49SPHcFaeEO6BrbL5TT6JL9un2wtynvSOQf0PxRww4d0RIp+FzaTf3tZj1oS6rWfw
         ziHHd/7ch7xSCY2LIDSOFQ/WiGq1tN31liqlAZ7R4Eeyj5nI7xbvi4sJUooTNqSiz/s6
         mP0nBMA7INKYuYVnsVZFO5zPJsuuldHNApjLeExj3YUJjZ9ReleR9Xdl42fwqX36nkoE
         CamBoF2nGdsiYq5UYQlsPkACII9P++69RiIWdmv5CJfExTH9rjve6dj+97h6cy5y1ePw
         jqOw==
X-Gm-Message-State: AOAM531zO3NQCBMfsjjbYrOPqNsjC9VAQuYGPYo45rV0bh6qtqimCRWe
        8TkEm4DKIPn4Npz7Nw2Vap1bLA==
X-Google-Smtp-Source: ABdhPJz1h5Fc45F5daqe66MhiGIVffd268qdCjCnPYhDLTXCqIsKqtcM61Fi0N5Ml5xq7+km3yCXYw==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr10242160wmc.122.1598539707094;
        Thu, 27 Aug 2020 07:48:27 -0700 (PDT)
Received: from amjad-ThinkPad-T490.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 33sm6756659wri.16.2020.08.27.07.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:48:26 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Dan Robertson <dan@dlrobertson.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "usb: dwc3: meson-g12a: fix shared reset control use"
Date:   Thu, 27 Aug 2020 16:48:10 +0200
Message-Id: <20200827144810.26657-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7a410953d1fb4dbe91ffcfdee9cbbf889d19b0d7.

This commit breaks USB on meson-gxl-s905x-libretech-cc. Reverting
the change solves the issue.

In fact, according to the reset framework code, consumers must not use
reset_control_(de)assert() on shared reset lines when reset_control_reset
has been used, and vice-versa.

Moreover, with this commit, usb is not guaranted to be reset since the
reset is likely to be initially deasserted.

Reverting the commit will bring back the suspend warning mentioned in the
commit description. Nevertheless, a warning is much less critical than
breaking dwc3-meson-g12a USB completely. We will address the warning
issue in another way as a 2nd step.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 88b75b5a039c..1f7f4d88ed9d 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -737,13 +737,13 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 		goto err_disable_clks;
 	}
 
-	ret = reset_control_deassert(priv->reset);
+	ret = reset_control_reset(priv->reset);
 	if (ret)
-		goto err_assert_reset;
+		goto err_disable_clks;
 
 	ret = dwc3_meson_g12a_get_phys(priv);
 	if (ret)
-		goto err_assert_reset;
+		goto err_disable_clks;
 
 	ret = priv->drvdata->setup_regmaps(priv, base);
 	if (ret)
@@ -752,7 +752,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	if (priv->vbus) {
 		ret = regulator_enable(priv->vbus);
 		if (ret)
-			goto err_assert_reset;
+			goto err_disable_clks;
 	}
 
 	/* Get dr_mode */
@@ -765,13 +765,13 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = priv->drvdata->usb_init(priv);
 	if (ret)
-		goto err_assert_reset;
+		goto err_disable_clks;
 
 	/* Init PHYs */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = phy_init(priv->phys[i]);
 		if (ret)
-			goto err_assert_reset;
+			goto err_disable_clks;
 	}
 
 	/* Set PHY Power */
@@ -809,9 +809,6 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	for (i = 0 ; i < PHY_COUNT ; ++i)
 		phy_exit(priv->phys[i]);
 
-err_assert_reset:
-	reset_control_assert(priv->reset);
-
 err_disable_clks:
 	clk_bulk_disable_unprepare(priv->drvdata->num_clks,
 				   priv->drvdata->clks);
-- 
2.17.1

