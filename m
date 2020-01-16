Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A9C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D112051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfE/AcGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436583AbgAPSXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:23:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32785 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395566AbgAPSXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so20216250wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cov12SfkIh+oexBgHBZ+gRTZEIqEjsP9GuoevKtumE8=;
        b=IfE/AcGIBZtMogp4pJ1vnzNDiMAS/TQbIr4SdqcNp2CaG0nWlzRycN3Mpymhncv+NU
         pjkD8vNSb7Okazn9lRdv0n0SsTUVFq0pygs/44pOUz9Pu+GfBjQqne+pnLnCkFW0vRd/
         V00UfH2aCwQqKH2F1ANxuCFt3IsJr/sF+0inGS7HS6655If5kmngNKDxcK6E5im1PFis
         klHa2GuK/o+TeaMb9gCBWIGjL5Nd9oxEn+e1VpjpVoR6lxrvhmu0iIWabBKL9yENaEg6
         AUfRGaW4cI9RdSxXcvSki0QEHSgoATdNBdwV3uYVVXSfiqil/nszFaoJnHPDoMu06uTN
         Y2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cov12SfkIh+oexBgHBZ+gRTZEIqEjsP9GuoevKtumE8=;
        b=RWzcRbsjzqNgpIwaQ89Xm8LKQSoyIpN+htiV56LNYksXTNUVZ+he/6V/r8aSXUKsL+
         hJTtnyDkLSWi6NQfzIlB40pBvPFmklGv3phj5Bz7q6wphjFO28B2v8ywFNUTtQmk0NH4
         qvNucCBUhRkCnr5pvX/lSY3e0yEOv+PmdNy8f4xaX3fNmhXUs+5R5wIIAfmtLUxdWHQE
         j+OpFlkWEn+8Q02uARQKkQ9Rzk9YKmrOGOeLyj7vqg+aPEXUsqENyck4oO1nOo/vzLP9
         RoWVIloHXZlVhwd24XZcVc0uTkk4iNXMUUj2lJ4ZdkJTt+Tp8RxmSiWhVaLKNoiVQB8K
         jLlA==
X-Gm-Message-State: APjAAAWL1f3K6apoWvKb3ZajPD+YZofLkrLaLFNu3bAO19q0CFKDwjLr
        CBn7zOr6jm1QUMF0e3GQzGRK6Q==
X-Google-Smtp-Source: APXvYqxWIejb0YpykDsuwCHNVjnl5GGEaOIWj+UApHCuOGElJG5HBES8xZ+lFCS57N2XCFS879y6GQ==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr4532434wrq.331.1579199013608;
        Thu, 16 Jan 2020 10:23:33 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 08/17] clocksource/drivers/bcm2835_timer: Fix memory leak of timer
Date:   Thu, 16 Jan 2020 19:22:55 +0100
Message-Id: <20200116182304.4926-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when setup_irq fails the error exit path will leak the
recently allocated timer structure.  Originally the code would
throw a panic but a later commit changed the behaviour to return
via the err_iounmap path and hence we now have a memory leak. Fix
this by adding a err_timer_free error path that kfree's timer.

Addresses-Coverity: ("Resource Leak")
Fixes: 524a7f08983d ("clocksource/drivers/bcm2835_timer: Convert init function to return error")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191219213246.34437-1-colin.king@canonical.com
---
 drivers/clocksource/bcm2835_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 2b196cbfadb6..b235f446ee50 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -121,7 +121,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	ret = setup_irq(irq, &timer->act);
 	if (ret) {
 		pr_err("Can't set up timer IRQ\n");
-		goto err_iounmap;
+		goto err_timer_free;
 	}
 
 	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);
@@ -130,6 +130,9 @@ static int __init bcm2835_timer_init(struct device_node *node)
 
 	return 0;
 
+err_timer_free:
+	kfree(timer);
+
 err_iounmap:
 	iounmap(base);
 	return ret;
-- 
2.17.1

