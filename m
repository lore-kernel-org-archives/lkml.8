Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B94C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADD6206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRRYgo72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgFATqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgFATqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:46:18 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49C7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:46:17 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k13so622322vsm.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4/267JR0EUM8P7aNFKR9/JTE0cS/k04+kTF3FvR954=;
        b=KRRYgo721tgdTC6QtaR6bloVPk+pwi1TgI/iDoFNch9VO1Jm7B4kRaGmCjL3x0kwxX
         7nzRwNcY0BjhX+8v22DAjel7SF09UcpMuGz9jyTHYyelqfU9jaqTzPRMlpDsBfLhn31G
         hOQEvTiGS9iMWguQuQAirRquTlfJ6b4MolQOrxeBPm1jcWqJHRRnhBgt9Xc08ITMTZQk
         tkkqeJZrZiwwppkdt5h0vgCe18n0LICKWhT0qbYZ4xMFTosay4dA13vCOKjft2JKdN+B
         ZYXfewfwPcMobN+Qhpe2M+mkWLHrtop9/Zkez1ZF3mwHyoW8nAEsraOuX/eOgLfTceN5
         KbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4/267JR0EUM8P7aNFKR9/JTE0cS/k04+kTF3FvR954=;
        b=VE0egQszimYokh4RDL5LOr9oPw3ZbfjIg6locxBv5EgsEDlWr3fk76P7AFEMHEBbw6
         2/EQvExq9wXynVatiVsqvMNXNOe+YO22t3Teu5YUTmEa0Pe8xkJ1ra3FLL4s2tRFSHOe
         ilRfAW5gZj1WWLH6rLuuBBUOAx/eMAQJH9tuqvoBh1ou1MlyLlKizPfdxFy8SyYpB/Ss
         TmOZN5MMtUgy7c/q9mKPERNvw2eXAHsGeZ8+MPodWkDenQHPAiwxNX24DA6C5p2uiDym
         Fp4S5uinzavAlWIS/N1rj15jyso7t3PcDEfiSs+UQP4qd68nZws86fcmH+lVdGKbt7Zn
         aQaA==
X-Gm-Message-State: AOAM531JM3pO/DeodqTs8iFzoERnUeHu9uttmnkfCrZQjebl8cLwcsQD
        rMvcl5DZTCWJRAjz0nLK+DmFyr0KlHvZL0i4bxuWPg==
X-Google-Smtp-Source: ABdhPJzhsZMIOkLxRlCryENw9GFRpPPYCI1jogAb4M2TvHgDhPvlf3+NgYUNz+c3lSA9KNbrvHoktly/4D/PjCj/d1g=
X-Received: by 2002:a67:c18a:: with SMTP id h10mr3756469vsj.186.1591040776950;
 Mon, 01 Jun 2020 12:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200527224659.206129-1-eranian@google.com> <20200527224659.206129-2-eranian@google.com>
 <20200601123850.GA213137@latitude>
In-Reply-To: <20200601123850.GA213137@latitude>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 1 Jun 2020 12:46:05 -0700
Message-ID: <CABPqkBSKF_4BpXxT=LDb786cW5euuOk7oUbnem5=P6BpMtk0ZA@mail.gmail.com>
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

On Mon, Jun 1, 2020 at 5:39 AM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> On 2020 Mai 27, Stephane Eranian wrote:
>
> ...
> > diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
> > index 6f1d1fde8b2de..12c42eba77ec3 100644
> > --- a/arch/x86/events/Makefile
> > +++ b/arch/x86/events/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-y                                        += core.o probe.o
> > +obj-$(PERF_EVENTS_INTEL_RAPL)                += rapl.o
> >  obj-y                                        += amd/
> >  obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
> >  obj-$(CONFIG_CPU_SUP_INTEL)          += intel/
>
> With this change, rapl won't be build. Must be:
>
> obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)                += rapl.o
>
Correct. I posted a patch last week to fix that.
Thanks.

> --
> Regards,
>   Johannes Hirte
>
