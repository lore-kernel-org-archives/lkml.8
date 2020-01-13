Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D069C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DDA2187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578943939;
	bh=Qa9wK6QQilr8ok6T3WZf5PfBmbljZ9QyuEtJpUpiFxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KpLGSUBiJHP8jhn8G1lixYqv9eKci0/JJGx8LZWedQZB395P1jBiXDfmBqciWgihq
	 eFUCT2wk1AWNZ1mvRuGvrxcnQSUbfayKsb8VteoavgaKx+aNwllWu3RZnMsWqJZth2
	 /Q3HIjTN6L8lVE+I5NUXlIsE9QHD+nrowC4NPEhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAMTcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:32:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44111 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgAMTcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:32:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so7766859lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ae/+DIZn8QK4Eu0S9kiQGO5TqvMJzTIQ/bcHyd6r6aQ=;
        b=dsTuRrPnmRxjK6yre9iMf8gYcDE0hjJkuaJ2eT9ghACf2vMogI+i+ZMgu9tiR3PjxB
         uzQhEdyjiSlebYb6SLrus5AR2u6J5fDcOnswpR5Vfnatgy1xjOGHGAsOhngu0riP6Xcw
         2ZfyA9EtBicLF7bVKr8HK+hd9gJ6oiCIwVO50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ae/+DIZn8QK4Eu0S9kiQGO5TqvMJzTIQ/bcHyd6r6aQ=;
        b=AZNSENZIzBX4/sFzdHTeSGRYwYQo6SkPyJ+5mbkAEuwGkBeWz/25LRY5UYQtrWqI5+
         cS3nA9/4egu1p0TxLQ2mrTDWVkW1lZgnWxr+vNDQbsm0T7KXqOEqX7kG30heZCFjaiVi
         zq2UW+CljqYI8HPONfqPKhbh2YCfC13xRlEtv74oCXHt/Fb5rwA7ab1b3alQe0b8XLXi
         tIdg4I5JW6pk7A2swCsuora/3rrfrOwYVsF+AW2pLp8613q4eLSg9Tv7S+BBvH1Id7iz
         VgDei+ctZdA1WiXbTXhXjgwlx5TT2Ku0XpIUFz5djog1tvau7/ZJLCG/SDeHjPjjp+aX
         PTlA==
X-Gm-Message-State: APjAAAXUkzUOI+sfS/GaOKQz/F4M8BJRvuk/JlX1hoCxen/LMXPpX2Ad
        vkJUDVFn3bu0Sv+qG/hmua3bZHZoWgc=
X-Google-Smtp-Source: APXvYqzfB3VRtVorvgZjo88OmPxOf1e2TIYrzS02KglPjSFgNWv+Ze7IFsV3COG54Wx/auM0Z2e5GA==
X-Received: by 2002:a19:c205:: with SMTP id l5mr9770364lfc.159.1578943934607;
        Mon, 13 Jan 2020 11:32:14 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id x23sm6110478lff.24.2020.01.13.11.32.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 11:32:13 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id w1so11461323ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:32:13 -0800 (PST)
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr12034973ljo.41.1578943932792;
 Mon, 13 Jan 2020 11:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-7-will@kernel.org>
 <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com> <20200113145954.GB4458@willie-the-truck>
In-Reply-To: <20200113145954.GB4458@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Jan 2020 11:31:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wirAWFOrfD4us1FepP0vWkZMpnqXusJyKHCqwBVsR43CA@mail.gmail.com>
Message-ID: <CAHk-=wirAWFOrfD4us1FepP0vWkZMpnqXusJyKHCqwBVsR43CA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 7:00 AM Will Deacon <will@kernel.org> wrote:
>
> I can't disagree with that, but the only option we've come up with so far
> that solves this in the READ_ONCE() macro itself is the thing from PeterZ:
>
> // Insert big fat comment here
> #define unqual_typeof(x)    typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))

I'm with Luc on this - that not only looks gcc-specific, it looks
fragile too, in that it's not obvious that "_Atomic typeof(x)" really
is guaranteed to do what we want.

> So I suppose my question is: how ill does this code really make you feel?

I wish the code was more obvious.

One way to do that might be to do your approach, but just write it as
a series of macros that makes it a bit more understandable what it
does.

Maybe it's just because of a "pee in the snow" effect, but I think
this is easier to explain:

  #define __pick_scalar_type(x,type,otherwise)          \
        __builtin_choose_expr(__same_type(x,type), (type)0, otherwise)

  #define __pick_integer_type(x, type, otherwise)       \
        __pick_scalar_type(x, unsigned type,            \
          __pick_scalar_type(x, signed type, otherwise))

  #define __unqual_scalar_typeof(x) typeof(             \
        __pick_integer_type(x, char,                    \
          __pick_integer_type(x, short,                 \
            __pick_integer_type(x, int,                 \
              __pick_integer_type(x, long,              \
                __pick_integer_type(x, long long, x))))))

just because you there's less repeated noise, and the repetition there
is is simpler.

So still "Eww", but maybe not quite _as_ "Eww".

             Linus
