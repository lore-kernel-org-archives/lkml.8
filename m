Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC13C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB0F20768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZ5myydx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHNUPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgHNUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:15:07 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07400C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 13:15:06 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a24so9189575oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1VjQolyfnnNVHHYuPIt8KNCctqJMTa9sGgTeUR70Ro=;
        b=DZ5myydxcvkGbm+IsJi3gh56/Bx0I9UaNCaJ/ja2SMZKO1klTplQvWE6mNbZhrGgv/
         UF99xSMV81q7h9YWU718ve0oCTci6YlEkeVIgBIl9rUO1DHkOKOkkBQFqnrtqVoFnicG
         4khUMVOXYg0QltxHVsuE+SOlJtDagL5LrMwEFeOG59n3JY92s+7oxtRSGfxB0VBeSIO+
         JwC4EnIwyEOh6Towkp8VMDKmTtvInhnauublH668LYzQWCOBwh0YFwelJM688XPUQFCX
         B5wqPD15o5+/D+tCHj5tTucdfC1n3qt2hRdNi79xBh/2bZTC3cBgEmROvyrkCxKk+NV9
         wxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1VjQolyfnnNVHHYuPIt8KNCctqJMTa9sGgTeUR70Ro=;
        b=mC0nbk7WBK+AYVPSjnASXaAWXm87T6Nj0GC/kgTszpO+CCSTglvQqfrkFXg6kMJELS
         wEVF1u4CuVZAbS3QSOY0Kh+0ANDOq9nXN47g9L+GtW4of5ljOzrsYRaOlLsEybEdaPni
         Y7TdSPDZDxVoIzLSPy3Yt0L1O4jx+1sH8d7aMqzp6T49+u4WY62JlHkGX7X3tJdhrE5c
         pIdjEjtt8kbAsuyLNeFc+TUzmWpRgggk4AVL8EC8GY8hjqkvWyyfit9AVTYd6SSGWc49
         qrIS+yS7tHxQMHZEIYmnessVjkYwHtWoZznCQ713BOi6nbghPhKE61zcimJjICTdiELA
         egsA==
X-Gm-Message-State: AOAM530qzstDtFA0linYnZtVZskVEhNQgp1lxsOmhmSOf22pFrzMkqU+
        zVEoEG6vnznf/GAwBqTkY/6/eF6wiNcluoS0VYNFvQ==
X-Google-Smtp-Source: ABdhPJw4UOC9yfUWvWUG9o2FjojXvLZmJIXbbxjYgl69mSx9NHERCd5aVLqvrPbeoCFTLDdWCdN9atd5Igcy//QirKc=
X-Received: by 2002:aca:dc85:: with SMTP id t127mr2517949oig.169.1597436106306;
 Fri, 14 Aug 2020 13:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200814062458.53049-1-john.stultz@linaro.org>
 <20200814062458.53049-2-john.stultz@linaro.org> <CAAEAJfDy7V9thc4-dfkwkiRAqqG=D1_qWTv7_gOkN9dcaM6mkw@mail.gmail.com>
In-Reply-To: <CAAEAJfDy7V9thc4-dfkwkiRAqqG=D1_qWTv7_gOkN9dcaM6mkw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 14 Aug 2020 13:14:55 -0700
Message-ID: <CALAqxLUKkAubGMPYKZC6ufjaepkHw21Cit4h=nnOJGjYnO7GUA@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 2/2] dma-heap: Add a system-uncached heap
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 9:15 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> Thanks for the patch.
>
> On Fri, 14 Aug 2020 at 03:25, John Stultz <john.stultz@linaro.org> wrote:
> >
> > This adds a heap that allocates non-contiguous buffers that are
> > marked as writecombined, so they are not cached by the CPU.
> >
>
> What's the rationale for exposing the memory
> attribute as a new heap, instead of just introducing flags?
>
> I guess this calls for some guidelines on what situations
> call for a separate heap, and when it's just a modifier flag.

YES! :) A big part of this patch is to start a discussion and feel out
what properties of heaps are generic enough to be flags, and what
aspects are unique enough to deserve having their own heap
implementation.

ION used the ION_FLAG_CACHED bit for this and considered it a generic
property (though by default all buffers were uncached). This seemed to
cause enough friction in reviews that we dropped it and used cachable
buffers for the initial DMA BUF heaps.

Further, I want to make sure we avoid the custom flag abuse that ION
saw, especially with vendor heaps. So I think having each unique
behavior being a separate heap is a reasonable stance.

That said, we added the (currently unused) heap-flags field to the
interface as there may be some attributes or modalities that are truly
generic across heaps. So if we want to add an UNCACHED flag instead,
I'm open to that.. however I want to make sure it has clear general
meaning so that its behavior is consistent across all heaps and
architectures (or produces an error if it's not supported).

thanks
-john
