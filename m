Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9492083E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rd1riGz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGBChv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgGBChu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:37:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8C5C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 19:37:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so10683188pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E6qbMlZ2Efi0OnOWp1DIBcuwZU3AyV6M/I4efZUFWaQ=;
        b=rd1riGz5u1jk9KczDNJXRDIkj0NTKkAhfsqIiYDHCcSsb8ey6U0F1lFO9QGss6CNbt
         Ip86QpCH2sEZK9SlOx8nKnf+n7jnVHXxm4NDfae5aC7viKXQaHcBWLTHnT6GbUzbeB7Q
         Mt8RBMyjd5iZNseSUs4Hz9hF/NbUBjYL8aSdfWs72ZYYvmAzNw6GXFglngdNHIGl6Jz2
         SMxgCUVkKjoKBbxwdlXXC2OdpN0OV92nz91NjSWmYWmnCZa4dxe/J3mmJBCHoiqT3lhm
         Pvp1PNtK7P8ThpAdcqJDe7TNdWDTx6ealZ829ZRwwmdUPNhjWCw6ivyfs/J10c3DFw7X
         MkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E6qbMlZ2Efi0OnOWp1DIBcuwZU3AyV6M/I4efZUFWaQ=;
        b=EIAObv5V48aqqySAXFzeXyZ8pyxWcfooUgeNBTU3P9G1lpvCOsvpOJv5EgHfiOgNsY
         9+cyOjN9B2aALvOsMfdQYznJrH5UUdsN24cXg/2+UhLd4ERK/uE0ldeE/mw5j9ccyorn
         l4bNT6uIn01hfNh7WP+FyAXgsIJOI5y+08965q4zEBHY3i3ele+K/OUI860g6Xh38U3L
         ZLbL1R7v1BKc3R4fPJFEdfyzf0vmjRRGa2fyxdQO44lO5/xfJrKm0hwF3jP8dTHM5jtC
         sMb7CkZGCtI2R8tuvKmzTW9aFctV/DIvTYOZda/X8j18TQBPNyTGTwF8k7ip3CxoL7X7
         mZ4A==
X-Gm-Message-State: AOAM530nsjSNebOVwlYLPP+gz5VVUCQsCJApeVknbwyc0QKmq2wnaGTC
        3SWvChp1LJNoxFoP/U14oYR9bjiyqxw=
X-Google-Smtp-Source: ABdhPJzWA2sCClagfIdhuHoEOvXzH6EhJArvtlPVjv9hibIidWhx1A4wpf9A1PD40eqx9Md3bEahxQ==
X-Received: by 2002:a17:90a:6a03:: with SMTP id t3mr30648268pjj.174.1593657470066;
        Wed, 01 Jul 2020 19:37:50 -0700 (PDT)
Received: from localhost ([223.235.247.110])
        by smtp.gmail.com with ESMTPSA id io3sm235298pjb.22.2020.07.01.19.37.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 19:37:48 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:07:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
Message-ID: <20200702023746.li2uf4zl7bwzg62x@vireshk-i7>
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
 <20200701045227.epojzjwuky5kkdzj@vireshk-i7>
 <CAJZ5v0iRW25n9CqvJ=ODbVh2osocx+wJVz62GqaWV9m4sdL12g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iRW25n9CqvJ=ODbVh2osocx+wJVz62GqaWV9m4sdL12g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-20, 14:16, Rafael J. Wysocki wrote:
> On Wed, Jul 1, 2020 at 6:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 01-07-20, 12:20, Xin Hao wrote:
> > >  The 'caps' variable has been defined, so there is no need to get
> > >  'highest_perf' value through 'cpu->caps.highest_perf', you can use
> > >  'caps->highest_perf' instead.
> > >
> > > Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> > > ---
> > >  drivers/cpufreq/cppc_cpufreq.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > > index 257d726a4456..051d0e56c67a 100644
> > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > @@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
> > >               if (!max_khz)
> > >                       max_khz = cppc_get_dmi_max_khz();
> > >               mul = max_khz;
> > > -             div = cpu->perf_caps.highest_perf;
> > > +             div = caps->highest_perf;
> > >       }
> > >       return (u64)perf * mul / div;
> > >  }
> > > @@ -184,7 +184,7 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
> > >       } else {
> > >               if (!max_khz)
> > >                       max_khz = cppc_get_dmi_max_khz();
> > > -             mul = cpu->perf_caps.highest_perf;
> > > +             mul = caps->highest_perf;
> > >               div = max_khz;
> > >       }
> >
> > Applied. Thanks.
> 
> I applied the previous cppc_cpufreq patch, hopefully it will not clash
> with this one.
> 
> Are you going to take care of this driver going forward?

I started picking up the patches for this driver as it was mostly ARM
stuff and FWIW, I picked the previous one as well and because it was
sent by me, I never replied with the "Applied" message :)

Will it be possible for you to drop that one? Or should I drop that
now ? There shouldn't be any conflicts for now though.

-- 
viresh
