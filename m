Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA07AC38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA26720732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5wcAY78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgBXWns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:43:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45245 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgBXWnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:43:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so7723593qte.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2fqwSDzA0qJPpkXoUfayaMO91DSowAScYmB2Y++l/a8=;
        b=U5wcAY78fNAT6JrMEi+/p2hrw25/AJUpkfQvL/Ljki2hEcUEkNRdFH8A3WZk7VqHj4
         KSasPNBO/tnV+eC4t8T8Wyrda8gK6tx9L4ysCtVbFDLZtkfOomSfGbgns1UKOJwRE45W
         dZL7ofeJ83oWexlCiTL71Anr2EQH4b8JnACYvqtNzFbts09bV4aNf7RE1w+W+nYChgsr
         59GrzZSQnPUf5VtOtohsMcP7OFjM+qStclRVdkbLMoJqUJ9VYRl+/yW7fjVGElRtHLNs
         1CV3CY2YgO2e1xKCiy1tQU6x/HA/xB5wj5Gjz3h2ddh0VAEPOOmBWw19f4JwFSLtnAEv
         smrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2fqwSDzA0qJPpkXoUfayaMO91DSowAScYmB2Y++l/a8=;
        b=pUvrSTS8bMoIbQAnCh3Ov5H2nOEhZLNbVQDz3S8C1/KH3C1qKLFHeEBoNhLtvtccCP
         FJWsbBvikD8ogBbjpeqqaY7aeqqgi8Gw3U6B+aClOgI6Gb2kZQKvnL3isqMcNxfYpnnS
         RuzDO3uIcWQaDqGWFCVfcW7Z5kpyJhdhi0dP3rTxJ+HBJ9lqsTmLKVj0g+RG1/1kDYAh
         exh8f/7XhqL5cSeKSfQP1tk7Yjn6Gq5MoJ8L6h8jfFcEewpCZBpVotuM/DmyPxjQolux
         uPEFMBtWY5AhAzmALBboqoxXtN0ZGbT++T0gjAqLM1sUlCq21O+FEDa2N/Ihv1RazRwN
         o+1g==
X-Gm-Message-State: APjAAAVMbo85RRmj556VtxuutA9fv8cfz5CWbMo//vSUbR3ZJyPw7dUm
        M7Zk6dUbBnVNnE/FBHtvzZo=
X-Google-Smtp-Source: APXvYqw8+jEg8gvPmeH8S420a8jIk4XnnJGz1ipKsykeqLPVFuVVoCftrE9rn0JljXfx/6JhabMxGg==
X-Received: by 2002:ac8:1b59:: with SMTP id p25mr51970654qtk.336.1582584226324;
        Mon, 24 Feb 2020 14:43:46 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g17sm6599084qtq.29.2020.02.24.14.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:43:45 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 24 Feb 2020 17:43:44 -0500
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200224224343.GA572699@rani.riverdale.lan>
References: <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <alpine.LSU.2.21.2002241319150.12812@wotan.suse.de>
 <CAKwvOd=nCAyXtng1N-fvNYa=-NGD0yu+Rm6io9F1gs0FieatwA@mail.gmail.com>
 <20200224212828.xvxl3mklpvlrdtiw@google.com>
 <20200224214845.GC409112@rani.riverdale.lan>
 <20200224221703.eqql5hrx4ccngwa5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224221703.eqql5hrx4ccngwa5@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 02:17:03PM -0800, Fangrui Song wrote:
> On 2020-02-24, Arvind Sankar wrote:
> >On Mon, Feb 24, 2020 at 01:28:28PM -0800, Fangrui Song wrote:
> >> Hi Michael, please see my other reply on this thread: https://lkml.org/lkml/2020/2/24/47
> >>
> >> Synthesized sections can be matched as well. For example, SECTIONS { .pltfoo : { *(.plt) }} can rename the output section .plt to .pltfoo
> >> It seems that in GNU ld, the synthesized section is associated with the
> >> original object file, so it can be written as:
> >>
> >>    SECTIONS { .pltfoo : { a.o(.plt) }}
> >>
> >> In lld, you need a wildcard to match the synthesized section *(.plt)
> >>
> >> .rela.dyn is another example.
> >>
> >
> >With the BFD toolchain, file matching doesn't actually seem to work at
> >least for .rela.dyn. I've tried playing around with it in the past and
> >if you try to use file-matching to capture relocations from a particular
> >input file, it just doesn't work sensibly.
> 
> I think most things are working in GNU ld...
> 
> /* a.x */
> SECTIONS {
>    .rela.pltfoo : { a.o(.rela.plt) }  /* *(.rela.plt) with lld */
>    .rela.dynfoo : { a.o(.rela.data) } /* *(.rela.dyn) with lld */
> }

The file matching doesn't do anything sensible. If you split your .data
section out into b.s, and update the linker script so it filters for
b.o(.rela.data), .rela.dynfoo doesn't get created, instead the default
.rela.dyn will contains the .data section relocation. If you keep the
filter as a.o(.rela.data), you get .rela.dynfoo, even though a.o doesn't
actually contain any .rela.data section any more.

> 
> % cat <<e > a.s
>   .globl foo
>   foo:
>     call bar
>   .data
>   .quad quz
> e
> % as a.s -o a.o
> % ld.bfd -T a.x a.o -shared -o a.so
