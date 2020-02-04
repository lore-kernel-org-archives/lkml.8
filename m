Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435DDC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1677820674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPud0Ihy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgBDTMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:12:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40158 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBDTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:12:10 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so1804822pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 11:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFXhEwC/wFCkTe/lPBw8m3XC/MunfcfcPF2H9ytGoVc=;
        b=lPud0IhyMRajOMKw49bKGnWv+xpIFX1ZYKTLwemLAOwK9T0aHLDngCuhvEKt+dtJGx
         rjUBAZ7USNj9U4KRqF2gjZo37W4178z3GRxFF/oWtYDDGFZWmI9dB9RxwOMMThN6sDHO
         KLLXiB44aHmu5mI8Nx60UyYqRlRJLOTAFDSGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFXhEwC/wFCkTe/lPBw8m3XC/MunfcfcPF2H9ytGoVc=;
        b=Ro8J1URLLVXFNMOvjISmITKKcthhYiINCL8US4oNtzr3Dom7+8bwfY7V38a4MtK7n2
         WxZT3/SrjbjOV1g7GFkP3rtZJSDGpmBbrCk9B2CSItwH+tNYI4QXTBCGNff2lWfn7Yya
         SOvYASuBPxDsNEpN4AuKpGolC182irlY/0ahVMi9Q95kits1TStYWsT/x4rZ2FWidEHT
         4D/YqlMMrOEl00bRRd+wknBWefAhSuy5fGKvmHNIfrg/k8xBmtjSHhSObd4MnCMDJFJG
         ofDcLDXguU+HoSvdpAfCsgNS0Ye+MGvK8t8/HTzP8ZSld0JZANu2YFqkHIc0HwlGxTYf
         EN0g==
X-Gm-Message-State: APjAAAWfk4eLJD4nh9v3jeyb6sH4D3rkfgwqK5U7wcwRwV4cdrvAwrgz
        qUW1MBZjbhTeWGGo0cKtcnsHYw==
X-Google-Smtp-Source: APXvYqwNQG37TNBqu0MyO3BxrbVd79f56GLuwPiZ6tu1FZGC4hxyGZHTkNe/F46qpzjEOch7mYsYhg==
X-Received: by 2002:a17:90a:ead8:: with SMTP id ev24mr688790pjb.91.1580843528907;
        Tue, 04 Feb 2020 11:12:08 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c19sm26303229pfc.144.2020.02.04.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:12:08 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/3] spi: spi-geni-qcom: Let firmware specify irq trigger flags
Date:   Tue,  4 Feb 2020 11:12:04 -0800
Message-Id: <20200204191206.97036-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204191206.97036-1-swboyd@chromium.org>
References: <20200204191206.97036-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
should take care of this for us. Just use 0 instead so that we use the
flags from the firmware.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6f3d64a1a2b3..46e501fc87f3 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -585,8 +585,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-	ret = request_irq(mas->irq, geni_spi_isr,
-			IRQF_TRIGGER_HIGH, "spi_geni", spi);
+	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(&pdev->dev), spi);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-- 
Sent by a computer, using git, on the internet

