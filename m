Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FFEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 22:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7A020727
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 22:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kd0qghWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgEPWp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 18:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726700AbgEPWp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 18:45:58 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77FBC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 15:45:58 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id s37so3161606ybe.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGBJJg8ccdwDotOS0lajgPUzbH0sjT5P5HzXMeDAq6s=;
        b=kd0qghWCRvLiIcrwqmOceUa+qsoVQBLrtOax5TvLJgwX3fxzydbRjZhIsfo+zfmtY7
         cfHsoHFnX1/lUXrEdatIt/7VebDx+uQzJ8MwLzT8nysM1h1I/u21OwnIrARKwqyo/k7W
         jCXGL6/jabykrmNvaT0ARC4LEiweXH7Ij0bDdKR+wJO0qaIOn94yXBlN6LUWjgthqHia
         mlaEaKKs0A/SxTckt+0buJYQiyq2yjdrElje8OE1OQIREJTUc0HEUbXQTMbfEFTsK9Ql
         AjfTSGIqXyLt6zvJhxMlg7J8SMpumGibGRhesdRp+pM8fZ8x09YKJ1FL4aGJcoZs/eO4
         NafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGBJJg8ccdwDotOS0lajgPUzbH0sjT5P5HzXMeDAq6s=;
        b=hcURau5o+9VNYyD5CbNuU9W0Ld2bVRQ8thqki//keHRF1vo/gMqWqHpqIljfbLsf1y
         CnOduoTSDiwSvTIWeWBabzmFiblK4aKfHtIZrloePyFMFSyqD6gOjZy3NzQ4Xcq1Nwmk
         ANHiDzJNOhip6BcEyD5RdO8pao9zG1Yk4l6+zz9kGZgO2FIQtGfetxTRSvi9V8dei6KW
         oqPA2qP9FKb52831MOH/nP2GOLRfF4aniDdt9SH6I5pqSN615XLGqygZ4q8d/tqFSGtf
         luL7a0r34Nece48YzjwgYA+Wyvfq5vtfR9IR47yBpIjoEnwte7TFV9Bp2BW3tHlyi2a0
         iesw==
X-Gm-Message-State: AOAM531i5sHusQQVNYnijWpQbFrPPLtw6XrMOp2M0czDwX8NWqi61Tqe
        VnU0wPBPU21zvn6CfRj9SVE9ZE0/3ObedlZq7ljrQA==
X-Google-Smtp-Source: ABdhPJw4eoMpS6yh5Ftbeph6barp57A1uRQk/pXHg889I/Eh4I9qLMOWudeieo57XFx0yL23ArvJ+BA00DbX7kOBZ/o=
X-Received: by 2002:a25:4cc4:: with SMTP id z187mr16200349yba.274.1589669157558;
 Sat, 16 May 2020 15:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200516021736.226222-1-shakeelb@google.com> <20200516.134018.1760282800329273820.davem@davemloft.net>
 <CALvZod7euq10j6k9Z_dej4BvGXDjqbND05oM-u6tQrLjosX31A@mail.gmail.com>
In-Reply-To: <CALvZod7euq10j6k9Z_dej4BvGXDjqbND05oM-u6tQrLjosX31A@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 16 May 2020 15:45:46 -0700
Message-ID: <CANn89iJ9BYNi__DhLp_QE5JU7=RxkzknOSxD+P+qiHg2=Ho6Ow@mail.gmail.com>
Subject: Re: [PATCH] net/packet: simply allocations in alloc_one_pg_vec_page
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 3:35 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Sat, May 16, 2020 at 1:40 PM David Miller <davem@davemloft.net> wrote:
> >
> > From: Shakeel Butt <shakeelb@google.com>
> > Date: Fri, 15 May 2020 19:17:36 -0700
> >
> > > and thus there is no need to have any fallback after vzalloc.
> >
> > This statement is false.
> >
> > The virtual mapping allocation or the page table allocations can fail.
> >
> > A fallback is therefore indeed necessary.
>
> I am assuming that you at least agree that vzalloc should only be
> called for non-zero order allocations. So, my argument is if non-zero
> order vzalloc has failed (allocations internal to vzalloc, including
> virtual mapping allocation and page table allocations, are order 0 and
> use GFP_KERNEL i.e. triggering reclaim and oom-killer) then the next
> non-zero order page allocation has very low chance of succeeding.


32bit kernels might have exhausted their vmalloc space, yet they can
still allocate order-0 pages.
