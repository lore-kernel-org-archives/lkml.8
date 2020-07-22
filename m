Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B5C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1323207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPjQ1rMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgGVRIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732062AbgGVRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:08:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F07C0619DC;
        Wed, 22 Jul 2020 10:08:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so2630013wrh.3;
        Wed, 22 Jul 2020 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/f+3CAnVUu/WjuKg7piRBh88qTkT5e7hVX0fEyS5bwY=;
        b=LPjQ1rMW3KUqOFtgB3vrPVE9Sn6xRahSMWV9fihcIJqpX7NsQq2hm8zVigCnCAP40y
         AIJa9NhAf5pnxIAqytIJZQSu1nCx02XXgjXFnKulbqk8vx/U8+ru7I53HpkKFBrX58jw
         HzdTjIL2ZDUg6zl1Eqx7eBYUpkspH7P9a5Srvxhlz+1mGMEIG/cWk067IVjLSbXrVbiZ
         Au9vrrv8Ha5SIX4q4R46LXdfheE2fjxA+dewBZ2/6oJqkZNwj06QnErpATE8MAnu/1bE
         vqPR++e24Ub0RkhjNxZdWE1grDGLgoeccbhLSe8kaUqrpHznZMtoRDJfHOYKrwvcWnI/
         T1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/f+3CAnVUu/WjuKg7piRBh88qTkT5e7hVX0fEyS5bwY=;
        b=D97jnLz2K8kOUQnCOqazLFvdllgTL9UuvaFwBpFX7TiituB6MgNgBAIynFR/CsRf/b
         aFT65lZYYsjBFHX3846WjH3pJRPLMODHO3jjR4TSuLpL1zFvlXsRrJ5c3SaGMjdS9Fpi
         q3Oo1kbYdjeMI06Gns9NDRRo1LXAlWorviaQ6KLYqVTpfJcI6+weIjfRMf3wCsRf43LP
         FxPHrCUlXyQ3OuHPTFC/AYk5UsrjGhBXw0p5zA3M0eZn1z3KmG3MZAbhwJoWEOTPb5ha
         r82P/uST2zBt75+wjoJRq9Jggt7Mu88wqrWju5ju0zUEVwzgAFLG61vTqdPQc3gAk8+C
         AxBg==
X-Gm-Message-State: AOAM532euvTshNe6q57k1IhG2n2e3C6Rdl5UZMs0tsnyGCKOl8ricYiy
        Y2T3GlVv9Oj14UTgxBGmqMSZTQhR
X-Google-Smtp-Source: ABdhPJx3dWTAnp+oEPCdkWSM21p/Re1l+8HQDMp+BzYjHY48DxTeiqtREbtrDMDERZuUV3imK4fwfg==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr417496wrt.8.1595437693205;
        Wed, 22 Jul 2020 10:08:13 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 133sm392960wme.5.2020.07.22.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:08:12 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v3 7/7] usb: bdc: Use devm_clk_get_optional()
Date:   Wed, 22 Jul 2020 13:07:46 -0400
Message-Id: <20200722170746.5222-8-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722170746.5222-1-alcooperx@gmail.com>
References: <20200722170746.5222-1-alcooperx@gmail.com>
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

