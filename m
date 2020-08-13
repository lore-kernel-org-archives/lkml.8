Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434ACC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E32D20774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQQTnjyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMMe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHMMex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:34:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C74DC061384
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:34:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so4885733wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3uEAwJLgL9HOnp4WfEgQ6HPIoDO6xpaWopK8Q+HmGk=;
        b=fQQTnjytAsYYb6U28l4hea+cVyA8Oa4Y6wLtWv7R4Eb3hEI5Q9QUYTlskJemGUUOQC
         bt+7UirIqACAbvxy81mTMDFViioTzbmlM2nOkDad4aMGNkpuOqqZJ5V9O6yjdZx/Spso
         qCg59PcJquzfQaSddP8yuED5h4jl1PrnfXJxl3Cu9bvVS0X/rmqirGh93O/hNDFx49uU
         iXM0YI6MaZKQ+z99PMvWOg5oqSKpYX2v3Z8pFtm4/jfrc6JfbhaNmWmATzeLvlb4dWrP
         vzz9H9MICwsqXK7DErrKI0FTfapIX4rf68880SbgvyYgo+BswLk0UQlcAhBwwhtyWS4t
         FQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3uEAwJLgL9HOnp4WfEgQ6HPIoDO6xpaWopK8Q+HmGk=;
        b=Uf2zpij9tSNeaSldhBQ/odaKmdoKMMXM1G5bTQnd0Td/LOUiqv67iQN5VE4iLFqpmL
         VJHwTvklgVuB0cCNI6kCMAoRfAbWEg0qM3NC7EPWzDCKZvCZmCxfkXUr7AF/Rc3jm03O
         n1kknz8spjv+CWLbsY8Ii3cSIXxzGAazH0Y0Y2FR283BAwzsYp38DsD0Ud2fGw9LDUe+
         i3eb5M5YSnqxhfvBROoigZYzjtSVIvHykOK2uux6tLGJCgM3fHGnNFdJnHZUNtPl52lL
         sjJE2X3u1c1sQOKuhkymaSw/8ovYLvCupV7M2eQmMLTIvuWDunBiFCMKHWRJ7wOTXbNP
         ks+w==
X-Gm-Message-State: AOAM532UnJriy0jMs6u7OVQLjvqOZ3DCJFvr7QqCnUE3hk72jvkdad5H
        sHTiFBuZzAlEd58DIMsYpVi+2dznH1E3QJQk0/8w8g==
X-Google-Smtp-Source: ABdhPJyFT4uz/eeLKFjW8ZpZRSmHtA8nhNF+nipha3H4ZWg8H5FDUBEfBmgaiDE9vS22eNpiBvDsx1dD2wgkiZIWk64=
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr3926900wmh.146.1597322089935;
 Thu, 13 Aug 2020 05:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200811190252.10559-1-sibis@codeaurora.org> <CAPDyKFqNMEtHwcJFxYQP5H1Yjrsr1T3UUZoXes69EthSjAYs2A@mail.gmail.com>
 <1ba3e4d703dd0a52547d63fa014451eb@codeaurora.org>
In-Reply-To: <1ba3e4d703dd0a52547d63fa014451eb@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Aug 2020 14:34:13 +0200
Message-ID: <CAPDyKFrH9WTg4O5L+e1AijNvsagLYZ9QVTeoD0x0SQgYd3hkBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel-owner@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 at 19:03, Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Uffe,
> Thanks for taking time to review the
> series!
>
> On 2020-08-12 15:15, Ulf Hansson wrote:
> > On Tue, 11 Aug 2020 at 21:03, Sibi Sankar <sibis@codeaurora.org> wrote:
> >>
> >> This is for power domains which needs to stay powered on for suspend
> >> but can be powered on/off as part of runtime PM. This flag is aimed at
> >> power domains coupled to remote processors which enter suspend states
> >> independent to that of the application processor. Such power domains
> >> are turned off only on remote processor crash/shutdown.
> >
> > As Kevin also requested, please elaborate more on the use case.
> >
> > Why exactly must the PM domain stay powered on during system suspend?
> > Is there a wakeup configured that needs to be managed - or is there a
> > co-processor/FW behaviour that needs to be obeyed to?
>
> Yes this is a co-processor behavior that
> needs to be obeyed. Specifically application
> processor notifies the Always on Subsystem
> (AOSS) that a particular co-processor is up
> using the power domains exposed by AOSS QMP
> driver. AOSS uses this information to wait
> for the co-processors to suspend before
> starting its sleep sequence. The application
> processor powers off these power domains only
> if the co-processor has crashed or powered
> off.

Thanks for clarifying!

Although, can you please elaborate a bit more on the actual use case?
What are the typical co-processor and what drivers are involved in
managing it?

As you may know, runtime PM becomes disabled during system suspend of
a device. Which means, if the driver tries to power off the
coprocessor (via calling pm_runtime_put() for example), somewhere in
the system suspend phase of the corresponding device, its attached PM
domain stays powered on when managed by genpd.

Then in the suspend_noirq phase, genpd tries to power off the PM
domain, unless there are wakeups to consider.

Taking the above into account, wouldn't that mean that you potentially
may end up keeping the PM domain powered on, even if it actually can
be powered off in the suspend_noirq phase by genpd?

Kind regards
Uffe

> >
> >>
> >> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >> ---
> >>  drivers/base/power/domain.c | 3 ++-
> >>  include/linux/pm_domain.h   | 5 +++++
> >>  2 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> >> index 2cb5e04cf86cd..ba78ac4a450d4 100644
> >> --- a/drivers/base/power/domain.c
> >> +++ b/drivers/base/power/domain.c
> >> @@ -129,6 +129,7 @@ static const struct genpd_lock_ops genpd_spin_ops
> >> = {
> >>  #define genpd_is_active_wakeup(genpd)  (genpd->flags &
> >> GENPD_FLAG_ACTIVE_WAKEUP)
> >>  #define genpd_is_cpu_domain(genpd)     (genpd->flags &
> >> GENPD_FLAG_CPU_DOMAIN)
> >>  #define genpd_is_rpm_always_on(genpd)  (genpd->flags &
> >> GENPD_FLAG_RPM_ALWAYS_ON)
> >> +#define genpd_is_suspend_on(genpd)     (genpd->flags &
> >> GENPD_FLAG_SUSPEND_ON)
> >>
> >>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device
> >> *dev,
> >>                 const struct generic_pm_domain *genpd)
> >> @@ -949,7 +950,7 @@ static void genpd_sync_power_off(struct
> >> generic_pm_domain *genpd, bool use_lock,
> >>  {
> >>         struct gpd_link *link;
> >>
> >> -       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
> >> +       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd) ||
> >> genpd_is_suspend_on(genpd))
> >>                 return;
> >>
> >>         if (genpd->suspended_count != genpd->device_count
> >> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> >> index ee11502a575b0..3002a2d68936a 100644
> >> --- a/include/linux/pm_domain.h
> >> +++ b/include/linux/pm_domain.h
> >> @@ -55,6 +55,10 @@
> >>   *
> >>   * GENPD_FLAG_RPM_ALWAYS_ON:   Instructs genpd to always keep the PM
> >> domain
> >>   *                             powered on except for system suspend.
> >> + *
> >> + * GENPD_FLAG_SUSPEND_ON:      Instructs genpd to keep the PM domain
> >> powered
> >> + *                             on during suspend and runtime PM
> >> controlled
> >> + *                             otherwise.
> >>   */
> >>  #define GENPD_FLAG_PM_CLK       (1U << 0)
> >>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
> >> @@ -62,6 +66,7 @@
> >>  #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
> >>  #define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
> >>  #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
> >> +#define GENPD_FLAG_SUSPEND_ON   (1U << 6)
> >>
> >>  enum gpd_status {
> >>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
> >> --
> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> >> Forum,
> >> a Linux Foundation Collaborative Project
> >>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.
