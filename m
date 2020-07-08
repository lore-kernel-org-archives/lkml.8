Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E067DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FC320C09
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCd5I/c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgGHI1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgGHI1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:27:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D207AC08E763;
        Wed,  8 Jul 2020 01:27:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so53158315ljn.4;
        Wed, 08 Jul 2020 01:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2L7hrK40nfAErtndrzwbfTG3zrA6wCit9fAYng6JIA=;
        b=fCd5I/c53jLPqdRTrGMal1Utxqy8yCRAhtvE6GUfMGWDnK0uA7gF02ZAds0WJn0fp6
         3iebXE5cv0/cCT+Ta+ASnT5CzL3c2fPQd8cmQ12buO0IHPWKBDVsztvWxBDLQFtWITvH
         6JGsK8L+Nb+sUpX3P1mdqo7q6OPYDpXHpfivumfz91Ry66pyHbJPAt9Xe0Hn1tUupAEl
         kgSx0q1saE5HDQraaJkm93CxzLdb1rCMVdODRNsPMJdT7U9cqJOGVL61b/aGyjHJmMz+
         pJZMQAYdQRKXGQWh81M+j2xsySABUqv1vdQT+jDZZtO5Vx6jKYAp5j0Kg3WPu5Sm/1qE
         1ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2L7hrK40nfAErtndrzwbfTG3zrA6wCit9fAYng6JIA=;
        b=ZV2rMvLOXewqoXRRXYCAlSktTsADMugDymJ174Efi/okBfBOxPa5sebKEuH0vn5p6w
         Lf+I1KKSopyxfKq90y1Ek9DDZGOPXph669MElUMlWxJgDtZsA6Y+sQNStVv46LKfsS1l
         Z1K6FuLvu5jOmhMwCuUYMWAjhmK2eq5QPttHyHiJvX8rlSJ6/hZKL3NugTpKLVOExAY4
         pB9w9pfjx7+Y7AGELwwhi3jTcy1Lb+YZu0vrAvFcXCgizF9coSvmNSJlc0zLPM9lYwXk
         /BR0XWciL+EbKRJ0yAARdiuwbP151dayZ5629QSaloXuJI7VpHkoDXBId8Bqb0e0AMiE
         A5dg==
X-Gm-Message-State: AOAM532tXXzHC6AIvH9h9hYh1+hU+SeOZNWGin9scm2zZmvr5/hYI+lA
        imm5d4zQRn6nnrIWbJhc9oP9xhDl
X-Google-Smtp-Source: ABdhPJy0+erCYT97SMJfqXkQRycFP5pkDkDh5ilWRsuXLAGM+KzMFMwGPCGsCFaN7wwRhUZHQP/9gg==
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr30586662ljg.284.1594196871390;
        Wed, 08 Jul 2020 01:27:51 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.gmail.com with ESMTPSA id d2sm737555ljg.6.2020.07.08.01.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 01:27:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] gpio: max77620: Don't handle disabled interrupts
Date:   Wed,  8 Jul 2020 11:26:33 +0300
Message-Id: <20200708082634.30191-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200708082634.30191-1-digetx@gmail.com>
References: <20200708082634.30191-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether GPIO IRQ is enabled before proceeding with handling the
interrupt request. The interrupt handler now returns IRQ_NONE if none
of interrupts were handled, which is usually a sign of a problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpio/gpio-max77620.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index dd83c16a1ec6..8d54bc4307c2 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -37,7 +37,9 @@ static irqreturn_t max77620_gpio_irqhandler(int irq, void *data)
 		return IRQ_NONE;
 	}
 
-	pending = value;
+	pending = value & gpio->irq_enb_mask;
+	if (!pending)
+		return IRQ_NONE;
 
 	for_each_set_bit(offset, &pending, MAX77620_GPIO_NR) {
 		unsigned int virq;
-- 
2.26.0

