Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F39C5ACC1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55F220750
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znQttMIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgCKRVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:21:30 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37504 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbgCKRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:21:27 -0400
Received: by mail-pj1-f66.google.com with SMTP id ca13so1354107pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CpmywWyp6aExqYXO2nsoyNHZG6T/FiFmGDy6H1VmZYo=;
        b=znQttMIzLhlauM/O9plxveT/fNrNaEDEifiJ5H0Am0jZ8/lTIHyXlHg0yknkHJiADu
         9kR8VtlZGdEdod+7vB5Oxm0Z8GKCvxdCT9LqcNp7XKTJYI+DkdgngFyvvW9OLgEJQx8Q
         IK9rG8mgyRvlrAM53TgYZxF8UCtZzrdzrfR2hy2tOzQ/s5RF0TJyZHYO0s19r1C5tav4
         QwMI+KfyoMaztfRLMF4mzN/jvm1SxRcxJQBY2ap3p48leqUmNYqOMlYyOwu4PiOvcMeW
         YIm2SeipEb3FeP/t33f8fg9qDGH/t/Ms5OMgia3XPUBPIugzSIvdpzidGf5zAyPaZsXV
         Xhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CpmywWyp6aExqYXO2nsoyNHZG6T/FiFmGDy6H1VmZYo=;
        b=bcYFH0HxB/UnkQQhc9zyZSoZopBS+vDDK56YvweLSnsgf2HMEs/nwKBGevGOTmTKlY
         vHJkVfP+ff9qlRLsdc8TLi98rOyYwpJDWmI+5UYQ/3j1F0nJVJG8+o/XgMn/qmfUrEjy
         HDCVg2pGqjrv453GNx0joJYdD4z/gIWGhEhoN7JEebhjv6Joz5dMTgtm+qpWdqPF8rNl
         7JisCQHMO5xGqkjPlHlv0Sv2BtkIl+PooX5Gn8e9oSgsjyukfk3s7hQXa0yziWbuuIew
         gVMNhyNevplgs3rRNXltKs/pbTJzU+gN8Din8zH+Um6+IZ9sXQDEkf21zGSt6NpRsjiP
         hJrw==
X-Gm-Message-State: ANhLgQ1iyVLw9Lxz5mjR5LN4qdjWp4xAyQ8LiuTAhtXx/Hya/EqP2Okb
        5RUcJQXG7HKuGAnEB4yT+XECF/uI2Gs=
X-Google-Smtp-Source: ADFU+vuRBKnrKmXU0JZNUQ5/lnkIEqkKhvu5m1kBFMbNPnH6c1//Ozyk0auxbkjc1uDgkvgSp6FZyw==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr4002764plb.20.1583947286400;
        Wed, 11 Mar 2020 10:21:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id b24sm14914053pfi.52.2020.03.11.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:21:25 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND][PATCH v8 5/6] usb: dwc3: Rework clock initialization to be more flexible
Date:   Wed, 11 Mar 2020 17:21:08 +0000
Message-Id: <20200311172109.45134-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311172109.45134-1-john.stultz@linaro.org>
References: <20200311172109.45134-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 core binding specifies three clocks:
  ref, bus_early, and suspend

which are all controlled in the driver together.

However some variants of the hardware my not have all three
clks, or some may have more. Usually this was handled by using
the dwc3-of-simple glue driver, but that resulted in a
proliferation of bindings for for every variant, when the only
difference was the clocks and resets lists.

So this patch reworks the reading of the clks from the dts to
use devm_clk_bulk_get_all() will will fetch all the clocks
specified in the dts together.

This patch was recommended by Rob Herring <robh@kernel.org>
as an alternative to creating multiple bindings for each variant
of hardware.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Rework dwc3 core rather then adding another dwc-of-simple
    binding.
v6: Re-introduce this patch, on Rob's suggestion
---
 drivers/usb/dwc3/core.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1d85c42b9c67..ba21af5c1204 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -289,12 +289,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	return 0;
 }
 
-static const struct clk_bulk_data dwc3_core_clks[] = {
-	{ .id = "ref" },
-	{ .id = "bus_early" },
-	{ .id = "suspend" },
-};
-
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
@@ -1441,11 +1435,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (!dwc)
 		return -ENOMEM;
 
-	dwc->clks = devm_kmemdup(dev, dwc3_core_clks, sizeof(dwc3_core_clks),
-				 GFP_KERNEL);
-	if (!dwc->clks)
-		return -ENOMEM;
-
 	dwc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1481,17 +1470,18 @@ static int dwc3_probe(struct platform_device *pdev)
 		return PTR_ERR(dwc->reset);
 
 	if (dev->of_node) {
-		dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
-
-		ret = devm_clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+		ret = devm_clk_bulk_get_all(dev, &dwc->clks);
 		if (ret == -EPROBE_DEFER)
 			return ret;
 		/*
 		 * Clocks are optional, but new DT platforms should support all
 		 * clocks as required by the DT-binding.
 		 */
-		if (ret)
+		if (ret < 0)
 			dwc->num_clks = 0;
+		else
+			dwc->num_clks = ret;
+
 	}
 
 	ret = reset_control_deassert(dwc->reset);
-- 
2.17.1

