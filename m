Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80F8C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08E22053B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ELhdnX0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgDQAdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728177AbgDQAdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:33:15 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75778C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:33:14 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id v24so83126uak.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ucYU/r7+yD1eULFrMllNCtHtA6o8h+uSI2plba/H4A=;
        b=ELhdnX0AGyli5AW8J9vflrzj7yYF3tC1CxfidL2Vrto5TlTdT4mgKO1Zmt/ydIOSiH
         OIb87NyRtTOWWvNCBZynYWeIZApLb6vJhDnmCx+YXEIq3n0e25UU1iTecNsF0FDkioHy
         3xy49uFb1shFcKD0f/zwiIk2H4IfUc2pfpYTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ucYU/r7+yD1eULFrMllNCtHtA6o8h+uSI2plba/H4A=;
        b=a1bh8xZHczmju/hq5fOgrM+pDcK9rg4CAqe4QU5PVr44O23RvcmRbR2N3uufqPloNT
         Yr8orHSdPFIvdshzrUYQ/Ql3ZpW3MdLjLHreFVjzRxEcMOIwAUgn5i7PhmRAWixBnRMa
         dFYFG6zS6ajDxKA1leSBYfiz85mMDAviY/8Lrn1mxBKHChBd1hkg2zRbLXs6U+5PP9v5
         TX0kDtVxxD6BFDIYRNvzOGpXJdAUDHuryAmK6Y27nsh5FsBJxhBnPmELeJHMNqJhCKIg
         gd98nKs6Yl59CCQ2SvuKuQYxrBG+3e6x6qmIzVKjjQa7Z43wCcgm1ZlBqkh7MlW1CSnK
         iYPQ==
X-Gm-Message-State: AGi0Pubqj7SX2dtXMddtF+lCq4QCz5/8RcDRRHpLqLOO1ZRgUfwQx2vc
        7dYFVBP/Scw6x4kv4AwosxeX3PYrHtk=
X-Google-Smtp-Source: APiQypIa3IeoXG9oAGEE1PaiLFxCzTip86c3zxvC6gRjiyggH29JGVZcjsRvDYe3MbIlKiegnGjNBw==
X-Received: by 2002:a9f:3765:: with SMTP id a34mr512375uae.134.1587083593162;
        Thu, 16 Apr 2020 17:33:13 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id w143sm6337727vkd.5.2020.04.16.17.33.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 17:33:12 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id y15so160213vsm.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:33:12 -0700 (PDT)
X-Received: by 2002:a05:6102:3204:: with SMTP id r4mr282736vsf.109.1587083591511;
 Thu, 16 Apr 2020 17:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200414102312.1.I295cb72bc5334a2af80313cbe97cb5c9dcb1442c@changeid>
 <4cf5c74a-44c0-190d-e752-a46ccd5cda7d@codeaurora.org>
In-Reply-To: <4cf5c74a-44c0-190d-e752-a46ccd5cda7d@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Apr 2020 17:33:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xw5n2CR3+3NtW1+7HD947ULeNQqCAC_OWAY0yRD=cfVQ@mail.gmail.com>
Message-ID: <CAD=FV=Xw5n2CR3+3NtW1+7HD947ULeNQqCAC_OWAY0yRD=cfVQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Remove the pm_lock
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 16, 2020 at 3:51 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> On 4/14/2020 10:53 PM, Douglas Anderson wrote:
> > It has been postulated that the pm_lock is bad for performance because
> > a CPU currently running rpmh_flush() could block other CPUs from
> > coming out of idle.  Similarly CPUs coming out of / going into idle
> > all need to contend with each other for the spinlock just to update
> > the variable tracking who's in PM.
> >
> > Let's optimize this a bit.  Specifically:
> >
> > - Use a count rather than a bitmask.  This is faster to access and
> >    also means we can use the atomic_inc_return() function to really
> >    detect who the last one to enter PM was.
> > - Accept that it's OK if we race and are doing the flush (because we
> >    think we're last) while another CPU is coming out of idle.  As long
> >    as we block that CPU if/when it tries to do an active-only transfer
> >    we're OK.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   drivers/soc/qcom/rpmh-internal.h |  7 ++---
> >   drivers/soc/qcom/rpmh-rsc.c      | 46 +++++++++++++++-----------------
> >   2 files changed, 24 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> > index dba8510c0669..449cd511702b 100644
> > --- a/drivers/soc/qcom/rpmh-internal.h
> > +++ b/drivers/soc/qcom/rpmh-internal.h
> > @@ -97,7 +97,7 @@ struct rpmh_ctrlr {
> >    * @num_tcs:            Number of TCSes in this DRV.
> >    * @rsc_pm:             CPU PM notifier for controller.
> >    *                      Used when solver mode is not present.
> > - * @cpus_entered_pm:    CPU mask for cpus in idle power collapse.
> > + * @cpus_in_pm:         Number of CPUs not in idle power collapse.
> >    *                      Used when solver mode is not present.
> >    * @tcs:                TCS groups.
> >    * @tcs_in_use:         S/W state of the TCS; only set for ACTIVE_ONLY
> > @@ -111,8 +111,6 @@ struct rpmh_ctrlr {
> >    *                      grabbing this lock and a tcs_lock at the same time,
> >    *                      grab the tcs_lock first so we always have a
> >    *                      consistent lock ordering.
> > - * @pm_lock:            Synchronize during PM notifications.
> > - *                      Used when solver mode is not present.
> >    * @client:             Handle to the DRV's client.
> >    */
> >   struct rsc_drv {
> > @@ -121,11 +119,10 @@ struct rsc_drv {
> >       int id;
> >       int num_tcs;
> >       struct notifier_block rsc_pm;
> > -     struct cpumask cpus_entered_pm;
> > +     atomic_t cpus_in_pm;
> >       struct tcs_group tcs[TCS_TYPE_NR];
> >       DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
> >       spinlock_t lock;
> > -     spinlock_t pm_lock;
> >       struct rpmh_ctrlr client;
> >   };
> >
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > index 732316bb67dc..4e45a8ac6cde 100644
> > --- a/drivers/soc/qcom/rpmh-rsc.c
> > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > @@ -740,6 +740,8 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
> >    * SLEEP and WAKE sets. If AMCs are busy, controller can not enter
> >    * power collapse, so deny from the last cpu's pm notification.
> >    *
> > + * Context: Must be called with the drv->lock held.
> > + *
> >    * Return:
> >    * * False          - AMCs are idle
> >    * * True           - AMCs are busy
> > @@ -754,9 +756,6 @@ static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
> >        * dedicated TCS for active state use, then re-purposed wake TCSes
> >        * should be checked for not busy, because we used wake TCSes for
> >        * active requests in this case.
> > -      *
> > -      * Since this is called from the last cpu, need not take drv or tcs
> > -      * lock before checking tcs_is_free().
> >        */
> >       if (!tcs->num_tcs)
> >               tcs = &drv->tcs[WAKE_TCS];
> > @@ -791,36 +790,36 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
> >   {
> >       struct rsc_drv *drv = container_of(nfb, struct rsc_drv, rsc_pm);
> >       int ret = NOTIFY_OK;
> > -
> > -     spin_lock(&drv->pm_lock);
> > +     int cpus_in_pm;
> >
> >       switch (action) {
> >       case CPU_PM_ENTER:
> > -             cpumask_set_cpu(smp_processor_id(), &drv->cpus_entered_pm);
> > -
> > -             if (!cpumask_equal(&drv->cpus_entered_pm, cpu_online_mask))
> > -                     goto exit;
> > +             cpus_in_pm = atomic_inc_return(&drv->cpus_in_pm);
> > +             if (cpus_in_pm < num_online_cpus())
> > +                     return NOTIFY_OK;
> >               break;
> >       case CPU_PM_ENTER_FAILED:
> >       case CPU_PM_EXIT:
> > -             cpumask_clear_cpu(smp_processor_id(), &drv->cpus_entered_pm);
> > -             goto exit;
> > -     }
> > -
> > -     ret = rpmh_rsc_ctrlr_is_busy(drv);
> > -     if (ret) {
> > -             ret = NOTIFY_BAD;
> > -             goto exit;
> > +             atomic_dec(&drv->cpus_in_pm);
> > +             return NOTIFY_OK;
> >       }
> >
> > -     ret = rpmh_flush(&drv->client);
> > -     if (ret)
> > +     /*
> > +      * It's likely we're on the last CPU. Grab the drv->lock and write
> > +      * out the sleep/wake commands to RPMH hardware. Grabbing the lock
> > +      * means that if we race with another CPU coming up we are still
> > +      * guaranteed to be safe. If another CPU came up just after we checked
> > +      * and has already started an active transfer then we'll notice we're
> > +      * busy and abort. If another CPU comes up after we start flushing it
> > +      * will be blocked from starting an active transfer until we're done
> > +      * flushing. If another CPU starts an active transfer after we release
> > +      * the lock we're still OK because we're no longer the last CPU.
> > +      */
> > +     spin_lock(&drv->lock);
> > +     if (rpmh_rsc_ctrlr_is_busy(drv) || !rpmh_flush(&drv->client))
> >               ret = NOTIFY_BAD;
> > -     else
> > -             ret = NOTIFY_OK;
> > +     spin_unlock(&drv->lock);
> >
> > -exit:
> > -     spin_unlock(&drv->pm_lock);
> >       return ret;
> >   }
> There is a race if we allow other CPUs to exit without pm lock
> below scenarios can happen.
>
> 1. for the last cpu (CPU-x) CPU_PM_ENTER notification came
> 2. On CPU-x, rpmh_flush() is in progress with drv->lock held, which is
> at the flush_batch() stage
> 3. Meanwhile any other CPU (CPU-y) woken up and did CPU_PM_EXIT
> 4. From the woken up cpu, rpmh_invalidate() is invoked.
> 5. It takes ctrlr->cache_lock and empties the cached batch requests
> (making list empty and kfree() the cached requests)
> 6. The last cpu (CPU-x) which was doing rpmh_flush() suddently gets the
> list empty which it was traversing in flush_batch(),
>     leading to null pointer derefence.
>
> To Fix above race condtion, ctrlr->cache_lock should be taken inside
> rpmh_flush() starting point.

Good catch!


> also need to remove lockdep_assert_irqs_disabled() which got insterted,
> since IRQ might be enabled by this time if some CPU exits.

I'm pretty sure lockdep_assert_irqs_disabled() should stay.  That's
talking about whether the local CPU's IRQs are disabled.  Whether
another processor is running or not will not affect the local CPU.


-Doug
