Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1ACC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B8F20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lLCWTSx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgCZVTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:19:14 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35417 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgCZVTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:19:13 -0400
Received: by mail-vk1-f194.google.com with SMTP id f17so1914721vkk.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLvF4D/A+305Z0Ss7OvyVOW8EKybx8dnVL63yLJQoSs=;
        b=lLCWTSx5UqSh1z9NnVQzYiYoMn4TP35oA4HiiZ2zg+gz1uWvA+MYB28BWMVb+myRlf
         yBDUSkf7M1bBlypo1Dyzj+oCK+e2sSTUs/746Hrfro3PhrXSHp+6Zqf8eO+3EisjzJVa
         zPwknJn2VhJeTHZuqGhS4nOxlhXGCopNoSS6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLvF4D/A+305Z0Ss7OvyVOW8EKybx8dnVL63yLJQoSs=;
        b=JJrmNCl0rhjWLeTZXSFu994s6+ZTrc6QlB9mSjE57vADtLX3DZe4FJgHjNMvCl3pvo
         SFzTQILeDdGXPfKdcHO6dKhCdoLYUgrWSKGrwtAvQbgWXYCkEqyPVaFbjbegOaFytrWP
         rf+BV/nalocnGx/aSLBA4FQjQF3STwybTsWqIGGfSuVe/LzFGY6ClTUEzHZncmo72zrn
         09vGk6APnn42SeyhWs0zdn77CyUhgu4tB9LRbLT9NP9HfEy2zcyt9sboln91P1pjOMsg
         x8MpMiZm+6rf1uPX5hdOJwllYYZJUigI3s2oDYViSVS6/lUq6ck98HH08/cujcydnc6C
         o9cQ==
X-Gm-Message-State: ANhLgQ3AzLN8R0eH+oUZr9XWPgR0yA27hi9aext8pqcnNJ80mNCbjYSa
        jCEDv0wTx2W6UftHWR9OCC1o4V2kEG0=
X-Google-Smtp-Source: ADFU+vtrHDEzcsalK/R3cREyGSV6Vb+xFpQSCUD0OL4qcdrkY5Z71+5ATfp4m7Yq2vi30z8Eoiv3OA==
X-Received: by 2002:a1f:6182:: with SMTP id v124mr8629948vkb.48.1585257550901;
        Thu, 26 Mar 2020 14:19:10 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id o24sm1770809vsl.11.2020.03.26.14.19.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 14:19:10 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id b5so4934831vsb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:19:09 -0700 (PDT)
X-Received: by 2002:a05:6102:3204:: with SMTP id r4mr8703099vsf.109.1585257549044;
 Thu, 26 Mar 2020 14:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <1585244270-637-1-git-send-email-mkshah@codeaurora.org> <1585244270-637-5-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1585244270-637-5-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Mar 2020 14:18:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQAbqitmYR7=5+AAL8pqy2imzEWf8BTkBoD6mthAwpKw@mail.gmail.com>
Message-ID: <CAD=FV=UQAbqitmYR7=5+AAL8pqy2imzEWf8BTkBoD6mthAwpKw@mail.gmail.com>
Subject: Re: [PATCH v14 4/6] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 26, 2020 at 10:38 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Add changes to invoke rpmh flush() from cpu pm notification.
> This is done when last cpu is entering power collapse and

s/when last/when the last/

> controller is not busy.

A few overall comments:

* CPU_PM certainly seems interesting and I wasn't aware of it.

* Your series is predicated on nobody calling any of the RPMH
functions after the last CPU enters low power mode with CPU_PM_ENTER
and before some CPU calls CPU_PM_EXIT.  Is it worth adding a check for
that to the code?  This is super important for the 'zero-active-TCS'
case but even for the 'some-active-TCS' it's still important that
nobody tries to update the sleep/wake values after you flush.

* I think your series is focused on idle, right?  What about
suspend/resume?  You need a flush before suspend, right?  Do you need
to register for something to handle suspend, or do the pm callbacks
all get called for full system suspend?  If so, how late do they get
called?


> Controller that do have 'HW solver' mode do not need to register

s/Controller/Controllers


> @@ -85,22 +85,30 @@ struct rpmh_ctrlr {
>   * Resource State Coordinator controller (RSC)
>   *
>   * @name:       controller identifier
> + * @base:       start address of the RSC's DRV registers
>   * @tcs_base:   start address of the TCS registers in this controller
>   * @id:         instance id in the controller (Direct Resource Voter)
>   * @num_tcs:    number of TCSes in this DRV
> + * @rsc_pm:     CPU PM notifier for controller
> + * @cpus_in_pc: CPU mask for cpus in idle power collapse

Name "cpus_entered_pm" to match Linux naming?  Also the comment should
clearly say that this is only used in non-solver mode.


>   * @tcs:        TCS groups
>   * @tcs_in_use: s/w state of the TCS
>   * @lock:       synchronize state of the controller
> + * @pm_lock:    synchronize during PM notifications

Comment should say that this is only for non-solver mode.


> @@ -521,6 +527,71 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
>         return tcs_ctrl_write(drv, msg);
>  }
>
> +/**
> + * rpmh_rsc_ctrlr_is_busy: Check if any of the AMCs are busy.
> + *
> + * @drv: The controller
> + *
> + * Returns True if the TCSes are engaged in handling requests, False otherwise.

This is almost, but not quite in kernel-doc syntax.  Why not make it
match the example in "Documentation/doc-guide/kernel-doc.rst"?
Specifically trying to follow that style:

 * rpmh_rsc_ctrlr_is_busy() - Check if any of the AMCs are busy.
 * @drv: The controller
 *
 * Return: true if TCSes are engaged in handling requests; else false


> +static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
> +{
> +       int m;
> +       struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
> +
> +       /**

nit: why double star in "/**"?  That's for kerneldoc comments.  I
don't think it makes sense here...


> +        * If we made an active request on a RSC that does not have a
> +        * dedicated TCS for active state use, then re-purposed wake TCSes
> +        * should be checked for not busy
> +        */
> +       if (!tcs->num_tcs)
> +               tcs = get_tcs_of_type(drv, WAKE_TCS);
> +
> +       for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> +               if (!tcs_is_free(drv, m))

As per my documentation patch, tcs_is_free():

 * Must be called with the drv->lock held or the tcs_lock for the TCS being
 * tested.

...I think you're OK calling without the lock since you're running on
the last CPU (and you're blocking any other CPUs from coming online)
and interrupts are disabled, but please document.


> +static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
> +                                   unsigned long action, void *v)
> +{
> +       struct rsc_drv *drv = container_of(nfb, struct rsc_drv, rsc_pm);
> +       unsigned long flags;
> +       int ret = NOTIFY_OK;
> +
> +       spin_lock_irqsave(&drv->pm_lock, flags);

nit: you can get away with just spin_lock().  cpu_pm_enter() is
documented to be called with interrupts already disabled so the
"irqsave" and "irqrestore" is useless.


> +       switch (action) {
> +       case CPU_PM_ENTER:
> +               cpumask_set_cpu(raw_smp_processor_id(), &drv->cpus_in_pc);
> +
> +               if (!cpumask_equal(&drv->cpus_in_pc, cpu_online_mask))

Is it ever possible to offline a CPU after doing "CPU_PM_ENTER" on it?
 If so you'll never be "equal" to the online mask again.  This seems
safer:

!cpumask_subset(cpu_online_mask, &drv->cpus_in_pc)


> +                       goto exit;
> +               break;
> +       case CPU_PM_ENTER_FAILED:
> +       case CPU_PM_EXIT:
> +               cpumask_clear_cpu(raw_smp_processor_id(), &drv->cpus_in_pc);
> +               goto exit;
> +       }
> +
> +       ret = rpmh_rsc_ctrlr_is_busy(drv);
> +       if (ret) {
> +               ret = NOTIFY_BAD;
> +               goto exit;
> +       }

Are you sure you can't just skip the call to rpmh_rsc_ctrlr_is_busy()?
 Specifically, I'm not sure why you need to block until the last
active mode transaction is done.

a) If the active mode transaction was on its own TCS, I'd hope that
the RPMH hardware would know to let the active transitions happen
before triggering the sleep (please confirm)

b) If the active mode transaction was borrowing the wake TCS the flush
should notice and return NOTIFY_BAD anyway.

Oh!  ...but looking closer at case b) points out a problem anyway.
You need to go into rpmh_flush() and stop having it loop on 'while
(ret == -EAGAIN)".  As per my documentation series (please review)
when -EAGAIN is returned it's important that the caller enable
interrupts for a little while before trying again.  You're not doing
that here.  Maybe if you fix it then you can get rid of your special
case rpmh_rsc_ctrlr_is_busy()?


> +       ret = rpmh_flush(&drv->client);

Back when RPMH first landed we had a whole argument about whether it
should be one file or two.  Given that it's currently two files, I
think the abstraction is that rpmh-rsc generally doesn't call into
rpmh except for the very special rpmh_tx_done().

...so seems like the whole pm_callback should move into rpmh.c and not
in rpmh-rsc.c?


> @@ -533,21 +604,20 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
>         int i, ret, n, st = 0;
>         struct tcs_group *tcs;
>         struct resource *res;
> -       void __iomem *base;
>         char drv_id[10] = {0};
>
>         snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, drv_id);
> -       base = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(base))
> -               return PTR_ERR(base);
> +       drv->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(drv->base))
> +               return PTR_ERR(drv->base);

I don't understand this part of the change.  Why move "base" into the
driver data.  It's not needed after probe.  Please undo this.  If you
really feel like base needs to be separate please move to its own
patch.


> @@ -663,6 +734,20 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       /*
> +        * CPU PM notification are not required for controllers that support
> +        * 'HW solver' mode where they can be in autonomous mode executing low
> +        * power mode to power down.
> +        */
> +       solver_config = readl_relaxed(drv->base + DRV_SOLVER_CONFIG);
> +       solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
> +       solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
> +       if (!solver_config) {
> +               drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
> +               cpu_pm_register_notifier(&drv->rsc_pm);
> +               spin_lock_init(&drv->pm_lock);

nit: init the spin lock before registering instead of after.


>   * @ctrlr: controller making request to flush cached data
>   *
> - * Return: -EBUSY if the controller is busy, probably waiting on a response
> - * to a RPMH request sent earlier.
> + * Return: 0 on success, error number otherwise.
>   *
> - * This function is always called from the sleep code from the last CPU
> - * that is powering down the entire system. Since no other RPMH API would be
> - * executing at this time, it is safe to run lockless.
> + * This function can either be called from sleep code on the last CPU
> + * (thus no spinlock needed) or with the ctrlr->cache_lock already held.

Now you can remove the "or with the ctrlr->cache_lock already held"
since it's no longer true.


-Doug
