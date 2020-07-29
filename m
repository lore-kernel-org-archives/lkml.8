Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C814120829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RVbqy5eC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TY7G6j9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgG2Mrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:47:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41954 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2Mrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:47:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596026864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Y4OYJjMYjInJLB1x6yEBhHYOFD16/ZaJSmb+RhIU0M=;
        b=RVbqy5eC4PwZaaRSgNqGSgtHJQ2yeiVdg0mEVDFNu58vzZth0z6smn3YI/UMkNF0Bf/zLn
        k84LQwPQk/QowMtkDA6r9G+AWc50TNqiXiDJIWtvsw360zH+kHm4CFcT5lKcVG9thXgxEU
        4ak7RjuLA4qBYBkzrvi6qE7XQv7Vf+ehksZhq3J2cdJnCuV9Uq5cpzVI1xHUhEDuoP3emv
        MBPVqeunOHBUpgbrw6FdjE0zqA22bjKl9pWdIfE62nUd0Lxy6N/3/zzMfwYWZsOsk3rKVp
        W9R2xLufCleWmI/QrYNnnE6w7i/gUx2qYowd0NXfGR2z5jIQHaUMquWtfZhFqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596026864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Y4OYJjMYjInJLB1x6yEBhHYOFD16/ZaJSmb+RhIU0M=;
        b=TY7G6j9sy+5xSGtSerCIPtawKzENIPukrBXD8fxzA3Js2rnzn4xUNlmiA7jKVUDnDL3WKW
        eptM1hjQxdi4fwAQ==
To:     Freddy Hsin <freddy.hsin@mediatek.com>,
        linux-mediatek@lists.infradead.or,
        linux-arm-kernel@lists.infradead.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks \(Codethink\)" <ben.dooks@codethink.co.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, chang-an.chen@mediatek.com,
        Baolin Wang <baolin.wang7@gmail.com>,
        wsd_upstream@mediatek.com, kuohong.wang@mediatek.com,
        stanley.chu@mediatek.com, Freddy Hsin <freddy.hsin@mediatek.com>
Subject: Re: [PATCH v1 1/2] kernel: time: export sched_clock_register function
In-Reply-To: <1595931377-21627-2-git-send-email-freddy.hsin@mediatek.com>
References: <1595931377-21627-1-git-send-email-freddy.hsin@mediatek.com> <1595931377-21627-2-git-send-email-freddy.hsin@mediatek.com>
Date:   Wed, 29 Jul 2020 14:47:43 +0200
Message-ID: <87pn8ea3o0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freddy,

Freddy Hsin <freddy.hsin@mediatek.com> writes:

please do not come up with random prefixes. Just look at the topmost two
commits on that file:

2c8bd58812ee ("time/sched_clock: Expire timer in hardirq context")
2707745533d6 ("time/sched_clock: Disable interrupts in sched_clock_register()")

Also the sentence after the colon starts with an uppercase letter.

Please change 'sched_clock_register function' to
'sched_clock_register()' which makes it clear that this is a function

> export sched_clock_register function, because the Mediatek timer
> loadable module depends on this function

Again sentences start with an uppercase letter. Also the reason for
exporting this is wrong. There is no mediatek timer module now.

The point of exporting this (if at all) is that it's required for any
ARM SoC timer driver to be modularized.
> @@ -239,6 +239,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
>  
>  	pr_debug("Registered %pS as sched_clock source\n", read);
>  }
> +EXPORT_SYMBOL(sched_clock_register);

EXPORT_SYMBOL_GPL() please.

Thanks,

        tglx
