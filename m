Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BE4C4345B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A7720704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upRwI5gM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGQQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgGQQ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE141C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so11905803wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnBtmSOMI3qCFo9FmJWl9WfxHjSJK5KQqVLRraKU05I=;
        b=upRwI5gMeGvdCbgPj9Hbz2zOy3eA+/cM1dWqW4XaF8zVm1a/FK+TCaV2C0+85l3dlo
         Xhhscxuy1lIt4yUbirxN3IkC3t/t1umvWhZkXmccs6CG5EHwXYsQGPurvMgCK+ZNpF80
         Ggmfa+5tbctui2lwO4pl42VaoSS7xt6YaY4jQAtlAzBemaUl3t4znnhATvkfFEvPWc1v
         Z6Tkx/Q4qD56HI9w8YKnZoJwIVhYKKkjPiFCgJZdvsYuS5WnyM0pCP/4yVkew1pUHA8p
         Sl7kfF2E0kkyBw8Lr6gDxebP4MvXkkRTzPPJUu145D1vAWp22creWVT6dvf50LY296bo
         LQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnBtmSOMI3qCFo9FmJWl9WfxHjSJK5KQqVLRraKU05I=;
        b=s7ewYX7jsmbqYdii7obYqUX0MMhNDJ7RbAthKcQ/cnasY1L7i6cVRfLjibE4UqD0Il
         MRRTg1PpsipHTTFMd/UhSDsqO9RR+NGehTnQdzHB4DoLYQQv4tgQ93z+JwlPNlNazhpz
         8F0QkTurS6/UNvCKJQGzegN07NJkuobJhqk6tHtVyQ98NYDO2fjAVLO0Fjk9BG9Y5Dom
         zkKHj1UAsqmN3m4IuEE7jjWS1o4h5tvYt4TajmycpkbD7XIf06fPKX/2sUk0X9AoYC36
         lPE3BsZisy/Z8ZJVmTkMgmgBAuLr15DrMWTMsP7Jh0U8nsKRQDLqTAp8Y7RRIKkC2PPm
         VOeQ==
X-Gm-Message-State: AOAM530VMlJN6jsPIEf97twfZ46w1yk7VkWPkMYQ/vcRIDhMvA1QZvZh
        MUGbT8HGsrO1Nai08pER7r2+8Q==
X-Google-Smtp-Source: ABdhPJw78hm6xyry1788msKvDaJiA9KH6AqlvKTZo56vyvYluhOxS8hz+N6ckrFwd9dGFHPH4WvFyw==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr12017980wrm.71.1595004963587;
        Fri, 17 Jul 2020 09:56:03 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nishant Kamat <nskamat@ti.com>, Balaji T K <balajitk@ti.com>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Girish S Ghongdemath <girishsg@ti.com>,
        Ambresh K <ambresh@ti.com>,
        Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>,
        Mikko Ylinen <mikko.k.ylinen@nokia.com>
Subject: [PATCH 05/30] iio: adc: twl6030-gpadc: Fix some misdocumentation and formatting issues
Date:   Fri, 17 Jul 2020 17:55:13 +0100
Message-Id: <20200717165538.3275050-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/twl6030-gpadc.c:110: warning: Function parameter or member 'ideal' not described in 'twl6030_gpadc_platform_data'
 drivers/iio/adc/twl6030-gpadc.c:110: warning: Function parameter or member 'channel_to_reg' not described in 'twl6030_gpadc_platform_data'

Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Nishant Kamat <nskamat@ti.com>
Cc: Balaji T K <balajitk@ti.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Girish S Ghongdemath <girishsg@ti.com>
Cc: Ambresh K <ambresh@ti.com>
Cc: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/twl6030-gpadc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index f24148bd15de4..a19a6ce65e390 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -94,9 +94,9 @@ struct twl6030_gpadc_data;
  * struct twl6030_gpadc_platform_data - platform specific data
  * @nchannels:		number of GPADC channels
  * @iio_channels:	iio channels
- * @twl6030_ideal:	pointer to calibration parameters
+ * @ideal:		pointer to calibration parameters
  * @start_conversion:	pointer to ADC start conversion function
- * @channel_to_reg	pointer to ADC function to convert channel to
+ * @channel_to_reg:	pointer to ADC function to convert channel to
  *			register address for reading conversion result
  * @calibrate:		pointer to calibration function
  */
-- 
2.25.1

