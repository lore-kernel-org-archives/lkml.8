Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F5DC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7E820716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFy95hPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgC0QJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:09:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36277 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgC0QJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:09:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so3621108plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTxI/vmh7H8psD5zaF9jAeQPznpJVnF6SqRKJaDJ+ks=;
        b=fFy95hPWrJfvZ3Lque6nIPsxfKs0aHjKz2gkg3eZnac5pJTyjhCyNfpEgTa2VyGCPc
         Udgh6NwWcOdvnXuWNOubNLIwZoXPVgcO/Jmmv6jIjvvQQj9IauI0bWPztzstPC2S8oDh
         DdjdEmeRCZwJjMqEK5HB95iRPnr0wrQ/N6XF1T/sfW+2iLCD0dgPIY8VRpAJaiy6kKl1
         aAm3rJwyTkYfefXViJ4pYJyj12BiicZGcJSleDnRJWWP0JCY9Yubpb2pFb1r5nl8fWCf
         xV98byxx7KFwWHgpPlr4bJM6AtWBsvoQ/9JHLbzEzcy4LLX69K4wKXmxiHIbjQetrWja
         aLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTxI/vmh7H8psD5zaF9jAeQPznpJVnF6SqRKJaDJ+ks=;
        b=NRYwuZTAy+CrHG8isqkMuI0cBRqLzXCfeIo6vy1qSe4IJTSanIJiKlRbvSKHaMEYuy
         d97HvuVizdibJynNGEnZisgU03wbHgj7KsUY1sBzY7nrjxSADrcYivEEGPzktqL+iL+A
         ZYIWE4KQ0Meym1lAdBP3g6/+16vCHx4udiyt9Mdsp06eyHZ+XmORtraaO1wS5UGvBUyA
         +1pZUlirdq03k7P6wJrBWYDmuuEUhCGqFbn0AQnKdHf0oRIVVS6Eh/XsnbUbQrlshTZc
         lNPGBjNuFygxZtEIN92WoZs3QdpoKiO1+fGXE5J5PSfZO+cge48vNx0PKYQBzrkHnQmZ
         A30w==
X-Gm-Message-State: ANhLgQ1ojecs62mR6ImOL7QB0LLbL3xv5RNP2uqUc8kJRi/ngP4Acsn0
        k6SfUMBOedF/Rxvw8kQQcFY=
X-Google-Smtp-Source: ADFU+vuwwqvSXZqXsarIhQFTkxUNP9dT0yJPIDweKZX4m/IfsxbgmDPlKTpvk3ewS1TVqwTAYezvGA==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr14307042plt.35.1585325374377;
        Fri, 27 Mar 2020 09:09:34 -0700 (PDT)
Received: from localhost ([49.207.55.57])
        by smtp.gmail.com with ESMTPSA id i14sm4176480pgh.47.2020.03.27.09.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 09:09:33 -0700 (PDT)
Date:   Fri, 27 Mar 2020 21:39:32 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Subject: [PATCH v5 2/6] c6x: replace setup_irq() by request_irq()
Message-ID: <56e991e920ce5806771fab892574cba89a3d413f.1585320721.git.afzal.mohd.ma@gmail.com>
References: <20200321174303.GA7930@afzalpc>
 <cover.1585320721.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585320721.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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

Link to v3, v2 & v1,
[v3] https://lkml.kernel.org/r/20200304004143.3960-1-afzal.mohd.ma@gmail.com
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v5:
 * No change
v4:
 * Non-existent
v3:
 * Split out from tree wide series, as Thomas suggested to get it thr'
	respective maintainers
 * Modify pr_err displayed in case of error
 * Re-arrange code & choose pr_err args as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/c6x/platforms/timer64.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/platforms/timer64.c b/arch/c6x/platforms/timer64.c
index d98d94303498..661f4c7c6ef6 100644
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
+		pr_err("Failed to request irq %d (timer)\n", cd->irq);
 
 out:
 	of_node_put(np);
-- 
2.25.1

