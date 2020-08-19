Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5BFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D952207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0md1oG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHSTG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHSTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:06:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:06:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t23so18663717qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nBo8PSBZeaGMeAMnr74jCiSvVKt1AfbKh1e/zCH2wlU=;
        b=U0md1oG90UoroCXHOPDVKOaLRbkyYquaarrQI13wQyKVNrbV552HLus74J9pQOMJjB
         mq05HdIdiK/JNzf4mfhjxS7tKsbMJwixWYc0L1slPqTOWz/18RtIth3XANSFIIG+kwKd
         Nn0cklkb83z2ObqEs4jYyLQwLj0hSK/eM/4NXFaiHgxkdA9XxkfC+DJEtATXbeOrZ7gx
         HuGof3/aiBRQ0cFmmOVhswfMbdZ2xrPqw+tdPXS7qT3NPtSxxS9DMqsYGOiN0D7MnLqd
         a3GJhGP8dKyVphjPHHqI4JzZcNMGoMT8SF40fgAm+oYlcRy2xXOcALvpQnLkkO9sROqT
         Mn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nBo8PSBZeaGMeAMnr74jCiSvVKt1AfbKh1e/zCH2wlU=;
        b=JFieJKSFVQa26bROMWEM3kFOdPAtQcPieUj0o4etjQcpFEIHtG2kPPnOCh5US4op3+
         0Q7CBr99ZGarbISHegq1i07RFaBiTelCcKOVhpPhtC2Wu4jlN49UUEPY7Jh1oO6z7Xqt
         H7BNcDM6Hua+z3UaBXKOdI2lYoO2POxNRkU6k3FBmI1IpNMKE580sqqL/yyhJ8MzA8bb
         bP0+BegkZeSGyk0H9QIdGOcYLOhQPn76dHZJzzRTQcnrRZHUvvaylzQUsYn7f4QD3erx
         h8oPkPMw9QSfGQJ8wrQts/d8034YsXilkIqNDMBjot9wPfsxwg2WtFehUZf0rv68ilf5
         gKqQ==
X-Gm-Message-State: AOAM533Wg3VhKwRESPNmnlJAsCvTw3QUwjDQWf93BenOfVUOjnRD+YnU
        2bRWBotth4PeFGTzYbCuedo=
X-Google-Smtp-Source: ABdhPJyio4bXtNT1w7OeEUrKV+LC7xLfwK9HdV/D3f/TbfpJOwparjxaVEI6Joa9/AU0OTVOK+vAHw==
X-Received: by 2002:aed:2358:: with SMTP id i24mr24215013qtc.234.1597863981858;
        Wed, 19 Aug 2020 12:06:21 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u21sm22927752qkk.1.2020.08.19.12.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:06:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 19 Aug 2020 15:06:19 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] lib/string.c: Use freestanding environment
Message-ID: <20200819190619.GA4135577@rani.riverdale.lan>
References: <CAHk-=wiJLvqS1_O+yAQSZr-Lj49HdJyLpt3J_nW=otHLfEN4RA@mail.gmail.com>
 <20200819140816.3807604-1-nivedita@alum.mit.edu>
 <CAKwvOdn-mv1D1GEk3pWnPYsyzQRRk5qZFhSi0CYn6tRDo1O_iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdn-mv1D1GEk3pWnPYsyzQRRk5qZFhSi0CYn6tRDo1O_iw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:35:11AM -0700, Nick Desaulniers wrote:
> On Wed, Aug 19, 2020 at 7:08 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > gcc can transform the loop in a naive implementation of memset/memcpy
> > etc into a call to the function itself. This optimization is enabled by
> > -ftree-loop-distribute-patterns.
> >
> > This has been the case for a while (see eg [0]), but gcc-10.x enables
> > this option at -O2 rather than -O3 as in previous versions.
> >
> > Add -ffreestanding, which implicitly disables this optimization with
> > gcc. It is unclear whether clang performs such optimizations, but
> > hopefully it will also not do so in a freestanding environment.
> >
> > [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56888
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> For Clang:
> For x86_64 defconfig:
> This results in no change for the code generated.
> 
> For aarch64 defconfig:
> This results in calls to bcmp being replaced with calls to memcmp in
> strstr and strnstr.  I plan on adding -fno-built-bcmp then removing
> bcmp anyways.  Not a bug either way, just noting the difference is
> disassembly.
> 
> For arm defconfig:
> This results in no change for the code generated.
> 
> I should check the other architectures we support, but my local build
> doesn't have all backends enabled currently; we'll catch it once it's
> being testing in -next if it's an issue, but I don't foresee it
> (knocks on wood, famous last words, ...)
> 
> If it helps GCC not optimize these core functions into infinite
> recursion, I'm for that, especially since I'd bet these get called
> frequently and early on in boot, which is my least favorite time to
> debug.
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 

I verified that arch/c6x with gcc-10 downloaded from kernel.org has the
broken memset with CC_OPTIMIZE_FOR_PERFORMANCE and gets fixed with this
patch. The default is optimize for size though, which doesn't seem to be
busted.

Thanks.
