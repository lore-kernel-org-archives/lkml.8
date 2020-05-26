Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A29207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEtC9JqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbgEZJW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388636AbgEZJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:22:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA27C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:22:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v16so23641246ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHtMUTjIpKGUVpTGb6eXqa1GBMsHXSe04tQOYQTSzwk=;
        b=oEtC9JqLK6JUL+a09fup+E3zmswBCXWI3NHfhAeye40YMT/bZyDqHtuU4TEwB9FFaA
         PQyMqRt1usaUnx4ouAZuqxXbnvHXqIwQQQPVDsiNGWmZMtk4/0BiERce+XhIUzzEIG9f
         7YLBwF5B3zkUWkw0rrxo1FMolJJWsHiFs581btuKT1U/A1xmOuhWyS/10UwH/J8G5VrU
         lUN+3WznXNQ1n7yqOWXLAfW6fjDVbaBVuSMErOAUqdmMV3ykZ12gG3B5FLQ1VSVGngjQ
         WLz1ev/VKjH5X8ibPWTK8CEfNUv8+zvKU/GaOOYg9qOZxC+vlFi0QQ36SuGx+ZrpOifC
         njFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHtMUTjIpKGUVpTGb6eXqa1GBMsHXSe04tQOYQTSzwk=;
        b=lyDUg694/7l3EVVjaYc+g0Dep4iPR5my35o0qJ9hc35k1Fj/AyFhR6wu1Y1KENbT2k
         6UmEyAbH+0uRt+wCNNoV/eoRlfOocK0c6ohUaqP3cvcKJ3VE5Vomz9lShQn4pqTAu+9O
         yTjMsqLhGZG3mNh/K0zA+QWT343OGLL2bJv6+WvRYc8BfUEq8+RNcGAXL/7zELCSpgT7
         lZwhBPavGi+hzi7Ew1Vab4ekUllOtn5N1j2WwWledMctSD05GJfkJJjMb1qh/DF4w1el
         ARxoVv9g6qL5C+UWYPkg1y8ow3BwYGP8zx+3jtUhR8kfE4CiGgZmrvKN0/3/gOhdaUBM
         Ca4Q==
X-Gm-Message-State: AOAM533IIz5roacRt3bKwqHMDBUQyVrqfvII2N49FkyPuKP/YwBVi16I
        92K2Y+OrVi+Z73pj88jCG6BnHbzUmXQpjsyJvEXuho++8bw=
X-Google-Smtp-Source: ABdhPJym48nO1qx6Xam2hpUVXTrGYHOl37dIdmsOtBDTKVNSlX2HngDefNjA8Df4YLq2vZMNOewwm8FZbTbAdvC9Nb4=
X-Received: by 2002:a2e:1451:: with SMTP id 17mr188903lju.30.1590484971486;
 Tue, 26 May 2020 02:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org> <20200522171451.GD10319@linux.intel.com>
 <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
 <20200522200346.GB150221@linux.intel.com> <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
In-Reply-To: <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 26 May 2020 14:52:39 +0530
Message-ID: <CAFA6WYMe8xOPwsBuxoKb0e4kAhXfTjwYGVd7fNUR07hgQ_9TJg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Joakim Bech <joakim.bech@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Thiru (original author), Ilias, Joakim

Hi Jarkko,

On Mon, 25 May 2020 at 12:20, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Fri, 22 May 2020 at 23:03, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, May 22, 2020 at 10:29:44PM +0300, Maxim Uvarov wrote:
> > > On Fri, 22 May 2020 at 20:15, Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Thu, May 21, 2020 at 09:47:43AM +0300, Maxim Uvarov wrote:
> > > > > Register driver on TEE bus. module tee registers bus,
> > > >
> > > > "on the TEE bus"
> > > >
> > > > "The module tee"
> > > >
> > > > > and module optee calls optee_enumerate_devices() to scan
> > > > > all devices on the bus. Trusted Application for this driver
> > > >
> > > > Looking at drivers/tee, it shows that tee and optee are in fact the same
> > > > module as opposed to what your commit message says.
> > > >
> > >
> > > In the current kernel it's 2 different modules.
> > >
> > > > > can be Early TA's (can be compiled into optee-os). In that
> > > > > case it will be on OPTEE bus before linux booting. Also
> > > > > optee-suplicant application is needed to be loaded between
> > > > > OPTEE module and ftpm module to maintain functionality
> > > > > for fTPM driver.
> > > >
> > > > Why is this needed and why things worked before having this?

If you remembered earlier discussions when this driver was added,
tee-supplicant dependency concern was raised at that time too. But the
response from author [1] was to use a workaround in firmware to
overcome the initialization issue of fTPM driver.

Basically while using upstream OP-TEE, fTPM NV RAM is implemented via
RPMB secure storage [2]. So any fTPM operation dependent on NV RAM may
fail without access to RPMB secure storage.

And during kernel boot, RPMB access isn't available (there were some
prior efforts [3] around this but unfortunately didn't land in
upstream) due to which we need to rely on user mode tee-supplicant for
corresponding access.

So we should only register fTPM device when the underlying
infrastructure is working, which is something this patch-set addresses
via registering fTPM device only when the tee-supplicant is up and
running.

[1] https://lkml.org/lkml/2019/7/4/779
[2] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#rpmb-secure-storage
[3] https://lwn.net/Articles/682276/

> > > >
> > >
> > > Before these changes user space has to drive boot sequence. I.e.  tee
> > > and optee modules loads, then application tee-supplicant has to start
> > > and only then module ftpm can be loaded. The reason for that is
> > > storage services are implemented in userspace and driver needs them.
> >
> > Is the TPM implementation uploaded to TEE from user space and or what
> > storage are we talking about? Not sure how these storage services
> > connect to the TPM.

Please see my response above.

-Sumit

> >
> > /Jarkko
>
> Jakko,
> tee-supplicant application provides state machine over callbacks with
> RPC messages.
> https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/tee_supplicant.c#L614
> It also allocates shm. Without running tee-supplicant
> tee_client_open_session() will fail.
> optee_open_session()->get_msg_arg()->tee_shm_alloc()->...
> Optee team wanted to remove some dependencies from tee-supplicant with
> moving code
> to the kernel. But for now I think that should be out of the scope of
> current patches due to
> they fix driver initialization on tee bus without breaking current
> functionality.
>
> Maxim.
