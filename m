Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5ABC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA29020CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mopFLxsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbgBYRyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:54:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39490 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbgBYRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:54:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id j15so7240695pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EGHWPlxApQjuktMa4xDP9Q063H+hJfu1b6AJ+NVENyk=;
        b=mopFLxsWbeU0/yL28BByX3Qmrqu4/lNA+fcgdrQ0c38OZPHrInJHNTj2WYC/ILCWI3
         rXsIHYNPOo1xWFMGo7b/0CEJyDfVXjQ/OF3IJs1bd8q8HuaPPs18JlBn3fRBNx7jqN5f
         fC8vxPOg23B/AWvtJ+Qf4eNAws51cK2BgiyA2EA5uI5P3NgCw0Wv9hQUdeTRc3PUrZ0V
         hRk0YjbtV5tCBvV82AvEH/9gQey8wstJTVxNI3gzLRzj7PSSlwWMWxLKk9pa39J5/c6r
         JpjLoP7WYSaFE7JvzH24FqeckT308GZ6KURzKIQEE9oy3BJrKRDDhYmWeLqZFBVK+T/2
         mbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EGHWPlxApQjuktMa4xDP9Q063H+hJfu1b6AJ+NVENyk=;
        b=MjnnkPolL/bqWHtNpe9LD757AtMAdRbKg9zZXZ/v0m8+GQXTchl92INC1tJo9n4WTP
         +iG+mfesSNGlTeQxBTVTDwJMaQjNRwkicHlFlJ25aKO+R/xJFTe6XOEx4Gq68StCeozs
         Tfzo3sbz+h02HowQ1ID6r9fB/nScxxGzkOEXWptvMhr1T+XZwbPgvJJmgPPAHzb/4EkL
         iZVS6m7qmR1/hPOrQJiBK0LwqLsOEVMpwPQ672KwLoq5aOtLMUkp4V0VVNWD8F5qWnCz
         lRVLhnMk1azBSFdvZMOvtGhITD68Ya7+pDafnIBp0KscdVNerPtGR+0KfOJIpoM2pZgf
         zBzg==
X-Gm-Message-State: APjAAAWqqJ1KnUx+tp6gOTPaFi/LGRc/EUMgFxc1sQHcI5borbvtbh/N
        +5hr6KoeqchEcbgLt7zlXZS8S05AGIg=
X-Google-Smtp-Source: APXvYqzHMYAmH1VGS/4L4IKuT3hh7pV1x1nh2bDeq23It8zTwLG0Ky2zYk/YSXEkpzQl6uUTVp43bQ==
X-Received: by 2002:a63:2b0a:: with SMTP id r10mr12434661pgr.213.1582653248359;
        Tue, 25 Feb 2020 09:54:08 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id v8sm18013291pgt.52.2020.02.25.09.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:54:07 -0800 (PST)
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
Subject: [PATCH v8 6/6] usb: dwc3: Rework resets initialization to be more flexible
Date:   Tue, 25 Feb 2020 17:53:04 +0000
Message-Id: <20200225175304.36406-7-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225175304.36406-1-john.stultz@linaro.org>
References: <20200225175304.36406-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 core binding specifies one reset.

However some variants of the hardware may have more. Previously
this was handled by using the dwc3-of-simple glue driver, but
that resulted in a proliferation of bindings for for every
variant, when the only difference was the clocks and resets
lists.

So this patch reworks the reading of the resets to fetch all the
resets specified in the dts together.

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
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ba21af5c1204..2afcc04da338 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1465,7 +1465,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
+	dwc->reset = devm_reset_control_array_get(dev, true, true);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
 
-- 
2.17.1

