Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2012C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814A520717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms7mwOup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgGUOoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbgGUOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:44:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14CBC061794;
        Tue, 21 Jul 2020 07:44:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so21461820wru.6;
        Tue, 21 Jul 2020 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/f+3CAnVUu/WjuKg7piRBh88qTkT5e7hVX0fEyS5bwY=;
        b=Ms7mwOupgucNKvHjaO51nVyunwKt6+TL6btD/qMIECU2mqYJHJGKfg0XiRiLB7OpCJ
         io2x9OLHnMKcDRuYwpIFmGJUw9nx+4eIGRX1JD1S5w8M1Wrhi30qUR+SWaQj1hWwOdbx
         rWzX12fpHhEHXa1DqPgEJal92k2p3qDfkbYvoUnQxIWle+DzQ0xhcAwa8jCEpHjFxIYC
         uYcKJKepMIlbAx0dF6m8BO6vmQ3hY9qnFwuY1M65G/4vLNk+pdyOC5TLRQeIBRkfGquB
         45o9VO43PPPeC0ELIrcBPy72cH2PtBh1xBrARSHHxwWlIfoo/AebnNF61SHg7Bt6Q/k5
         bCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/f+3CAnVUu/WjuKg7piRBh88qTkT5e7hVX0fEyS5bwY=;
        b=PFzv/1GssZdM+YH4gk1vlf1FYZ/KLT07U7xTMe9wyMZIdmWzN15kG2S6ruZWtTeK1q
         dNRT2hLhkSAfG0ZUgvwWqr2uKcfCcDttYT0VXREFfkzj3gV1K5YFt6adEhQo1igAMvRe
         XwWfWEDxT6+DtcyBZtozl+0aA3JS53YkVyc/A4TBEePzkT3aTY7ooS41U0PrUSZ8onWF
         AzSOJfPJnTD8P0+gRhalSJrOKgxhzvbWMzoJT5rKgM+36WpLSKM73EhQocByiJlmwGfJ
         AlTkq84itPAd7xr8ywF5MmzIslpP1yxmN2OuVOZDT2Vh0FnpCaXyL1fIhfRNnybTQj6a
         e0GQ==
X-Gm-Message-State: AOAM532cRKpDZBnx6AlnenycowcJT6aVg/8TknssdS5jHSA2EVT1BR8h
        jruV8BwcoSHt4TH4zlMXkF2LZy/O
X-Google-Smtp-Source: ABdhPJzB0wLvFkFof5pNtZA4xFonrctQrhfecc9Jb5K8Cw2fhCvUQR6jldysZfVCTluswm8bqGFpWA==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr7590524wrr.151.1595342645103;
        Tue, 21 Jul 2020 07:44:05 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y6sm38043116wrr.74.2020.07.21.07.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:44:04 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v2 7/7] usb: bdc: Use devm_clk_get_optional()
Date:   Tue, 21 Jul 2020 10:43:26 -0400
Message-Id: <20200721144326.7976-8-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721144326.7976-1-alcooperx@gmail.com>
References: <20200721144326.7976-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

The BDC clock is optional and we may get an -EPROBE_DEFER error code
which would not be propagated correctly, fix this by using
devm_clk_get_optional().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index c1650247ea39..f6e4026618e8 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -497,11 +497,9 @@ static int bdc_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	clk = devm_clk_get(dev, "sw_usbd");
-	if (IS_ERR(clk)) {
-		dev_info(dev, "Clock not found in Device Tree\n");
-		clk = NULL;
-	}
+	clk = devm_clk_get_optional(dev, "sw_usbd");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-- 
2.17.1

