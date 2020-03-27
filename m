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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBA4C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B879206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2Otw0ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC0MoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:44:16 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52009 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0MoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:44:15 -0400
Received: by mail-pj1-f68.google.com with SMTP id w9so3809816pjh.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fsqy8TfQMOxnl1SbG7WxWf+f3gEqGelUnglQJSOP4Ds=;
        b=Q2Otw0ipFM9So8sggRAQgCgojzHVsLtIWn5ukWMxPAJdhOBRRO8zrGPlbCo0y2GA6f
         sfSVJRy6ndUByUc0Y3zWpTCLkaYG1RKjr/IHeNTv1R/Pb2gMLXbg9ioX4QgQHzRY5cps
         N3G1ayLdmVxwy4ZjqYlozMN1h34Utvi7fqBiojTRK0pIWMPWvGE0LkUWFA7kqgJuJxja
         rKlEgcXH3J6jBX59IpTWHjzmjQIIBmiyOt5i1v4tca9ZWxogZVM6CDRSdBnOmpGpFEth
         pjmUsrvDUdhO3Bv5CYeCGEspT8IqMcwpli64OnZGn6JM6hBdUYfCQ86yCN7labB76D8d
         c4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fsqy8TfQMOxnl1SbG7WxWf+f3gEqGelUnglQJSOP4Ds=;
        b=pbG3GJQqE3qYL1EJB0FcUBf/+6v2yI/eHbksT+APD9emzzHNIYzIBr2xmTy8VUtmC0
         1k8t0V6KRDBDnhX0QVvjvqPvZbKeplQLh9WDQlg4Pn+QL+JXSYsnPTBjLVNo7xO+MABX
         vahqybYMipIDbrTSuiRiHbBq+ELFqxIHkziZdf/1C2DZibxSa4O5sboRsSi1sP1ir7FN
         fIqFs4yToNKtEzOfrt58h+iPQS3wzkp7218Pa1wJSVe44glVmdRe4FTpVzZunTOnYCIR
         TAsN82SMi3JOUow9JY/XR2L5wgpZpJYc/zaLyhwtAEjWVjsmD7BmZ3Zai+NhisxSdha3
         punA==
X-Gm-Message-State: ANhLgQ2ngndMSf001UuLeeP4BDEYhgW6crCTxnxIBO0WugrRvle7hE0H
        2JM1/osKu04MV4UZgtvTlv4=
X-Google-Smtp-Source: ADFU+vsoujK+muRM6+KaBCVLLvd9JnFa4Q3MxDpF532ov0b1AY3yVciRuMclmYx+K3BcdM08YjVIlA==
X-Received: by 2002:a17:90a:1b22:: with SMTP id q31mr5878074pjq.109.1585313055028;
        Fri, 27 Mar 2020 05:44:15 -0700 (PDT)
Received: from localhost.localdomain ([49.207.51.33])
        by smtp.gmail.com with ESMTPSA id v26sm4056641pfn.51.2020.03.27.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:44:14 -0700 (PDT)
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
Subject: [PATCH v4 2/5] ARM: spear: replace setup_irq() by request_irq()
Date:   Fri, 27 Mar 2020 18:14:06 +0530
Message-Id: <20200327124406.4123-1-afzal.mohd.ma@gmail.com>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

 arch/arm/mach-spear/time.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index 289e036c9c30..d1fdb6066f7b 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -181,12 +181,6 @@ static irqreturn_t spear_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction spear_timer_irq = {
-	.name = "timer",
-	.flags = IRQF_TIMER,
-	.handler = spear_timer_interrupt
-};
-
 static void __init spear_clockevent_init(int irq)
 {
 	u32 tick_rate;
@@ -201,7 +195,8 @@ static void __init spear_clockevent_init(int irq)
 
 	clockevents_config_and_register(&clkevt, tick_rate, 3, 0xfff0);
 
-	setup_irq(irq, &spear_timer_irq);
+	if (request_irq(irq, spear_timer_interrupt, IRQF_TIMER, "timer", NULL))
+		pr_err("Failed to request irq %d (timer)\n", irq);
 }
 
 static const struct of_device_id timer_of_match[] __initconst = {
-- 
2.25.1

