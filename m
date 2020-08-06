Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A217C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D42320855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596748829;
	bh=ygf/hb4i36coL4CczX40u4QnxwWRJdvMHAOD9f9QBQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MCTogM2I6AoYsiO13o4MgrFRMk2MFXRmF8jTdpsY/+AHQxIzx4P7jrghCS7kR9RXQ
	 mNgcF9Xv86FvYS/I+5ALiAwY4DHtd/vS7ZNk3989az08prV1s/OJZzrGqBdiuSyFmd
	 IRccWxr+/d6jJMTr7+CdazKFSSi4HcpKnJ9ehpzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgHFVU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHFVUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 17:20:25 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B10C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 14:20:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so29222864ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 14:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YPR3MpC9gaaLsW0X+php5boRYjdOPKrvx3E/iijH0gk=;
        b=HE8B2DmVifyo0nqaNyh7XDBI7+2DXl+L9P41CpkBK8KPpuOmZAMltB1xFOi4g+PXCP
         gn9jj04PBHu9uTDUY8yM5xmxKK1OQj2zVwq3TUEicU+yuCnLx2ZYiv7PQ3sbT+hGsgBq
         LQvvR4FbJ4VFsvQxl8C7TNTF1Df4i1ktRurm5Q08sNAc+H+z4nhiVMkEpr209mswEGIt
         rv2Yr8P2QSC0f+yxh3P/Pnem9Yts409INt/XtmQCynTtQSpyuG/rYDsGo7FwZzSEMo7E
         gBq3lYTn0Slka2lXPbr48xDD3VjTP5imirBA8fSF+/u6WoECA8PNi5jE5GMzRCDpbPIb
         J/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YPR3MpC9gaaLsW0X+php5boRYjdOPKrvx3E/iijH0gk=;
        b=SFOBktwUpeB65FCYmNX/wzHoOWfxkP0mN5ZZOwsNiSMvbUtiqKJH3gPJp/VYeaRhMk
         +hgBCoTRtBjrNytIZWd3N8uY7NQlptI1izmTXRjCKOgh25j6z0gF1FWtEJSb6uREBFkq
         +dDsmqaBN/8Mr3qNMWfNLK7OWbvr3gRJPrCegIY8+qLYj/jgCSMZS7mEXsYFYhaRMzXe
         7kzGmvExBnXa3zRfXeQnBuNVtRNx6qsKwC5470oB6/wAF5F/pn86XICINtLytMCPYALZ
         s2M6n/vx9Ag3XvT3me5NKyj3Uxr5zktF8cs9KU/am1kO8/GH4Bp2wAo6TEIHGAJWmsen
         LgvQ==
X-Gm-Message-State: AOAM533H8j65HllwBzFDoLxmEQzlpXeXVqT8Ww2qBbzgU3LQXaBP3dTG
        5Fn78qeavI+IAyHw7CYAqDw=
X-Google-Smtp-Source: ABdhPJwONwSI+hK/dWY/sp/sqhTBQIRYbswq5rF10Q54H/ucMDZ1Vmu4dmXGa4gRiRB0yJ7z1lp2tA==
X-Received: by 2002:a17:907:2712:: with SMTP id w18mr6035728ejk.473.1596748822201;
        Thu, 06 Aug 2020 14:20:22 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s5sm4536747ejv.67.2020.08.06.14.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 14:20:21 -0700 (PDT)
Date:   Thu, 6 Aug 2020 23:20:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200806212019.GA2149204@gmail.com>
References: <20200803190354.GA1293087@gmail.com>
 <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com>
 <20200806185723.GA24304@suse.de>
 <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Aug 6, 2020 at 11:57 AM Joerg Roedel <jroedel@suse.de> wrote:
> >
> > On Thu, Aug 06, 2020 at 03:10:34PM +0200, Ingo Molnar wrote:
> > >
> > > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > > So apparently the "the page-table pages are all pre-allocated now" is
> > > > simply not true. Joerg?
> >
> > It pre-allocates the whole vmalloc/ioremap PUD/P4D pages, but I actually
> > only tested it with 4-level paging, as I don't have access to 5-level
> > paging hardware.
> 
> I don't think Jason has either.
> 
> The
> 
>         PGD 0 P4D 0
> 
> line tells us that "pgd_present()" is true, even though PGD is 0
> (otherwise it wouldn't print the P4D part). That means that he doesn't
> have l5 enabled.
> 
> But you may obviously have different settings for CONFIG_X86_5LEVEL,
> and maybe that ends up changing something?
> 
> But since apparently it's not immediately obvious what the problem is,
> I'll revert it for now.

I've reverted it in x86/urgent as well earlier today, can send you 
that tree right now if you prefer that route.

Thanks,

	Ingo
