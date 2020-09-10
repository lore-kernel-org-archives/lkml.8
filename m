Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7399C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826A121556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zdsfz/te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIJToc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbgIJPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:33:38 -0400
Received: from mail-oi1-x264.google.com (mail-oi1-x264.google.com [IPv6:2607:f8b0:4864:20::264])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C1DC061373
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:26:25 -0700 (PDT)
Received: by mail-oi1-x264.google.com with SMTP id d189so6246629oig.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fJHhgYEwWxBGPZV0ck5d43o8h1NDMA91jT0wBqCfnwY=;
        b=Zdsfz/texQfzXW2RGAHepIO+zcBnvTWRPvI9uTSQnnv62NJZBg2LJ6xmh15MhBIyrw
         v2XZbgrWLuNbsmf/JyNDTQY9RgOzmk6Cbd/1ypznE5opXiubVRfp31r9c36Og/nxYeMK
         GKaoaYgBHLRuJDDj4YQAG9m6P0os4YS4Trbzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fJHhgYEwWxBGPZV0ck5d43o8h1NDMA91jT0wBqCfnwY=;
        b=jSsUhs8eZcTfdmH1hpcjHw++9vizsDj1eFrtVi5PAANQmvmEDsqvPozGHwRGqz4MGm
         ujHyF0H7HSyIbW8/EXTL72Eg+HwMk54ghGEQjRKF0hIrtsJcNB5oJixFnT5eS0VF+VIe
         h7mhk4n8bk/zvkZC+mdG4kK6k3z3w0upkzfUyViVoNGl5RjLGIEvYIVb9r5rYWW3azlx
         alceeC7VEtUA8UZXYC4LjAqbKpzaZ8Q/FUahPrf29Pd3sPNUXi/geXGlKeDbjlpzLq5L
         91YFfl0Mb47Vxp4rv5WgAoiWSL6Xd4Gin4uhRNpqQ1mbtwBAee+rwjIHWfA3CKlNZgk9
         TGkw==
X-Gm-Message-State: AOAM5308iGSD0kAlLNZbtBFii4QRCF5ZJk34iS4KWfCLWLijkqQQU48Z
        ml0oEXqSWa/SjFD3Bhec4jLzqWs/tLWjhv3gmyIANmN2EQ1L
X-Google-Smtp-Source: ABdhPJyG0h05fMgSeA0kb5tHFjfFMkLwJoDKu0c8WIRTzJdH0BccQ194jKVgXJ9oEvffUNNs8qjWbXf25PZO
X-Received: by 2002:aca:d54d:: with SMTP id m74mr336105oig.3.1599751584954;
        Thu, 10 Sep 2020 08:26:24 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id h4sm943004oom.19.2020.09.10.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:26:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Ray Jui <ray.jui@broadcom.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 4/4] spi: bcm-qspi: Clean up 7425, 7429, and 7435 settings
Date:   Thu, 10 Sep 2020 08:25:39 -0700
Message-Id: <20200910152539.45584-4-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910152539.45584-1-ray.jui@broadcom.com>
References: <20200910152539.45584-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom QSPI driver now falls back to no MSPI_DEV support as the
default setting in the generic compatible string, explicit settings for
STB chips 7425, 7429, and 7435 can be removed.

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index b78d47a4403c..14c9d0133bce 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1281,18 +1281,6 @@ static const struct bcm_qspi_data bcm_qspi_spcr3_data = {
 };
 
 static const struct of_device_id bcm_qspi_of_match[] = {
-	{
-		.compatible = "brcm,spi-bcm7425-qspi",
-		.data = &bcm_qspi_no_rev_data,
-	},
-	{
-		.compatible = "brcm,spi-bcm7429-qspi",
-		.data = &bcm_qspi_no_rev_data,
-	},
-	{
-		.compatible = "brcm,spi-bcm7435-qspi",
-		.data = &bcm_qspi_no_rev_data,
-	},
 	{
 		.compatible = "brcm,spi-bcm7445-qspi",
 		.data = &bcm_qspi_rev_data,
-- 
2.17.1

