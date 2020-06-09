Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22553C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF45C20812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTaZexr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgFILbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbgFILa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:30:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D9BC08C5C2;
        Tue,  9 Jun 2020 04:30:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so2495136wmj.0;
        Tue, 09 Jun 2020 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bH/+slbZjQBA3mYlSc2q+05536qmkTvC1HCFI8ZmnIE=;
        b=FTaZexr38TGn3YldlZdOFciSIxmG1MkcO6rPSsRRK4OfWjR7a9gl0znAiEgoyR3yqb
         oTZdf4NyeLjorwZbZS+BzsoRhdFSkVyOE1jmVDzeRY0z+NiigUPSAB+vJonQsdyZhbJW
         m5pkDmKAQQTdWGczJtXE97kyNt8D2kTqi6e5kHFoxu7jciVPisI/tGL3iBgJLTlKD3/O
         nqrY1zAnQYjnvsPZkU2pP3U24LuTyyUpnX8fVPmclfVgMGNY0QN5LjKnsVK+3qY7UGRc
         cXGMUDfjqXuvWfc0gsiLHkriW9FNNFLjR4vkpcXbfLNi9JPj0GkkAMiY+JG596M8lnv/
         T6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bH/+slbZjQBA3mYlSc2q+05536qmkTvC1HCFI8ZmnIE=;
        b=rtDrZd8eEUB5cUtD105Xygel9166P/Ebmz4jaQZWrJ6qeDYlvN8QpR0hLhc49T0irz
         PZQ56Vp/ActNImU0Ulh7a1KpcPqMgdHYGmX+16KmmAis+Z3O72uwJo58LLgop4T0VAoQ
         RfzUd7Qiqkc5+cnFqPypcY0cZxxDKgiw2GsBr/lwzyTGHyVfEVygTL6y8t9mM9lq7mey
         KClsedAEsaXF9413Gjol66wQbGRCX+8Dzqnh50I5TxWSepIDe8KOWQ4dLMlIJLG9i7tK
         HwyJVMDITHmZz7n3Gts0pk/zpoZKIJCSLN94kRG+S2csG7tIiN53wNs8NQSGpxVGFGWy
         FF4w==
X-Gm-Message-State: AOAM531rvSvwtDfoeEXtiSldEUoNh3TcjeAN/q/PgQkEFO4JoWsATgQ0
        7zLQSvxZaoEsu2lnlNYTp7E=
X-Google-Smtp-Source: ABdhPJyb/putWPrIRSQ+MFJ+GR8f+CvA9NmKmGqs0c02IlxuemZcWgOwbIIuRScgxih6gY0m3eHiJw==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr3508031wmi.22.1591702254431;
        Tue, 09 Jun 2020 04:30:54 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id l17sm2609877wmi.16.2020.06.09.04.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 04:30:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        julia.lawall@lip6.fr, f4bug@amsat.org, jonas.gorski@gmail.com,
        lkp@intel.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/2] clk: bcm63xx-gate: add BCM6318 support
Date:   Tue,  9 Jun 2020 13:30:49 +0200
Message-Id: <20200609113049.4035426-3-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609113049.4035426-1-noltari@gmail.com>
References: <20200609113049.4035426-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the gated clock controllers found on the BCM6318.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/clk/bcm/clk-bcm63xx-gate.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm63xx-gate.c b/drivers/clk/bcm/clk-bcm63xx-gate.c
index 98e884957db8..12394c091d13 100644
--- a/drivers/clk/bcm/clk-bcm63xx-gate.c
+++ b/drivers/clk/bcm/clk-bcm63xx-gate.c
@@ -40,6 +40,48 @@ static const struct clk_bcm63xx_table_entry bcm3368_clocks[] = {
 	{ },
 };
 
+static const struct clk_bcm63xx_table_entry bcm6318_clocks[] = {
+	{ .name = "adsl_asb", .bit = 0, },
+	{ .name = "usb_asb", .bit = 1, },
+	{ .name = "mips_asb", .bit = 2, },
+	{ .name = "pcie_asb", .bit = 3, },
+	{ .name = "phymips_asb", .bit = 4, },
+	{ .name = "robosw_asb", .bit = 5, },
+	{ .name = "sar_asb", .bit = 6, },
+	{ .name = "sdr_asb", .bit = 7, },
+	{ .name = "swreg_asb", .bit = 8, },
+	{ .name = "periph_asb", .bit = 9, },
+	{ .name = "cpubus160", .bit = 10, },
+	{ .name = "adsl", .bit = 11, },
+	{ .name = "sar124", .bit = 12, },
+	{ .name = "mips", .bit = 13, .flags = CLK_IS_CRITICAL, },
+	{ .name = "pcie", .bit = 14, },
+	{ .name = "robosw250", .bit = 16, },
+	{ .name = "robosw025", .bit = 17, },
+	{ .name = "sdr", .bit = 19, .flags = CLK_IS_CRITICAL, },
+	{ .name = "usb", .bit = 20, },
+	{ .name = "hsspi", .bit = 25, },
+	{ .name = "pcie25", .bit = 27, },
+	{ .name = "phymips", .bit = 28, },
+	{ .name = "afe", .bit = 29, },
+	{ .name = "qproc", .bit = 30, },
+	{ },
+};
+
+static const struct clk_bcm63xx_table_entry bcm6318_ubus_clocks[] = {
+	{ .name = "adsl-ubus", .bit = 0, },
+	{ .name = "arb-ubus", .bit = 1, .flags = CLK_IS_CRITICAL, },
+	{ .name = "mips-ubus", .bit = 2, .flags = CLK_IS_CRITICAL, },
+	{ .name = "pcie-ubus", .bit = 3, },
+	{ .name = "periph-ubus", .bit = 4, .flags = CLK_IS_CRITICAL, },
+	{ .name = "phymips-ubus", .bit = 5, },
+	{ .name = "robosw-ubus", .bit = 6, },
+	{ .name = "sar-ubus", .bit = 7, },
+	{ .name = "sdr-ubus", .bit = 8, },
+	{ .name = "usb-ubus", .bit = 9, },
+	{ },
+};
+
 static const struct clk_bcm63xx_table_entry bcm6328_clocks[] = {
 	{ .name = "phy_mips", .bit = 0, },
 	{ .name = "adsl_qproc", .bit = 1, },
@@ -217,6 +259,8 @@ static int clk_bcm63xx_remove(struct platform_device *pdev)
 
 static const struct of_device_id clk_bcm63xx_dt_ids[] = {
 	{ .compatible = "brcm,bcm3368-clocks", .data = &bcm3368_clocks, },
+	{ .compatible = "brcm,bcm6318-clocks", .data = &bcm6318_clocks, },
+	{ .compatible = "brcm,bcm6318-ubus-clocks", .data = &bcm6318_ubus_clocks, },
 	{ .compatible = "brcm,bcm6328-clocks", .data = &bcm6328_clocks, },
 	{ .compatible = "brcm,bcm6358-clocks", .data = &bcm6358_clocks, },
 	{ .compatible = "brcm,bcm6362-clocks", .data = &bcm6362_clocks, },
-- 
2.26.2

