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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F932C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139AC2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeUXuFl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgC0Mor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:44:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46546 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgC0Mor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:44:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id q3so4428846pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xFdvPRnQ5Nq8J+GnOFEHtRkDs3iYX4yKgZJqfls3/Pk=;
        b=YeUXuFl8dwFM3mWt1H2uHEqUccLT5Xz+QFYTGztMmEJoY6CJssaZCuvAawjQwmUXCq
         WE7TnXJ0S7ox17JZ+21+DTHw+iZW/GlO1d0lUqXN7992tY+agbibzc+IMP/oGW7vpWM5
         gE13iQAxCOeB4Yl8kdzjItjkLawp/ZVSOtQ4rKgzu700xbuaJQMe5Ccsu8TwjVsLusAH
         wK8EPmnr3IelGS4b8u3BeSJXBSboMATZKfmjFAV+FFSy/aE3tJvInzpdaqzOsuRN9bzc
         vICZ6w+pbojyLVGrrIUCRIp/TNOH4/Mgwtm5lC6p4NGYsrXsAPUp7ocz2WJkTycuDQYY
         /ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xFdvPRnQ5Nq8J+GnOFEHtRkDs3iYX4yKgZJqfls3/Pk=;
        b=Jsd0L5bwp/K8vs210gcwf/QVDeXl31yAC0yUk3qCOoOBc2VrID7c4ZTDIM047U9T4K
         aWlNcRuk6Zub0TXXGimqs0N/YPhMEvzJgaqqKB6xcyUjEP0Z2WoOYGLp87rFOw2+8/+k
         bEdnHnhgya/g+UhNPqW3OMhHVhsxgqwvZQXKrwZniG2QC2FJR1cm74U4qTcHaqaYJp1z
         ZdKt0Om5CwNPv0PCQ8JkrghItpog0VBmRUMzyAGkceMZ1FVSb/P79YoBGNaciELQU5OV
         kGEozq6fwYtMd5KbJkxcPiedua8iG3f/3yBEVJ3F2tooc/Cyn2FYgUm70NLXib8lIxoe
         29Eg==
X-Gm-Message-State: ANhLgQ3AbxRHIMGNsj93++FJ8kCgp9CBByAca4SjZ7d7kR+HCg58CF58
        SFJ5NrlLaYTjBc8M0EH04ao=
X-Google-Smtp-Source: ADFU+vuLkq2V3axK2zqaj7bfQQYwxISRui0bqL+BPM0Z4hxEntrKa7bvyaSE7IdlBKgOhRoaLMMD4Q==
X-Received: by 2002:a63:2442:: with SMTP id k63mr5968884pgk.250.1585313085217;
        Fri, 27 Mar 2020 05:44:45 -0700 (PDT)
Received: from localhost.localdomain ([49.207.51.33])
        by smtp.gmail.com with ESMTPSA id 1sm3752699pjo.10.2020.03.27.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:44:44 -0700 (PDT)
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
Subject: [PATCH v4 4/5] ARM: mmp: replace setup_irq() by request_irq()
Date:   Fri, 27 Mar 2020 18:14:37 +0530
Message-Id: <20200327124437.4239-1-afzal.mohd.ma@gmail.com>
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
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Tested-by: Lubomir Rintel <lkundrak@v3.sk>
---

v4:
 * Add received tags

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

 arch/arm/mach-mmp/time.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index c65cfc1ad99b..049a65f47b42 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -175,13 +175,6 @@ static void __init timer_config(void)
 	__raw_writel(0x2, mmp_timer_base + TMR_CER);
 }
 
-static struct irqaction timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= timer_interrupt,
-	.dev_id		= &ckevt,
-};
-
 void __init mmp_timer_init(int irq, unsigned long rate)
 {
 	timer_config();
@@ -190,7 +183,9 @@ void __init mmp_timer_init(int irq, unsigned long rate)
 
 	ckevt.cpumask = cpumask_of(0);
 
-	setup_irq(irq, &timer_irq);
+	if (request_irq(irq, timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			"timer", &ckevt))
+		pr_err("Failed to request irq %d (timer)\n", irq);
 
 	clocksource_register_hz(&cksrc, rate);
 	clockevents_config_and_register(&ckevt, rate, MIN_DELTA, MAX_DELTA);
-- 
2.25.1

