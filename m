Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C1C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF352088E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIgBjCAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgGPN7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgGPN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66609C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so7173187wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orBUHy/BGmffZA4LA+ipGScBGUJn7fYfkbVAM8m+aww=;
        b=lIgBjCArdEpGcSjo1Rtyqs2OSMZAreCnZeJRzKDgcP3CvY/5Xd0NYDupYFjKFwfWM5
         8NTez5a0+GP2x5yjemlpLB+aTTjQ8S/dqgLBGoRHH1TirXWad94K54nYcZY5/E/HogpY
         Pa0szhtyvxV7eswEIeRtZGLcXBcTnM8d098PbdOkekwkzEqrrpOPEjcBBsk9PQdq8x7l
         vN7XrcDk9k5slv9pZz8JLLhKPWH5mgn37I/ifQZjH20DkFWId3KtsmI853Spb2u3OD/8
         XZthh5TsJnei/DNdFfuLF9sII/FWEpg4Ddo+zhujsBMvEcNZa1ReZeoKjd8zy3mQP0kk
         KhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orBUHy/BGmffZA4LA+ipGScBGUJn7fYfkbVAM8m+aww=;
        b=Eiv19cjUfgMIFHivKxSRf7oC5aMl7513BOQ6HsPsHjR8qtRfZHeGLWt7xLqtNJWCtN
         5huIUhnMzovfWK0T4+pYxSXBwYGSJVS8z/AZ4Qto+SPYFYPPt42WZa2d3pn8wzrrIZhC
         akpXU0BP3fNeGbhqNdIwWdetHwG++2jBg6KjQgUUc4BnQgJ6DjNpsFXkZUNTG4s2c/2H
         fb/hCGAKnZycOL/NY5q3feX+6bJwiV9xJPiDJYduwA14wwWMhwO4fl7uE0QyjpYVM+ps
         lpu4iaNQV9Riq7Bbt8ZPYm35nhS5/HTgVaFevI1/VHWGSHmtR1TA3Mb8yj21NaW7mL5m
         qJag==
X-Gm-Message-State: AOAM532NT7UjxA9tpcy9VqBRHy8pH/l09Vzwsbm/5mkA9/xJXohJpwgB
        uVhddu9RJmCCNgZ2Klx7muSXOw==
X-Google-Smtp-Source: ABdhPJy1JSTu3kbsgYP/loEirhUW8pkWOd//jLIarF1XbEoVeVUlgCgFHlYhgElHekzZ+SrfxtpWig==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr5162237wrw.244.1594907973157;
        Thu, 16 Jul 2020 06:59:33 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 01/30] iio: adc: ad_sigma_delta: Remove unused variable 'ret'
Date:   Thu, 16 Jul 2020 14:58:59 +0100
Message-Id: <20200716135928.1456727-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad_sigma_delta.c: In function ‘ad_sd_trigger_handler’:
 drivers/iio/adc/ad_sigma_delta.c:405:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 405 | int ret;
 | ^~~

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad_sigma_delta.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index dd3d54b3bc8bb..f269b926440da 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -402,7 +402,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	unsigned int reg_size;
 	unsigned int data_reg;
 	uint8_t data[16];
-	int ret;
 
 	memset(data, 0x00, 16);
 
@@ -419,14 +418,12 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	case 4:
 	case 2:
 	case 1:
-		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
-			&data[0]);
+		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[0]);
 		break;
 	case 3:
 		/* We store 24 bit samples in a 32 bit word. Keep the upper
 		 * byte set to zero. */
-		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
-			&data[1]);
+		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[1]);
 		break;
 	}
 
-- 
2.25.1

