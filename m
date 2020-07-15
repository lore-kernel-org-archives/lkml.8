Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB52CC433ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F6D2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RH7cBJ2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgGOPHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGOPGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F49C08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so3094857wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=42oj6jbSoGTF/ydaYibmpIO6VIJqDyq5aw5c0LpPRTc=;
        b=RH7cBJ2WlhKQHMXBNizOzo0T2ahy8XU3B6sEARR+uPl/o4nKI3IuEZJ8uLvbbZC5t4
         l+AQ8s+3lqDbOapGH58ozWtwg6v2+RT2FZ/JrwPNhkDFeWKYhdds3OJIy2j/3nVpUHrf
         vghBDZGIJosR4XixZz0e228Ju4WbUGTyTYT3ukz5dmafd9HXsLrkhYug7ZwpZ93bHTAP
         2QenT/NInodOgQnlQXZhCDNVS3NG0xHeAslNgHrC3Z4fXIrCBuLGhlx+eqnWpBg6zyd6
         SI4SMBZdEt6nG3WgD8giZCqQmEn/lEzYF4u8dFu5sOWMyxqNUNeH2E/mOMwRTNvnggql
         BEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=42oj6jbSoGTF/ydaYibmpIO6VIJqDyq5aw5c0LpPRTc=;
        b=HvPWbyooVJFqECT6ym67J4CafLC7dreZ15Xp2xY/AQty+khtHmzg40fFHbVUBNaWH9
         Y/klOnXTiwMrjOfPdJe+1n+/q71Lq7c8qrS2y+CC4+EdpJcF/deKxUEQDbHiShwhPEgo
         NckDzZLzm5JiHpvH1QOGs5BijewU9iGCbDdtT3jzII9yfHceKDfGauUfn0NnlPP43TsZ
         qR89uKWM6euAeyhOzQCN+BBKfM2+sskgHewGMswZiYfELgtzYFFy9VXhowMGkEDfyEep
         yAt/KwCOWtKq0OqyE4lsuF7YjffOIgrxyV55V/YZBA13uzTru6WSqT5iTekOdwcZGA0z
         xQ+Q==
X-Gm-Message-State: AOAM5331MQRiHPBhl8nnyZZvKUJdipsz96ui7hGDBLudtQ78jh+pxf4n
        x6yIWcWT9dqtNmeTUX1HbZp6YA==
X-Google-Smtp-Source: ABdhPJxc3qUeyfFWGzOmf9reFa92XgdB27XAAzFJpjdbVd7jj+ddsAHBcS7KpBUlsilZ+jYr/eF36A==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr11986837wrs.228.1594825610727;
        Wed, 15 Jul 2020 08:06:50 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 12/14] spi: spi-at91-usart: Make use of the defined 'struct of_device_id'
Date:   Wed, 15 Jul 2020 16:06:30 +0100
Message-Id: <20200715150632.409077-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's there so why not use it.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-at91-usart.c:684:34: warning: ‘at91_usart_spi_dt_ids’ defined but not used [-Wunused-const-variable=]
 684 | static const struct of_device_id at91_usart_spi_dt_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~~

Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-at91-usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 88033422a42ae..d47a20be43ccd 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -692,6 +692,7 @@ static struct platform_driver at91_usart_spi_driver = {
 	.driver = {
 		.name = "at91_usart_spi",
 		.pm = &at91_usart_spi_pm_ops,
+		.of_match_table = at91_usart_spi_dt_ids,
 	},
 	.probe = at91_usart_spi_probe,
 	.remove = at91_usart_spi_remove,
-- 
2.25.1

