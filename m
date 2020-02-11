Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B6C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D8F20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YMVL4Uut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgBKNNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:13:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33257 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgBKNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:13:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so12362702wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vPmpeWQjbELhAAh7qUDhl/FE61ojZhZ+nedC+mmNBA=;
        b=YMVL4UutOUUUBwxTLjas1GuxZpiRAyZ1QAJDqZuCsiixVQ0HwJ8iqYUKqX4By5wK1O
         xh5q5/mIudN6g8VmBHS+ZVag+52200shz8xC+qEl5LTCcxOS9snJLRjuDHpc6Uq/8VMD
         /6BZpEia3GazsYMJfmihNFHq7HA0BMFugaXVwo6qJag3ClvXZPuzjUW8pACj2AN6HJCY
         EDpVS9GLXJtxdNC9SmGGn9C7fNvv2wno61s8xPnkugdealVsXLRUmJxHRks0PlH6hyGb
         s73Uvf0fZhev9/ZOwoT21KBAA23sMroSApT3hyDQqvHJKDqVrtogp75kjFOM4er1dKUX
         /l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vPmpeWQjbELhAAh7qUDhl/FE61ojZhZ+nedC+mmNBA=;
        b=grOT8tqeT4+7IkTv0s+dAi2G7CLChZHE+MdSH62PbUqD8kMtKrv9PKaodLbms1r60p
         fhsNRjxowFoscDPTPImbNLbCfyrg9mWUDUG+iJuhyW3tI0BjwJ27nS74sbiE4mVaSmwQ
         Fo3H3GzRLPyXiMHz3eIaEGOCJZJRLa4an7HIsNrVT/9iWOyjB9JYB9peYves8fjhlGNg
         XMdY66yJoIFKvMkrgtisW1H1SCYtV8XABVsuySbJ95hptKdgCIZBoFiRYOTODZc/n3EY
         GLjy8G/8z5O8IxiLE0i0hPP6ZI6Zx14W+xd9fBr9Au2ClRHiyKC31Df6cccK4j7Eaod5
         3wkA==
X-Gm-Message-State: APjAAAUQHSKphX/chMsgV0pjos5Oxmz5PxUZMMQoF/LBjbDKzPTYUop2
        i/MmVJ3l2+OicN6+wL8cgGsv4w==
X-Google-Smtp-Source: APXvYqwsqGPsgxct0EcwFH2nXNkyOmhcAIVbam2T5OBf09TafGb/SaZA0NIR5OfaTljHguvsgfn4aA==
X-Received: by 2002:a5d:4d12:: with SMTP id z18mr8658792wrt.139.1581426786597;
        Tue, 11 Feb 2020 05:13:06 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id b21sm3873013wmd.37.2020.02.11.05.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:13:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 6/6] irqchip: keystone: use irq_domain_dispose_mappings()
Date:   Tue, 11 Feb 2020 14:12:40 +0100
Message-Id: <20200211131240.15853-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211131240.15853-1-brgl@bgdev.pl>
References: <20200211131240.15853-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Shrink the code a bit by using the new irq_domain_dispose_mappings()
helper.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/irqchip/irq-keystone.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 8118ebe80b09..57819d1c3c32 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -135,6 +135,7 @@ static int keystone_irq_map(struct irq_domain *h, unsigned int virq,
 static const struct irq_domain_ops keystone_irq_ops = {
 	.map	= keystone_irq_map,
 	.xlate	= irq_domain_xlate_onecell,
+	.remove	= irq_domain_dispose_mappings,
 };
 
 static int keystone_irq_probe(struct platform_device *pdev)
@@ -203,13 +204,9 @@ static int keystone_irq_probe(struct platform_device *pdev)
 static int keystone_irq_remove(struct platform_device *pdev)
 {
 	struct keystone_irq_device *kirq = platform_get_drvdata(pdev);
-	int hwirq;
 
 	free_irq(kirq->irq, kirq);
 
-	for (hwirq = 0; hwirq < KEYSTONE_N_IRQ; hwirq++)
-		irq_dispose_mapping(irq_find_mapping(kirq->irqd, hwirq));
-
 	irq_domain_remove(kirq->irqd);
 	return 0;
 }
-- 
2.25.0

