Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E53C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C3A208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pouY5t34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgEIEoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIEox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:44:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82036C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 21:44:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so3826578ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 21:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=MRnH5k9ZI9zg5bBwtUec2EUFq39SVuIpRRMAftUUCeQ=;
        b=pouY5t34NrhTXy1cRVhZTkVj0Vz+TvTPUeb9CGHBENQ+rOH3CjUzxpDI7qNzs3oAFx
         2Ibs87NF4nNXWQnQl0OA0WXbhwv6dxcTaoeXEu1obOwGFq34Dm/wiGu5nVHSwdKyJ/iP
         QkcUgIAej5ariJQrMB1GSbpj9j9SF6DszX/r13uVYj/UsgGe0hHhvXHtLdEtOMmCJG5X
         3STqswNY7tn0AzJNgPiLI1MzqQdqNkvz+40nZOC9gqll8ujByvqvQvgIfhD0WfiVJumq
         SPiXXd9OuQirzrv4czEVNSo7f+dn0+W3moAcCufDO+Amroftvt96fAPAXdhRjxz2o3xE
         OSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=MRnH5k9ZI9zg5bBwtUec2EUFq39SVuIpRRMAftUUCeQ=;
        b=cG7IbNRA+1CbjXlVaRVScMFYXUBNTcvIJyIFmQQkHa5tXaHwRr1n3NUMIGAPsRBH2A
         Tn4wNJRuEVdO07Nd1WafgHdMLwoXNUs0PtHGmqdWcqHB189z1PsUbuXiXuyC0hz7tZt/
         883JRiLItDaYYcbXA2EnSowg1V3pR+bfafgB0MX0fIdIHKeh7AcKTkt1w9Cq4GMLyzJN
         Ks/ymLKRzW+R6++Cio2zy1YVKyIn+Mh53aY45yA2GjNRlbH7Z55qEVDDMi5lZANi3DLm
         twQzDkddo5wSH8RweB9UYlyUCdHRHV6pQ/euniSofrJbfn/m0XmPdn7Dopv+awtpMGBj
         bqYA==
X-Gm-Message-State: AOAM533cW/yuOCoVOf/t9Giv1nM4yZqupbtrWHIvwYzrc06cawkiWnUz
        8ZjgqPBJmhOKsGACqIvHpxDkygyLtS+gnccOAYk=
X-Google-Smtp-Source: ABdhPJxanvVrcq7FG18owQu9bSMjR4aEQukN7BE4V1vAgTP5CPWWftYEBozZZPIykC3o8oWCEnWi/KcodkE+Khl6/3Q=
X-Received: by 2002:a05:651c:385:: with SMTP id e5mr3709241ljp.208.1588999491978;
 Fri, 08 May 2020 21:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200508182835.228107-1-ndesaulniers@google.com>
 <20200508183230.229464-1-ndesaulniers@google.com> <20200508202835.GA550540@ubuntu-s3-xlarge-x86>
 <20200508164703.0000481d@intel.com>
In-Reply-To: <20200508164703.0000481d@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 9 May 2020 06:44:40 +0200
Message-ID: <CA+icZUXcaZKjA=khdzy2DyXtwA4YkN=XBqNvTQSQqSz7tdipfA@mail.gmail.com>
Subject: Re: [PATCH v5] x86: bitops: fix build regression
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ilie Halip <ilie.halip@gmail.com>, x86@kernel.org,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 1:47 AM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> On Fri, 8 May 2020 13:28:35 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> > On Fri, May 08, 2020 at 11:32:29AM -0700, Nick Desaulniers wrote:
> > > Use the `%b` "x86 Operand Modifier" to instead force register allocation
> > > to select a lower-8-bit GPR operand.
>
> This looks OK to me, I appreciate the work done to find the right
> fix and clean up the code while not breaking sparse! I had a look at
> the assembly from gcc 9.3.1 and it looks good. Thanks!
>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>

Tested v5 on Debian/testing AMD64 with a selfmade llvm-toolchain
(LLVM/Clang/LLD) v10.0.1+git92d5c1be9ee9

Please add:

     Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

For details see
<https://github.com/ClangBuiltLinux/linux/issues/961#issuecomment-626104287>

Thanks to all involved people.

- Sedat -
