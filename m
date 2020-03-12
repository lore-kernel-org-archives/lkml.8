Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA59C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C86120578
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHn2t8Gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbgCLGsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:48:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45572 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387845AbgCLGsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:48:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id 2so2746498pfg.12;
        Wed, 11 Mar 2020 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lxjxhXNAD3AGywNMl8H5owtCRspegZReTpVXsaoFlvM=;
        b=CHn2t8Gp6E99syTcM5Av0LZWL8jbCoQ5jap7ar2l6fwwQ94ld29tvZ2SQaDyM2UU8G
         PW/TBP58I1SL36LotuxvC8sTUJ6ISHI1Ks+kH0bK09zP46a4aZ3tE9av/ya27yUt8qbU
         XoE7fVdMiU85mCK52RFMbR+nutYGYwxFK1LezC6Hd/PY6kJseH+I6HfBPlAaAtROTs/P
         VTtY/fhkw+1KfQ6s0fqwH3xjOPJE9GLWoYvrPtTJkhSTE0waj6AkPoJPOO+8yybr6HG9
         j5zWZWCdxKJE7YczJZnE4y4AJE04ML1XF5ToDQYzB6fERP0UIHA9gpvlQ4Os0pnmcpIt
         8dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lxjxhXNAD3AGywNMl8H5owtCRspegZReTpVXsaoFlvM=;
        b=cX69dMX3iX6B8Lsd/yd0OowhrVkEPBmljeJe6d9JmkBbI8SbTNtG2UgkGkQrhpzDOp
         7m1o6MJYcRrh6R9sn9BlPVXGCu86h6iZQ9HKQjxtK7qnhNHSHW+ITQaa1l2AqJKx2AXK
         +qsT52AroragheehdEqSxI2uYNOEiMGEEx23N2WzYjX0sEZYeZ0e6G8n5ynxPAHSqeMs
         79nFOKV2WZZLjLRdSAf5WOrXNihx4i7jtqw1jI9ErQ2uebSLlWJ/biE+5dw2+7guxvET
         gyCTGnLixFhYPINg4hHmzImooxsRZJAq7fjfmOIXdaVXT8W0TzS5A1AvezyrcP5MVFWZ
         CyMA==
X-Gm-Message-State: ANhLgQ3reQ5Dp9UCkD8BWUecQxhwmX01TKrMUsElLHx2cySejbi7SrRT
        QCHH5z2t1AluUJo+yOHmPjM=
X-Google-Smtp-Source: ADFU+vsZyABanN90ZhdifavscU6wtE4scsZ3AAJ8cEf7mvO9vLvMg7a4MP11N/8+VsKLJKB7fS7zqg==
X-Received: by 2002:a63:4282:: with SMTP id p124mr6575179pga.59.1583995710764;
        Wed, 11 Mar 2020 23:48:30 -0700 (PDT)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id z20sm23429783pge.62.2020.03.11.23.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 23:48:30 -0700 (PDT)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     afzal.mohd.ma@gmail.com, allison@lohutok.net, baohua@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        festevam@gmail.com, gregkh@linuxfoundation.org, info@metux.net,
        kernel@pengutronix.de, kgene@kernel.org, khilman@baylibre.com,
        krzk@kernel.org, kstewart@linuxfoundation.org,
        linus.walleij@linaro.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux@prisktech.co.nz, nsaenzjulienne@suse.de, rjui@broadcom.com,
        s.hauer@pengutronix.de, sbranden@broadcom.com, shawnguo@kernel.org,
        tglx@linutronix.de, u.kleine-koenig@pengutronix.de
Subject: [PATCH v4] clocksource/drivers/timer-cs5535: request irq with non-NULL dev_id
Date:   Thu, 12 Mar 2020 12:18:17 +0530
Message-Id: <20200312064817.19000-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <e47ba222-bf4e-d13c-fbd3-6e7952097188@linaro.org>
References: <e47ba222-bf4e-d13c-fbd3-6e7952097188@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently all usages of setup_irq() was replaced by request_irq().
request_irq() does a few sanity checks that were not done in
setup_irq(), if they fail irq registration will fail. One of the check
is to ensure that non-NULL dev_id is passed in the case of shared irq.

Fix it by passing non-NULL dev_id while registering the shared irq.

Fixes: cc2550b421aa ("clocksource: Replace setup_irq() by request_irq()")
Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Hi Daniel,

i have assumed that you would not rebase your drivers/next tree & put the
SHA-id in Fixes tag.

Regards
afzal

 drivers/clocksource/timer-cs5535.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-cs5535.c b/drivers/clocksource/timer-cs5535.c
index 51ea0509fb25..d47acfe848ae 100644
--- a/drivers/clocksource/timer-cs5535.c
+++ b/drivers/clocksource/timer-cs5535.c
@@ -133,6 +133,7 @@ static irqreturn_t mfgpt_tick(int irq, void *dev_id)
 
 static int __init cs5535_mfgpt_init(void)
 {
+	unsigned long flags = IRQF_NOBALANCING | IRQF_TIMER | IRQF_SHARED;
 	struct cs5535_mfgpt_timer *timer;
 	int ret;
 	uint16_t val;
@@ -152,9 +153,7 @@ static int __init cs5535_mfgpt_init(void)
 	}
 
 	/* And register it with the kernel */
-	ret = request_irq(timer_irq, mfgpt_tick,
-			  IRQF_NOBALANCING | IRQF_TIMER | IRQF_SHARED,
-			  DRV_NAME, NULL);
+	ret = request_irq(timer_irq, mfgpt_tick, flags, DRV_NAME, timer);
 	if (ret) {
 		printk(KERN_ERR DRV_NAME ": Unable to set up the interrupt.\n");
 		goto err_irq;
-- 
2.18.0

