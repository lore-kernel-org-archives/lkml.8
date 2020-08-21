Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B1E20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="IORYYSgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHUVdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHUVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:33:00 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05101C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:33:00 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w2so2725411edv.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dekqT/9e5PdeM8sWswsA+oOJMSN8oLgPDWj1BwuZ1oM=;
        b=IORYYSgdCNFTn1PvikD7MWj5KJMBEC4w3neBYPhoHuZl3+1NadfWxOJzUnBl6of0uR
         LTiG3KN3prEReIIdaTIjxkNBTZWTd6k8ETvSrgPn2fIzIj5jMR6TA/1oaAx/KQwgdnLV
         07qffHl1uhiIujQ62NY3IqQ5kzpVeoamXgrsy3REzM7kN/q0ehYtJOTYZ90tRr3KAiKG
         AYdohTXLaDF/jn07aM+JpXkU0yTWwRUKAkEZUwCnqnrealdxKr3h8R4YKhiVuQ8mS8Z+
         PJp0vwU8fjUJ28lp7nf29xGo19Oanxu6uDGFztLYBU7HzftX0kGqPHVs+IHslg03Ju+r
         mdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dekqT/9e5PdeM8sWswsA+oOJMSN8oLgPDWj1BwuZ1oM=;
        b=JnLKBt7czpiS5Oy/DSCDG31SMbT0gsGzzIMPcU45OQRz/wEBYpIt62gP/UfHh4rG9C
         dV9YhOF6Q35NP6+njw1ONEHMSsIPIdZsTAfWXedt2sxUGa87qtvPeFaI1OdEddXqIFun
         efB0qawExMhghU+Sr/ywLTplMW6fY1b8yZEBkERE+NwssPhlQDNnzt708dYxFVhuhjPA
         pz97Q0guhRjYhVN5e9yluEujOYE3wmxAmWuDAiwRdsgyaJ3+/+LQ/n6TVTwruCg7I+5H
         1pFRrAMVJ1c/B7nGjViBTtoME65GY9N7wAGZ0DCdMS87sW6RTdcVrMtp4iYNjGJRAie2
         Li/w==
X-Gm-Message-State: AOAM532P0Da7qSyQJylLfbuVnZ4yBmzaaQLTbpHgQYK6yhVWx6/TPIXz
        hqmaY0H8q7ejRpfDkkhOvIQTN3rZUPoXD+cRRntrUA==
X-Google-Smtp-Source: ABdhPJxl8w752+O26JqyOdWAMNWy4Yq/ZQfEDJxbzsalwN4fVAhF7D0XRMkmJx/ev4NmSymkDfw53FsU226oStsd5nA=
X-Received: by 2002:aa7:da9a:: with SMTP id q26mr4929479eds.163.1598045578567;
 Fri, 21 Aug 2020 14:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Aq8+h6Y6t7W2GR_jJER5ghaHTH0wP81V-iYHxrR0Lk2vw@mail.gmail.com>
 <29FD0DDA-3093-46A3-BCF4-85DEC229E30D@intel.com>
In-Reply-To: <29FD0DDA-3093-46A3-BCF4-85DEC229E30D@intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Fri, 21 Aug 2020 14:32:47 -0700
Message-ID: <CAP045AqiT75B9o5OV+SJT8uTzo7A55Y1BxjNcaSuxtm5EoAxaQ@mail.gmail.com>
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Robert O'Callahan" <rocallahan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 1:08 PM Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
>
>
> > On Aug 20, 2020, at 21:41, Kyle Huey <me@kylehuey.com> wrote:
> >
> > On the x86-64 5.9-rc1 TLS is completely broken in 32 bit tracees when
> > running under rr[0]. Booting the kernel with `nofsgsbase` fixes it and
> > I bisected to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.8&id=673903495c85137791d5820d690229efe09c8f7b.
> >
> > STR:
> > 1. Build rr from source by
> >  a. git clone https://github.com/mozilla/rr
> >  b. mkdir rr/obj
> >  c. cd rr/obj
> >  d. cmake ..
> >  e. make -j16
> > 2. Run the simple 32 bit tracee outside of rr with `./bin/simple_32`.
> > It should print a message and exit cleanly.
> > 3. Run it under rr with `./bin/rr ./bin/simple_32`.
> >
> > It should behave the same way, but with fsgsbase enabled it will
> > segfault. The `simple_32` binary is a simple "hello world" type
> > program but it does link to pthreads, so pre-main code attempts to
> > access TLS variables.
> >
> > The interplay between 32 bit and 64 bit TLS is dark magic to me
> > unfortunately so this is all the useful information I have.
>
> As I run it and collect the ptrace logs, it starts to set FSBASE with
> some numbers, e.g. 140632147826496, and then later attempts to set GS
> with 99 through putreg(), not putreg32().
>
> With FSGSBASE, the FS/GS base is decoupled from the selector. Andy
> made putreg32() to retain the old behavior, fetching FS/GS base
> according to the index, but the putreg() does not do. So, rr probably
> relies on the old behavior as observed to setting the GS index only.
> But it was previously considered to be okay with this comment [1]:
>
>    "Our modifications to fs/gs/fs_base/gs_base are always either a)
>     setting values that the kernel set during recording to make them
>     happen during replay or b) emulating PTRACE_SET_REGS that a tracee
>     ptracer tried to set on another tracee. Either way I think the
>     effects are going to be the same as what would happen if the
>     program were run without rr."
>
> It is not straightforward to go into the rr internal to me. Robert,
> any thought?

Hmm. When we are running a 32 bit tracee in a 64 bit build of rr we
internally convert between the 32 bit and 64 bit user_regs_structs[0]
at the ptrace boundary. This does not preserve the fs/gsbase (because
there is no fs/gsbase in the 32 bit user_regs_struct, of course).

40c45904f818c1f6555294ca27afc5fda4f09e68 added magic for a 32 bit
tracer tracing a 32 bit tracee on a 64 bit kernel, but it looks like a
64 bit tracer tracing a 32 bit tracee on a 64 bit kernel *is* now
expected to preserve the fs/gsbase values (or die, in our case).

Is that correct?

- Kyle

[0] https://github.com/mozilla/rr/blob/fcd2a26680a3fc2bda5f40d732d0c72b9628357b/src/Registers.cc#L519
