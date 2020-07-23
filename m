Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4371CC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245C722B40
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUdXAo34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgGWP1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D04C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so6726935wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcr8FiQcF4dcjc+1sT9fDo6gYVNY2HcPFMXM5v83NF4=;
        b=fUdXAo34sJI9Nocd1bdBlfYHHPYfMTox6oVwVJiBjL6FoYVn6+p/mCZ3LyKIodqTf9
         uCaOe21npf+1dWHx/wNkJiAR+cyXU0R1hhdpC4r7Lviv+GaibqIav+EGNBIgnmT/ETpy
         7DmAfGB84zaOoErEI9zavQTrGl4FKkac4oV+qdofgXuVNcMKtrOWPyL+ZTbkNgmT71sb
         9zgb4HRiGFbBnqjr8q8bB86ZQce37gtpT5u6Zp9y/j1mYGukdhnujbHZBTABvjTJ97tp
         9NPFY9DZ5SQtx6EPlDNfH+Lw8ZZ4jMPROnUccZ5uJxuvJ4CE44EhEj5DQNpTseI1J7JR
         ZpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcr8FiQcF4dcjc+1sT9fDo6gYVNY2HcPFMXM5v83NF4=;
        b=VxMYh/de2d2Pzduc9keFT5LLMGjV4weg0vIZUl0Q2D8I/rNXB20HgsGE1tsE2KcZqs
         v5X+rBzQHT6wAzGTo/fnC2Ab9ZOSZj940/rID/r3r5ap+wVkXCEkL2kAMXFfXyp7QnaV
         iV9AqvjEWX6tYhGX8jP/pRrKhNrl0yNLDx+eEF0xBtij+ui0tpFx5//8PfJmr3zdsWi1
         CLQpvU/mkQSh0n4AznU8OCVwzmJiJiXilCwpzXIKNMJH+EUrE4VJCukFxzxrbmYiCyPA
         5IMpMAsB+Kfh1NwbafsIGMXxdVMzlIh74zyZOdOtx5Fd08f7bw0oPOqJQNjH5145f3Pn
         ckgA==
X-Gm-Message-State: AOAM530S2cQAqJn0eb4XXBWLkJSoWWKtG6fXo0iLMu1aSMDybAOCDPAw
        iz/3VwEx1uuQnEaREXJvxpB6+Q==
X-Google-Smtp-Source: ABdhPJwDhCN3AoJJvUyS+OvPDjrPC0R/KjZhd8zi2hvwwI6iTAJHUgFySZUsPoM6/EqmPNx/Y/jfig==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr4538366wmc.2.1595518018374;
        Thu, 23 Jul 2020 08:26:58 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:26:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/16] ARM: at91: add atmel tcb capabilities
Date:   Thu, 23 Jul 2020 17:26:24 +0200
Message-Id: <20200723152639.639771-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Some atmel socs have extra tcb capabilities that allow using a generic
clock source or enabling a quadrature decoder.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-5-alexandre.belloni@bootlin.com
---
 include/soc/at91/atmel_tcb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index c3c7200ce151..1d7071dc0bca 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -36,9 +36,14 @@ struct clk;
 /**
  * struct atmel_tcb_config - SoC data for a Timer/Counter Block
  * @counter_width: size in bits of a timer counter register
+ * @has_gclk: boolean indicating if a timer counter has a generic clock
+ * @has_qdec: boolean indicating if a timer counter has a quadrature
+ * decoder.
  */
 struct atmel_tcb_config {
 	size_t	counter_width;
+	bool    has_gclk;
+	bool    has_qdec;
 };
 
 /**
-- 
2.25.1

