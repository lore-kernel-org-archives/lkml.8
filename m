Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455082068F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrlziTiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgF3SqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgF3SqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:46:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AFDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:46:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g139so11991878lfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFuGFxLjY8MbMo7U24jI5f07679fmJ9gh5uKn5H5mfc=;
        b=WrlziTiDeexaiFvnx66t1nVCdoYMolZgaOuLsj7EplpI+pSGit3wIf1JizoglqrsY4
         qaGF8w9bIsV4V9LvA5f5vxhmTVrKoQ/0OJHe9t2+PT/EutbJPMzH0b9GDY2YfHyRVIJm
         uOLw5Qrr16/ElSYa7syx4MmOoAq8fMrqyUoG8SNntv/+f67ctqm3adHunkhzrVEPtD+C
         1RDDiZak0T9QY0pDEjCai0NpXszVGkg6mIwDuG4IrDhGzQIyyXuLAZEch1RVShDcdt5z
         kEJoa6cOl6UYxHsEyNCp3h35mW3XxVmTCfnDmdPlsW4YVKjzJ28eDqPbQCa8RVSySyUK
         XhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFuGFxLjY8MbMo7U24jI5f07679fmJ9gh5uKn5H5mfc=;
        b=eemQ9BvxAYqxYSX8Z8RJFIGQRlyjPnVbL9WKzyNg2gT8zC4e/D1pJyfMQZISn7QvRY
         QsDlwX7gquNmD7hksDbqm5IVT4uMATQ7tyKJJa4jKp567sb984Hef7c0l42PjRSAKdaH
         rOkI8tCHQ+q/W94HjoU0UgBlw9wjf/o7KSvXEF8pva1IOAdMjZJrtXHL0OgRgnsZIdC5
         wdHhmwdA8udGlyJdaIamgd+pKn3ymaLJlGjXUSCpPCDjh/T1ExeLUTFsoMpC8FscoFp1
         XCHIg+7Lpss0exwN5qz/7b113fpBS57z1xi4arUfhX/WZBME4z8BS/RXl91YEqelGbt5
         pZTA==
X-Gm-Message-State: AOAM530DY4yw1heLuH+Ej5m+hCAaC4xvxmx9Lr/xUGE/NtuSFMGXrKZo
        j7MkgB/3MkEl5+vTzkQWtzIlC7YzTiQo/Y5gZiELx7rW
X-Google-Smtp-Source: ABdhPJyuD/QmkIZ4GaET8YqyAzhOCbA1xOtAHYtLjnr4JcUmIvOqYdaFhjNiECjG8mm30iJ0MnsggSH5efYy/WQESn0=
X-Received: by 2002:a05:6512:31d5:: with SMTP id j21mr1815560lfe.83.1593542781204;
 Tue, 30 Jun 2020 11:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com> <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
In-Reply-To: <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 1 Jul 2020 00:16:09 +0530
Message-ID: <CAP245DW4ntkK9rWCZT8KX07tBJoHaUkXPVRH4Vp2yRHi=m6JCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev, tz
 and governor list
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 8:40 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Hi, Daniel,
>
> seems that you forgot to cc linux-pm mailing list.
>
> On Tue, 2020-06-30 at 17:16 +0530, Amit Kucheria wrote:
> > On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > >
> > > The cdev, tz and governor list, as well as their respective locks
> > > are
> > > statically defined in the thermal_core.c file.
> > >
> > > In order to give a sane access to these list, like browsing all the
> > > thermal zones or all the cooling devices, let's define a set of
> > > helpers where we pass a callback as a parameter to be called for
> > > each
> > > thermal entity.
> > >
> > > We keep the self-encapsulation and ensure the locks are correctly
> > > taken when looking at the list.
> > >
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > ---
> > >  drivers/thermal/thermal_core.c | 51
> > > ++++++++++++++++++++++++++++++++++
> >
> > Is the idea to not use thermal_helpers.c from now on? It fits
> > perfectly with a patch I have to merge all its contents to
> > thermal_core.c :-)
>
> I agree these changes should be in thermal_helper.c

I was actually serious about killing thermal_helper.c :-)

What is the reason for those 5-6 functions to live outside
thermal_core.c? Functions in thermal_helper.c are called by governors
and drivers, just like the functions in thermal_core.c. I couldn't
find a pattern.

Regards,
Amit
