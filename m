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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD10BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A045820661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEXsZOns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBLIDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:03:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35579 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgBLIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:03:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id y73so847720pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ECVgvgHFKNpFfK3tEgc2bceIocAVUdU7DE70DEQvQUU=;
        b=nEXsZOnsZ7JEkTVePqQYvtvHeA9oDHxSCnxk/xyxIUqftq+ukqj2a9QCXdWAxRlxJm
         mAQW7ysw9fg3r7TTeQZhlR6qBjlSB6fUeiuKx2IMgICmp2HVgovQ77rW3L7NEikLtKr2
         /a1YNtGKop3d03I2IDh+VDWszT1pysthd/uu1GClbKy3WjJ08P0Al3ZzBho1B83C5vtl
         EyWEJdWv4FlAPmoas2+9L337wYdE9R+SQzvzTFcqg5bLHW9LNWcIbvHqcfJvcnMRE40l
         O11Y+W//f/L4dgBOhJ+/4xpOogdgqXUR+YcA5J72Jy2dLa7h8lK1sAXFm6JfBh1w3QRn
         qQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ECVgvgHFKNpFfK3tEgc2bceIocAVUdU7DE70DEQvQUU=;
        b=Mx6u0FinM1yzNLgognOvR2TBYir1fWKpgn0rXzSgYGah+j8h8733azZOFVQaLoIPVg
         sSWYNwSGTK0hlhVGiC+F++kgz8KTUphmm2zR8O/4ja2uwFgafy03fvdicY5ksgVlf8g/
         QBAz/sXEzKxlkWoGdQdgMeqxHYDPwdMS3N3H29bL8aISvwpQpRZdEdBHDStWgNjf6zxK
         w8NXnLT/3yem3HK5xwKxBB9xbFblDxuG/UUCbJeOSd7eg7263KpYhD0zOSRgg2gyl5Gp
         Dzh+iSgySn5/mbyq4xJ5ia5ZA2Nbj3oiyFs5otQ5a1N39NiiM1vb74QiNj2/Mo4MHGaI
         3QKA==
X-Gm-Message-State: APjAAAVrJC2QSjKIGdI4QXGCB0GOOj2gjQGW11YtCcQfiCCo0nIzutsv
        c9sG+J+Kg9AEEz9L3EYnd613gIXEFQ4=
X-Google-Smtp-Source: APXvYqwLGvY+eW5Xpxhw0kmtoyAu5P45eLVAIEMi0q8HFj9p3L2uPUit8HIChSIAdWgt2aMJ/zeMmA==
X-Received: by 2002:aa7:8654:: with SMTP id a20mr7267615pfo.88.1581494627173;
        Wed, 12 Feb 2020 00:03:47 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id b98sm5916627pjc.16.2020.02.12.00.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:03:46 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:33:45 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Simek <monstr@monstr.eu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/18] microblaze: Replace setup_irq() by request_irq()
Message-ID: <94d816d0a2462d748b677c05fb56d18b65e32dbc.1581478324.git.afzal.mohd.ma@gmail.com>
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

 arch/microblaze/kernel/timer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index a6683484b3a1..f8832cf49384 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -161,13 +161,6 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction timer_irqaction = {
-	.handler = timer_interrupt,
-	.flags = IRQF_TIMER,
-	.name = "timer",
-	.dev_id = &clockevent_xilinx_timer,
-};
-
 static __init int xilinx_clockevent_init(void)
 {
 	clockevent_xilinx_timer.mult =
@@ -309,7 +302,8 @@ static int __init xilinx_timer_init(struct device_node *timer)
 
 	freq_div_hz = timer_clock_freq / HZ;
 
-	ret = setup_irq(irq, &timer_irqaction);
+	ret = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer",
+			  &clockevent_xilinx_timer);
 	if (ret) {
 		pr_err("Failed to setup IRQ");
 		return ret;
-- 
2.24.1

