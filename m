Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE576C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF15A2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeGkhfQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHXOhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHXOhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:37:36 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D28C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:37:35 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id k18so2668299uao.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8W9mgANFdhD/nPgjHPXy+ZyiEA7eniKvivZqryTeP2Q=;
        b=qeGkhfQTZOUkrmLQcSxVI0QEwtoVWW4rcQmTIE6NI5YOjOMEXX+faITZxnMfHC/fAd
         5+vOKDi+PPO2E0CkfnlHUuUFbdeP8gdcOUyrsRjPHQoj+TgIuJp9Ah6dPWnm3T+FMXeP
         70Z1FoYf7gXWgCahDM9JdpVdH/MYPYhbI8henrNSnZhvoWb3his2OQXEla1azwja7ara
         KZqlNd4BGngedaZmoOBBYwpgBMpTsCF2ma5ZpC/aXGOqfa8OoHA/yPGio4pFh/5xagON
         FjpthiDqp9XG02oM9utlkp+jsJkUmADSoczCFH+2vnEFJ4iDvmx/i2ytegFxfyFZ7pbG
         HoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8W9mgANFdhD/nPgjHPXy+ZyiEA7eniKvivZqryTeP2Q=;
        b=T49M9AMBgAn4ahgBzyAwVjLJnbW1OL4xcAQu6dSO79IHEg+uiF2EjcsoEtkLcE7Wka
         bVcTZb+k7GbbnJ4Po8zMvEzpnrZefDDmAcEASNI0M5o/lsVAerXn/1mIOvslrG5KfHLd
         SrwWEERNpl1QBCGWkTRVJqwijgCzb6GbgKJfjggDrtXVDYjT96NkGSFIh8NLGE7RAIXt
         Hkl7QNeaniwJUjeTgq1gunbgdlEEBRiKhlyvKzW9h3KUuVQYVcMKb1il6U5UPT45hVBK
         aq7AMRD84Jt+AAQjfDeHS66coFDjjbCK8pQzIEGrSCrrpqxyI5OxjrQfHwaoeeiyjICJ
         TnVg==
X-Gm-Message-State: AOAM532ukPMcJxm46BkrZ96egelnfxfQ3xHHC6cDLUezAD50tpe05Y7C
        Di2s+qp7JJO03JoGBSMPFLY4JCzgs1sFPF7a36wUXA==
X-Google-Smtp-Source: ABdhPJyAQGXYOmmRXLlyOHYhrpGHHX2XddAp86ASA1UkzpuvS8A48lsaHdRFf8yw+ww3BuTRQYZtKWupqO66pIM6OPI=
X-Received: by 2002:ab0:2848:: with SMTP id c8mr1364877uaq.15.1598279854501;
 Mon, 24 Aug 2020 07:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200730080146.25185-1-stephan@gerhold.net> <20200730080146.25185-4-stephan@gerhold.net>
 <20200824112744.jsyaxrfbybyjpwex@vireshk-i7> <20200824115549.GB208090@gerhold.net>
In-Reply-To: <20200824115549.GB208090@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 16:36:57 +0200
Message-ID: <CAPDyKFojtArMRfO+Z8YaWCWw2fFYcO62x3eL1paNi5pKRg3Jww@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] opp: Power on (virtual) power domains managed by
 the OPP core
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 at 13:56, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Mon, Aug 24, 2020 at 04:57:44PM +0530, Viresh Kumar wrote:
> > On 30-07-20, 10:01, Stephan Gerhold wrote:
> > > dev_pm_opp_attach_genpd() allows attaching an arbitrary number of
> > > power domains to an OPP table. In that case, the genpd core will
> > > create a virtual device for each of the power domains.
> > >
> > > At the moment, the OPP core only calls
> > > dev_pm_genpd_set_performance_state() on these virtual devices.
> > > It does not attempt to power on the power domains. Therefore
> > > the required power domain might never get turned on.
> > >
> > > So far, dev_pm_opp_attach_genpd() is only used in qcom-cpufreq-nvmem.c
> > > to attach the CPR power domain to the CPU OPP table. The CPR driver
> > > does not check if it was actually powered on so this did not cause
> > > any problems. However, other drivers (e.g. rpmpd) might ignore the
> > > performance state until the power domain is actually powered on.
> > >
> > > Since these virtual devices are managed exclusively by the OPP core,
> > > I would say that it should also be responsible to ensure they are
> > > enabled. A similar approach is already used for regulators, see
> > > commit 8d45719caaf5 ("opp: core: add regulators enable and disable").
> > >
> > > This commit implements similar functionality for the virtual genpd
> > > devices managed by the OPP core. The power domains are turned on
> > > the first time dev_pm_opp_set_rate() is called. They are turned off
> > > again when dev_pm_opp_set_rate(dev, 0) is called.
> > >
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > ---
> > > Related discussion: https://lore.kernel.org/linux-arm-msm/20200426123140.GA190483@gerhold.net/
> > >
> > > There would be also other ways to implement this, e.g. device links,
> > > assuming that the device using the OPP table also makes use of runtime PM.
> > > My first thought was that it would be most consistent to handle this like
> > > regulators, bandwidth votes etc. RFC :)
> >
> > This stuff was done ages back and I am starting to forget almost
> > everything now :)
> >
> > Ulf, why doesn't pm_runtime_get(dev) take care of enabling multiple
> > power domain case ? RFP (request for patience) :)
> >
>
> So I'm really not an expert for power domains, but here is my
> understanding:
>
> We attach the power domains in dev_pm_opp_attach_genpd(opp_dev, names),
> where opp_dev is the device the OPP table belongs to.
>
> To do that, the genpd core creates a set of virtual devices. These
> virtual devices are not related to opp_dev in any way. Therefore, the
> power domains stay off until we run pm_runtime_get(virt_dev) for each of
> the virtual devices. (Which is what is implemented in this patch...)

Just to clarify. The reason why genpd creates virtual devices isn't
because of the opp table itself.

Instead this is because we can only attach one PM domain per device.
And since a device may have multiple PM domains, we need to create a
virtual device and per PM domain and attach that instead. Then it's up
to the caller to manage the virtual devices.

In some cases where the PM domains can be managed together, a device
link makes sense - while in others it doesn't.

>
> If I understand correctly, what you would like to do is to have a single
> pm_runtime_get(opp_dev) call also enable all the virtual devices?
>
> As far as I understand, this can be done by adding "device links"
> between opp_dev and the virtual devices, e.g.
>
>         device_link_add(opp_dev, virt_dev, DL_FLAG_PM_RUNTIME);
>
> for each of the virtual devices.

Yep.

>
> But the problem with that approach is that it assumes that someone
> actually calls pm_runtime_get(opp_dev), i.e. we assume that opp_dev is
> managed by runtime PM. As far as I know, this isn't the case for the CPU
> OPP table for example.
>
> Maybe Ulf can correct me if I'm wrong :)

If I understand correctly, the opp_dev is the actual consumer device.
It could represent an I/O controller for example, or a CPU in the CPU
freq case.

That said, perhaps should rely on the consumer to deploy runtime PM
support, but let the OPP core to set up the device links for the genpd
virtual devices!?

>
> Thanks!
> Stephan

Kind regards
Uffe
