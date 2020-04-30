Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D252C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DDC2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKOnI1/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgD3Qfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgD3Qfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:35:52 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7FC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:35:52 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b12so2134493ion.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHOM9ScIACBAlj+EOQQZskvxADzU4dEs6BpxOZoTWCg=;
        b=DKOnI1/+M5kE4JIw2Yp+nF/RAd2KxfFdck3bIvzB9AlctHyy+RL1/A4oFRifDlFDEi
         0HGkvP4KvdCdEiWI0FOxU1i/5oaMPU9AQ604Ft4OEZSfP6sSdZMBMFR3ppk0v8YSwefO
         lOIJjZR+alCUq3QcUCj+hoKzU3y8Oq/vJ6riI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHOM9ScIACBAlj+EOQQZskvxADzU4dEs6BpxOZoTWCg=;
        b=AC32CITGmgsGN7Wv/DDJ2K4I9k+Xjm1tEVfrr+6U/pQ+82BsF1DYRA5Pa/fgBR4feD
         Wts4IyQkDjDhIK1oKTMELcBpEV7jl1gWAsXeiM/mp6pc451KgZhWiybV2EyBCS1uf7AM
         13MyHRDW4K8qqQl/roQe/7RJx4XqDKZG1uN0bFvT3wAOtKDAyZ1XaZyAw366fvUSwdtj
         hLpQ6OdxXzCUM47zWjf8IGdGuBPej3TGiQltPpuBApKZsXzxRb5MozfZtqp9BfJkab06
         /QhcRYQaA3w6aVWrSHYVG4rHLq2hUAfPuu7i5Ph7Hma2Ov3fIlHt4kSPG7x3UjkShn0F
         XlWg==
X-Gm-Message-State: AGi0PuZsxCJjraQID1UAj6TPSQkxu9vnfJmXZpBXqv2ItrvdvOpK27Km
        ZsEXZ1A3oH+wzy1bBGLAbYgLNjOn2Tw=
X-Google-Smtp-Source: APiQypIpS6n3oxNtmpOMu5Ddm4IVYYVOfiXKKuagiYYK4/u8tsASTQTTbQk3A55jjgGFgcvTcTJMKg==
X-Received: by 2002:a6b:6c0a:: with SMTP id a10mr2820947ioh.140.1588264551712;
        Thu, 30 Apr 2020 09:35:51 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id q29sm108171ill.65.2020.04.30.09.35.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 09:35:50 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id x2so1930465ilp.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:35:50 -0700 (PDT)
X-Received: by 2002:a92:ca81:: with SMTP id t1mr2769977ilo.187.1588264549492;
 Thu, 30 Apr 2020 09:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200428211351.85055-1-dianders@chromium.org> <20200428141218.v3.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
 <20200430154927.vhkhoffqwirb2fmm@holly.lan>
In-Reply-To: <20200430154927.vhkhoffqwirb2fmm@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Apr 2020 09:35:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ut7kHr+V_+Yyk=+NC5qBrKEQ+O6Ra4HRHs5XoAHFcWeA@mail.gmail.com>
Message-ID: <CAD=FV=Ut7kHr+V_+Yyk=+NC5qBrKEQ+O6Ra4HRHs5XoAHFcWeA@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] kgdb: Delay "kgdbwait" to dbg_late_init() by default
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-serial@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>, bp@alien8.de,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 30, 2020 at 8:49 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Apr 28, 2020 at 02:13:44PM -0700, Douglas Anderson wrote:
> > Using kgdb requires at least some level of architecture-level
> > initialization.  If nothing else, it relies on the architecture to
> > pass breakpoints / crashes onto kgdb.
> >
> > On some architectures this all works super early, specifically it
> > starts working at some point in time before Linux parses
> > early_params's.  On other architectures it doesn't.  A survey of a few
> > platforms:
> >
> > a) x86: Presumably it all works early since "ekgdboc" is documented to
> >    work here.
> > b) arm64: Catching crashes works; with a simple patch breakpoints can
> >    also be made to work.
> > c) arm: Nothing in kgdb works until
> >    paging_init() -> devicemaps_init() -> early_trap_init()
> >
> > Let's be conservative and, by default, process "kgdbwait" (which tells
> > the kernel to drop into the debugger ASAP at boot) a bit later at
> > dbg_late_init() time.  If an architecture has tested it and wants to
> > re-enable super early debugging, they can select the
> > ARCH_HAS_EARLY_DEBUG KConfig option.  We'll do this for x86 to start.
> > It should be noted that dbg_late_init() is still called quite early in
> > the system.
> >
> > Note that this patch doesn't affect when kgdb runs its init.  If kgdb
> > is set to initialize early it will still initialize when parsing
> > early_param's.  This patch _only_ inhibits the initial breakpoint from
> > "kgdbwait".  This means:
> >
> > * Without any extra patches arm64 platforms will at least catch
> >   crashes after kgdb inits.
> > * arm platforms will catch crashes (and could handle a hardcoded
> >   kgdb_breakpoint()) any time after early_trap_init() runs, even
> >   before dbg_late_init().
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> It looks like this patch is triggering some warnings from the existing
> defconfigs (both x86 and arm64). It looks like this:
>
> ---
> wychelm$ make defconfig
>   GEN     Makefile
> *** Default configuration is based on 'x86_64_defconfig'
>
> WARNING: unmet direct dependencies detected for ARCH_HAS_EARLY_DEBUG
>   Depends on [n]: KGDB [=n]
>   Selected by [y]:
>   - X86 [=y]
>
> WARNING: unmet direct dependencies detected for ARCH_HAS_EARLY_DEBUG
>   Depends on [n]: KGDB [=n]
>   Selected by [y]:
>   - X86 [=y]

Ah, thanks!  I hadn't noticed those.  I think it'd be easy to just
change the relevant patches to just "select ARCH_HAS_EARLY_DEBUG if
KGDB".  If you agree that's a good fix and are willing, I'd be happy
if you just added it to the relevant patches when applying.  If not, I
can post a v4.

-Doug
