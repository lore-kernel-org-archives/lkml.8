Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED1C47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640B6206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589241919;
	bh=kGIn1Cbp1w1N7HG+NQYCda26lWB/Qiug9WGsCjGHWtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ksr0G8DhKQBwHuZbpdeUBuAK6wUWNeYLKVxcTGij84I/9vuH3ixRHWYkhc8VqeKcd
	 FvJWREcwGxQRvB8CP3ISondVmF09ookE050w4ygHmBr8feSUT6Wm0OotCPItG6nJf4
	 HiXtxxjzU/N01E7UCaVPVTl9Fj9Ns93R0GVex1W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgELAFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgELAFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:05:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EAFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:05:16 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b26so9040249lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5Vj2zQnFxzww1DFlagDjlY/ke7T1Z1ZZyehhz3heRw=;
        b=hcCGC2Hjo9nph3jrRydschmaR9AWBPPm9PAXs2M7D48jJzPcQ/KQADnqlDpnbnJWU2
         FMk/VAczA3dIzQWm/k5t7DbIXUsXBEjJ+AkRztrSEyQksG0iw5ouUugZlBp6wOhhj8E8
         Qjh8V3jCkhFfic+LUce/yQLpldSBlnv4B00B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5Vj2zQnFxzww1DFlagDjlY/ke7T1Z1ZZyehhz3heRw=;
        b=XJbRPABeIDRyYsX3vw0jSy0qItu5LjR+LtThlL5JARjgiwlYxRegm7esdPZjq3MhwD
         rZAX+eLF7e6kKwi+ebHr2WTIHh/7rOAl7lAdDMPEopZLBabMqFtmLG3ELWsoLlq/nL76
         l+GNlAigQ5gDXSUbFeV8iseIQaC6VOVM50gWIelnxSgnT1vizn6N7svQVMwJaHYBLok3
         ZGSJ6veqWcYjs5xGT+gbrb6h63UOHVYqUO43xHLNZdhSYUH0WmU3ngrk2dK67vnaIIbh
         6HkeQ3omj0HDmwI+imO+qRaIX58s5LeTKXO5XG41sMIqVGyAeSxFV8BCBSoX/HKokq86
         Tk3g==
X-Gm-Message-State: AOAM533gP2TqPMdLLvuOm2AQedLTqslcGmz74zBWBv0TsbGziKxzxDPV
        OtTBHS+xdkTMPUv0O9iw8IGnN7M5Xzc=
X-Google-Smtp-Source: ABdhPJx2q8BsxYvBpo7wQhbAOG+L+m1SOZova/uYsuvJLVgPCWA+mpw6dO3g/Ej8OBHdOexNma5SDA==
X-Received: by 2002:a05:6512:3b2:: with SMTP id v18mr12539634lfp.140.1589241913887;
        Mon, 11 May 2020 17:05:13 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id s27sm11165246ljo.80.2020.05.11.17.05.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 17:05:12 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u4so9028547lfm.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:05:12 -0700 (PDT)
X-Received: by 2002:ac2:5df9:: with SMTP id z25mr12792137lfq.125.1589241912072;
 Mon, 11 May 2020 17:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain> <20200511215720.303181-1-Jason@zx2c4.com>
In-Reply-To: <20200511215720.303181-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 May 2020 17:04:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi87j=wj0ijkYZ3WoPVkZ9Fq1U2bLnQ66nk425B5kW0Cw@mail.gmail.com>
Message-ID: <CAHk-=wi87j=wj0ijkYZ3WoPVkZ9Fq1U2bLnQ66nk425B5kW0Cw@mail.gmail.com>
Subject: Re: [PATCH v2] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        stable <stable@vger.kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 2:57 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> GCC 10 appears to have changed -O2 in order to make compilation time
> faster when using -flto, seemingly at the expense of performance, in
> particular with regards to how the inliner works. Since -O3 these days
> shouldn't have the same set of bugs as 10 years ago, this commit
> defaults new kernel compiles to -O3 when using gcc >= 10.

I'm not convinced this is sensible.

-O3 historically does bad things with gcc. Including bad things for
performance. It traditionally makes code larger and often SLOWER.

And I don't mean slower to compile (although that's an issue). I mean
actually generating slower code.

Things like trying to unroll loops etc makes very little sense in the
kernel, where we very seldom have high loop counts for pretty much
anything.

There's a reason -O3 isn't even offered as an option.

Maybe things have changed, and maybe they've improved. But I'd like to
see actual numbers for something like this.

Not inlining as aggressively is not necessarily a bad thing. It can
be, of course. But I've actually also done gcc bugreports about gcc
inlining too much, and generating _worse_ code as a result (ie
inlinging things that were behind an "if (unlikely())" test, and
causing the likely path to grow a stack fram and stack spills as a
result).

So just "O3 inlines more" is not a valid argument.

              Linus
