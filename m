Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ECDC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF27121D6C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599687247;
	bh=MyGCCFAgjPrJuTxv6ESslWXTkvxYvypITFIZbu9YrxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OxSfLNx/Yi1kp/QHxTKrg2ReabfmXOQGE1OVpJrygCCgdL1ndkHDx8vni5JGP+avR
	 8fSqfWH2oKVV66+2EeMKDjtJz4EfQmDy+TsFGWRAEIXVmoIuol/kPRJkqtE5XRlxjR
	 1uXKgJuo015Igedb+P6bBUV/RgtSEeTQap2SXTbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgIIVeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgIIVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:33:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FBBC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:33:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r24so5505405ljm.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0+jz5nEBaWAhh7n7Hp1qz3wUrloORRxGTRRlKkQIgM=;
        b=ZC+O3RgWhIgNKsFzAoxkbel7tu0gOmF8ciyCULsTleltXACSMEUPzu0YhQCYyxG+n0
         fRQ2KEHRUpo3+MHY+wuhqjq5jU82lgflP0z62nRjLA58w/Z1YR52q8f3ta82dR9XKkQK
         4JeSuKlLlKaSmxiZJnS7lLTjpttmYgqxvU9OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0+jz5nEBaWAhh7n7Hp1qz3wUrloORRxGTRRlKkQIgM=;
        b=iYs0a6flljgTirrWDnrQnCw6w63CSuY7q8/eSlladrpafFMFnKwZwo3FBkyoD/shgm
         NeMwkRP65ZOjPPFgdeupcV197v+Zv2/z4BQT8DMuOSjIVlIA8llzy4d4L4v+nG5p12Nm
         Rosy3ioIZxofIGg21bqpmX4I1bspFn3EMAdFKhrcUMiG+VYdNraY0HSfX0QQ20A1596y
         Gw7UztHZC0yLNaCmdOQ+z5ixMcSUWlD4l/xWGUzgs8XvcY2to6V/WMetvmiCkSZrcPP3
         TDkGydzgsU7C1QK3sHZkzvSFnFTr21Go7Njca0uGh3xM9XNxbitH6VcyvP7xPYqNQaTs
         0p4A==
X-Gm-Message-State: AOAM5316Gi7E74eQ2aTGmBn/aXMe0tCUsYTBXXthZPYFevtEVGwUL+xZ
        Hn5hWWc9Ngj4I8nLlbcK3UPqmS888ij/bw==
X-Google-Smtp-Source: ABdhPJyBty9W4rR612I1wozp5mXavZyJQQ0NimbczpEi1vcq7r0iQtu9lu9Avb1YI5rSpMZ58LMYng==
X-Received: by 2002:a2e:9410:: with SMTP id i16mr2990432ljh.443.1599687233708;
        Wed, 09 Sep 2020 14:33:53 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id f12sm834157lfp.69.2020.09.09.14.33.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:33:52 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id w3so5477744ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:33:52 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr2679648ljh.70.1599687232145;
 Wed, 09 Sep 2020 14:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142803.GM1236603@ZenIV.linux.org.uk>
 <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com> <20200909184001.GB28786@gate.crashing.org>
In-Reply-To: <20200909184001.GB28786@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Sep 2020 14:33:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
Message-ID: <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 11:42 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> It will not work like this in GCC, no.  The LLVM people know about that.
> I do not know why they insist on pushing this, being incompatible and
> everything.

Umm. Since they'd be the ones supporting this, *gcc* would be the
incompatible one, not clang.

Like it or not, clang is becoming a major kernel compiler. It's
already basically used for all android uses afaik.

So I'd phrase it differently. If gcc is planning on doing some
different model for asm goto with outputs, that would be the
incompatible case.

I'm not sure how gcc could do it differently. The only possible
difference I see is

 (a) not doing it at all

 (b) doing the "all goto targets have the outputs" case

and honestly, (b) is actually inferior for the error cases, even if to
a compiler person it might feel like the "RightThing(tm)" to do.
Because when an exception happens, the outputs simply won't be
initialized.

Anyway, for either of those cases, the kernel won't care either way.
We'll have to support the non-goto case for many years even if
everybody were to magically implement it today, so it's not like this
is a "you have to do it" thing.

           Linus
