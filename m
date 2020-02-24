Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F22CC35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE9A20727
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8OjjWWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgBXAwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:52:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44980 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgBXAwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:52:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id a14so3835640pgb.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 16:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=of4f6PCXhm2TZjWzLEPyHqZGybs1An/e7D6Lh/EnIpg=;
        b=d8OjjWWqo/QcvrMXdxU7tGnaoAiuNURummvkToW0TZBmzZ9G5hgHE9NTwZWSDCkbvs
         Qw4I4QSFMSg/yzU86189CSFT5lthYd//WpBHDRU3YYNGbOShAspdhQzxqEkGRHZVyJgM
         RYJQBL/ykSNiZZEGhCxEO28cRlWCKaQ6W4UuXAS/PyH2iIycmXouD78QOi80VBNCftHV
         iiF01nkbJzJpc5umDEymr8sFIu0edQqvg/ZDrpw/PVysUlbQl4/8botrQhNESCMCnoEd
         7om0LmolkkZxzwZtOP0UascZDSqbSoX1kKZkD44oEgXoobCjIdrEBjFGGxJTxpPAHcqG
         +WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=of4f6PCXhm2TZjWzLEPyHqZGybs1An/e7D6Lh/EnIpg=;
        b=fF4tMPGxZSSZhv6+mRmoLIoXhSz6elO2Qdn/ieboSKyuwI0EFcX+bj3JzK+1ekG72L
         tS2JuZch1CwjJ0TDmeUvFUZg1QUdW2tv9ZDOMV08mzUHNLCHKBBVNauS6SZf7SMVjNNa
         eCEzP6NyH3dqrfD3ip8n7gvuyFH0KNbLRZRIszt5+r+guX12GQwnyYD5dDkUhDhek8j0
         hZJiY8P1mlXph1rXDUc0WzIU5NvBgEw6y3nb8DFsA24YL4bPTOZcxGIp2rGKDhN35u8e
         aQaGdpdM70wqvhLzhSxVlks+SOVmgbhcwuaMxDxNus85IgzRwvX/mt9Q41shm5A7zaQ5
         gHjw==
X-Gm-Message-State: APjAAAWTVpx67YCxd4+ddxFl6Nxuj2J1aslMA1hkN853tfUYZw0FMXtI
        tcRfJloWjuSVcTdG5qC23VEDv1MeIlw=
X-Google-Smtp-Source: APXvYqx9xIM/JGdZMiluf9CTMtOGuK/jMiMK/DNvHlV1fXYqeQO+ueIaSAHdoIQ1Yy8nXMeZuOxJ0g==
X-Received: by 2002:aa7:8f0d:: with SMTP id x13mr50022739pfr.61.1582505533305;
        Sun, 23 Feb 2020 16:52:13 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id p18sm13612012pjo.3.2020.02.23.16.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:52:12 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:22:10 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guan Xuetao <gxt@pku.edu.cn>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 13/18] unicore32: replace setup_irq() by request_irq()
Message-ID: <59112552df99ee7263663b9c474d306a9847fe30.1582471508.git.afzal.mohd.ma@gmail.com>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). The early boot setup_irq()
invocations happen either via 'init_IRQ()' or 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/unicore32/kernel/time.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/unicore32/kernel/time.c b/arch/unicore32/kernel/time.c
index 8b217a761bf0..f69a2244ebd6 100644
--- a/arch/unicore32/kernel/time.c
+++ b/arch/unicore32/kernel/time.c
@@ -72,13 +72,6 @@ static struct clocksource cksrc_puv3_oscr = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static struct irqaction puv3_timer_irq = {
-	.name		= "ost0",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= puv3_ost0_interrupt,
-	.dev_id		= &ckevt_puv3_osmr0,
-};
-
 void __init time_init(void)
 {
 	writel(0, OST_OIER);		/* disable any timer interrupts */
@@ -94,7 +87,9 @@ void __init time_init(void)
 	ckevt_puv3_osmr0.min_delta_ticks = MIN_OSCR_DELTA * 2;
 	ckevt_puv3_osmr0.cpumask = cpumask_of(0);
 
-	setup_irq(IRQ_TIMER0, &puv3_timer_irq);
+	if (request_irq(IRQ_TIMER0, puv3_ost0_interrupt,
+			IRQF_TIMER | IRQF_IRQPOLL, "ost0", &ckevt_puv3_osmr0))
+		pr_err("%s: request_irq() failed\n", "ost0");
 
 	clocksource_register_hz(&cksrc_puv3_oscr, CLOCK_TICK_RATE);
 	clockevents_register_device(&ckevt_puv3_osmr0);
-- 
2.25.1

