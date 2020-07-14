Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD48C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D203C22464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQWr3OUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGNM5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNM5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:57:43 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC66C061755;
        Tue, 14 Jul 2020 05:57:42 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i18so14096364ilk.10;
        Tue, 14 Jul 2020 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tpy10WfAX1z1P9FVWP37eg4rB5eaWpDttxXVOTpuTN0=;
        b=VQWr3OUL+Tw7NvsiDWjYGOi2Y/vfT0dY1jb07fuNs/RI+zXm/++xC+VDvD/Npiuut+
         dTTBZtpE9v8FIGhnxywnkwBuInIrScxL0ok6fZONyCuIJ1LA+NyOtUqkubnAkaG2hgkk
         2mOMpwtskfuUpDD5WYvCd4PsoBX8jt7gN1ezE+eJX/bOggAfp+JTHvBXMznowQlfM7Fe
         2hYEeP2P6wzDOZ6xISPS94FaRA78Kjv6E+aywxfv9mYsRxLPlghYiQ/pcWpfIHINmxhn
         Pw+xEs8m/z2vZfoclDFEw0bEtpFqlsoB5Rx4NICICV7huYYfl8bz6JsG6+USI1zzhBM2
         GPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tpy10WfAX1z1P9FVWP37eg4rB5eaWpDttxXVOTpuTN0=;
        b=PKSCtqSlBsgHkiqCCuqKXJjMGDxKSYHfxwijVu5r7RDwvHjK0fM/5nmz2amHruiEm7
         uunJpI/c2VOgjcjCoAAfDzORpz1CnokOpam9bF8ZUC0zvtxqBfILM5YFg+BNswEr6c/3
         uXCWEQeayE6Oa0a+OTyUkCayLJLwKSR38wWk17Gu+nen9FSv/R1yEjvoQZZDjT2YPCFQ
         IU5JvaWsF+zelwX7nOlQmEQVMuCx6JQ/3ThdkgGPaqabRAagYv3AbsddLzTB4HIepEkq
         y+D3nzwv0tug4jb6+tBNqNDQGhf1cux8mO4gSu98zUuYsm6Tw8WHvzplrhEZJ+HnalLf
         MjkQ==
X-Gm-Message-State: AOAM533IDSnGvvqhZwD9di6QRtRO77rydGSbg7mcgLEWmhZAP8lBMprO
        wfklCpkBtm2SJlISgUj9gacr/lzrGa6Ti3itefg=
X-Google-Smtp-Source: ABdhPJz1Shw/+QySeLYjrkVPP/h07k/H6RrpTQq2av+wXlP2/uAQgBICNQC+qP14iFQk3R1mNYpVoNBIkPtZLLXspVU=
X-Received: by 2002:a92:8b11:: with SMTP id i17mr4587786ild.212.1594731462385;
 Tue, 14 Jul 2020 05:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com> <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
 <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com> <CAJfpegvU2JQcNM+0mcMPk-_e==RcT0xjqYUHCTzx3g0oCw6RiA@mail.gmail.com>
 <CA+icZUXtYt6LtaB4Fc3UWS0iCOZPV1ExaZgc-1-cD6TBw29Q8A@mail.gmail.com> <CAJfpegs+hN2G02qigUyQMp=0Ev+t_vYHmK5kh3z+U1GkSuLH-w@mail.gmail.com>
In-Reply-To: <CAJfpegs+hN2G02qigUyQMp=0Ev+t_vYHmK5kh3z+U1GkSuLH-w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 14:57:30 +0200
Message-ID: <CA+icZUWSeUJwtymRL2MXXCRy3SyhQ9LraQAzUwCB2my09BWRcA@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in tree_insert
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-fsdevel@vger.kernel.org,
        Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 2:53 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Jul 14, 2020 at 2:40 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> > Did you sent out a new version of your patch?
> > If yes, where can I get it from?
>
> Just pushed a bunch of fixes including this one to
>
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next
>

Just-In-Time... I stopped my kernel-build and applied from <fuse.git#for-next>.

Thanks.

- Sedat -
