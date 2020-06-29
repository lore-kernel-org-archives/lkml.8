Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBB3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508092078A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JP+KeEw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgF2XnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgF2XnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:43:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06653C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:43:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so9041949pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QciK5tXPc0ig4ewp8mAOTjfJLOJkGR17cLI3UFIq7P4=;
        b=JP+KeEw5Ge2u0AgRunHG6CylzE+cjwR7RMtG2QLQWVY0SIR3gmC+cjStYNxrDVrF0T
         cWYhp3nhvP0oIs8lc57KPy6JBKX03zycDRKQa4/w1+HqdRKKW1wBReQJuZaLVWtpYpWY
         zztg+w4Z21un2gOixaBjAOXx1LE6O+uO7LIIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QciK5tXPc0ig4ewp8mAOTjfJLOJkGR17cLI3UFIq7P4=;
        b=ueJAuoDguJkAvZ6JyBN6uptEaE5cX2TqJ7rCC0yxh3AetqHUp97kVdKMeXRWnNCHRd
         TU1iC3rTCO9+RSc3OV95PlXMtsoDtvNyF0n8a0YKmNcMyOF5Nk82HIQ0JqcZLsIaAIH0
         NuPwPbsJYzXgu+nw6LUykbb3DS3IKzUhK5B0SfEz0QI1SfKO0MWvzYl7eRX90nXuU0vG
         Er8zvLog1w/LfgHP5S12mkVad3F0MloMnvTdueEbQTXXhBy55aZOc+Bj84I0eMAl5auh
         MTvDX+/6bsLiXHQTSo3QqQ5f/1027xnYi59wXWmp27RmoMjXjq78SObDLHfagmaFO2es
         cafQ==
X-Gm-Message-State: AOAM531lvF0mNrA2oikle3iJ6RU8rsxZ348ezWFmLqMOauulYPCEEGzz
        g2wTmCI4k6OORW+Mrid0Hcz8bA==
X-Google-Smtp-Source: ABdhPJyI8g97mTqP8wUF/YUNfuHe3OhvjyzPpoxFXcVqURHplY/uOe+v6Yiqilg3jnWEFhYr70yfWQ==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr7635504pfl.2.1593474199348;
        Mon, 29 Jun 2020 16:43:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s30sm753535pgn.34.2020.06.29.16.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:43:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: Avoid setting the chip select if we don't need to
Date:   Mon, 29 Jun 2020 16:41:06 -0700
Message-Id: <20200629164103.1.Ied8e8ad8bbb2df7f947e3bc5ea1c315e041785a2@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SPI controllers (like spi-geni-qcom) setting the chip select
is a heavy operation.  For instance on spi-geni-qcom, with the current
code, is was measured as taking upwards of 20 us.  Even on SPI
controllers that aren't as heavy, setting the chip select is at least
something like a MMIO operation over some peripheral bus which isn't
as fast as a RAM access.

While it would be good to find ways to mitigate problems like this in
the drivers for those SPI controllers, it can also be noted that the
SPI framework could also help out.  Specifically, in some situations,
we can see the SPI framework calling the driver's set_cs() with the
same parameter several times in a row.  This is specifically observed
when looking at the way the Chrome OS EC SPI driver (cros_ec_spi)
works but other drivers likely trip it to some extent.

Let's solve this by caching the chip select state in the core and only
calling into the controller if there was a change.  We check not only
the "enable" state but also the chip select mode (active high or
active low) since controllers may care about both the mode and the
enable flag in their callback.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi.c       | 11 +++++++++++
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6fa56590bba2..d4ba723a30da 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -778,6 +778,17 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 {
 	bool enable1 = enable;
 
+	/*
+	 * Avoid calling into the driver (or doing delays) if the chip select
+	 * isn't actually changing from the last time this was called.
+	 */
+	if ((spi->controller->last_cs_enable == enable) &&
+	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
+		return;
+
+	spi->controller->last_cs_enable = enable;
+	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
+
 	if (!spi->controller->set_cs_timing) {
 		if (enable1)
 			spi_delay_exec(&spi->controller->cs_setup, NULL);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index b4917df79637..0e67a9a3a1d3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -368,6 +368,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @cur_msg_prepared: spi_prepare_message was called for the currently
  *                    in-flight message
  * @cur_msg_mapped: message has been mapped for DMA
+ * @last_cs_enable: was enable true on the last call to set_cs.
+ * @last_cs_mode_high: was (mode & SPI_CS_HIGH) true on the last call to set_cs.
  * @xfer_completion: used by core transfer_one_message()
  * @busy: message pump is busy
  * @running: message pump is running
@@ -604,6 +606,8 @@ struct spi_controller {
 	bool				auto_runtime_pm;
 	bool                            cur_msg_prepared;
 	bool				cur_msg_mapped;
+	bool				last_cs_enable;
+	bool				last_cs_mode_high;
 	bool                            fallback;
 	struct completion               xfer_completion;
 	size_t				max_dma_len;
-- 
2.27.0.212.ge8ba1cc988-goog

