Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CD6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CEE20786
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MHUNxH6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgHCX7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgHCX6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:58:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E3C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:58:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f68so10791856ilh.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bp6OwO92DPNru+lJBtL8+lflqmBd40LGlvDc78rVJ9c=;
        b=MHUNxH6sVnlzX16mnBO0Libr5RgVsQYv7/UqRC0xTEUbYCbo3sOqowucBA3nb+m5MX
         m8FwZqCpFUl/T08XoQJUnhJNTzHCdLOmUkdAV6Pnv+6WaOYjgLjlNOPBAK2MVIOrIRhP
         eQ1iYXdyJitiQUzJSNADJUzaWFUIrKDbJSCOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bp6OwO92DPNru+lJBtL8+lflqmBd40LGlvDc78rVJ9c=;
        b=oTCLDm3/poAtaFMl60ocd8YeQp3MftYwOifToHT+zO0/ppv84ta9KOtc6AWK9OFoBQ
         BXK2pI4iB5hOs82fgDqDMJDD0LOb3xlnp44vZcp41igz88wSziyIiq36RWVyf8k7Oco2
         P0VZ8EemCjzcIK1FuVPIymAa7kLXgcc/keJA+hRKIUcDV9U7eAEZk2FwsfInBxpZMFR5
         gAy0HbRxDeVmH/7nhJlaQswZPHmsqW+hupZ7PlptDrZTWzc/pRsY4CgYwbShF9eKMdmv
         Vok+3uImdsltaT+taa25OE13qFXPf02wj05xH7v6l1jnSEadxOf5f1rl0Oc4Lex8rBxr
         vaDg==
X-Gm-Message-State: AOAM533Nj80Dky8rWMFmeQEP68iJOfdfDCS5hghVa+KG+VlbRQg0MIGV
        DNTTeO4qHlp6obmZnZ+LUdWNzA==
X-Google-Smtp-Source: ABdhPJxHGJNGeHI0qdX4nnx8eSv09ZJiDnvrlC0tQ13wHy6OexeBXFmXFY6nkq0UlgH4JqadZFUj6w==
X-Received: by 2002:a92:3006:: with SMTP id x6mr2079172ile.260.1596499102078;
        Mon, 03 Aug 2020 16:58:22 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:21 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 03/15] iio: sx9310: Fix irq handling
Date:   Mon,  3 Aug 2020 17:58:03 -0600
Message-Id: <20200803175559.v5.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes enable/disable irq handling at various points. The driver needs to
only enable/disable irqs if there is an actual irq handler installed.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4:
 - Reverted condition check logic on enable/disable_irq methods.

Changes in v3:
 - Moved irq presence check down to lower methods

Changes in v2:
 - Reordered error handling on sx9310_resume()

 drivers/iio/proximity/sx9310.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index d7c77fc661ba86..dafee85018aa6d 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -323,11 +323,15 @@ static int sx9310_put_event_channel(struct sx9310_data *data, int channel)
 
 static int sx9310_enable_irq(struct sx9310_data *data, unsigned int irq)
 {
+	if (!data->client->irq)
+		return 0;
 	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, irq);
 }
 
 static int sx9310_disable_irq(struct sx9310_data *data, unsigned int irq)
 {
+	if (!data->client->irq)
+		return 0;
 	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, 0);
 }
 
@@ -381,7 +385,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 
 	mutex_unlock(&data->mutex);
 
-	if (data->client->irq > 0) {
+	if (data->client->irq) {
 		ret = wait_for_completion_interruptible(&data->completion);
 		reinit_completion(&data->completion);
 	} else {
@@ -1010,10 +1014,11 @@ static int __maybe_unused sx9310_resume(struct device *dev)
 
 out:
 	mutex_unlock(&data->mutex);
+	if (ret)
+		return ret;
 
 	enable_irq(data->client->irq);
-
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops sx9310_pm_ops = {
-- 
2.28.0.163.g6104cc2f0b6-goog

