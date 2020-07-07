Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF60C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84E120708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oAhYJb3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGGNEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgGGNEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:04:44 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8123CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 06:04:44 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m9so18779473qvx.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3vCyH9yces12BRj3OiWTj9K/S80Ld9W3fkzJn+Hp168=;
        b=oAhYJb3YIr+QqdyG66wYt2hOm1J8utDn7lO7TMYNOFmAxXD3xRaj6WQei4kOIM1PB6
         P9mNqreAczhhJJ6l/zJ82QwVtL56a8dmu41XvcO4HJlrBCVWsYVFpkEGnLEk5uYjVRVs
         5dudlShmnAvX3n4CN002ngEIkhCNxAEshUH16pnG2VnMqw89/YIRalCc5ksx3d8a0s8Q
         U4VbFgTwdK/uoXhWmTBasiSMrss6abx1SJI8kiy2r3HB46fbsm6uCboAx6gp0pbkLGMJ
         7BA6lnPlkDYM0NNI8c0IgRSMATZ0lGYSj+ieFIfEb8XGvm855TXq2kvpUzlE7ayk30fg
         kiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3vCyH9yces12BRj3OiWTj9K/S80Ld9W3fkzJn+Hp168=;
        b=kLk19HarKf54Wshw+tn8fWvVh6mzwhKizoYL5T1J43gjCt570YmoTaOUcJgW34RCVf
         +zkN/tfSIFd2/2RbdBt6SKJHVuk5tVx6YTZEhK5IhlYP9xGsTFLJXzb6DQrwAJCC9II9
         4lG728KoJAux5hBap15gw1b0Ztz6wVZ5c7noKEBGSRFGuuLUdETo2Mf0yyX9bUeDAV5b
         RRHrBd3KHpe70gOTIj3MihZu5l/DnNPq9j2fZozy4toRR0t357jc3xHr3JTNn0EXDM/m
         T0YhK+LpBbybu1dGcb7GASMvhAewnQ+XJAaTRq4OQXCNaVFC9ADJDDTJoeYDu0p1Dx7O
         QFJQ==
X-Gm-Message-State: AOAM530UbKhR40TXa0p/aks+Fxvm1V//djCTKC0rCJmrgmJR6sgfC/Br
        06/ep94KLMIy/Uk3nN9KrkL3IA==
X-Google-Smtp-Source: ABdhPJzLmHCBVGXd4GRYHv4ovW8bAtVTdk2PkcT5qlvNEK8tsnikm6KWAJIG9Rb70HEoyZ4Fym4UKA==
X-Received: by 2002:a0c:a4e3:: with SMTP id x90mr22521958qvx.36.1594127083631;
        Tue, 07 Jul 2020 06:04:43 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x29sm19429137qtx.74.2020.07.07.06.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 06:04:42 -0700 (PDT)
Date:   Tue, 7 Jul 2020 09:04:36 -0400
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200707130436.GA992@lca.pw>
References: <AF8CFC10-7655-4664-974D-3632793B0710@lca.pw>
 <20200707120619.GO5913@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707120619.GO5913@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 02:06:19PM +0200, Michal Hocko wrote:
> On Tue 07-07-20 07:43:48, Qian Cai wrote:
> > 
> > 
> > > On Jul 7, 2020, at 6:28 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > 
> > > Would you have any examples? Because I find this highly unlikely.
> > > OVERCOMMIT_NEVER only works when virtual memory is not largerly
> > > overcommited wrt to real memory demand. And that tends to be more of
> > > an exception rather than a rule. "Modern" userspace (whatever that
> > > means) tends to be really hungry with virtual memory which is only used
> > > very sparsely.
> > > 
> > > I would argue that either somebody is running an "OVERCOMMIT_NEVER"
> > > friendly SW and this is a permanent setting or this is not used at all.
> > > At least this is my experience.
> > > 
> > > So I strongly suspect that LTP test failure is not something we should
> > > really lose sleep over. It would be nice to find a way to flush existing
> > > batches but I would rather see a real workload that would suffer from
> > > this imprecision.
> > 
> > I hear you many times that you really don’t care about those use
> > cases unless you hear exactly people are using in your world.
> > 
> > For example, when you said LTP oom tests are totally artificial last
> > time and how less you care about if they are failing, and I could only
> > enjoy their efficiencies to find many issues like race conditions
> > and bad error accumulation handling etc that your “real world use
> > cases” are going to take ages or no way to flag them.
> 
> Yes, they are effective at hitting corner cases and that is fine. I
> am not dismissing their usefulness. I have tried to explain that many
> times but let me try again. Seeing a corner case and think about a
> potential fix is one thing. On the other hand it is not really ideal to
> treat such a failure a hard regression and consider otherwise useful

Well, terms like "corner cases" and "hard regression" are rather
subjective.

> functionality/improvement to be reverted without a proper cost benefit
> analysis. Sure having corner cases is not really nice but really, look
> at this example again. Overcommit setting is a global thing, it is hard
> to change it during runtime nilly willy. Because that might have really
> detrimental side effects on all workloads running. So it is quite
> reasonable to expect that this is either early after the boot or when
> the system is in quiescent state when almost nothing but very core
> services are running and likelihood that the mode of operation changes.

Not really convinced that is only way people will use those tunables.

> 
> > There are just too many valid use cases in this wild world. The
> > difference is that I admit that I don’t know or even aware all the
> > use cases, and I don’t believe you do as well.
> 
> Me neither and I am not claiming that. All I am saying is that a real
> risk of a regression is reasonably low that I wouldn't lose sleep over
> that. It is perfectly fine to address this pro-actively if the fix is
> reasonably maintainable. I was mostly reacting to your pushing for a
> revert solely based on LTP results.
> 
> LTP is a very useful tool to raise awareness of potential problems but
> you shouldn't really follow those results just blindly.

You must think I am a newbie tester to give me this piece of advice
then.
