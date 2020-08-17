Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F49C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F1A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZKT/oHgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHQN5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgHQN5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:57:39 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A1C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 06:57:39 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id x2so3541950vkd.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdKYrohN8OlGDXEszWS+Ec7t39VpiibXfsuU/BXESmU=;
        b=ZKT/oHgXJeLaz2zSrpCOpcciOR4Mu1pqaSQj+Y449pXWXd5zG14b92RWlkzZCxWBO7
         yME6N7qJVHxW7bemEEpv63eiFnQiLjA0UKyEvL6CwHme89gvtDcenUq5X9ku6kYABH4m
         ad78O5beq8PPyCpELu1KKVgY+uZ0KpO9XYRLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdKYrohN8OlGDXEszWS+Ec7t39VpiibXfsuU/BXESmU=;
        b=kHVOLKJukQOyP6/53lLCd4o4DtGkgIGLuxPIvkIDbisrL2xB+ifkbr7ADi5p2/jkP2
         Y5uxa/NARB9qePBBGUi7+NClxIVlvEYgpt7STPjUqBr5HuzCZM61AcQjc02cjnOVJ62X
         uMaiUwub49FJ0RoJqP7PLW2IysqSSd6H88H64KSvyB4GC4zzE7ftNRfZLVKp/JXuQOUt
         Zt5h/WE1qhSvtL4NvAoHb3Cl8E4HuJlVqNTFgGm1oFSns/KSjeja3M7NEsXimgevuVkl
         ujpV5ddmwQYzrR2tl4/QHO2rNPdHGns8aJj8RdWKpaWhJfAQ7STmZQaa4nG9Qzxp29XG
         bUng==
X-Gm-Message-State: AOAM533kOJkWEUPjnk1yuRXId4xqP9ga1wrOSCbxYLynVFxz6AbupxRL
        f/PUiS1ai2euazGu+mlO5WOZgTN0snrt1Q==
X-Google-Smtp-Source: ABdhPJzK73CNAqxzr0x2/nId4hP+Z28X6MSHJSc6YUp3sLnMBv1ZTRDpjtWFy/vHCXm0a8LwtYkgOw==
X-Received: by 2002:a1f:a094:: with SMTP id j142mr8008466vke.7.1597672655950;
        Mon, 17 Aug 2020 06:57:35 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id x25sm2629655ual.2.2020.08.17.06.57.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:57:34 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id o184so8307226vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 06:57:34 -0700 (PDT)
X-Received: by 2002:a67:fd67:: with SMTP id h7mr7276952vsa.121.1597672654168;
 Mon, 17 Aug 2020 06:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org> <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
 <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
 <20200814141322.lffebtamfjt2qrym@holly.lan> <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
In-Reply-To: <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Aug 2020 06:57:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WiZi18zBwx9J0sKLdCqMCvxuQ=U0m21yNqhtaBfZEqzA@mail.gmail.com>
Message-ID: <CAD=FV=WiZi18zBwx9J0sKLdCqMCvxuQ=U0m21yNqhtaBfZEqzA@mail.gmail.com>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial drivers
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 17, 2020 at 5:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Thanks for your suggestion, irq_work_schedule() looked even better
> without any overhead, see below:
>
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 3082378..1eade89 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_IRQ_WORK_H
>
>  #include <linux/smp_types.h>
> +#include <linux/workqueue.h>
>
>  /*
>   * An entry can be in one of four states:
> @@ -24,6 +25,11 @@ struct irq_work {
>         void (*func)(struct irq_work *);
>  };
>
> +struct irq_work_schedule {
> +       struct irq_work work;
> +       struct work_struct *sched_work;
> +};
> +
>  static inline
>  void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
>  {
>  {
> @@ -39,6 +45,7 @@ void init_irq_work(struct irq_work *work, void
> (*func)(struct irq_work *))
>
>  bool irq_work_queue(struct irq_work *work);
>  bool irq_work_queue_on(struct irq_work *work, int cpu);
> +bool irq_work_schedule(struct work_struct *sched_work);
>
>  void irq_work_tick(void);
>  void irq_work_sync(struct irq_work *work);
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index eca8396..3880316 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -24,6 +24,8 @@
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
>
> +static struct irq_work_schedule irq_work_sched;
> +
>  /*
>   * Claim the entry so that no one else will poke at it.
>   */
> @@ -79,6 +81,25 @@ bool irq_work_queue(struct irq_work *work)
>  }
>  EXPORT_SYMBOL_GPL(irq_work_queue);
>
> +static void irq_work_schedule_fn(struct irq_work *work)
> +{
> +       struct irq_work_schedule *irq_work_sched =
> +               container_of(work, struct irq_work_schedule, work);
> +
> +       if (irq_work_sched->sched_work)
> +               schedule_work(irq_work_sched->sched_work);
> +}
> +
> +/* Schedule work via irq work queue */
> +bool irq_work_schedule(struct work_struct *sched_work)
> +{
> +       init_irq_work(&irq_work_sched.work, irq_work_schedule_fn);
> +       irq_work_sched.sched_work = sched_work;
> +
> +       return irq_work_queue(&irq_work_sched.work);
> +}
> +EXPORT_SYMBOL_GPL(irq_work_schedule);

Wait, howzat work?  There's a single global variable that you stash
the "sched_work" into with no locking?  What if two people schedule
work at the same time?

-Doug
