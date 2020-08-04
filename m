Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4095C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EA02067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNLlroBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgHDNY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgHDNYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:24:47 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9E1C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 06:24:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so4691418pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LL7CVx3M+GnKSSe8eUQMx8d9kBXew/bFtxjaZTrFB4I=;
        b=HNLlroBUqWnzQ0xGT6GTr/Id4TzheIch2ECQb//1Mh+eL1JbUWj7mgeq13LfdccS98
         IS3DGtZa2HgV/RhIJuVePSKzqD3uwjzCS1qPt4Fito6mIqPvXraCYBmdo3L34332gOIm
         WmfyL0evZGWgvDbKbmphDaCTUSc2DQbsN3FZIG1S/LRGxUsEGkoRmRKe10PFG0piz92M
         AhSuxdBD/UQqupXICBkPfCSJFZTywgv3NvO04VK0i+G1rFdbd3XmQteUx1vj4/C5GbfW
         pWOV7qnFTZRWi05TIryxjWTQNA2vc3vyZdMkk8iDFMuFXYFCkua4Y53lmW6gg4sBAf/7
         0SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LL7CVx3M+GnKSSe8eUQMx8d9kBXew/bFtxjaZTrFB4I=;
        b=UCGKhoRp9VK/HwJBFP04d10nwFgVTOo6PfrzL9qjoi7eeMLzp7/Fq0zRdGptKkRxoo
         AILBh2dqtm9GY/S2AIA9lC5YYPkwS66m20604U6vS0aNFHfVzulIGLzejsvzPnrrmRYl
         pCLeIMshW33Qaj1xeduAcFFicVLtUDt6wZKQ44vp4zmchZzuOR4sAMtYv2dCSCxmsrIy
         pz9cl9TZOWlDdvgm9+l2jKTXYS2LBFUiTqasMoqF6nRGFPre21+Q7+dh2kiZ34Ln/95l
         EoLFwfFmXeRqepYs47cHxaVzpwvFtJ4S3nijZqpOndgwXnzHbgR1l97pFSqzelxWqX1J
         q1Yg==
X-Gm-Message-State: AOAM532u1c25jnGPTvY70072y0SbVxB3RXIZl7SWL4FR3GwtP/bwR4uN
        sXUvIXW9tQfNLOpOytuKcGjyLj/f2tWeoPaO8WwdeA==
X-Google-Smtp-Source: ABdhPJx3jQKW6ryn3Y7C/EY3oYgP1FKFpU1S+iDkIFMexVg3zCcBg4JLu/mb7S7DJX/i24rr6RUB20iZPZdJ3KDAP60=
X-Received: by 2002:a65:4bc7:: with SMTP id p7mr3313300pgr.440.1596547484618;
 Tue, 04 Aug 2020 06:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com> <26fb6165a17abcf61222eda5184c030fb6b133d1.1596544734.git.andreyknvl@google.com>
 <20200804131939.GC31076@gaia>
In-Reply-To: <20200804131939.GC31076@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Aug 2020 15:24:33 +0200
Message-ID: <CAAeHK+wVpLvjcwGzD=0FyXiC0+tf6CU0uwh_vfzBXfaCpDyKPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kasan, arm64: don't instrument functions that
 enable kasan
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 3:19 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Aug 04, 2020 at 02:41:26PM +0200, Andrey Konovalov wrote:
> > This patch prepares Software Tag-Based KASAN for stack tagging support.
> >
> > With stack tagging enabled, KASAN tags stack variable in each function
> > in its prologue. In start_kernel() stack variables get tagged before KASAN
> > is enabled via setup_arch()->kasan_init(). As the result the tags for
> > start_kernel()'s stack variables end up in the temporary shadow memory.
> > Later when KASAN gets enabled, switched to normal shadow, and starts
> > checking tags, this leads to false-positive reports, as proper tags are
> > missing in normal shadow.
> >
> > Disable KASAN instrumentation for start_kernel(). Also disable it for
> > arm64's setup_arch() as a precaution (it doesn't have any stack variables
> > right now).
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> I thought I acked this already. Either way:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Sorry, I forgot to include that into v2. Thanks!
