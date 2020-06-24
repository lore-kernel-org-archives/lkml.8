Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CED2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479AC2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Erqp8Qyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404393AbgFXPFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404357AbgFXPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:04:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89355C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so2604041wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLytrf9J+7CHVP5wu7KcfI+noBAdF1Wf8Twuues69S4=;
        b=Erqp8QynHDhJNjQVXw0Nml++ayuUC2985duv2TS42VTDHkluSux1WL8NVNlRd8PFfF
         Tr69ZgM7bf++tb18l5IAjqYmUpu9tlF7PJUiSz8Tr/vUqOcC+v8dsF8Tj4Kt+xMHXB7y
         fyOCi0BW4U5Gw4ul4uy156ZMt+/VwWbNKspvpwakR+6aCVHht2wBlU4p+IAvEkVI1ZMB
         1Z+gXQ77Ie+8ckr7Pl9VYdxjHb12JG1gSlFtHtQBcg1hfU9FICm9DSB1JAhMxSxyUTpN
         tcuNu/c7Vb6L56SkTxqn1Nf5SV14/ketmit5cqVFZ8i4Y61Uv3chtiOdN+0GUmuUGDIc
         zUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLytrf9J+7CHVP5wu7KcfI+noBAdF1Wf8Twuues69S4=;
        b=J7CueydVSrPrcALNYlaB92NSL7gjR8lH9Evo95yRM7/7xPEj3DC89z2KdpzOhkjCmH
         1mW2IQq6TOcxt2K2UN+LlbIWWf4S545j9cTJ/Jxtf1eU6wF6OGBw6OwDYRPw2hD/4v+G
         jC23TUxHXBQc7ItTgyx9jiSMD+e7qcPsSxsrNpZatlNk9aHlt9kEl1UkebT7HFNwhs1C
         L01J5S9ZcsQSr14oDiNVK40IZnmjFAborsaE5PoyAHTtcrzhRzSqDhKKZh2c1EbLIRAU
         YRk6/3zDcF9rC3njox1w2BDI5iZWdqSs6HCxbWYqoV9uRMqx/cGGsLxrnM0Af/EdF11Z
         jS+g==
X-Gm-Message-State: AOAM533myPlImDwf9B8BIDpPSjsDIcP+KCFVeCWgYAbAwh3tUgjo/GO4
        MQZvTPi1lQ7KIxaoLcUdpkUG7g==
X-Google-Smtp-Source: ABdhPJysPmy/tKH5YJkFzQIv2duUP1ODgbSrj8iubXadOJPQ7Zmf5Z3K1aBiaL4Ibwz73S2H6Wavjg==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr25625367wrq.322.1593011087317;
        Wed, 24 Jun 2020 08:04:47 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f186sm8200319wmf.29.2020.06.24.08.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:04:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Software Engineering <sbabic@denx.de>
Subject: [PATCH 5/8] backlight: ili922x: Add missing kerneldoc description for ili922x_reg_dump()'s arg
Date:   Wed, 24 Jun 2020 15:57:18 +0100
Message-Id: <20200624145721.2590327-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.  Descriptions required.

Prevents warnings like:

 drivers/video/backlight/ili922x.c:298: warning: Function parameter or member 'spi' not described in 'ili922x_reg_dump'

Cc: <stable@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Software Engineering <sbabic@denx.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/ili922x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
index cd41433b87aeb..26193f38234e7 100644
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -295,6 +295,8 @@ static int ili922x_write(struct spi_device *spi, u8 reg, u16 value)
 #ifdef DEBUG
 /**
  * ili922x_reg_dump - dump all registers
+ *
+ * @spi: pointer to the controller side proxy for an SPI slave device
  */
 static void ili922x_reg_dump(struct spi_device *spi)
 {
-- 
2.25.1

