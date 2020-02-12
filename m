Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB40C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6174C20661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExSIDJO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgBLIC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:02:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39540 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgBLIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:02:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so652956plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eMeroIQpVgDNum8GBYidkDcorT6ibKCN4TxxfUjFMok=;
        b=ExSIDJO1qrm9VO5FQEo1MS7s2qYq3lKuT07ObCm/iFQBalKNWqIQcvCvUcPo+nokK9
         g4G1qnQqhpmUyhTGs3X1bgXKEe2gn1R6wdIIpvRDMQx0GsSBydP56uABb7MX/2geUJp0
         v71aT+nTZoPMs0I2uCUaCmk4oWy/jFwmngTmErYfo6RjzpdpWMLaTAxQhrM/Nz+4wfVn
         ZnXKf59UYTZm6vZCygRAvdZbOcgti1Sxc1B9Gs5Yx0Vx7XUsEp4AecmWJ3iJ17/mdlW4
         uoJpxzSTOv99jR6ZZY9aY0GoBUKDbUFDvIiUCKPZumKtnzJEZ4aPomfLI+KKgWnW4Msb
         LpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eMeroIQpVgDNum8GBYidkDcorT6ibKCN4TxxfUjFMok=;
        b=s/Y1BuPXQWn1KJwMZi8wZje5tB6CI7OWjsama5u0C3enNKe86IZLGiZSkEivmLboaT
         LxWvXdMx+NsxFgjiulPl8qpgrIUibpMxjZqMl1kay2IDDcdhLFIwSpj5e3ql27Ql/ewm
         ti1Ou0MTAk5H6jJbq18t3rq9BwfODTEbJ3jG82JfWOcGjjkh6PWzrtz+raBqFS9np0xD
         +0c7eatWCX9R82aYf9CCnDAOahvoQ+WdqWXn8q+ZVNckhkUt+pZ3IOq2f3MzcjRGEs+z
         uYjG9aKfQ9oNZTnvlhxymzoznCnEN6jgDCQWtQIF1qqADghSy4TKcFh7kZA5uLmD5bPl
         cHAw==
X-Gm-Message-State: APjAAAVQ4mcQDPFmHUNze1qo1XNRlVgCbdj6eN0HcJOCD+CJ29V0D44b
        QuSlJu8anr6KpsTNfQ6kx0RMyJvxKOc=
X-Google-Smtp-Source: APXvYqyIgHOsLXA1A3E4M+vgtk9GkKSV8MiZqdqgmr18zJJcrybvyhYFz0oZY7/HTGDHwYWkz/VCBA==
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr7022732pls.262.1581494576960;
        Wed, 12 Feb 2020 00:02:56 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id iq22sm6061520pjb.9.2020.02.12.00.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:02:56 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:32:54 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>
Subject: [PATCH 03/18] c6x: replace setup_irq() by request_irq()
Message-ID: <11cbe657937077b56bd28d277c9b9455a6985501.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/c6x/platforms/timer64.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/platforms/timer64.c b/arch/c6x/platforms/timer64.c
index d98d94303498..ceee34c51d4b 100644
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
+		pr_err("request_irq() on %s failed\n", "timer");
 
 out:
 	of_node_put(np);
-- 
2.24.1

