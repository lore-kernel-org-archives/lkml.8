Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AB7C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40742073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="W9ucJkuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgBMOiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:38:15 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41422 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:38:14 -0500
Received: by mail-vs1-f66.google.com with SMTP id k188so3697147vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTGeYI1rpCsqzS+QJ2jyVVgmk5cKDUPQLxKut0+nk34=;
        b=W9ucJkukTXawT1/uYCRj+tzgedS2wBUfTDHsPBWH4SKU8cS9HEubTrrScplCjDeCZ+
         becVbWsme4CcNg0VmO/29KcbzhZJ1i1bb/Eaoo/58fFZk0nAOPkE0eK/NEtC3ddyBOO4
         mAiLjdZlTJaW3jaRuhH1H8/FR9KTQ/oRFHXnzTl/Vpzq0c9oMnmT6O7/pq/N24zNU4x9
         Vn6dUz2E2krBOdHqoF1iUMXDUP8VYP6DLQPsGYGDCsh5BuaC1XJAb67lV8BirO4ykdA0
         nGa0XpWmkrINl9E+4/gOhRtEUpEH+cCgDse46EmbDrucaR1cZ8t7pLRrTfihesQOT0bP
         +vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTGeYI1rpCsqzS+QJ2jyVVgmk5cKDUPQLxKut0+nk34=;
        b=omUFNAUGYRqnePh3VhEpeDIA9tFNWKGRYScu7WCiyTq88z5ya5Kpw0LnUHgvYot8ak
         y3dDiEBmjT0h80TyZvTck4VAZpUAD/jea5FHUj/5pe0xfGfOcrhqMV7rWwSALqpp8MGs
         gMaMKYnIKvKDNIgIRQulNZdShxVQc9uIXjjA83Ogi62m/5Al6zSh4sPBK1kSHOJr4Rvw
         0PBxR0qKSk/SR7dD+GEGIwBN2D6JuM3PTRM6ewAUR9RMDgKaHmQDoIhw0rGq63yYzv9O
         HUYqntTVIMAr2hd7DTluzr5clbv5MrHh7PJSmd/p1nPX/VVe76FQ5LCA5FaBvxaB2gfZ
         4QDA==
X-Gm-Message-State: APjAAAUdsludbQ8CiuML2BjDnMBU6SbJ6KmmseQMuUoNjeMxvpVsu+7I
        BragJO8T1A/vpAFyEe/oQDlu7qmUDQXSoZvvW74xrQ==
X-Google-Smtp-Source: APXvYqxoujzJqreZSsB/WPh/aTs8F/SEQ7VFh97HoWwvfNR4raoIerI/H7ivCHeAPwWd4SIuWEJeYl9pxSzUaBo7A8g=
X-Received: by 2002:a67:de85:: with SMTP id r5mr2308729vsk.9.1581604693763;
 Thu, 13 Feb 2020 06:38:13 -0800 (PST)
MIME-Version: 1.0
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-4-git-send-email-thara.gopinath@linaro.org>
 <CAHLCerMEieWMyk8RcM-y8c3Usq_e5CTYJ4AqhCQOzihRTUWbTg@mail.gmail.com> <5E4557B1.8020809@linaro.org>
In-Reply-To: <5E4557B1.8020809@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 13 Feb 2020 20:08:02 +0530
Message-ID: <CAHLCerNB3qSRG0cz+bW50h00Nbz+3s0rW0sjWjK5NL+6CbV2WA@mail.gmail.com>
Subject: Re: [Patch v9 3/8] arm,arm64,drivers:Add infrastructure to store and
 update instantaneous thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, corbet@lwn.net,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 7:35 PM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> On 02/13/2020 07:25 AM, Amit Kucheria wrote:
> > On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
> > <thara.gopinath@linaro.org> wrote:
> >>
> >> Add architecture specific APIs to update and track thermal pressure on a
> >> per cpu basis. A per cpu variable thermal_pressure is introduced to keep
> >> track of instantaneous per cpu thermal pressure. Thermal pressure is the
> >> delta between maximum capacity and capped capacity due to a thermal event.
> >
> > s/capped/decreased to have consistent use throughout the series e.g. in patch 1.
> >
> > Though personally, I like "capped capacity"  in which case
> > s/decreased/capped in patch 1 and elsewhere.
>
> I will fix this
> >
> >>
> >> topology_get_thermal_pressure can be hooked into the scheduler specified
> >> arch_cpu_thermal_capacity to retrieve instantaneous thermal pressure of a
> >> cpu.
> >>
> >> arch_set_thermal_pressure can be used to update the thermal pressure.
> >>
> >> Considering topology_get_thermal_pressure reads thermal_pressure and
> >> arch_set_thermal_pressure writes into thermal_pressure, one can argue for
> >> some sort of locking mechanism to avoid a stale value.  But considering
> >> topology_get_thermal_pressure can be called from a system critical path
> >> like scheduler tick function, a locking mechanism is not ideal. This means
> >> that it is possible the thermal_pressure value used to calculate average
> >> thermal pressure for a cpu can be stale for upto 1 tick period.
> >>
> >> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> >> ---
> >>
> >> v6->v7:
> >>         - Changed the input argument in arch_set_thermal_pressure from
> >>           capped capacity to delta capacity(thermal pressure) as per
> >>           Ionela's review comments.
> >>
> >>  arch/arm/include/asm/topology.h   |  3 +++
> >>  arch/arm64/include/asm/topology.h |  3 +++
> >
> > Any particular reason to enable this for arm/arm64 in this patch
> > itself? I'd have enabled them in two separate patches after this one.
>
> No reason. No reason not to as well as arch_topology is "Arm specific
> cpu topology file" and changes are one-liners.

One reason to do this, IMHO, is to keep platform conversions separate
from the core infrastructure in a series, so the core can get merged
while platform maintainers can take their time to decide if, when, how
to merge this.
