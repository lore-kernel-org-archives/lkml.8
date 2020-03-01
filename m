Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9B0C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372CB20880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoR5EYtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCAMXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:23:37 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39481 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCAMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:23:36 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so3224340pjr.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M1Tw0l8NSxHrnFk48cTGyVKS7Y6NVhLq2HbfLfz6X0M=;
        b=LoR5EYtINgvkiEV3tCchC2pkp0jOybj1tIf7CJHE6zujeJm3l6uBnAI3u0dPHLjuoJ
         qpu0F2CIQsiemqzWI+CgQzB/K+TV+acy/bKaRe/TLKqks+3XOM8B9tdaEZOtaSc1sEpA
         qxdEc9U1TWc3L6/h1NzAw683JgPMXOKAXJX6Ne1Z/vLcgMT9UG8PZyQUaf2LV5QcDysC
         ZbAsZz0PwVvOBxAnOnT6x0aReD6xEDH/8Buw6mafWqD3z4wKeGF3BotpjSkZ/4jOFy1n
         +uwTPEtLRFfeoSgaiRq6FiELLp2pgiCdlXUDXVinSva6MM9G3IVU8pVUXdTxu8SS+lg9
         0jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M1Tw0l8NSxHrnFk48cTGyVKS7Y6NVhLq2HbfLfz6X0M=;
        b=jqop1BXyh7fYQ0+vlYgDgXb8vKddzHwgkcrQ9Ao0fIyggWseEwn1hKux6cedZFQkwn
         cJp4bQrJtcAr1vT9WbY8kKEFxc2jeM9FddFjJjYCYX7BO3pLrWYiQ28Y2ANlv/Hi8nDj
         jVt89NLIXRW+vTnaF8ZHNe+j9Knr2/ktp/x1bagJUMfNDJEe3kpCyob5uh+6Rx6fjepg
         9MIWh4McTVZw8xINmMMV3CAwXZeWqgvcMlQBtc3UcPKECO04W+MB3xEoI8FB3HpAvWeG
         26m+Lb+foH1/SxF4du0OK7wt7r8IONoA2E5EtZ+8VlkSe3v1QHCDIaL5eU8D8tdhi/LD
         bo6A==
X-Gm-Message-State: ANhLgQ36QnVcQlfsdV5pJZgCtXLB2SpEumjQTkxd2mP+OQV1uK+kzf9f
        0zaa47MlaTRMcJ8JqhKakiU=
X-Google-Smtp-Source: ADFU+vvzI5wnq+cQKsvcTg/UAQ1prjIw+f6K6U2mxOpdS0K1OmtZ28my7M9tmttdLToU5QfXf9QjlA==
X-Received: by 2002:a17:90a:bd90:: with SMTP id z16mr1106965pjr.36.1583065415887;
        Sun, 01 Mar 2020 04:23:35 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id l37sm8280607pjb.15.2020.03.01.04.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:23:35 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] ARM: orion: replace setup_irq() by request_irq()
Date:   Sun,  1 Mar 2020 17:53:30 +0530
Message-Id: <20200301122330.4296-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
Hi sub-arch maintainers,

If the patch is okay, please take it thr' your tree.

Regards
afzal

v3:
 * Split out from series, also split out from ARM patch to subarch level
	as Thomas suggested to take it thr' respective maintainers
 * Modify string displayed in case of error as suggested by Thomas
 * Re-arrange code as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/arm/plat-orion/time.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index ffb93db68e9c..509d4824dc1c 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -177,12 +177,6 @@ static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction orion_timer_irq = {
-	.name		= "orion_tick",
-	.flags		= IRQF_TIMER,
-	.handler	= orion_timer_interrupt
-};
-
 void __init
 orion_time_set_base(void __iomem *_timer_base)
 {
@@ -236,7 +230,9 @@ orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
 	/*
 	 * Setup clockevent timer (interrupt-driven).
 	 */
-	setup_irq(irq, &orion_timer_irq);
+	if (request_irq(irq, orion_timer_interrupt, IRQF_TIMER, "orion_tick",
+			NULL))
+		pr_err("Failed to request irq %u (orion_tick)\n", irq);
 	orion_clkevt.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&orion_clkevt, tclk, 1, 0xfffffffe);
 }
-- 
2.25.1

