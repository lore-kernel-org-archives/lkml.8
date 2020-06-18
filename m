Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D4AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425E0206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HfoZ5lRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgFRPK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731398AbgFRPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:10:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF3DC0613EF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:10:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so3023208pgo.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVe6UCUtrVR7cafEV9bt9G1zk5uDkvg9No0xHEHinP8=;
        b=HfoZ5lRONe1F61xrxP9U4L/d9eEWRtxvGR1cJncfL/woxzmvANr4v7yU5w9uV+0w7P
         XcjIgNgXmghUX+eAEQaMHmAjrIUFdQM2LLEcvBGYYsI1BUw4VKM5Q0VLNRn6y7Vq7/9j
         CkxlFgDNBB8iW6/bhIasfNViYUjlV+/a8geOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVe6UCUtrVR7cafEV9bt9G1zk5uDkvg9No0xHEHinP8=;
        b=lv6GYWWxXua/zCLBWAY9qGaxvLDjq1CWOMVhRdZHcScfU/HfEL1XW8DcuwawkAXJj/
         RwZMygYgc4aUKmaN68yV3QSsVVMEinZs/+3wNFMtc/GEhI//5MP63BkiatA70AYSQ9c5
         Deqp0wyoW91qjLOEtE9lpjmIVvlXE19dLsvMW826kqF61ZDROJrxoE5R/iC8SfThs+B0
         0Q7leBehXmuuexSp9VfEeq618JB4TIaln3I+fy6VG3vXaDStd/aE4BNUPHJG2tKAWuxj
         tHvTU/otOjmgBlfLyfxTado6qWgrJ0FijXMHOZCdCssOQK2bQ9FHX3Se+tOEIvLrQbgH
         IShg==
X-Gm-Message-State: AOAM533HXOEyloLB7kDxT/NX0X1pQTC8G6ZynarDoAWYvyLzi+J4q+8Y
        5upCTDeGQfouMbLdlSVv0FZ7NQ==
X-Google-Smtp-Source: ABdhPJxeb3obYpA8AnWN2pNjegngMD5qnPGIspUqIiUGT3QjemzJUaNiSOGvh5KCaQsVt6QmO1Xtyw==
X-Received: by 2002:a62:3103:: with SMTP id x3mr3897100pfx.130.1592493052313;
        Thu, 18 Jun 2020 08:10:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b14sm3171510pft.23.2020.06.18.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:10:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        skakit@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 4/5] spi: spi-geni-qcom: Actually use our FIFO
Date:   Thu, 18 Jun 2020 08:06:25 -0700
Message-Id: <20200618080459.v4.4.I988281f7c6ee0ed00325559bfce7539f403da69e@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The geni hardware has a FIFO that can hold up to 64 bytes (it has 16
entries that can hold 4 bytes each), at least on the two SoCs I tested
(sdm845 and sc7180).  We configured our RX Watermark to 0, which
basically meant we got an interrupt as soon as the first 4 bytes
showed up in the FIFO.  Tracing the IRQ handler showed that we often
only read 4 or 8 bytes per IRQ handler.

I tried setting the RX Watermark to "fifo size - 2" but that just got
me a bunch of overrun errors reported.  Setting it to "fifo size - 3"
seemed to work great, though.  This made me worried that we'd start
getting overruns if we had long interrupt latency, but that doesn't
appear to be the case and delays inserted in the IRQ handler while
using "fifo size - 3" didn't cause any errors.  Presumably there is
some interaction with the poorly-documented RFR (ready for receive)
level means that "fifo size - 3" is the max.  We are the SPI master,
so it makes sense that there would be no problems with overruns, the
master should just stop clocking.

Despite "fifo size - 3" working, I chose "fifo size / 2" (8 entries =
32 bytes) which gives us a little extra time to get to the interrupt
handler and should reduce dead time on the SPI wires.  With this
setting, I often saw the IRQ handler handle 40 bytes but sometimes up
to 56 if we had bad interrupt latency.

Testing by running "flashrom -p ec -r" on a Chromebook saw interrupts
from the SPI driver cut roughly in half.  Time was roughly the same.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Technically this is an improvement, not a fix.  ...but it should be
such a decrease in interrupts that I've tagged it as a Fix nonetheless
as per suggestion during review.

Changes in v4: None
Changes in v3:
- ("spi: spi-geni-qcom: Actually use our FIFO") new in v3.

Changes in v2: None

 drivers/spi/spi-geni-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 11f36d237c77..5b8ca8b93b06 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -285,7 +285,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	 * Hardware programming guide suggests to configure
 	 * RX FIFO RFR level to fifo_depth-2.
 	 */
-	geni_se_init(se, 0x0, mas->tx_fifo_depth - 2);
+	geni_se_init(se, mas->tx_fifo_depth / 2, mas->tx_fifo_depth - 2);
 	/* Transmit an entire FIFO worth of data per IRQ */
 	mas->tx_wm = 1;
 	ver = geni_se_get_qup_hw_version(se);
-- 
2.27.0.290.gba653c62da-goog

