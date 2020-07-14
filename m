Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA73EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8436A21548
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594690218;
	bh=2hQOOp6LKhBZZUGFSaoyD6zVWe78nvZsz3WstUlpTHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uiJ6V6XXFvYoQu+PyNeOEmsc2qDVEbxVNg/p1sQDTbDnoiKi8jPDzuv5/mTlasWOn
	 wwvHVT8P4NwAcHd5IOxG2YZynbOQnjqVMldAgHWrnlfxjAu5qFDwIdcm/JF1NTmWaK
	 QddhxsFqVo53ETs17LUadHBwnxUuddhos5WYAzvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgGNBaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgGNBaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:30:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A0AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 18:30:16 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u25so10344981lfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 18:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cENxVazJtUyRs8+TPVerStC+DeUI4Gvj6LmZ7ZROrI=;
        b=T2o2K0XDEYzAK0t1NpCaURDBSHhm6G0kY1NRB4gbtYcFGXLeyMtjroiZ2lhHbYiAfP
         TaYRX16KBJObXloU+Wkq4Bcu2txdp88fOT6rPQ6LVgzB+/yYqnmRSyXWiUXEGe/IhMnc
         MQKe1A7cVcQV83eyKH//AlNfNbjXm8/qJamgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cENxVazJtUyRs8+TPVerStC+DeUI4Gvj6LmZ7ZROrI=;
        b=tgrFB7NBiOxWj1iu04ePH+osuMPEprSGnGsq/QbV5hbPR9HCcsb9mQ+bKONI0DpKlZ
         Yow1EDG1gThJQvZ7QnoqmMbJudhaI981tKwvwXzgbNh9yt9u3wOn0B89fw9XDDKr+ZAl
         pT2u/WiVEeihEwRWB86NrC0R8BIFLp2UKOu/yoEUI8Fnv+vaULM8k53G4E2w27gO/CzX
         wFKAZS7TIhp/5JFcf6EePXvI2Oj5HyF1XWNh0Hc1Fn/G2VWRvzFUz7aTbvmlck/wNfgI
         k2otB401sJ7NrY3NKxxQdXM6YyjIobnUn7LnJrrxPhc16fkwBvDhZbqbVnwESqKNt5zM
         REmg==
X-Gm-Message-State: AOAM533iql87pYMj1yBFe65IsTys3gAyVG9O9WG/RzyvHk2bNaJA5Gs7
        ByhVlAYaRZeE6AUVgYQ/LGNKGXN97Lw=
X-Google-Smtp-Source: ABdhPJzkgceUz0lCL/uwyH/O3nlPIggUVywAoOkSJPj2g/5arZPFAMK7d2a7Be6Pq7oxJcpRBXaLbQ==
X-Received: by 2002:a19:ccd0:: with SMTP id c199mr903767lfg.194.1594690214077;
        Mon, 13 Jul 2020 18:30:14 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x16sm4935568lfc.76.2020.07.13.18.30.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 18:30:12 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id t74so10351156lff.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 18:30:12 -0700 (PDT)
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr889540lfq.125.1594690211814;
 Mon, 13 Jul 2020 18:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <CAKwvOdn7Ugu_687b9CnOnL8RA9hbi+ONCb10gS=3VqtkTsmduw@mail.gmail.com>
 <CAKwvOdm4gMe_-DcB_H4mDGm8Yy++_7G20sg9xuZoom-rF2j1Sw@mail.gmail.com>
 <CAKwvOdmGtZtqF5f-5x0n4GNCWLOnrk2r6e3X2XHGmoOL7f7u0g@mail.gmail.com>
 <CAHk-=winDAeDTAe33QVoRvTJELMDjQpYPqSPcNwSk+SwPrav=g@mail.gmail.com>
 <CAKwvOdmsap8iB+H5JXiHYwSJFrtQ_krjNH7eQCGe7p-LjK7ftA@mail.gmail.com> <CAKwvOdm4Pc6J8_SurAwgHhG2bY7rALaUXo=fSeCLom+nSPw+4w@mail.gmail.com>
In-Reply-To: <CAKwvOdm4Pc6J8_SurAwgHhG2bY7rALaUXo=fSeCLom+nSPw+4w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Jul 2020 18:29:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wju+jFMxFyjsEDDJ7w4_VqhN1G15ehaY4mwGYKFYoZ5AQ@mail.gmail.com>
Message-ID: <CAHk-=wju+jFMxFyjsEDDJ7w4_VqhN1G15ehaY4mwGYKFYoZ5AQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] x86: Clean up percpu operations
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 5:31 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> So I did:

Ack, I have the series, and it looks fine to me.

> Actually, looks like a lot of merged PRs come from github!  Grizzly
> Adams *did* have a beard!

Oh, I think github is an _excellent_ hosting service.

I just can't stand their web workflow for creating commits and merging code.

At least at some point it was really easy to generate totally horrible
commit messages using the web interface without the proper header line
etc. I _think_ that got fixed. But the merge codeflow still doesn't
work at all for the kernel.

(To be fair, I've used it for _other_ projects, and there it can work
really really well, together with all the test infrastructure etc).

They also have a very spammy email system where people can add me to
their projects and "invite" me, and I get email about it.

But again - as a hosting site for kernel pulls, it's one of the better ones.

So you definitely don't need a kernel.org account to send me pull
requests, github is in fact much better than some others (infradead is
very slow to pull for me, for example).

A kernel.org pull doesn't strictly need a signed tag - I do kernel.org
pulls over ssh, and I trust the user security there. Any other hosting
service I _do_ require that the pull requests are proper signed tags,
though.

But even that difference is largely gone: for kernel.org pulls I've
very heavily favored signed tags, and I think almost all of them are
using them by now.

               Linus
