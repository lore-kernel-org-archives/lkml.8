Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05AC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E852071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsh9H7XU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgDYPEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbgDYPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 11:04:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67117C09B04B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 08:04:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o135so967062qke.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aFNkj/X0ARFk1lHudyAFFChBsuWKz++VCQGA+5bkEF4=;
        b=Qsh9H7XUkaGUDZISgiDxKbDqE0iw0p/pS6gA7oFdel3Wd2F3lv0ULO/fCkynQ67oCW
         DqWtaidJKbBNrWGqbCP7qSK+SvwCC4f+9bp25MtF/7pRsPwDG6NvOxgGo3PFdQyTbK9U
         HgmY8uxbNL+ONgb2jjOi9yfcQlHZ4sRWWDIWKmQ3rc7aa5T8kHU8NYYx0yOoV4TFOvBB
         zcRXfwiHCdP6/1zuEF9vdLa2ESgC7uFkZYUp8cJLLXcV95+IwNuEuNW7EPeE5REcVFKe
         FtkmVOk/yIUksd6uHUEdCrZ9voizXd/hkn4tOTB0RkHU/FlwCcm37vjPXni2YIZIKT0r
         x0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aFNkj/X0ARFk1lHudyAFFChBsuWKz++VCQGA+5bkEF4=;
        b=Q167AaacFgzvMt25+XlPliEsUI3oNnTwgxQOUloO0xVbC6m3mubIapPP28bJ8nB5kV
         29H05ThLro+mJ+GSEAyHEzmXMmLJegmUQbOmTct1xVoLh5SM8aT3QZrddjVpvJbrkGkC
         e//z9A/jFbyP7wLrSdoyRptys05e6IKGGTVniexeUllh+yHGWqxNsEzbpIfm+tO1Q4Be
         fh00SrI33UUmlG4ImJQZskEjmhWrh/tjavFxvhoKwf7tq5asDBSRK951dHndnzg+Es7O
         RPzFMunHuaXPFayIigGZMwtHZDC/Kp/TvPnT7YLvAGHPS4BOSIC5glTGMZqIulXAK99H
         JHPg==
X-Gm-Message-State: AGi0PuaESOI9iP+zsJcKvxW1wo54x8RBfN56FgHPYP0yqcBxz++O51o3
        Xf7Vl/rGDvlJF7zLH6lqVv0=
X-Google-Smtp-Source: APiQypKJgUBaip4pHz85dIJ60/YCLMMEy1fNhqdI2WcdwQ7f+6cxi9Dc6VyvXD4/F3xc3Z0mZd1YHQ==
X-Received: by 2002:a37:e30e:: with SMTP id y14mr13686328qki.61.1587827085314;
        Sat, 25 Apr 2020 08:04:45 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p10sm5925035qtu.14.2020.04.25.08.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 08:04:43 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 25 Apr 2020 11:04:40 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>, boris.ostrovsky@oracle.com,
        jgross@suse.com, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200425150440.GA470719@rani.riverdale.lan>
References: <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic>
 <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
 <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic>
 <20200423161126.GD26021@zn.tnic>
 <20200425014657.GA2191784@rani.riverdale.lan>
 <20200425085759.GA24294@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200425085759.GA24294@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 10:57:59AM +0200, Borislav Petkov wrote:
> On Fri, Apr 24, 2020 at 09:46:57PM -0400, Arvind Sankar wrote:
> > The comment above boot_init_stack_canary's definition should be updated
> > to note that it needs to be called from a function that, in addition to
> > not returning, either has stackprotector disabled or avoids ending in a
> > tail call.
> 
> How's that?
> 
> diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
> index 91e29b6a86a5..237a54f60d6b 100644
> --- a/arch/x86/include/asm/stackprotector.h
> +++ b/arch/x86/include/asm/stackprotector.h
> @@ -55,8 +55,12 @@
>  /*
>   * Initialize the stackprotector canary value.
>   *
> - * NOTE: this must only be called from functions that never return,
> - * and it must always be inlined.
> + * NOTE: this must only be called from functions that never return, it must
> + * always be inlined and it should be called from a compilation unit for
> + * which stack protector is disabled.
> + *
> + * Alternatively, the caller should not end with a function call which gets
> + * tail-call optimized as that would lead to checking a modified canary value.
>   */
>  static __always_inline void boot_init_stack_canary(void)
>  {

I'd put the clause about stack protector being disabled and the
tail-call one together, to make clear that you still need the never
return and always inline bits. Also, this function is implemented by
multiple arch's and they all have similar comments -- might be better to
consolidate the comment in the generic (dummy) one in
include/linux/stackprotector.h laying out the restrictions that arch
implementations should follow?

> 
> > There are also other calls that likely need to be fixed as well -- in
> > init/main.c, arch/x86/xen/smp_pv.c, and there is a powerpc version of
> > start_secondary in arch/powerpc/kernel/smp.c which may also be affected.
> 
> Yes, there was an attempt to fix former:
> 
> https://lkml.kernel.org/r/20200413123535.10884-1-frederic.pierret@qubes-os.org

There's also the one in init/main.c which is used by multiple
architectures. On x86 at least, the call to arch_call_rest_init at the
end of start_kernel does not get tail-call optimized by gcc-10, but I
don't see anything that actually prevents that from happening. We should
add the asm("") there as well I think, unless the compiler guys see
something about this function that will always prevent the optimization?

Cc'ing PPC list for powerpc start_secondary.
