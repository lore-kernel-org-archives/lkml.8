Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D66C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958722085B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeK5pDhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgFPVZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgFPVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:25:41 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BD7C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:25:39 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y1so16748987qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=28r6rliKpqrCrvOQBglemhj8yF+v/viU6nj7dTvpNtg=;
        b=OeK5pDhrtzVUVkfVTUbnaq+kERfXKgC/EHygCLbka0ktT88f4wphdrwWH7iaI0gZE5
         dhBi/XcuJIpyJaOZAlOA311+oRfwvtOlpNkmGRvwMEo14ALT4wCcKzWnijzOuDnqVqMS
         3khRbyqJoncHD/VMXoJzPznzZnyZpqe836HtjXL3GGc7W4WYF8sb/s1OUj1OxrLW2JrL
         1x4K4YkbtV4oOBc++SZOspKosQjaVEHBYjhkZ+/IHfZcD4Uc4+OevcN/ScmCei1Tujpx
         jbJwXdjRmLBejx8J1WU6iipJSfgCkkR43ZvRjvjx8lWDI+El3A/YFUBm8MNviQi3FgMI
         TI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=28r6rliKpqrCrvOQBglemhj8yF+v/viU6nj7dTvpNtg=;
        b=n/ptvPNpy9uddzhBR+rdXHG110jxPTtXXnJ3q2d7JCCrs1S2g0+J2Y+pt5MjmlfvK5
         6vq383K1b24ZHSADBjikn5t1c06DkV2zk3anf2r5L22qP63pD5gQbgs8QHCT57U4UehT
         u/RK54u7z6JAKANwgoEc35UGxsaZu77cB8t6HLn7ChyAI9a4Nk3NzdygRH4bAM758F2Z
         HRyulLvddXxKMfsFjyISUq5QQJXvpD1R7Z2N5IZGUeRjkYApr3xDCDd8z0Wd/4hIU0Vk
         /jOBC/KHftcan/Yrty9w3ReiPgw6hdhE2EWldy79hK8nZOWeHeWV67GWpUSwfn7cqjpm
         BEhA==
X-Gm-Message-State: AOAM533C1G6c1N0KnkrfTGR3O+JyD3eWJqKDiLPtuGFwGl/MLBF6wASk
        Q4ISL8t1Zfq76zrwTQ5ZdYk=
X-Google-Smtp-Source: ABdhPJyM3USefraMr7uTM3M9cjs1gHPnJaY2iTRNhp2h3RXRhhkTS9K7Hn/Q68D7gClJZLU2Dsf5RA==
X-Received: by 2002:ac8:3a06:: with SMTP id w6mr23118281qte.199.1592342738719;
        Tue, 16 Jun 2020 14:25:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i14sm14622118qkl.105.2020.06.16.14.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 14:25:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 16 Jun 2020 17:25:36 -0400
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Linux 5.8-rc1
Message-ID: <20200616212536.GA1934393@rani.riverdale.lan>
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
 <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com>
 <20200616203352.GA1815527@rani.riverdale.lan>
 <CAEJqkghzD_6F2N=M65uYHzpOOJ8bvMw18JCfwsiQoH-kToPKLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEJqkghzD_6F2N=M65uYHzpOOJ8bvMw18JCfwsiQoH-kToPKLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:17:08PM +0200, Gabriel C wrote:
> Am Di., 16. Juni 2020 um 22:33 Uhr schrieb Arvind Sankar
> <nivedita@alum.mit.edu>:
> >
> > Can you attach the output of gcc -dumpspecs and gcc -v? I suspect your
> > compiler enables stack protector by default. My distro compiler does
> > that too, but not if -ffreestanding is enabled (which it is for the
> > purgatory).
> >
> 
> Files including config uploaded to there:
> 
> http://crazy.dev.frugalware.org/kernel/
> 

Yeah, your gcc doesn't have the -ffreestanding handling. Mine (from
gentoo) has this in the -dumpspecs output:

*cc1_options:
... %{nostdlib|nodefaultlibs|ffreestanding:-fno-stack-protector} ...

to switch off the default ssp when the standard libraries aren't available.

> > Does this patch help?
> >
> 
> I'll test in a bit and let you know.
> 
> > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > index b04e6e72a592..088bd764e0b7 100644
> > --- a/arch/x86/purgatory/Makefile
> > +++ b/arch/x86/purgatory/Makefile
> > @@ -34,6 +34,7 @@ KCOV_INSTRUMENT := n
> >  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> >  PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
> >  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
> > +PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
> >
> >  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
> >  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
> 
> Thx.
