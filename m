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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0779C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889E6207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veGRSLLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgGUOnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:43:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0EAC061794;
        Tue, 21 Jul 2020 07:43:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a14so6619637wra.5;
        Tue, 21 Jul 2020 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PcFNrK19mZrXhPQzacSfnIQyQlDsSGJMMRsF7kKt4gA=;
        b=veGRSLLaYi7xt3AG+fhtj2uh8ZYMwM+wp1U3jzN3N06nVP/J2FvPFALC2D2/lTp9KO
         wINKG2iTecEocZoCRHB+qdOl3D1EqG6cNxtOhJwK87DCcILgiR44qnt1u4b0US8HzEBE
         uwsQlaGtpVevuT0wMwvLFYdlH2Iq+rF5eaXNHz2JriJfD5DBU8OxelPZghXqGQQHDveI
         QxT+56FRTVJrrNs/AnTY7qsYCRecXvpCuAi+ax8EYakUprmthdvn+Qe/PJfIku1Hmp8K
         TAWHECgTYWzUrG9j0pG66f3OOqLHly85ODGlo+0VS3S8JGGKZQ0O76oiWhb0AdlLT7SZ
         TKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PcFNrK19mZrXhPQzacSfnIQyQlDsSGJMMRsF7kKt4gA=;
        b=iYxv3Dxsv1TeaTMCWvfbBh2CJAOLn4VOOhUWPa33kvfFL9ziHsWZUekB0DhergnePR
         l9pwBw9nJ5uYdVko5IKusYdQOaMH6aw2deBCI4aFiCxOYbe1tGlcMlm/IXe7dz/2q0k2
         joXDxsCnKBnxGy0BMByvAHaz/YELVB8mW+xIlInVyGAgLX66c+BaYgzleR3gMaNAgvyO
         EoEI0uxyrX0BvC5pvXcRLFV6NSD1g0R8tQUpceMNZ3McXqQRGZ3aWwpLlPAcxSI7cMA+
         b2YQcPIAdTSEYSzH1XzsAHLHdrRQOFPCgR7znGbFtw2CI+ZnPaLeA0Cr9Z7RNgm7E9r/
         mZ8g==
X-Gm-Message-State: AOAM5312CF7j67JyWIMdWul+Sy6AmUoDkakvb5j6V3bZk8HKNQCK6rvM
        OQKYfhZ/Y+1Hv5VtjPBEIo0tB9fA
X-Google-Smtp-Source: ABdhPJzkjuU1HwRnS/yXc7/xnUILcnXDZLyJPPUiX6yZFkszg1uOx6Uqu8Wc1vVp6tEEbmmri4VOzg==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr6584137wrv.86.1595342631992;
        Tue, 21 Jul 2020 07:43:51 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y6sm38043116wrr.74.2020.07.21.07.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:43:51 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v2 2/7] usb: bdc: Add compatible string for new style USB DT nodes
Date:   Tue, 21 Jul 2020 10:43:21 -0400
Message-Id: <20200721144326.7976-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721144326.7976-1-alcooperx@gmail.com>
References: <20200721144326.7976-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for some newer boards that only have this
as there match sting. Remove unused compatible string "brcm,bdc-v0.16".

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 02a3a774670b..18d510fc02fb 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -629,7 +629,7 @@ static SIMPLE_DEV_PM_OPS(bdc_pm_ops, bdc_suspend,
 		bdc_resume);
 
 static const struct of_device_id bdc_of_match[] = {
-	{ .compatible = "brcm,bdc-v0.16" },
+	{ .compatible = "brcm,bdc-udc-v2" },
 	{ .compatible = "brcm,bdc" },
 	{ /* sentinel */ }
 };
-- 
2.17.1

