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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC84C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73983206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcgaZIpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBXAuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:50:39 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35844 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXAuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:50:39 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv17so3402245pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 16:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bRs/6UurSkQmTd0HvCFOeF6FqxH77Vxv+5Td3VByxMw=;
        b=VcgaZIpkCWIJefUSsYN8uyJzslMdOWTew8X/TECGf7x9xHM1ZMhmj95lZVevynOyL8
         QBtCLZm4tFAd4Xim4kuO5MKGJCZ7Pd1r2EA5jlzTHWM7pZ8QO6vYyykAkCqpBedNCwwE
         bhNzrfVMRR4bTNek/538WwCj5iPqdTR+rFaUby86nOh+wdd8C+ubkx0Uy22t1Z8/WSsy
         5+U/LdVc2ycjrQYHrfz9dEcb0ILfFUzbrm/SMpOcxxehc2qDdqcJtWGvi9yVzwNvLEHy
         DO1vsQdCwc1AK1Tjo8z4a8C9ysOsCT8WVGP1iXyx3MarwRljwpwSvUndz+oYZ20pdLke
         CvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bRs/6UurSkQmTd0HvCFOeF6FqxH77Vxv+5Td3VByxMw=;
        b=MODu/8gpXCEaChGZVYI/2PvGWRgVHpQvNa0ndFqiYQphPfWXjimfp7IkfhaDKUuuJS
         NOQDdK7QraHE+w1MetUwyOpmCb5O8ANc3Abe1mAHtIhBFf2xQZM1xDBD2zKIu8wmBdko
         ppPiG40AlMgDE4NWihOPGYC6W2oZYsr/cXf7HwPtK9tO1D7VDGf35FjfYTKciuNYL+T6
         DjUEHrlrkmjCncAatdt+H1iAkKCfsmUcSiaecH1D9jIX/m68YAPy9M+gW7FGAqymYEfn
         bSNW+LzO9Kiy+zlPXCo2BTG+R2dQFdKufWwH8OeK4SZzlvx7dkav59s/L9136Ka//U4O
         oz9g==
X-Gm-Message-State: APjAAAV3r850GQ0Kgu4CCn48blN3EnOHl7OUJ5oTMuZ2TeQyikdZ+1Dz
        xg4gT4FyGB8Q79J5dNTffQED/ABECD4=
X-Google-Smtp-Source: APXvYqxrCcRbBpUsRlS0+h88J0qYXhhrDZm7fnwnt8y25xjjCEb63Ocz/pZnG15tLJa0PoMaperuGA==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr46131864pln.185.1582505438099;
        Sun, 23 Feb 2020 16:50:38 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id x21sm10053050pfn.164.2020.02.23.16.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:50:37 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:20:35 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Simek <monstr@monstr.eu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 07/18] microblaze: Replace setup_irq() by request_irq()
Message-ID: <2059d2aae0cf9dc2216540c8b0a3042f532dcaf4.1582471508.git.afzal.mohd.ma@gmail.com>
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
2.25.1

