Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ACCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382B02073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UoJLWgeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCKWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:22:22 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1384DC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 03:22:22 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 72so26360499otc.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pd7yLV/SO1LXlgw6apJI4TFl8BhIVhbdOA/baiOJLT4=;
        b=UoJLWgeGLocz0e8pv9iFzBeVk+4kJpSQGN1VfpjZUStopG6omp+MBlHC6v609VEzAK
         wc2/eax8OtTaoTSnq/K4T1mNIGGZVs5/MhpSD7T0OT+TPXP74gxLIBDPJeFO/w/B96sk
         GLWHjUEAzT1UWQZsdNTG1DN7xoSCQv1eUOoH23Qh/ktfbcZ/oMlnL7UmF0b5dWXG+Nr5
         uS15lN2GyTjCjhbsU2jDW/04BjcQaTmrTyCH+oXu2K3S2uMLNWIMsH27ltqQZvMzSJw2
         /FQhi/A8Daqyd9sSt3WxBKm2SaitpFSa2AdLNwAChtUHLca8qXyy6kuGB+OVhbjBFexh
         S02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pd7yLV/SO1LXlgw6apJI4TFl8BhIVhbdOA/baiOJLT4=;
        b=FMv3/Cc/v9OaEtkt9RZfkBK9qPWECmJCRnrgaV4eDNVEbEwL1fjhK//O4HYZWtodRG
         8bewk7KWzA6WP8il6S94dAAfmeDsPmpdr6ArIIm+KsdnKaBjGsw+kef6Z88k3Fr+k9xi
         hsArRnFB7NvEmwDOM2ER0hjC8cwJUDJdFhZj/XK7F93GviYEBnfVq9/6dcLpIsgoGc6c
         iN5u+Q8IC0AqIC64XTnVZQAr3wwHMAwUk2ZQG1bYHwlam7E+frc8tX3cbHVb8D9e8HJO
         xvk0s9wOwXXG0x7iN+CU3paqdumPyuB552cI5P65dRdCRVpcb1hWjynO8R9sX8R+IjNq
         CHCA==
X-Gm-Message-State: AOAM533f9sVhLCl7jbhOEfUfM05UjyidJ2RtIGdwB4gbifWEXNdD0Q/A
        t4ciF/1Pg/QigFJc/9NiF7noQkzYpWJupqdaXrc3qwoM
X-Google-Smtp-Source: ABdhPJx2f3pVaLOQ8x/apSBaKeTS8NPWTPXF2TKzer6LRMMteZ3+UafBjvjdhGIG4cyvSiqTRvLljgt7ok/1TXPHEcY=
X-Received: by 2002:a9d:3a36:: with SMTP id j51mr31045607otc.129.1593771741510;
 Fri, 03 Jul 2020 03:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
 <80902e5d0d5ef752e71672e9c5794d0f5f9ccd15.camel@perches.com>
 <CANiq72=Qakg1HAW8XggsBqiu=6-GVtQNDzeefmXxVG_RNA8MkA@mail.gmail.com> <9f0f19938130cbe9fd9412091254bacb8dd8bee1.camel@perches.com>
In-Reply-To: <9f0f19938130cbe9fd9412091254bacb8dd8bee1.camel@perches.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 3 Jul 2020 18:22:11 +0800
Message-ID: <CANXhq0q=kEmXjBoSYrdKCHB=X_kksPro3gBQg8LCaSJcfLowqQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/Lindent: increase the maximum line length to 100
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 5:51 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-07-03 at 11:41 +0200, Miguel Ojeda wrote:
> > On Fri, Jul 3, 2020 at 10:51 AM Joe Perches <joe@perches.com> wrote:
> > > I'd prefer to delete Lindent instead.
> >
> > +1, especially since there is `clang-format` now.

Agree, it is often used.

>
> Awhile back I did send a patch:
> https://lore.kernel.org/lkml/1360610974.28491.6.camel@joe-AO722/
>
>

Cool, let us go the patch above.
