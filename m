Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D13AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308D7246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9JYwdcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1WUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:20:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23164 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgB1WUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582928398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bw5Jnhp7KqPb5r94FhJWL4ZVprMiJ57A5xuYCAkv6DM=;
        b=T9JYwdcF8wA4XGgtfODvFK4AGtNFOSyD/vwe2No8CwshzkYZjokVbOmW7Lu5LlQyZ7p9Zc
        wh639JMip6P6qUqP8cPKNMTh339Sou5JeTVMrkMVCc8TBYD+uqgg7u79xt3PRwwtm7Ay9T
        uhdY+vpioHY9tJ21OGLQUao9SmP2tNw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-X7ET3VtSOQyYUpQVwKYx1w-1; Fri, 28 Feb 2020 17:19:57 -0500
X-MC-Unique: X7ET3VtSOQyYUpQVwKYx1w-1
Received: by mail-il1-f197.google.com with SMTP id i67so4755762ilf.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 14:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bw5Jnhp7KqPb5r94FhJWL4ZVprMiJ57A5xuYCAkv6DM=;
        b=BU/V287OkI+TIWew1V0HJ45bdNthCnGBSM0bA5dgxZpimGre2IkV1h3PNZQzTGD8cp
         +OinQhTAY+Rd9mR8PpuJJ8B7vfNkq7jRjeArI6/6TOdPd8sEsiMmvm0BEtzFyISdOAxr
         O92iBTwT7AJgBddFv9S/+s4QT1UNlOabJXKDc4ttbkwF77ltCaHB9OTbdWUItWFk0yp/
         XiQ77My8lMFlXksy2Oi/cZU7wA33QndXdcZIsTOk1ZswOJ3xhJTGptssiBX5PTOjJUhh
         NwJuD0YAgdo7vpVAR7XS95+qjH9ZctWP9+xaSdWKZC6MmpjqDd426ps5unEvLlCloLwH
         1Qfg==
X-Gm-Message-State: APjAAAWBL02mng9Kg2kMh+DLuLNhqpmbrTFWNebtMwavIZCzMudfrCN0
        GLLkKzQo59YEZIMkowxpNfKCLJqa19s1K484vpLI58skQ2/+3BwRyCh0y/mHdVGuNcvZfoSGY+j
        2axraur+IwBzFxW3TXdlpALvQM+ztkqSnrBSlQVdD
X-Received: by 2002:a02:84ee:: with SMTP id f101mr5290812jai.7.1582928396008;
        Fri, 28 Feb 2020 14:19:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOw4io9YQxYqs7muQh08Wi5KSyvP4Fx8ks9FOupRVElFoJFO/gjY7DAVMFEkm98oQfXCmYnmWSU5Uq/+CB9hE=
X-Received: by 2002:a02:84ee:: with SMTP id f101mr5290771jai.7.1582928395604;
 Fri, 28 Feb 2020 14:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20200223172559.6912-1-jarkko.sakkinen@linux.intel.com>
 <20200224100932.GA15526@wind.enjellic.com> <20200224211317.GJ29865@linux.intel.com>
 <20200228220212.GA7978@wind.enjellic.com>
In-Reply-To: <20200228220212.GA7978@wind.enjellic.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Fri, 28 Feb 2020 17:19:45 -0500
Message-ID: <CAOASepMmFC5bmoETu_KP967u+vFkqb385JckU1uFHHaVKNVaFw@mail.gmail.com>
Subject: Re: [PATCH v27 00/22] Intel SGX foundations
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        Patrick Uiterwijk <puiterwijk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 5:04 PM Dr. Greg <greg@enjellic.com> wrote:
>
> On Mon, Feb 24, 2020 at 01:13:17PM -0800, Sean Christopherson wrote:
>
> Hi, I hope the week is ending well for everyone.
>
> > On Mon, Feb 24, 2020 at 04:09:32AM -0600, Dr. Greg wrote:
> > > On Sun, Feb 23, 2020 at 07:25:37PM +0200, Jarkko Sakkinen wrote:
> > >
> > > Good morning, I hope the week is starting well for everyone.
> > >
> > > > Intel(R) SGX is a set of CPU instructions that can be used by
> > > > applications to set aside private regions of code and data. The code
> > > > outside the enclave is disallowed to access the memory inside the
> > > > enclave by the CPU access control.
> > >
> > > Do we misinterpret or is the driver not capable of being built in
> > > modular form?
>
> > Correct.
>
> That is what we had concluded, thanks for the verification.
>
> > > If not, it would appear that this functionality has been lost since
> > > version 19 of the driver, admittedly some time ago.
>
> > It was removed in v20[*].
>
> We didn't see documentation of this in any of the v20 release bullet
> points, hence the question.
>
> > > > * Allow the driver to be compiled as a module now that it no code is using
> > > >   its routines and it only uses exported symbols. Now the driver is
> > > >   essentially just a thin ioctl layer.
>
> > > Not having the driver available in modular form obviously makes
> > > work on the driver a bit more cumbersome.
>
> > Heh, depends on your development environment, e.g. I do 99% of my
> > testing in a VM with a very minimal kernel that even an anemic
> > system can incrementally build in a handful of seconds.
>
> Lacking a collection of big beefy development machines with 256+
> gigabytes of RAM isn't the challenge, rebooting to test functionality
> on the physical hardware is what is a bit of a nuisance.
>
> > > I'm assuming that the lack of module support is secondary to some
> > > innate architectural issues with the driver?
>
> > As of today, the only part of the driver that can be extracted into
> > a module is effectively the ioctl() handlers, i.e. a module would
> > just be an ioctl() wrapper around a bunch of in-kernel
> > functionality.  At that point, building the "driver" as a module
> > doesn't provide any novel benefit, e.g.  very little memory
> > footprint savings, reloading the module wouldn't "fix" any bugs with
> > EPC management, SGX can still be forcefully disabled via kernel
> > parameter, etc...  And on the flip side, allowing it to be a module
> > would require exporting a non-trivial number of APIs that really
> > shouldn't be exposed outside of the SGX subsystem.
> >
> > As for why things are baked into the kernel:
> >
> >   - EPC management: support for future enhancements (KVM and EPC cgroup).
> >
> >   - Reclaim: don't add a unnecessary infrastructure, i.e. avoid a callback
> >     mechanism for which there is a single implementation.
> >
> >   - Tracking of LEPUBKEYHASH MSRs: KVM support.
>
> I don't doubt the justifications, just a bit unusual for a driver, but
> this driver is obviously a bit unusual.
>
> It will be interesting to see if the distros compile it in.

We (Fedora) plan to as soon as it is merged. I even plan to ask for a backport.

> Thank you for the clarifications, have a good weekend.
>
> Dr. Greg
>
> As always,
> Dr. Greg Wettstein, Ph.D    Worker / Principal Engineer
> IDfusion, LLC
> 4206 19th Ave N.            Specialists in SGX secured infrastructure.
> Fargo, ND  58102
> PH: 701-281-1686            CELL: 701-361-2319
> EMAIL: gw@idfusion.org
> ------------------------------------------------------------------------------
> "We are confronted with insurmountable opportunities."
>                                 -- Walt Kelly
>

