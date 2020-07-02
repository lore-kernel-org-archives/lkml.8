Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45BCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE79207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKIHQJeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgGBApr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgGBApe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:45:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE86C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 17:45:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so8576754pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 17:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkGcjxRkJ6dCPuaybiPstZAyKU85uMADDKqqgUxYero=;
        b=AKIHQJeQnAOPNI2gGQrvqd9S3Y7bK1oz1xUxjXASgco2p5Jnkbd+JOewpSZ4lCXVg4
         onxJ3xvwbcwmLysRT7TDcyysWiMh4Ozitkz6tPoOlIS40R2T00KA+cqLdghcXBdL8FnW
         jveDSJpqRdDLw9TAHu5CGsM5eclZzjtUsdpOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkGcjxRkJ6dCPuaybiPstZAyKU85uMADDKqqgUxYero=;
        b=GnouTTV7znOAL381qSCIny8xkIqSB8FWyrXATANucH6iUGoXhGfvyWWBJTsvFc6Bky
         h54XWo5c0w/m2GaRYZ+lETZEMiRxxSfu8kV1Lk2Ju2RzrK+n7omKI7NUuM9yolvXi5wq
         D5TdTdQKzjnKgVz4Y5qDbA393DSm78bXdFjODEpU/qS3BXRpRE76U4ioyVQ6y0/bvne+
         awq6fP1/Odqu+ykM2bdu0i9/mQpI2nDNTZs3HyP1d02YszC+B7nt2pFnq2lqs+33icfl
         I1S2y/4ERraq4WRMFfA9gkuJxsmwzO/9UtdrLH6EqOKaGnXoiqhxcmtiBH3c3LT9GDbb
         j7iQ==
X-Gm-Message-State: AOAM531bh4fxLojF8Ao9Gw7tlgfsAii9QroSfjcHapsacbYq4CcJo5uA
        NPDKLWhdeBdMEZv+xamiM79mWw==
X-Google-Smtp-Source: ABdhPJxlhWIfAqHpE6aUGK+1UfUbqkZMAkfT4oF9/Vd/2Zzi+2KGX6ovV/CJ4W2f0mhqUZMvNbVxlA==
X-Received: by 2002:a17:902:b216:: with SMTP id t22mr23734470plr.181.1593650733748;
        Wed, 01 Jul 2020 17:45:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id w4sm6966212pfd.39.2020.07.01.17.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 17:45:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     akashast@codeaurora.org, linux-arm-msm@vger.kernel.org,
        mkshah@codeaurora.org, swboyd@chromium.org,
        georgi.djakov@linaro.org, ctheegal@codeaurora.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
Date:   Wed,  1 Jul 2020 17:45:07 -0700
Message-Id: <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200702004509.2333554-1-dianders@chromium.org>
References: <20200702004509.2333554-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every SPI transfer could have a different clock rate.  The
spi-geni-qcom controller code to deal with this was never very well
optimized and has always had a lot of code plus some calls into the
clk framework which, at the very least, would grab a mutex.  However,
until recently, the overhead wasn't _too_ much.  That changed with
commit 0e3b8a81f5df ("spi: spi-geni-qcom: Add interconnect support")
we're now calling geni_icc_set_bw(), which leads to a bunch of math
plus:
  geni_icc_set_bw()
    icc_set_bw()
      apply_constraints()
        qcom_icc_set()
          qcom_icc_bcm_voter_commit()
            rpmh_invalidate()
            rpmh_write_batch()
...and those rpmh commands can be a bit beefy if you call them too
often.

We already know what speed we were running at before, so if we see
that nothing has changed let's avoid the whole pile of code.

On my hardware, this made spi_geni_prepare_message() drop down from
~145 us down to ~14 us.

NOTE: Potentially it might also make sense to add some code into the
interconnect framework to avoid executing so much code when bandwidth
isn't changing, but even if we did that we still want to short circuit
here to save the extra math / clock calls.

Fixes: 0e3b8a81f5df ("spi: spi-geni-qcom: Add interconnect support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index e01c782ef7d0..bb4cdda2dec8 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -201,6 +201,9 @@ static int geni_spi_set_clock_and_bw(struct spi_geni_master *mas,
 	struct geni_se *se = &mas->se;
 	int ret;
 
+	if (clk_hz == mas->cur_speed_hz)
+		return 0;
+
 	ret = get_spi_clk_cfg(clk_hz, mas, &idx, &div);
 	if (ret) {
 		dev_err(mas->dev, "Err setting clk to %lu: %d\n", clk_hz, ret);
@@ -339,11 +342,9 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	}
 
 	/* Speed and bits per word can be overridden per transfer */
-	if (xfer->speed_hz != mas->cur_speed_hz) {
-		ret = geni_spi_set_clock_and_bw(mas, xfer->speed_hz);
-		if (ret)
-			return;
-	}
+	ret = geni_spi_set_clock_and_bw(mas, xfer->speed_hz);
+	if (ret)
+		return;
 
 	mas->tx_rem_bytes = 0;
 	mas->rx_rem_bytes = 0;
-- 
2.27.0.383.g050319c2ae-goog

