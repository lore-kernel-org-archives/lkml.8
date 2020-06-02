Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202AEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5202072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591140543;
	bh=50m9ED15fKYEF85+bncX8Hs4OfHZcurbbNPFCWyRsbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nRNAl5V9bmHgxHBq1HcoJzkKlgDuUjPgaffqOtm7SAgvV0lz/sUb+/txMJWSNmh4T
	 0K/b+Q/I17W07aUvUH0VaMnPGF4Dkedey8a94CfMFAhLel7FFzR9IEGyQRrmKHo9Nk
	 BkwqBaqaAgvckfr5uAfVIf+/KhGc8XswG5shXkK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgFBX3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgFBX27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:28:59 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1CDC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:28:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z18so331561lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjaU90Aqma95VsfOo2nizNA7PtUJ8ixbSgrVzYoKVZg=;
        b=O70cWbESKcocnY6Rm2LHbtj+/wDRLhMaZyD0QUV1oRWgIVbLODxahUb5+xk9qw9vrp
         L3AxrnpvUnYdzly11Nujw9UYnH2Pgc71UC26t8WvoMXs5dM1rKr/0chn4rmhHjEl+Uzm
         Mv+OfIfXSwr2nCko/k/DnMkWNZM/z4+dEjImk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjaU90Aqma95VsfOo2nizNA7PtUJ8ixbSgrVzYoKVZg=;
        b=U7djAmzG6wyFMTw/dyQQdhSonIOTZUdl3P6xJYJ1dl9W+uXeQvsnXTxy8/w9e+uUVW
         6t1S7CjIFH0xXb4yDNOXtbAydtJ5M9KrXZ/5Y1u8X7x9xo4c6ojaZc4ywLQPcBOkTku9
         aK+HnH0d6mUVayeLO6/k7OiqdnVbiiVBORPU29cKoCSpHYGevhzI8XADKqPG6yjj99VT
         PY5vumjSjUp5ZX63cpqCeLncKIngGxDMfllr9IivslcJHQpDNZSIf9tGbZm+xYIcGLJ2
         OervlWAclrnjg3ddBzi5THwlJoHdVvYcnU+qegJpYfgO+GE0B7bX9pginFyIKce1QgvE
         FNQA==
X-Gm-Message-State: AOAM53092FsHzbKuaDVIdXpBPtBb1ti95YyQVFpC+OzZRrzFZqWS1xnD
        T8Q5itA9B5L5UuMn43DZMmFsCU7Q2P8=
X-Google-Smtp-Source: ABdhPJxw0k/0KPLGOhuMi25pXJLqvysSPmibTJFN0rgXqGMlvl1iE31QkKwnCocQ11FDGGonpOy/Ng==
X-Received: by 2002:a2e:8953:: with SMTP id b19mr698262ljk.187.1591140536577;
        Tue, 02 Jun 2020 16:28:56 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k29sm64949ljc.136.2020.06.02.16.28.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 16:28:55 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id a25so388265ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:28:55 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr662056ljc.314.1591140534778;
 Tue, 02 Jun 2020 16:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200601170102.GA1346815@gmail.com> <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
 <20200602073350.GA481221@gmail.com> <b159ba4c53fcf04cc4eb747c45e1d4d2d83310a3.camel@kernel.crashing.org>
 <871rmxgw4d.fsf@nanos.tec.linutronix.de> <CAHk-=wgOFnMW-EgymmrTyqTPLrpGJrUJ_wBzehMpyT=SO4-JRQ@mail.gmail.com>
 <105f5a87b689eab38baf4d51d03e9f9707e74c66.camel@amazon.com>
In-Reply-To: <105f5a87b689eab38baf4d51d03e9f9707e74c66.camel@amazon.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 16:28:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC4PUhErcoDhCbTOdmPPy-Pj8j9ytsdcyz9TorOb4KUw@mail.gmail.com>
Message-ID: <CAHk-=whC4PUhErcoDhCbTOdmPPy-Pj8j9ytsdcyz9TorOb4KUw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.8
To:     "Singh, Balbir" <sblbir@amazon.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 4:01 PM Singh, Balbir <sblbir@amazon.com> wrote:
>
> >      (c) and if I read the code correctly, trying to flush the L1D$ on
> > non-intel without the HW support, it causes a WARN_ON_ONCE()! WTF?
>
> That is not correct, the function only complains if we do a software fallback
> flush without allocating the flush pages.

Right.

And if you're not on Intel, then that allocation would never have been
done, since the allocation function returns an error for non-intel
systems.

> That function is not exposed without
> the user using the prctl() API, which allocates those flush pages.

See above: it doesn't actually allocate those pages on anything but intel CPU's.

That said, looking deeper, it then does look like a
l1d_flush_init_once() failure will also cause the code to avoid
setting the TIF_SPEC_L1D_FLUSH bit, so non-intel CPU's will never call
the actual flushing routines, and thus never hit the WARN_ON. Ok.

> >  (2) the HW case is done for any vendor, if it reports the "I have the MSR"
>
> No l1d_flush_init_once() fails for users opting in via the prctl(), it
> succeeds for users of L1TF.

Yeah, again it looks like this all is basically just a hack for Intel CPU's.

It should never have been conditional on "do this on Intel".

It should have been conditional on the L1TF bug.

Yes, there's certainly overlap there, but it's not complete.

> >  (3) the VMX support certainly has various sanity checks like "oh, CPU
> > doesn't have X86_BUG_L1TF, then I won't do this even if there was some
> > kernel command line to say I should". But the new prctrl doesn't have
> > anything like that. It just enables that L1D$ thing mindlessly,
> > thinking that user-land software somehow knows what it's doing. BS.
>
> So you'd like to see a double opt-in?

I'd like it to be gated on being sane by default, together with some
system option like we have for pretty much all the mitigations.

>     Unforunately there is no gating
> of the bug and I tried to make it generic - clearly calling it opt-in
> flushing for the paranoid, for those who really care about CVE-2020-0550.

No, you didn't make it generic at all - you made it depend on
X86_VENDOR_INTEL instead.

So now the logic is "on Intel, do this thing whether it makes sense or
not, on other vendors, never do it whether it _would_ make sense or
not".

That to me is not sensible. I just don't see the logic.

This feature should never be enabled unless X86_BUG_L1TF is on, as far
as I can tell.

And it should never be enabled if SMT is on.

At that point, it at least starts making sense. Maybe we don't need
any further admin options at that point.

> Would this make you happier?
>
> 1. Remove SW fallback flush
> 2. Implement a double opt-in (CAP_SYS_ADMIN for the prctl or a
>    system wide disable)?
> 3. Ensure the flush happens only when the current core has
>    SMT disabled

I think that (3) case should basically be "X86_BUG_L1TF && !SMT". That
should basically be the default setting for this.

The (2) thing I would prefer to just be the same kind of thing we do
for all the other mitigations: have a kernel command line to override
the defaults.

The SW fallback right now feels wrong to me. It does seem to be very
microarchitecture-specific and I'd really like to understand the
reason for the magic TLB filling. At the same time, if the feature is
at least enabled under sane and understandable circumstances, and
people have a way to turn it off, maybe I don't care too much.

                  Linus
