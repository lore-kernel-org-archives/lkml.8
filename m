Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52005C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260E5207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzvI74TL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgFDPcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgFDPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:32:31 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA2C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:32:30 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id l10so1130490vsr.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YeM3iC830bcMzTR/1X2xHutiYoQDPBbG3PALEGjM+8=;
        b=KzvI74TLs01/oLy/0cPpC6nyVQBWh7hc3RQfaNxL10RgHvCd832kALaB4GKujiDV3/
         wpbTUQa54otkNkIZIBYOoiBhqO097n5dEeKWLE6N9iBzGO5CI4nQJAQKhpDTovNFnQr1
         SkQFzt/JiYGju9JqXH7m84Ghor0YnnzVTE2nS8N/cGqYM0EAecbz3xdQSDXj/v5e1ppO
         gcmzX7g3ZsKtcodoagZ+lhIR5/hX8p4BW9Qc7QS9jyGEy9Ej1OKDe65+4jUxiqElw6Ge
         bSGYzTf96Vitl69+ScdmDwrpElUmavWznW6NoyaNVSBUdX0hJWYgJ6VHBARXDlo2dInM
         xREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YeM3iC830bcMzTR/1X2xHutiYoQDPBbG3PALEGjM+8=;
        b=E5HQmxwGYfNCx6+erfJnDoneP/4y2cE4JnUkMnfMx/jnlgAu3ELMCYih/0v9A03O0d
         mP3mNGGpkuMH0dd6bhKll5zCChcvdQ/wwtbuacj+xsXaMClEPdf72MRHVTWB3CQumtpz
         K4ffqf1djS3hMdnmNNIPYqNlSQyws4zOgbawHvGU2Q1X8M95MzhPNJJ1m1G7+CbUvaHu
         BXKqZE7XpWmWdoEO2XKOkPPEYADyVHhTVBU0DE2suEOs/EVqv2nY2Yx27MgRwxjcVKiz
         MMOSc0CM8te2aMzR4EopFwxMvG155Aenq4FSqaqhav20zxQDvE1mh93btEak9aX8WW5B
         5Otg==
X-Gm-Message-State: AOAM533mjcR2Jon9hQB5eGnw55KD7A4kp0lDRer94Ci6hjUe5aUZBnhy
        Uyjla7RhOM2yDBgZcyPbsGbpMXpCBL99LPlk9U9D4A==
X-Google-Smtp-Source: ABdhPJx2fa1vWpZaxY5fdy+Mx4yS8qnGtleOmW6eUw0Nisc0u92OLMiJ7DIL+sJ8WMh9jhPlRPn1yPZuw/MLdR8uwzQ=
X-Received: by 2002:a05:6102:3195:: with SMTP id c21mr3530209vsh.31.1591284749590;
 Thu, 04 Jun 2020 08:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200527224659.206129-1-eranian@google.com> <20200527224659.206129-2-eranian@google.com>
 <20200601123850.GA213137@latitude> <CABPqkBSKF_4BpXxT=LDb786cW5euuOk7oUbnem5=P6BpMtk0ZA@mail.gmail.com>
 <20200604131141.GA678989@latitude>
In-Reply-To: <20200604131141.GA678989@latitude>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 4 Jun 2020 08:32:18 -0700
Message-ID: <CABPqkBRbh4XAQ2_5Zx0kx_vANrZjb=N8M6ZeR0px269Nbs1w_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] perf/x86/rapl: move RAPL support to common x86 code
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Ian Rogers <irogers@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 6:11 AM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> On 2020 Jun 01, Stephane Eranian wrote:
> > On Mon, Jun 1, 2020 at 5:39 AM Johannes Hirte
> > <johannes.hirte@datenkhaos.de> wrote:
> > >
> > > On 2020 Mai 27, Stephane Eranian wrote:
> > >
> > > ...
> > > > diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
> > > > index 6f1d1fde8b2de..12c42eba77ec3 100644
> > > > --- a/arch/x86/events/Makefile
> > > > +++ b/arch/x86/events/Makefile
> > > > @@ -1,5 +1,6 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > >  obj-y                                        += core.o probe.o
> > > > +obj-$(PERF_EVENTS_INTEL_RAPL)                += rapl.o
> > > >  obj-y                                        += amd/
> > > >  obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
> > > >  obj-$(CONFIG_CPU_SUP_INTEL)          += intel/
> > >
> > > With this change, rapl won't be build. Must be:
> > >
> > > obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)                += rapl.o
> > >
> > Correct. I posted a patch last week to fix that.
> > Thanks.
>
> Yes, it just wasn't in tip when I've tested. Sorry for the noise.
>
It is now. All is good.
Thanks.

>
> --
> Regards,
>   Johannes Hirte
>
