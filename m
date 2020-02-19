Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E5AC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42A624655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="w1E4Gp6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBSBLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:11:34 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.253]:49633 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgBSBLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:11:34 -0500
X-Greylist: delayed 1393 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 20:11:33 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 0C3E53249
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:48:20 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id 4DXHjJ2qURP4z4DXHjjPhG; Tue, 18 Feb 2020 18:48:20 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JoYnHBAG6Y5v6fA38lydAZysRIc6JyUc06Qk8jBvAUk=; b=w1E4Gp6D/9U2l7EaNAy00GX6Jg
        17Xr4eHKch+rmlP/+VeQNFjzBvy8SfbIIsRnA1R7vPNk+ign0ZNg4cBqUa1Qh0WSIKbhS5woHIAYY
        G4oexTma33sdm2XgXOg9I+3piUWcBU69QXNi0K1qEqprdB8A1mwcUNvyaB4KSB7UEdb2CDakCjxfo
        Z5RNwe1fP8CP1rgwk5F8QsUTJmIxE2Xdm/2PczWq/bDdw6se6VjEwWM/PdfgBUNmYa1eeGysnmjut
        XrVlPT6rQ91P7B/m6NzhNw9hHTd/vew785BKQUdKzi4gfVheSGv43gu3+GII0IlDXJotY7phCkFaA
        Ar4Ym6tg==;
Received: from [191.31.202.255] (port=52372 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1j4DXG-000PIC-8O; Tue, 18 Feb 2020 21:48:18 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2] clocksource: owl: Improve owl_timer_init fail messages
Date:   Tue, 18 Feb 2020 21:48:10 -0300
Message-Id: <20200219004810.411190-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <e3d851477d569ccb66294b2292495778a3a24c09.camel@suse.de>
References: <e3d851477d569ccb66294b2292495778a3a24c09.camel@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.202.255
X-Source-L: No
X-Exim-ID: 1j4DXG-000PIC-8O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.202.255]:52372
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 1
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return from clocksource_mmio_init, add messages in case of
an error and in case of not having a defined clock property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---

Thanks Manivannan and Andreas for the review.
Tested on my Caninos Labrador s500 based board.

Changes since v1:
(suggested by maintainers)
- Maintains consistency output PTR_ERR(clk)
- Returning in case of error on clocksource_mmio_init
- Use parentheses between the error code
- Remove OF mention

 drivers/clocksource/timer-owl.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-owl.c b/drivers/clocksource/timer-owl.c
index 900fe736145d..820fbcc05503 100644
--- a/drivers/clocksource/timer-owl.c
+++ b/drivers/clocksource/timer-owl.c
@@ -135,8 +135,11 @@ static int __init owl_timer_init(struct device_node *node)
 	}

 	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		pr_err("Failed to get clock for clocksource (%d)\n", ret);
+		return ret;
+	}

 	rate = clk_get_rate(clk);

@@ -144,8 +147,12 @@ static int __init owl_timer_init(struct device_node *node)
 	owl_timer_set_enabled(owl_clksrc_base, true);

 	sched_clock_register(owl_timer_sched_read, 32, rate);
-	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
-			      rate, 200, 32, clocksource_mmio_readl_up);
+	ret = clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
+				    rate, 200, 32, clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("Failed to register clocksource (%d)\n", ret);
+		return ret;
+	}

 	owl_timer_reset(owl_clkevt_base);

--
2.25.0

