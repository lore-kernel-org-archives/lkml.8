Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FBEC2BB55
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 02:56:08 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E973206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 02:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVgHrIm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E973206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgDMC4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgDMC4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 22:56:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C75C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 19:56:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h25so7358049lja.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 19:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYNMycTvlJ2EV1Lo7lvdVTGrDHdMYyiEd3JD336Xl10=;
        b=BVgHrIm4GEcahLKxi/1EW1/6QdLDS4OKrZMEh1jiAFHC2C0B5FQxElY5m1u+LAZjF2
         JLnTIzS+UC7k7aUX2Q/PA8l11nnrAD6tfzo8WZcrC2a+Y1vY6m5qU+4IzoWsu3BoNF5t
         pvfpk2KS8cACHwvGElpYSZmL4IUaU/j3pIC038XNO622Ss7825ksr0rtPDLf6G/ZMq6P
         TYUqdFETXA6s6mK7hEUcOi0YH45jKTucf26EbFOEofbQ5TtYVhldRH+SPBipCTMsqaRI
         hgGJpNK6YScSa90fQZBBGj9iGKNJ2YQa4c5eNcKU/h8wysVrPdG6d6tnTKLl21tuMmZd
         Fiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYNMycTvlJ2EV1Lo7lvdVTGrDHdMYyiEd3JD336Xl10=;
        b=uE3mLzx1G8xw3QJA+8ObZ7QYzJZmN3ZolrqILKTpqyWG0gzdB+XobPFT3PAtaAC8x+
         UdQkDa6bl4fUmgYGThK7YF+fMbnI/6ZNCoHVpurBIhcBNOA4X+uvPYvPXJEh9GZPpBta
         Kl7TrGIrqJk72XUvta3JJLYXTuF6W9zWv06Xa65gYV/R2wf48Am7nPxyxlO8iKsfTKv7
         9HAojT3pFXlicwphZODPUjdPuN4TcRCBZJ4qcUHGPQVZnY5rMIITsTItFv0Z918aGr3v
         dVl+iz1kXb158Hdoc0+WuZMh//mMU6TmUQh5h8xwjG1+RxN3bjao2+RSZBx8yGEO4CMH
         xFhQ==
X-Gm-Message-State: AGi0PubY7kmQOcssQaRuFHfCpUBwLNUF03eWZuDs6B2MEBm3929mXA8P
        6VpJ/wqxdf0rU8nyP2rAKg7JkqVv7TXFxE8Nd7g=
X-Google-Smtp-Source: APiQypKHr/vr0Gpf89vhDp6ifCxufaNG+KZzBgq0wae4l5a7rNDXJ682W7fLztfPJsxKuuViIi2cRYtop8hlAWIWZQk=
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr9150089lji.110.1586746562594;
 Sun, 12 Apr 2020 19:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
In-Reply-To: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 13 Apr 2020 10:55:49 +0800
Message-ID: <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Mar 24, 2020 at 1:59 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> From: Saravana Kannan <saravanak@google.com>
>
> This allows timer drivers to be compiled as modules.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Do you have any comments for this patch set? Thanks.

> ---
>  drivers/clocksource/timer-of.c | 17 +++++++++--------
>  drivers/clocksource/timer-of.h |  4 ++--
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
> index 572da47..fd3b868 100644
> --- a/drivers/clocksource/timer-of.c
> +++ b/drivers/clocksource/timer-of.c
> @@ -19,7 +19,7 @@
>   *
>   * Free the irq resource
>   */
> -static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
> +static void timer_of_irq_exit(struct of_timer_irq *of_irq)
>  {
>         struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);
>
> @@ -47,7 +47,7 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
>   *
>   * Returns 0 on success, < 0 otherwise
>   */
> -static __init int timer_of_irq_init(struct device_node *np,
> +static int timer_of_irq_init(struct device_node *np,
>                                     struct of_timer_irq *of_irq)
>  {
>         int ret;
> @@ -91,7 +91,7 @@ static __init int timer_of_irq_init(struct device_node *np,
>   *
>   * Disables and releases the refcount on the clk
>   */
> -static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
> +static void timer_of_clk_exit(struct of_timer_clk *of_clk)
>  {
>         of_clk->rate = 0;
>         clk_disable_unprepare(of_clk->clk);
> @@ -107,7 +107,7 @@ static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
>   *
>   * Returns 0 on success, < 0 otherwise
>   */
> -static __init int timer_of_clk_init(struct device_node *np,
> +static int timer_of_clk_init(struct device_node *np,
>                                     struct of_timer_clk *of_clk)
>  {
>         int ret;
> @@ -146,12 +146,12 @@ static __init int timer_of_clk_init(struct device_node *np,
>         goto out;
>  }
>
> -static __init void timer_of_base_exit(struct of_timer_base *of_base)
> +static void timer_of_base_exit(struct of_timer_base *of_base)
>  {
>         iounmap(of_base->base);
>  }
>
> -static __init int timer_of_base_init(struct device_node *np,
> +static int timer_of_base_init(struct device_node *np,
>                                      struct of_timer_base *of_base)
>  {
>         of_base->base = of_base->name ?
> @@ -165,7 +165,7 @@ static __init int timer_of_base_init(struct device_node *np,
>         return 0;
>  }
>
> -int __init timer_of_init(struct device_node *np, struct timer_of *to)
> +int timer_of_init(struct device_node *np, struct timer_of *to)
>  {
>         int ret = -EINVAL;
>         int flags = 0;
> @@ -209,6 +209,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
>                 timer_of_base_exit(&to->of_base);
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(timer_of_init);
>
>  /**
>   * timer_of_cleanup - release timer_of ressources
> @@ -217,7 +218,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
>   * Release the ressources that has been used in timer_of_init().
>   * This function should be called in init error cases
>   */
> -void __init timer_of_cleanup(struct timer_of *to)
> +void timer_of_cleanup(struct timer_of *to)
>  {
>         if (to->flags & TIMER_OF_IRQ)
>                 timer_of_irq_exit(&to->of_irq);
> diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
> index a5478f3..1b8cfac5 100644
> --- a/drivers/clocksource/timer-of.h
> +++ b/drivers/clocksource/timer-of.h
> @@ -66,9 +66,9 @@ static inline unsigned long timer_of_period(struct timer_of *to)
>         return to->of_clk.period;
>  }
>
> -extern int __init timer_of_init(struct device_node *np,
> +extern int timer_of_init(struct device_node *np,
>                                 struct timer_of *to);
>
> -extern void __init timer_of_cleanup(struct timer_of *to);
> +extern void timer_of_cleanup(struct timer_of *to);
>
>  #endif
> --
> 1.9.1
>


-- 
Baolin Wang
