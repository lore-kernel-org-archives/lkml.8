Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94332C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4932064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7K5AROP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbgDNWYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387736AbgDNWYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:24:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4650C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:24:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k133so11169374oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSvchkcd7+hD8iM08aRUkD2W1lGagSQVw2VCgv+Z9nA=;
        b=Y7K5AROPPWJ638uxbT81geDe7XOK+VI9SoMFP1YkVmSkr3nFmZ4qaRAajdMY5P3cIT
         SfndfJhq49V/M1qXysnmbyC1ZZJ2HASiDh7WhpLyW130dAR5jDd1clzwNZ2IIXlvlTJs
         RuVnt6U8FTMVETGKy2UII3b9auwVgCiA9xsWe2d7tnlSeQ4GB+ZDSa1s/8EZKG/Eu2dp
         9QJVhh+8EYf+/ICMkMZCiGzvaS8FgUg/to9uBToJ/Olv61Pwh8w00WyZhGmD8sOa4/bP
         syRATQgjXVh2l+DCx1pZG1S6lQjGbdGCWgWZoqNMMcAJvjHa9t2lCzzBBEIrg+aZvFCy
         lwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSvchkcd7+hD8iM08aRUkD2W1lGagSQVw2VCgv+Z9nA=;
        b=fvh1PbxutNxjquXwDu5N/m2joQsRvwpdmFMPSmh3JUyX5qT5z7lPbMMMBQuCYafONm
         YPouEyRVq/wKI1r/kp/1N5SoNUPTUXxNWB2wPQb8OH6v0/tOHGdkrs6Hv+DKdF1gHOnH
         Ke/idRqa+eTkbCdi84cHtPQ632IIRlU/LeXo7QdNahoDm49fAvh6KG2QMnnf7r3LSurN
         HuOIOAyCV+VrQvIM+qv9riuhrWDjFCldkSk/cG68O5uvDtpMTlLsa3wjjts7Cto0cjdM
         Q7HfPbESjdwcKpbRmxEaeUEsYDt4+Zb4evAadjFv99H8Yr+8z8APb/cXZTqufjF+MXZ+
         ZK/w==
X-Gm-Message-State: AGi0PuacW6N2lsFRdm4MAQTJBZn0PQzm6hpL+fiCqHgc+6OUT8H91oIA
        pRKMYeC+OMHCXEHxE9qxZPchvLt9oAPdi+iwlhlK3g==
X-Google-Smtp-Source: APiQypIHJWkal3YwLBhlR620KMxrsEGRChkItlIWHc8j6blfLVRMMIm6PKtY+yBy7aZLzjZWyt4bhDdw+/Bvv0ZliPU=
X-Received: by 2002:aca:b1d7:: with SMTP id a206mr7137583oif.97.1586903054325;
 Tue, 14 Apr 2020 15:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200326224459.105170-1-john.stultz@linaro.org>
 <20200326224459.105170-2-john.stultz@linaro.org> <20200414222158.GL576963@builder.lan>
In-Reply-To: <20200414222158.GL576963@builder.lan>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 14 Apr 2020 15:24:02 -0700
Message-ID: <CALAqxLWSxJsxF9ti=0hfM6487UuQMGK-bpZkkdABpngfHuu+1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] soc: qcom: rpmpd: Allow RPMPD driver to be loaded
 as a module
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 3:21 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 26 Mar 15:44 PDT 2020, John Stultz wrote:
>
> > This patch allow the rpmpd driver to be loaded as a permenent
> > module. Meaning it can be loaded from a module, but then cannot
> > be unloaded.
> >
> > Ideally, it would include a remove hook and related logic, but
> > apparently the genpd code isn't able to track usage and cleaning
> > things up? (See: https://lkml.org/lkml/2019/1/24/38)
> >
> > So making it a permenent module at least improves things slightly
> > over requiring it to be a built in driver.
> >
> > Feedback would be appreciated!
> >
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rajendra Nayak <rnayak@codeaurora.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Acked-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> > * Fix MODULE_LICENSE to be GPL v2 as suggested by Bjorn
> > * Leave initcall as core_initcall, since that switches to module_initcall
> >   only when built as a module, also suggested by Bjorn
> > * Add module tags taken from Rajendra's earlier patch
> > ---
> >  drivers/soc/qcom/Kconfig | 4 ++--
> >  drivers/soc/qcom/rpmpd.c | 6 ++++++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index d0a73e76d563..af774555b9d2 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -123,8 +123,8 @@ config QCOM_RPMHPD
> >         for the voltage rail.
> >
> >  config QCOM_RPMPD
> > -     bool "Qualcomm RPM Power domain driver"
> > -     depends on QCOM_SMD_RPM=y
> > +     tristate "Qualcomm RPM Power domain driver"
> > +     depends on QCOM_SMD_RPM
> >       help
> >         QCOM RPM Power domain driver to support power-domains with
> >         performance states. The driver communicates a performance state
> > diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> > index 2b1834c5609a..22fe94c03e79 100644
> > --- a/drivers/soc/qcom/rpmpd.c
> > +++ b/drivers/soc/qcom/rpmpd.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mutex.h>
> > +#include <linux/module.h>
>
> module comes before mutex in the alphabet.

:) Thanks for catching that.

> >  #include <linux/pm_domain.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > @@ -226,6 +227,7 @@ static const struct of_device_id rpmpd_match_table[] = {
> >       { .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
> >       { }
> >  };
> > +MODULE_DEVICE_TABLE(of, rpmpd_match_table);
> >
> >  static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
> >  {
> > @@ -422,3 +424,7 @@ static int __init rpmpd_init(void)
> >       return platform_driver_register(&rpmpd_driver);
> >  }
> >  core_initcall(rpmpd_init);
> > +
> > +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPM Power Domain Driver");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:qcom-rpmpd");
>
> Is there any reason for this alias?
>
> The module will be automatically loaded based on compatible and the
> MODULE_DEVICE_TABLE() information above, and for ACPI would need a
> similar acpi_device_id table.

I pulled it in from Rajendra's earlier patch. I'm ok to drop it though.

I'll fix these up and respin. Thanks for the review!

thanks
-john
