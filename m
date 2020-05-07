Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC42C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93B020870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7Tp4AxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgEGVrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgEGVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:47:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF2C05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:47:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so8208675wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07JG3t9XSdzjKBR3gO/dh2PoEqEi6IleGfYwBJiTgFU=;
        b=f7Tp4AxMK79ePHJ5Z6v06RicBBOBeNIBdaFoBBJLf8ilErbSMR8eZzQDGVWYP0iVHJ
         gR9zdkINJcohMBhl+dTul5A/1LZttPrk1WRa1Yn/wa0BY6R7ELGPvLh7J6k6mQxzDdSK
         Y/dtaIODiwsQshKeMQvQGsqxprJ/frari2oF5oHE57Pnw1lSQiRkERuX6O6L1IC0IU4r
         n5OXEqU7U3+14mmRGHnFWOqJDezDSOn3RnpIS5ydRWlSXW+b0X5H81frZg4KlSKWLvnM
         kWR64ON2V3+Q2DjeXYZGU+hzhv4t9kUj+inxrnRhiU0gfJfn/2/o23pyr5L38UIdrYjS
         QoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07JG3t9XSdzjKBR3gO/dh2PoEqEi6IleGfYwBJiTgFU=;
        b=JBlNmzo5rRRHy54S32siaVhfAbg/bAUbACkgMgafPr5NgrXL98CRlCgclYVkcQLcjl
         LQi4syUXHn2irLJYSPp/AyQAd8MhQKUU5Y+n3rAlKdolqPkYPHH6QE5OKbi9JieHK7ek
         9KZBszMWWtWCQ6oVbYsTJ0f6psh+xTSDOkZ4BYg4h4KAso0TMgku4mtNQwOw3+hBFNmV
         JPLNpMWJKyADacSeTmdJFs8//TlTQDtMec3Qp4qZazxlYpHK+khP6YF7P8CNbGGkOI6j
         aSf4GJHBUhR76Lv1famPJq3u7oPZBFc+VTWnHBZ+Y4e8u8D7JAPnb6kCMG6Ys0UicLfY
         ClFA==
X-Gm-Message-State: AGi0PubITBvsKFjmYdM/wx0GxMhNQYR4akDccVM9fdOYxOVKPhIV8ZoL
        P0R8jvoMxQxP/tVwvpDTvVzZDQ==
X-Google-Smtp-Source: APiQypK6dmdVOC6KqerH4joEtEzkdVJC5ZPdIsR+x0zWFJpChiO0B7EbtAgdvelkt7pUUsSVMUu4cA==
X-Received: by 2002:adf:b1c9:: with SMTP id r9mr19373343wra.271.1588888021879;
        Thu, 07 May 2020 14:47:01 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a10sm6653538wrp.0.2020.05.07.14.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:47:00 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 2/2] usb: typec: tps6598x: Add OF probe binding
Date:   Thu,  7 May 2020 22:47:33 +0100
Message-Id: <20200507214733.1982696-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200507214733.1982696-1-bryan.odonoghue@linaro.org>
References: <20200507214733.1982696-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a MODULE_DEVICE_TABLE() to allow probing of this driver from a DTS
setting.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gustavo A. R. Silva <garsilva@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/typec/tps6598x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index 0698addd1185..defa651282b0 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -563,6 +563,12 @@ static int tps6598x_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id tps6598x_of_match[] = {
+	{ .compatible = "ti,tps6598x", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tps6598x_of_match);
+
 static const struct i2c_device_id tps6598x_id[] = {
 	{ "tps6598x" },
 	{ }
@@ -572,6 +578,7 @@ MODULE_DEVICE_TABLE(i2c, tps6598x_id);
 static struct i2c_driver tps6598x_i2c_driver = {
 	.driver = {
 		.name = "tps6598x",
+		.of_match_table = tps6598x_of_match,
 	},
 	.probe_new = tps6598x_probe,
 	.remove = tps6598x_remove,
-- 
2.25.1

