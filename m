Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F27C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD3720738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598036744;
	bh=Id6R7u3ib9v/1/U8w2giTzJxHZLLpKGgT5f81aloJQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zVS5L1iodMZyWhnljgBN9+Cu3+Bz4q8jPvpXhRGS1EYX36gm2LB8gULAn5bAyvUHE
	 lMA9AhMlkF1sDEfNbO6PdHTuave3XhC39uVhKtGUoJ/Ut8ALfN1bnT4oePXq41Ba0z
	 o06yTHNFkQdkhfxLus/5k6o+GB3EnK63wnVJJa2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHUTFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUTFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:05:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2311C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:05:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g6so2977353ljn.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYAilJKJE/Ww6fPETY0UsPcqYTSdX+KcqzOQ2SZHjHk=;
        b=govgPlM5hnPkSEwfWGUIYxRmIaYCCF2bJTE78xBfzEYFWIPnokbR5UlRZzXwtuMDBP
         3GiSRxTe+MNLCrhfBipl0worTfXzuhdTvTP6Gg+IWnDBkSdWt5veGPtmhC5r57CVxwrS
         LCil9FpOzP42GhiX+Lc1tk9QZDcIjKIcMjeTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYAilJKJE/Ww6fPETY0UsPcqYTSdX+KcqzOQ2SZHjHk=;
        b=uXHMsnmYb6IuX+YOClWXZBKWyD6g/i5KNhZTws0QwFwrE3f9rtIy2eQ/nDWcwm8OB/
         P+dIcW/m9JfzrUzGLe+57a+TOzUmASby5ClZwTeKQG0BYSLBhL8xaqd3AwZliSN7fRsa
         wqfODZBQQQ20qElnp5ktgsnuQo/lMSr6Mtd9bgSshEPIjo/6UfWss6BHdJr5oByrgps9
         Jwvww07iZiYGD0AseB9jo4FyIU9Aps8uDNBqOuYcFyOZ0LoNIWR8UDB7b1iMyQUpKZv6
         c8j+sfpG1A75yuZwkxYx6Gh3vRLuD0wlAD4WSkdY4Tti2nMB1RkrU7SdwY64VWv9+bPF
         Uehg==
X-Gm-Message-State: AOAM532W7ip4yw7SnTmmamEW+0toVT/mmRZ7MIW09nsgjkPqCzCetsdk
        nEDHDpbGj7gWXIR00WgH1wU97iNS/rzjYA==
X-Google-Smtp-Source: ABdhPJxuAyvSezu1Wnlo/pz3YudXdushqM7Uw8Hd1p4QvruV89W6Q9o4ukLFmHP6N+cm6OaQRX480w==
X-Received: by 2002:a2e:91d4:: with SMTP id u20mr1993730ljg.87.1598036739724;
        Fri, 21 Aug 2020 12:05:39 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l19sm545227lfg.61.2020.08.21.12.05.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 12:05:36 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id v9so3003275ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:05:36 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr2338287ljf.285.1598036735955;
 Fri, 21 Aug 2020 12:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1> <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1> <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
 <20200821101333.GA3432@quack2.suse.cz> <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
 <20200821154756.GC3432@quack2.suse.cz> <CAHk-=wj-pfzKf3JDe9fr4o_nKYXJXfuYAMFCajwhy0YYYri4Fw@mail.gmail.com>
 <20200821180848.GA11376@xz-x1> <CAHk-=wj3fY2dch7Ah-MLbJcfU3buoXgJnwc1zWFSjVujSd39GA@mail.gmail.com>
In-Reply-To: <CAHk-=wj3fY2dch7Ah-MLbJcfU3buoXgJnwc1zWFSjVujSd39GA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 12:05:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5Oyg0LeAxSw_vizerm=sLd=sHfcVecZMKPZn6kNbbXA@mail.gmail.com>
Message-ID: <CAHk-=wj5Oyg0LeAxSw_vizerm=sLd=sHfcVecZMKPZn6kNbbXA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But the PageKsm() page_count() issue I didn't even realize. That worries me.

Well, the fix is simple, although I don't love the magic PageKsm
semantics that hide it from the page count.

But since (a) a Ksm page is presumably normally shared (ie things like
all zeroes) and (b) copying should always be safe, just do that.

The case we *used* to have with trying to reuse the KSM page seems
like it's not just adding complexity, it's optimizing for entirely the
wrong case.

Check both before and after getting the page lock, for the same reason
we do it for the page count.

The logic there matches the "reuse swap page", but while that old
logic may have made sense 20 years ago, the swap cache case should be
*so* rare these days that it feels completely pointless to try to
reuse it.

Aggressively doing a new allocation, copy, and freeing the old swap
cache page is quite possibly cheaper than taking the page lock anyway,
but more importantly, it's not a case that should normally trigger in
the first place.

That said, looking at this code again, I get the feeling that the
mapcount check is pointless.

Afaik, page_count() should always be larger than page_mapcount(), so
if mapcount is > 1, then we'd have caught it with the page_count()
check.

Hmm? Am I popssibly missing some other subtle special case?

Are there any THP issues? Again, doing the copy should always be the
safe thing to do, and since we get the page lock for the reuse case I
think we're ok on that front.

What else possible special cases could we hit?

                Linus
