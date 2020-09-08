Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7900FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E13B2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbgIHTTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:19:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43863 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732010AbgIHTSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:18:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id f18so11772425pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNtUGfwNy6biI3vtFA0ivt71Ld8XhVWKn22zfdXb+l4=;
        b=pyeRjrZIXM6e61vVvzDZFenxEdI48BbaYXEu7vnlzALHjuA8GrQC9FOyUDKI1UADtV
         MkDjbRLe8C49NNU+5OoblHtXE+iy0LzTjHlLMYtmZJ7cQxyMbJRxABAV0bbJa3c89z6w
         aIW3pQkOM6585xLTdPfTZB2MgWo5iLOruJGEThZUeaXBUu7yT/HlDGvolwdz3Dw3d3RH
         ClrozoSXB+t4Fjk4W3udQlbVbQ98sNrkJn+ZMf/Gn4iEtK9OUdsHxFurqFo0HhER+70C
         vlCJ2SXVaRxMpNDl2iohMkmkzyGNidW3aE2mFcdSsFIOFMg5y9Qm6RW3nDl/hyxXGpU4
         w07A==
X-Gm-Message-State: AOAM530U/NCtNl4/MT2I45sFgparDMTvjzZgyZt0TH90w22TnO86JUTq
        +/biiC4jw2qglWpfxvp+F/2gDPNCGwQ=
X-Google-Smtp-Source: ABdhPJzlx+4x/a9RJHeCc3UiL9N681GCAlZUOZI9zdgDvmujeGHrJ3xK8y0f/xMsO+5xcoHEGPkkcQ==
X-Received: by 2002:a62:f904:: with SMTP id o4mr285777pfh.14.1599592723078;
        Tue, 08 Sep 2020 12:18:43 -0700 (PDT)
Received: from sultan-box.localdomain ([2607:fb90:80c7:1f9e:6b7e:e1b1:f946:74e])
        by smtp.gmail.com with ESMTPSA id 194sm201124pfy.44.2020.09.08.12.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:18:42 -0700 (PDT)
Date:   Tue, 8 Sep 2020 12:18:38 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20200908191838.GA2014@sultan-box.localdomain>
References: <20200907094843.1949-1-Jason@zx2c4.com>
 <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
 <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
 <20200908172558.GG25236@zn.tnic>
 <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
 <20200908173656.GI25236@zn.tnic>
 <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
 <20200908180112.GK25236@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908180112.GK25236@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 08:01:12PM +0200, Borislav Petkov wrote:
> On Tue, Sep 08, 2020 at 07:42:12PM +0200, Jason A. Donenfeld wrote:
> > Are you prepared to track down all the MSRs that might maybe do
> > something naughty?
> 
> I'm not prepared - that's why this MSR filtering. To block *all* direct
> MSR accesses from userspace in the future.
> 
> > Does `dd` warn when you run `dd if=/dev/zero of=/dev/sda`?
> 
> Yah, because that's the same as bricking your hardware. Geez.
> 
> > Probably not possible. Optimal values are related to the "silicon
> > lottery" that occurs when you buy a new CPU. Different optimal values
> > for different individual chips.
> 
> Let's wait for what Srinivas finds out. I'd let Intel decide what they
> wanna do.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

I'd like to point out that on Intel's recent 14nm parts, undervolting is not so
much for squeezing every last drop of performance out of the SoC as it is for
necessity.

I have an i9-9880H laptop which, at 4000 MHz on all CPUs while compiling a
kernel, uses 107W with the stock configuration. Upon undervolting, this figure
goes down to 88W, a ~22% reduction in power consumption at the maximum pstate.
The point of this is not primarily to reduce the power footprint of my machine,
but to get the thermals of this CPU under control. Without undervolting, my
i9-9880H is quite useless, and quickly reaches 100 degC with the fans at max
speed when placed under load.

The 22% reduction in power consumption also makes it clear that these parts use
very heavy-handed voltages out-of-the-box. I consider this to be a defect in the
part; I've never encountered any other CPUs that run, by default, at a voltage
so high that I could achieve a 22% reduction in power consumption by
undervolting.

I've tested multiple 14nm Intel CPUs, 8th gen and above, and they all exhibit
this behavior. On my i5-8265U laptop, compiling a kernel causes the CPU to hit
its 35W power limit and run at about 3300 MHz instead of its maximum all-core
frequency of 3700 MHz. After undervolting, when compiling a kernel, my i5-8265U
runs at 3700 MHz and uses 27W; not only was power consumption reduced by ~30%,
but also performance was improved. Not to mention, my i5-8265U laptop's thermal
design cannot dissipate 35W for very long, but it can sustain 27W without
reaching 100 degC quite well.

If Intel's recent 14nm CPUs didn't guzzle power, then we would have no need to
undervolt. But they do, and here we are.

Sultan
