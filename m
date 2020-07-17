Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4840C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A5320704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGtCMRlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGQQ4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgGQQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDE2C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so15958830wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7pd6ShoPrm0jZpbjskrRfnA1hCGWtl3SFnepd2S/QNM=;
        b=VGtCMRlRyKO1bci+KeMExFH/2APwqhMYP6S3B9+EOf6gpg1qNARu0VHR3LvT61Neyg
         nm3rd+el8yz8XmTP2+zYHKNdshyA6ue/Nj/FWIZzGGJX8oqDJOz+Ct5Ou1DzYG54qFDH
         V3B7uywTdM+fb7kdwwIBORo/PJ0J8/kF+HGGc4mzFysjY89jf0bkZPJrq+15EKzqE7Yw
         LmZadfjDmnuJ4YH7zpONh4thewCq9vVBYbQ7vvaAJN/1cPTt5xt+0JbtOkStyaj3FdAG
         Y0yTXp9azBD9EZhNwWD5+SxbEosCZnQPQm0L27uCb61jiO13Y9ZD9xrZFWxUU1MyYrkU
         8PSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7pd6ShoPrm0jZpbjskrRfnA1hCGWtl3SFnepd2S/QNM=;
        b=bBhp3F5n07IkBIxioVaBHkWZyO82Cx3x2kVThyy4Li+3a/uik5GmCzDLh25+ShfQS/
         GJLPvF52j+bCSsxkrAdbq5DppR5j9UkAMEETHzSMnK6/1nJTmNKEqrsiXSEtwDeLlzPC
         r57tv1uQyleXYkDhVijCnPsp8MEIdDqXXaO0cNPY6KjpL9yDdAxDOhP6IjVF1gbU8imG
         JXxc1UXYHiVvuQwJXaBDPvPs1gO0ZE4ZdW2W1+XNBjRp2rPu+TUWwamC7jJ8yoZd/Tbj
         7HRCY9AV2so5PVAIekt5stJCpdIKquCTaG9pKw+Z6JNBQ2zm2dj3nptWtjXAHKVAWQ5F
         Dkwg==
X-Gm-Message-State: AOAM530T9lRy9onEriyyks3yfnLh+bjzBP2WZRKKS9caZ2BOSTS/jxRT
        9o/4IONzQbkriYqTpUBFXTxlmA==
X-Google-Smtp-Source: ABdhPJzMIXHm3ytdzPTg/jzS+f+DoP3PtJaIUny4rj64gipaY/71JD/hoOkN+ChIiten42HePer0ZA==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr9952267wma.24.1595004960384;
        Fri, 17 Jul 2020 09:56:00 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:55:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        J Keerthy <j-keerthy@ti.com>,
        Mikko Ylinen <mikko.k.ylinen@nokia.com>,
        Amit Kucheria <amit.kucheria@canonical.com>
Subject: [PATCH 02/30] iio: adc: twl4030-madc: Remove set but unused variables 'len'
Date:   Fri, 17 Jul 2020 17:55:10 +0100
Message-Id: <20200717165538.3275050-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/twl4030-madc.c: In function ‘twl4030_madc_threaded_irq_handler’:
 drivers/iio/adc/twl4030-madc.c:475:9: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
 475 | int i, len, ret;
 | ^~~

Cc: Sebastian Reichel <sre@kernel.org>
Cc: J Keerthy <j-keerthy@ti.com>
Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Cc: Amit Kucheria <amit.kucheria@canonical.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/twl4030-madc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 472b08f37feae..826d8295e9b3c 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -472,7 +472,7 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
 	struct twl4030_madc_data *madc = _madc;
 	const struct twl4030_madc_conversion_method *method;
 	u8 isr_val, imr_val;
-	int i, len, ret;
+	int i, ret;
 	struct twl4030_madc_request *r;
 
 	mutex_lock(&madc->lock);
@@ -504,8 +504,8 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
 			continue;
 		method = &twl4030_conversion_methods[r->method];
 		/* Read results */
-		len = twl4030_madc_read_channels(madc, method->rbase,
-						 r->channels, r->rbuf, r->raw);
+		twl4030_madc_read_channels(madc, method->rbase,
+					   r->channels, r->rbuf, r->raw);
 		/* Free request */
 		r->result_pending = false;
 		r->active = false;
@@ -525,8 +525,8 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
 			continue;
 		method = &twl4030_conversion_methods[r->method];
 		/* Read results */
-		len = twl4030_madc_read_channels(madc, method->rbase,
-						 r->channels, r->rbuf, r->raw);
+		twl4030_madc_read_channels(madc, method->rbase,
+					   r->channels, r->rbuf, r->raw);
 		/* Free request */
 		r->result_pending = false;
 		r->active = false;
-- 
2.25.1

