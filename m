Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22B6C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B591D2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIA92C3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgC0Mod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:44:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44594 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgC0Mod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:44:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id 142so4511657pgf.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OrmCqFezly2Rfxgtc8/QFu/0W5F3zvpkrW43juhNMPA=;
        b=GIA92C3GyqkFnDX8sA9Rknn8fwTnET1ETunHwCgySE9vDZlgyPZM1GTEDiX4Ed9drc
         YH4plfCR6mDkoPfE0nOfFfGPjfLT+W2/okVZ5EhQ+LPZD+3k3spQS23pLTXBiYuvPVjx
         o87eiA3EwHWieUIzUz0Xe1Up70BMgfdBO+fHkji+RKnEtXlrpr8/rOeK064Y/AmaDTya
         RcA9Vm3DNDRleceqduZA8aNk0u38lr/33qFn8a+ay0hVHF40ghOEWJqr4PkbpBpSavrW
         ZKpgwHZ525bKABBbRN8QEulmTk7qyiRpqA+dN3IRCfA+WZ+NBdJSPtEJ3DFpcz4HCpN+
         r5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OrmCqFezly2Rfxgtc8/QFu/0W5F3zvpkrW43juhNMPA=;
        b=aT0cPuGu7rTEry4csGBISds2tpzYUJ9qVekkwUiIGwJt6Q/EZUGt5kcRjohihCz5Vy
         yPoKDFoLqktmfVSRi9UK09Hy3OCVXKBrM9fLCo4Z/U2YeRaBx30wkVd3Uz33Dl03VuwR
         XJm6fdotPxegQVMYR87daTh1OqUUl0spKdYjEaJT1o1IWiOfgPhoeRjY6TjOzQR2xoUH
         NAtULEiAS8BW7cz2Fe9VoOp9Xu8cy5B/bNZtebGHL99SlmkGtamu1DOMPdoEq29sTVzP
         l2gdEG0NaBbV5ddfn/Ea65BdJ470VaPnPByoD1XdKQPovWSDziO7LpuWjNyJXrAxZOCY
         +6VA==
X-Gm-Message-State: ANhLgQ3iw+uNfxK3H2+pn6fvpAR5+J8XzBZncrC4nM6TryddsD3HAZdJ
        1izEB+96KAfhu+aGKp8kp3U=
X-Google-Smtp-Source: ADFU+vv89RkFVcocDRn4TLjad8m0Ax5S8FfzmE4pizTzzOO9MsncIbmfrgyhAIrDyE9xef9gEK/Cfg==
X-Received: by 2002:a62:6503:: with SMTP id z3mr14798534pfb.232.1585313070409;
        Fri, 27 Mar 2020 05:44:30 -0700 (PDT)
Received: from localhost.localdomain ([49.207.51.33])
        by smtp.gmail.com with ESMTPSA id u129sm4070380pfb.101.2020.03.27.05.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:44:29 -0700 (PDT)
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
Subject: [PATCH v4 3/5] ARM: cns3xxx: replace setup_irq() by request_irq()
Date:   Fri, 27 Mar 2020 18:14:22 +0530
Message-Id: <20200327124422.4181-1-afzal.mohd.ma@gmail.com>
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
Acked-by: Krzysztof Halasa <khalasa@piap.pl>
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

 arch/arm/mach-cns3xxx/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 1d61a7701c11..e4f4b20b83a2 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -189,12 +189,6 @@ static irqreturn_t cns3xxx_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction cns3xxx_timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= cns3xxx_timer_interrupt,
-};
-
 /*
  * Set up the clock source and clock events devices
  */
@@ -245,7 +239,9 @@ static void __init __cns3xxx_timer_init(unsigned int timer_irq)
 	writel(val, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
 
 	/* Make irqs happen for the system timer */
-	setup_irq(timer_irq, &cns3xxx_timer_irq);
+	if (request_irq(timer_irq, cns3xxx_timer_interrupt,
+			IRQF_TIMER | IRQF_IRQPOLL, "timer", NULL))
+		pr_err("Failed to request irq %d (timer)\n", timer_irq);
 
 	cns3xxx_clockevents_init(timer_irq);
 }
-- 
2.25.1

