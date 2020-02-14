Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91ACC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8001824650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="TWNAS05X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgBNHOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:14:41 -0500
Received: from gateway30.websitewelcome.com ([192.185.196.18]:24538 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbgBNHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:14:41 -0500
X-Greylist: delayed 1482 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Feb 2020 02:14:40 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id E7FD92350
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 00:49:57 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id 2UnVjc5DLvBMd2UnVjaSIR; Fri, 14 Feb 2020 00:49:57 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x3HqSZrL9+fZXJMxZEHFm+rcw99J7Dz8a7+GnuEr4Rw=; b=TWNAS05Xry4K2p0yjDxEBDZAdf
        O+NW/uoIPWMBCYQ9zxRTDOiPqhpISuK/+8j+L6rXQsKVl2JnM8Y6ocp/5An1eVoUG1wfb8eNBHQzI
        olaFwqqhcKEYYEpZe0Q51CAllGtlBBYqFY6GQXQ8izA3zJhbWR1P8f6hVzNk2Om57+VcsCSJNqhiK
        ysFxY9waAt23Wq9yFOH60UX8rJmvNf8cT07h9Euqt8vNvJLPhDIoz12olW5hmQh2KB3NRWz//J0Bt
        0mE9yfynqz83Xt/aFV28uFpUX5tP4tAs/bKcmthIhlj+bPxwrntu8OnrizHaDtlf64BdgnWgOSHzx
        x2pd0Ggw==;
Received: from [191.31.199.191] (port=34918 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1j2UnV-0014Dq-4o; Fri, 14 Feb 2020 03:49:57 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH] clocksource: owl: Improve owl_timer_init fail messages
Date:   Fri, 14 Feb 2020 03:49:23 -0300
Message-Id: <20200214064923.190035-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.199.191
X-Source-L: No
X-Exim-ID: 1j2UnV-0014Dq-4o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.199.191]:34918
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 1
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding error messages, in case of not having a defined clock property
and in case of an error in clocksource_mmio_init, which may not be
fatal, so just adding a pr_err to notify that it failed.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---

Tested on my Caninos Labrador s500 based board. If the clock property is not
set this message would help debug:

...
[    0.000000] Failed to get OF clock for clocksource
[    0.000000] Failed to initialize '/soc/timer@b0168000': -2
[    0.000000] timer_probe: no matching timers found
...

 drivers/clocksource/timer-owl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-owl.c b/drivers/clocksource/timer-owl.c
index 900fe736145d..f53596f9e86c 100644
--- a/drivers/clocksource/timer-owl.c
+++ b/drivers/clocksource/timer-owl.c
@@ -135,8 +135,10 @@ static int __init owl_timer_init(struct device_node *node)
 	}

 	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get OF clock for clocksource\n");
 		return PTR_ERR(clk);
+	}

 	rate = clk_get_rate(clk);

@@ -144,8 +146,11 @@ static int __init owl_timer_init(struct device_node *node)
 	owl_timer_set_enabled(owl_clksrc_base, true);

 	sched_clock_register(owl_timer_sched_read, 32, rate);
-	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
-			      rate, 200, 32, clocksource_mmio_readl_up);
+	ret = clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
+				    rate, 200, 32, clocksource_mmio_readl_up);
+
+	if (ret)
+		pr_err("Failed to register clocksource %d\n", ret);

 	owl_timer_reset(owl_clkevt_base);

--
2.25.0

