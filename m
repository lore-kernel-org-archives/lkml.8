Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3203C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C252E2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j26s40At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbgEYTW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389460AbgEYTW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:22:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D53C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 12:22:24 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so18272330qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sfZXJ75xgK8Z7AdSn/t8ZW/rrd23X9AtbdmWzY3vzbE=;
        b=j26s40AtNNsoX0+X7BVHLHJLQ9a1t37sJQvuguTFhmcEVG2aswsv55KAKR5yVI5JZr
         vgpzqfLg10M8U9OQ3EY5JEuc+YJpZg+YOQb0xHiwgDsg0TQ7QUTzvssmOiaOv1MBj959
         t2MralzwcxqjvU4WTiCORxczkq5hS8/fzCuX805DBQRQnZdrwvDTR/3NkUqDSHDfWM5C
         QycNe5ao1n4yaKD17U1stTFqcqNxukwllamUru574AuorHkPWo+wF0RTpMCOflmt95Ox
         9Xa3i+lO9MSAlAWpfGKEn13uNWVeRG3PAT3VYW8xB1TsI1tmQZT1UNxzsI+uJ7OVaEY4
         nuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sfZXJ75xgK8Z7AdSn/t8ZW/rrd23X9AtbdmWzY3vzbE=;
        b=ovwJdK+YLH9IO2vjn4R6uXG4GIABQ3wdILgHFvhkEBFtaTrQ3EY++iblaHGwmSIgJj
         dY4N9qyhPMBD7eN83VHZwyHtsi97nUf6LDCPti+YIUFYR6Bl+KTad08S0jGGLFsxdtKu
         m+lyBa60pAQ6Lr6TshVIjzqJPa3tPyFVOtak09Q3rzEQSyCq5jpfQwZsUPNrQD/vc5pD
         OVyxU3D1U+ZBaRzu6Byco9+eHCPZirdp2oLw66iKjDMVgMGCnpfecsoJq+5hUo5iPYKF
         fpEjirzTRJAlt3GzZ/4GAXf8GpheEnsr3oMs24PiPSHMi18tMZuaLtlKezYA92OPTmZn
         9CZg==
X-Gm-Message-State: AOAM533PeHfjP1GAHc+e6znp90WelmWL5mhtDDqROSFi2AYa0x7DTlqX
        DOLimRsP0n+lMyXbmUbOqM8=
X-Google-Smtp-Source: ABdhPJxD8KXP1iPlWUfnBYp1l9fRHdSyANlG2qd6NNYlY0HIVg2WqupR8Rqoe3flRHkynrwphcpRdQ==
X-Received: by 2002:a37:b4c7:: with SMTP id d190mr26969826qkf.432.1590434543882;
        Mon, 25 May 2020 12:22:23 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 99sm15323275qte.93.2020.05.25.12.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 12:22:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 25 May 2020 15:22:21 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86/boot: Check that there are no runtime relocations
Message-ID: <20200525192221.GA920865@rani.riverdale.lan>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-5-nivedita@alum.mit.edu>
 <CAMj1kXFjDMuLekYKiPoKDqJhfkY8UViApdMd3JaPmGbnKLO+NA@mail.gmail.com>
 <20200525162626.4covxuycii6bvmjg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525162626.4covxuycii6bvmjg@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 09:26:26AM -0700, Fangrui Song wrote:
> On 2020-05-25, Ard Biesheuvel wrote:
> >
> >Do we really need the macro here? Could we just do
> 
> The output section name does not matter: it will be discarded by the linker.
> 
> >.rel.dyn : { *(.rel.* .rela.*) }
> 
> If for some reasons there is at least one SHT_REL and at least one
> SHT_RELA, LLD will error "section type mismatch for .rel.dyn", while the
> intended diagnostic is the assert below.
> 
> >(or even
> >
> >.rel.dyn  : { *(.rel.* }
> >.rela.dyn : { *(.rela.*) }
> >
> >if the output section name matters, and always assert that both are empty)?
> 
>    .rel.dyn  : { *(.rel.* }
>    .rela.dyn : { *(.rela.*) }
> 
> looks good to me.
> 
> 
> FWIW I intend to add -z rel and -z rela to LLD: https://reviews.llvm.org/D80496#inline-738804
> (binutils thread https://sourceware.org/pipermail/binutils/2020-May/111244.html)
> 
> In case someone builds the x86-64 kernel with -z rel, your suggested
> input section description will work out of the box...
> 

Ok with me.
