Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2960C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA1D2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLLPmU6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgFQWdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgFQWdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:33:00 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CC9C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:59 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g2so2315247lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vsSuAzVaD0q/Cs/PzaYkTdpFOxrfzC0EanL9gUbc9c=;
        b=uLLPmU6lZ4gHlew6t1yhko8J/l/IVc71wqg9aecuIyc9XDz+XujTus68h1c5OC8qjR
         2dipMWuiavsTtXtVI0cu/+Yw0UGXqaUTBUakKXUp3u5zpG7+0C5huKD6xegTRz9xZMvy
         lXLU+KfsSgHL0hgvivNhc+wUsiu5GAkk82KSLNjs7kxLR3S17BSa48Q854CjqpF6Ks9Y
         fKhDKMJMdxiKk9xYXn4z9MI9YhjMPsB+IC9DOlegKCAExzOI+1AA85w4qbdnKgUHxBVA
         llGKrOiBEdAqRk3v6uZcXbMiE1uR0TPo8ySspTJymjoUYs7fI1hAXDsESFHDBGmnyjVa
         zJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vsSuAzVaD0q/Cs/PzaYkTdpFOxrfzC0EanL9gUbc9c=;
        b=UWfhavxRP3XvDvo0av3rqyGfOCtfgo/JEjMQZ7YHb3NDh/rQZYG4zV0YEpRbuObtqv
         fgZzg6ISLzqancgjUj4QM2N4XLl4RhHDcVAwOVG/IZ4hW9MRdMom67A6BMb9iudckeq2
         8l9k7u/icbOAyFYJ6nIe6Un8Lg0RfPsFu52L4D0Hlr1xg58dyw/EHJV+fWtUlJp9Cy6i
         OtyqVqlCydv/Q/zl4uLGuU4GrHcgLaQArhlxvhJqugDFU3uzzx7I2Qug4XecYw/rnTyk
         yS1rt4VhQrbm3gioJvq6Db5H3yGMY/Vs2CdcHBwTwDt1GVK5qqmn2k3pnYmK4OkI30U7
         f5IQ==
X-Gm-Message-State: AOAM531lbZe6hLEZDIzJTd5IJ9zgBhvBMYSInZ11JWm+7EXxWfncrawK
        vUMEvqxp99I+hqJI3SZC7Yk=
X-Google-Smtp-Source: ABdhPJy1MZ48+WKPFuKZxwECSEF1jQfKx4O5foSIoJjBMO4vhXjUwAVeCgs4K2QLDXmSS1xPWp8pxg==
X-Received: by 2002:a19:4c57:: with SMTP id z84mr568760lfa.213.1592433178215;
        Wed, 17 Jun 2020 15:32:58 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id 203sm226079lfh.19.2020.06.17.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:32:57 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/5] regulator: ltc3676: Constify ltc3676_regulators
Date:   Thu, 18 Jun 2020 00:32:45 +0200
Message-Id: <20200617223247.25566-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
References: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ltc3676_regulators is not modified and can be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   4361    2064       8    6433    1921 drivers/regulator/ltc3676.o

After:
   text    data     bss     dec     hex filename
   6121     304       8    6433    1921 drivers/regulator/ltc3676.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/ltc3676.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index e12e52c69e52..093b3e4a6303 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -221,7 +221,7 @@ static const struct regulator_ops ltc3676_fixed_regulator_ops = {
 #define LTC3676_FIXED_REG(_id, _name, _en_reg, _en_bit)                \
 	LTC3676_REG(_id, _name, fixed, LTC3676_ ## _en_reg, _en_bit, 0, 0)
 
-static struct regulator_desc ltc3676_regulators[LTC3676_NUM_REGULATORS] = {
+static const struct regulator_desc ltc3676_regulators[LTC3676_NUM_REGULATORS] = {
 	LTC3676_LINEAR_REG(SW1, sw1, BUCK1, DVB1A),
 	LTC3676_LINEAR_REG(SW2, sw2, BUCK2, DVB2A),
 	LTC3676_LINEAR_REG(SW3, sw3, BUCK3, DVB3A),
-- 
2.27.0

