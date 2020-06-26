Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBAFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FC62088E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y3vJvMHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgFZWUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgFZWUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:20:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F8C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:20:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so5559933pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVcpaUniYerIlCyx1vTQeFNCOepnPAPlvIx24HtK4yw=;
        b=Y3vJvMHtv5KZ2rxBZK3vacMhwJm2BUw4M6OpjYw7DFuo+buW2y6YZOxS9VLsWsK3Br
         spHitLO/QOTPyHk30J3sevum2LgoiFO60eyouWi/LhOQ7fVk+Fmdte6Us2I3UjXnXnic
         I2tKu6dMKjjZYxO2a9POgMdGv+hK+y3glrgMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVcpaUniYerIlCyx1vTQeFNCOepnPAPlvIx24HtK4yw=;
        b=atm3jRXP4izIM8VZcUrI3PBvQBdVViopkgF9TSEkWbiN6nh0ggBvYUXO+KyWkEoSJJ
         KRLlq/aycEd7nzrHC82yhO2mPnscca5RalyRVTEaIzU6x/bbHR5PHnA5MiuKeuPL+jdy
         nv70N9+SphRR8YZsWvSCM+BUTm5HcMfRjx+tRA7jjdkmd0qlRRpeg7025Ym3CGlyNfYs
         uMyAmSd/VF+FkhbJD0Jx0ZpJ6MJRRGcAMpMfvR6AzPMqFAYKsCPG06bCBHCkuqF7HdIB
         FJ1gEEF6RM9ivTcFuEuztnGq3KWEjM1y00i2NNS2/54G2LT3jC60cs/jXlbgGn8aKNBU
         lilQ==
X-Gm-Message-State: AOAM533OD25cWzSIyQnNGKnm18FyrtyV0STNYDLr2H2OkOxvXCEuQgrm
        BkByUViY0G9Y2xlygkJt/uFhWw==
X-Google-Smtp-Source: ABdhPJwJjzabhmueOPoNL5/wqZZOUQ+pyL+hA+NLvUlCg08OPdl1PBt92nCnlkxyWWtqpBO1KOiGhA==
X-Received: by 2002:a63:778c:: with SMTP id s134mr767729pgc.273.1593210021506;
        Fri, 26 Jun 2020 15:20:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id h9sm9001635pfk.155.2020.06.26.15.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:20:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        Dilip Kota <dkota@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-geni-qcom: Don't set the cs if it was already right
Date:   Fri, 26 Jun 2020 15:19:50 -0700
Message-Id: <20200626151946.1.I06134fd669bf91fd387dc6ecfe21d44c202bd412@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the chip select on the Qualcomm geni SPI controller isn't
exactly cheap.  Let's cache the current setting and avoid setting the
chip select if it's already right.

Using "flashrom" to read or write the EC firmware on a Chromebook
shows roughly a 25% reduction in interrupts and a 15% speedup.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5b1dca1fff79..e99a9d57449f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -79,6 +79,7 @@ struct spi_geni_master {
 	unsigned int oversampling;
 	spinlock_t lock;
 	int irq;
+	bool cs_flag;
 };
 
 static int get_spi_clk_cfg(unsigned int speed_hz,
@@ -146,10 +147,15 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	struct geni_se *se = &mas->se;
 	unsigned long time_left;
 
-	pm_runtime_get_sync(mas->dev);
 	if (!(slv->mode & SPI_CS_HIGH))
 		set_flag = !set_flag;
 
+	if (set_flag == mas->cs_flag)
+		return;
+
+	mas->cs_flag = set_flag;
+
+	pm_runtime_get_sync(mas->dev);
 	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->cs_done);
 	if (set_flag)
-- 
2.27.0.212.ge8ba1cc988-goog

