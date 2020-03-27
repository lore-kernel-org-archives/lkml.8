Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86789C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F15206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJj+HvEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgC0MpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:45:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44637 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgC0MpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:45:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id 142so4512173pgf.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+k9FpHI6R329k1p5n2ZmxLrGGeywgn+d1U7fGz/e9fs=;
        b=cJj+HvEYUrch4yUgmLxsQfZstI1JxA0pQDazHNg6IMMsqsjdMjKwmzWoVuCAdMQ2ua
         EERQg4cDrroRlSqfqACd0CcPBpWMjhlGDMIh2nmjzF6Tr8jcXlT6vvrVuPKFDZGplUui
         6VuoAq+7SvMyaKGfd4x36kLvjEhcQFWvsg8ctmPt669FtdT7mglaMQlhJ28EJqweoe0N
         36wuQErl0fLfSy2jtG4q2CXGRFRaKlbvmDk3eTxK7XHh7138+I21f2PDMFhymIxrgGXG
         0NzesrfPdwA/ykaTatv5zddtQzq5Y1HbMI9OJXfHg4mO1SoI7kMAGQ9ozclney7LWjed
         0Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+k9FpHI6R329k1p5n2ZmxLrGGeywgn+d1U7fGz/e9fs=;
        b=RZPT0I0qSOXq+kq2VzYgCodYKQHM64R2mFWuckgevIwSTlSdDKF+UdQSCgFy2THew6
         Zh66dZIObbcEgSEe5zbuoVENT4NIg3lo/1pdlsgHHUOmsE+U0BNcw+2hZryCUdwYuSm2
         qrd4UjUrRj8RNulRtbOXMBeug4BDWXJIzCgZxqNmgnpFOkLOpicFgR5z56cNxO0AjPty
         AXYDpSDaUCRLltCxyOzkb8jPrBUddrUrYmlOAgb4zr8M95HwFKcXOby3Kt42aknp/VmK
         SbezclsScSElaYVwmu7kLbQ4poJ+zc0rodqXqbJS07YBMY7OHZ3ytNmbSog8UepCWux1
         yWuw==
X-Gm-Message-State: ANhLgQ0jjcja0M+nOwlj51wNw1DKuBvHc6g0rJ7U6KUSV0hr79GerR0x
        BWjXuybItvf0+jY7nKZrWa8=
X-Google-Smtp-Source: ADFU+vt4ULTKYB4EI+sbHTJ5JUWGsxXrQ+wP+sgamWxYG48SKpaR8sUaOWRqDMbtt4LvgaR5hQ6/ig==
X-Received: by 2002:a65:53c9:: with SMTP id z9mr12309655pgr.405.1585313099156;
        Fri, 27 Mar 2020 05:44:59 -0700 (PDT)
Received: from localhost.localdomain ([49.207.51.33])
        by smtp.gmail.com with ESMTPSA id e9sm4085390pfl.179.2020.03.27.05.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:44:58 -0700 (PDT)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
List-Id: <soc.lore.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>
Subject: [PATCH v4 5/5] ARM: iop32x: replace setup_irq() by request_irq()
Date:   Fri, 27 Mar 2020 18:14:51 +0530
Message-Id: <20200327124451.4298-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAK8P3a2sqika7=3D6Zgkz+v8HtGEc0q0+skWG8mSKuL+qSoYLw@mail.gmail.com>
References: <CAK8P3a2sqika7=3D6Zgkz+v8HtGEc0q0+skWG8mSKuL+qSoYLw@mail.gmail.com>
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

v4:
 * No change

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

 arch/arm/mach-iop32x/time.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-iop32x/time.c b/arch/arm/mach-iop32x/time.c
index 18a4df5c1baa..ae533b66fefd 100644
--- a/arch/arm/mach-iop32x/time.c
+++ b/arch/arm/mach-iop32x/time.c
@@ -137,13 +137,6 @@ iop_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction iop_timer_irq = {
-	.name		= "IOP Timer Tick",
-	.handler	= iop_timer_interrupt,
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.dev_id		= &iop_clockevent,
-};
-
 static unsigned long iop_tick_rate;
 unsigned long get_iop_tick_rate(void)
 {
@@ -154,6 +147,7 @@ EXPORT_SYMBOL(get_iop_tick_rate);
 void __init iop_init_time(unsigned long tick_rate)
 {
 	u32 timer_ctl;
+	int irq = IRQ_IOP32X_TIMER0;
 
 	sched_clock_register(iop_read_sched_clock, 32, tick_rate);
 
@@ -168,7 +162,9 @@ void __init iop_init_time(unsigned long tick_rate)
 	 */
 	write_tmr0(timer_ctl & ~IOP_TMR_EN);
 	write_tisr(1);
-	setup_irq(IRQ_IOP32X_TIMER0, &iop_timer_irq);
+	if (request_irq(irq, iop_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			"IOP Timer Tick", &iop_clockevent))
+		pr_err("Failed to request irq() %d (IOP Timer Tick)\n", irq);
 	iop_clockevent.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&iop_clockevent, tick_rate,
 					0xf, 0xfffffffe);
-- 
2.25.1

