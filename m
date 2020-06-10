Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0365C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F5020734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DTECFQ0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgFJIaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgFJIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:30:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E33C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:30:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so1214657wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ig0Wg2PIvyajjV/Y8eTgJWpGeC/XcG4G3xO3aXfG82k=;
        b=DTECFQ0bjRfKJQiLq6V7fYnNYoGstQHaivOezI/tvE4vNkfVsM5E+kOKCoYZrkWQ8E
         07GF1OJ5g89l8Y6gsIetG5pftx0NdqTjpqPtKZKz/6k2dNaBn0Z2SZK7FL8znkkPohpW
         HS4BhLMugMY/q8R5tJQpq/MO5S9ZvJufVJS7ly/CpFL8AcdC+V1rLVnb2QYsa9abzIq/
         /pkQXuimNoTYoAIT9Am96pH2sY5EGmV8T+apfWzqDUUqtOuPKCoL8mz5V4Bj00tV3YWn
         euzCn5ZW9BftwIV05sEavFlk+ntT59KS5ZrP/UDs3u+URzOGKPukGgvjcQyNePbfNKO/
         pM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ig0Wg2PIvyajjV/Y8eTgJWpGeC/XcG4G3xO3aXfG82k=;
        b=at5Tc5tm5MuLltB+LzIM05ihlhD5GQy3O0ysGRpPxnVG71TvZJWykXe1LvKMzIGsaO
         21/nLOe8KDw1vFLuGMNutEwjYatxtT4brgWnghprp1b7Aadlojzza82j6FCbpZpM6bQ5
         2fU261XWEE2nBgJSGNb/ncmgbf2fYR5KMrbPFDQqnvQc0upa1jOvI2jr672Nwy+lXWoW
         BI5dEX9PXuf05XFI1hEiwUpfgUF7/Vxa0Lqjw9pasLwsY0LDJK3m85iuo+kmLH74aCq2
         YwoHl+xecZtJhW/9tyujjGsWyilEPH8lIkWofSItd2g4O97QevzzttER4hp39vhIGNHB
         6fBA==
X-Gm-Message-State: AOAM532kppHU4f7DJw4/IXdFGrZAOojp56+S70jI/jB/CcK6i1tpl4lw
        FgrGhcb5imsPAfnkzsXKeHveCg==
X-Google-Smtp-Source: ABdhPJxEeONnboKWlWlksQ0crqvdegr2mYAnJsEUGnJkTWBViWL1BgmpvfotRC7sgx0kvGovhCXAgA==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr2261311wrm.75.1591777817239;
        Wed, 10 Jun 2020 01:30:17 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id u13sm6958974wrp.53.2020.06.10.01.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 01:30:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: clk: g12a-clkc: Add NNA CLK Source clock IDs
Date:   Wed, 10 Jun 2020 10:30:11 +0200
Message-Id: <20200610083012.5024-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200610083012.5024-1-narmstrong@baylibre.com>
References: <20200610083012.5024-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Shmidt <dimitrysh@google.com>

This adds the Neural Network Accelerator IP source clocks.

Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/clock/g12a-clkc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index b0d65d73db96..40d49940d8a8 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -145,5 +145,7 @@
 #define CLKID_CPU3_CLK				255
 #define CLKID_SPICC0_SCLK			258
 #define CLKID_SPICC1_SCLK			261
+#define CLKID_NNA_AXI_CLK			264
+#define CLKID_NNA_CORE_CLK			267
 
 #endif /* __G12A_CLKC_H */
-- 
2.22.0

