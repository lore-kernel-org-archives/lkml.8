Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9913C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 22:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87AA22083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 22:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6CDxpR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgH3Wni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgH3Wnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 18:43:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A0AC061573;
        Sun, 30 Aug 2020 15:43:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so1093619lfy.10;
        Sun, 30 Aug 2020 15:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEgefS3eB+mvl2FPj7cQXBxT0AMkRWZor40Hj05yvRk=;
        b=V6CDxpR6NZ0wqk3lhJEKssprLK/jNsNvVptYlY6diwZHODH1Bvn1DC1NVjQMqk1hLk
         8qwJZM2OkP/YfjyKCdx8tRLMoe77FY9sJN88SqoIaConsDIvYr2Jqb3Iq/6JgH4nkBhi
         kV34nDHAwKtj+UwyEt6VAsb7zXADAb5f3aZwtALR0SuRTmrvcly28BW9GcSwYwfJsP3d
         GTefwXLmmfKE8gpD3P/XYkVNdaIvzUE8/xaYm+xacA3wNNwKvcXB/iTwXTBqdFwpII1C
         azIhloHEnOM21YPTY/eSP7VyWliwejSyTijaXVZON43swdT4aCH4SRNfOILQDr7NJ/kb
         WnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEgefS3eB+mvl2FPj7cQXBxT0AMkRWZor40Hj05yvRk=;
        b=Ge81O89gwzZb8ccsKUDLjErRF5V/vivSUqfZK0uwGn2wqx0SNpZ+hqvibT50YKS64V
         DD4ooEgMlYNA9uoLtxn6gvQzDxb/WbglMJe8i4xDDbNa8kT/M3I7TZ6tI0URDCT5k/Fd
         lkdu9ZQtNs7lUCpu9gNgB/HXfz9CJXsKWaQYgn1w//XTegFmJl4/GNRf6z+KB1QGFSnl
         nsRi1UggVMCaMnXHtD/AsKvgJ5qXIuhB6Sf6Z3i4qgcXz5Bs8yGhybHt8WU4yNCs9GMn
         VxJgdVTUrgwgy8jQejirCaj7g9qCqjO5WYOefb5GNvuRcXtUhEVJ+6416bYjMiOTKX4L
         17ew==
X-Gm-Message-State: AOAM530lYfaOsRYuZVEADwXAQ1xcghOm7EUoQNEoEInspDWVRwC2N4Xu
        XJGAuFk3TxRIwerLhfQzIm0=
X-Google-Smtp-Source: ABdhPJyhSpOE8zs7PimxwUVTHbFFGcTaS0ZF7UlFcKSPgmgwiNBvipZGuG6SrTNRCATQrmGv78BPXA==
X-Received: by 2002:a19:7605:: with SMTP id c5mr329237lff.116.1598827410497;
        Sun, 30 Aug 2020 15:43:30 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id m25sm1190072ljg.79.2020.08.30.15.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 15:43:29 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] pinctrl: actions: pinctrl-s700: Constify s700_padinfo[]
Date:   Mon, 31 Aug 2020 00:43:10 +0200
Message-Id: <20200830224311.36994-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830224311.36994-1-rikard.falkeborn@gmail.com>
References: <20200830224311.36994-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of s700_padinfo[] is to assign it to the padinfo field in
the owl_pinctrl_soc_data struct, which is a const pointer. Make it const
to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/pinctrl/actions/pinctrl-s700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/actions/pinctrl-s700.c b/drivers/pinctrl/actions/pinctrl-s700.c
index f579a6593f37..fd00940a5799 100644
--- a/drivers/pinctrl/actions/pinctrl-s700.c
+++ b/drivers/pinctrl/actions/pinctrl-s700.c
@@ -1685,7 +1685,7 @@ static PAD_PULLCTL_CONF(I2C2_SDATA, 2, 8, 1);
 static PAD_PULLCTL_CONF(I2C2_SCLK, 2, 7, 1);
 
 /* Pad info table for the pinmux subsystem */
-static struct owl_padinfo s700_padinfo[NUM_PADS] = {
+static const struct owl_padinfo s700_padinfo[NUM_PADS] = {
 	[ETH_TXD0] = PAD_INFO_ST(ETH_TXD0),
 	[ETH_TXD1] = PAD_INFO_ST(ETH_TXD1),
 	[ETH_TXEN] = PAD_INFO_ST(ETH_TXEN),
-- 
2.28.0

