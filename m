Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB18BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CB4208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="I+zYwfyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgFPVRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgFPVRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:17:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEEEC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:17:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d27so8054536lfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZrMRZK+NBwpqKVitehAL9xTIrDppW8h8HoB5F49GD8=;
        b=I+zYwfyHsGog+tXrkHOqqd0wp1mrc7LjZI96FBTEItv/JdmTmyIVxOfdGNBUdzRt5E
         H3mFXYpMNKfZiK+suf6+097zwNshCg6hFbqmAa25Mk4N5dYseZXLwpTQc9h5C8k3Y1Sg
         w9q2bLvXdEFqsTV1iw89KDEpbHvHIAqymqIr+nSeT3xmCO+M51z167uq9/e4h3iBHfip
         a5cC/kzPJzae6hPwp2RDEZLp7ApMXVzqILgbtWOJ4ndLudPrG31eLec8eMTUwyfOgLLJ
         grnpc3dVbqVthl3kgOgf8su5Vk2zv0acKvNt9P5/Al1zU4XK/e4AFkyLQTmq+Fj8pYpZ
         Dn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZrMRZK+NBwpqKVitehAL9xTIrDppW8h8HoB5F49GD8=;
        b=EyDTwGdijxrrWNDdhJRBt07UfajH/hDB7th7kgYBl/CAUY5ReFbf5UZKUsO7JLmgRF
         IlmEoFdznRHJFqEkEzfD4QP4lJ4yK4yhPsAlfCC2lP3m2S/q98IULKeHJsI0L3AMVgFw
         yurLOmRgfsl/Eg7D5th+1r4f5OCjf8gDEedaQylQ5nytb5KBYaFlvy4cx5N2c9XvU0BB
         pNXXxtdGgWIcAbHonlidq252rBCj5e4st6DvEvxhDvhTj4KXzPlQrc4m4sCP8jJwBFrE
         9kDl3SZW4xHgPkjL0LauFE9ohiBHtCIe3feUewrgl4+ikwDB+i6FPAr02WjacAN3IwO0
         61KQ==
X-Gm-Message-State: AOAM53004SOD754/H26DOdl5Q9biGmwbv0mccjQeVsJHnjuIWOLABSIq
        2BlVIERJQ/A375XGMu//qfPFHWzndWm4AhzSCg8NQsmKcw==
X-Google-Smtp-Source: ABdhPJxpHQleWXov1W9//pLAITKlL504+pe7hMIseUIRwP0OPd5cxY2+wZK9l4cjgQ4u2DkW4L4id+X8Ub28k9c8oSE=
X-Received: by 2002:a19:4945:: with SMTP id l5mr2740737lfj.12.1592342255315;
 Tue, 16 Jun 2020 14:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
 <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com> <20200616203352.GA1815527@rani.riverdale.lan>
In-Reply-To: <20200616203352.GA1815527@rani.riverdale.lan>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Tue, 16 Jun 2020 23:17:08 +0200
Message-ID: <CAEJqkghzD_6F2N=M65uYHzpOOJ8bvMw18JCfwsiQoH-kToPKLQ@mail.gmail.com>
Subject: Re: Linux 5.8-rc1
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 16. Juni 2020 um 22:33 Uhr schrieb Arvind Sankar
<nivedita@alum.mit.edu>:
>
> On Tue, Jun 16, 2020 at 10:11:46PM +0200, Gabriel C wrote:
> > * Am So., 14. Juni 2020 um 22:44 Uhr schrieb Linus Torvalds
> > <torvalds@linux-foundation.org>:
> >
> > Hello,
> >
> > > So I didn't really expect this, but 5.8 looks to be one of our biggest
> > > releases of all time.
> > >
> >
> > I hit a compiler error caused by e4160b2e4b02377c67f8ecd05786811598f39acd.
> >
> > x86/purgatory: Fail the build if purgatory.ro has missing symbols
> >
> > Having CONFIG_STACKPROTECTOR* & CONFIG_KEXEC_FILE enabled always
> > results in a linking error like this:
> >
> > LD      arch/x86/purgatory/purgatory.chk
> > ld: arch/x86/purgatory/purgatory.ro: in function `verify_sha256_digest':
> > purgatory.c:(.text+0x108): undefined reference to `__stack_chk_fail'
> > ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> > sha256.c:(.text+0x1c74): undefined reference to `__stack_chk_fail'
> > ld: arch/x86/purgatory/purgatory.ro: in function `__sha256_final':
> > sha256.c:(.text+0x1e65): undefined reference to `__stack_chk_fail'
> > ld: arch/x86/purgatory/purgatory.ro: in function `_kstrtoull':
> > string.c:(.text+0x2107): undefined reference to `__stack_chk_fail'
> >
> > I didn't look closer at that but from the error, it seems to be,
> > some missing -fstack-protector* vs -fno-stack-protector* checks
> > somewhere.
> >
> >
> > Best Regards,
> >
> > Gabriel C
>
> Can you attach the output of gcc -dumpspecs and gcc -v? I suspect your
> compiler enables stack protector by default. My distro compiler does
> that too, but not if -ffreestanding is enabled (which it is for the
> purgatory).
>

Files including config uploaded to there:

http://crazy.dev.frugalware.org/kernel/

> Does this patch help?
>

I'll test in a bit and let you know.

> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index b04e6e72a592..088bd764e0b7 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -34,6 +34,7 @@ KCOV_INSTRUMENT := n
>  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
>  PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
> +PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
>
>  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
>  # in turn leaves some undefined symbols like __fentry__ in purgatory and not

Thx.
