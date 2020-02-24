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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5274C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7943206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miOEcLxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgBXAtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:49:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38220 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgBXAtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:49:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so4225364pgn.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 16:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aF2z8+E0AwYI5qjyMhAQIkKUTThSQyGv129oA05SnGM=;
        b=miOEcLxQCYxHHwgKXBkzt7cOJoZ9yVJPPnFMYemYVT8SQNxK9vvqxphw46vVxMtp1i
         jxRZR3dnVEmjsBvqIWb4k+jenwLh9dZmkV8ej87DehLHyVfY59jcg1duFhqqq/pqYazT
         nPsHI2fN1vDPCEOj0FwAAre31Igfv+h/OysQAOJwM5IW6jtufta2Jzkz9vR+sNeK0qjA
         c8AQWUfRq9KXFbr9EY6Y8RyPLuRU33TKUm82cdZuqjwVevkvFOS3ItfxJUixrAne0SDI
         BLHEiTdN9USkzafMFgRI/LWYsQ4B5DCTYR3oN2ba+UML+a/N1f6DLIqxyWKMmkctKQP6
         k7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aF2z8+E0AwYI5qjyMhAQIkKUTThSQyGv129oA05SnGM=;
        b=H2GxSLCxaSCWCPw5HbZsBPVUnQCCTLr9Vr1iBoiwwrIbGZYJTZiyXEp83wNTUVbOUf
         G75lFuI7+JPpPtA46krVqJg3shTpozVZdE/sz5egtPpNyJPnHwUk/8enaYEVIM45t+vF
         +evTf+UBa2ndWT1PcYq00r+gpJoQF2YPaXzQquZ/Kw15NNHUpTeMSM76eBqbyQ/OttlJ
         wMHWAyNMnIAHzdbJo+9Lt+fPFa+7Rh4ZMibK1ki61v7oF7jhQl7EY6EmmF8K4S8OZuWn
         mEWc7Vkp93IF/VoArmvzcliQ14b40cso/QET7KwBcqM9Db09OMpC7ZN9s1Z055nDnnL7
         bJww==
X-Gm-Message-State: APjAAAWmqFHVMfRKmufvarBE4XWlW10MFzQV4NRo78RO0EaZquD0WGJ/
        1yfruwjUYJkJlgGbMgRqQjo=
X-Google-Smtp-Source: APXvYqwwU6sHnHzzLXspnyy9Mph+6wFHb6IW+Ko8XPW+LYSiGmC5VO3IWe7DJ8B18A3K/N81t9vwTw==
X-Received: by 2002:a62:1c95:: with SMTP id c143mr47345462pfc.219.1582505362707;
        Sun, 23 Feb 2020 16:49:22 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id f81sm10244442pfa.118.2020.02.23.16.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:49:22 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:19:20 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>
Subject: [PATCH v2 03/18] c6x: replace setup_irq() by request_irq()
Message-ID: <c29bc4f5627b9df376f5f5a622f5c3cc5cd6f400.1582471508.git.afzal.mohd.ma@gmail.com>
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
Acked-by: Mark Salter <msalter@redhat.com>
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/c6x/platforms/timer64.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/platforms/timer64.c b/arch/c6x/platforms/timer64.c
index d98d94303498..0b8c47bc16ce 100644
--- a/arch/c6x/platforms/timer64.c
+++ b/arch/c6x/platforms/timer64.c
@@ -165,13 +165,6 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction timer_iact = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER,
-	.handler	= timer_interrupt,
-	.dev_id		= &t64_clockevent_device,
-};
-
 void __init timer64_init(void)
 {
 	struct clock_event_device *cd = &t64_clockevent_device;
@@ -238,7 +231,9 @@ void __init timer64_init(void)
 	cd->cpumask		= cpumask_of(smp_processor_id());
 
 	clockevents_register_device(cd);
-	setup_irq(cd->irq, &timer_iact);
+	if (request_irq(cd->irq, timer_interrupt, IRQF_TIMER, "timer",
+			&t64_clockevent_device))
+		pr_err("%s: request_irq() failed\n", "timer");
 
 out:
 	of_node_put(np);
-- 
2.25.1

