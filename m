Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE0C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD73E206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpFBqYyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgC1Q5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:57:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45908 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1Q5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:57:10 -0400
Received: by mail-vs1-f65.google.com with SMTP id x82so8209227vsc.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhiFJBSZNtYSvVSvHZmFB6j429D2Xk9a0RkMHEiXG8c=;
        b=IpFBqYydKO4X5tjZdF6/ZSTKxEeM4WlIS+ChGXQtJZy6GTvXCdyL5j9abJnkh8lpj7
         YbRntbJc/li2sXz0p7VnDRVStfetfIIK0Z3oxhLGQMrur1diTBse//y5dNZauZQlUqTA
         2TtgDESP1R/glkc4qtp1x4YUlOMl0OAqyXob9jKHbQCpN7/hq3LZTYnjiHDIk+Zjr/Pl
         sFK+0fNSiKD2CSd2FTJNczajwXqS3XXlxFJ6MQzTfx5NeZYfnJOym/rJ6TVAzEITpO1B
         pOp5DoGZTulkPH2QHCIlixDZpKmc7+9d/Fok2RouVJjxvZzbbFObc9o//WOUHJBGf/Os
         1znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhiFJBSZNtYSvVSvHZmFB6j429D2Xk9a0RkMHEiXG8c=;
        b=EB7elC6f2/Tt/zRIyl4da04L9Bu4R66K56Yr9ddAzFgluRl2QO/sowv0u1zjKdOaFI
         yqq2fhgKo/xozBPMc7dwHeqoo1SReIGhsdmFXk464p9Qy/mX3xDX51ypdJuD7h0bYozk
         Jy/me93e034rOZbzdLPXNT8QAr5v2YUoJyq1w44b6FagpkMRd6V3etEFHtUfNEoifMMT
         rsFiF2ka+8AWAlq7Ft8IMtKqQc9XJY6CE0V/Apex8AdId9VFHfNGbAdG/0SDQgx834HH
         cgjXOeiLkEZgzzWdyKvdl/ObyoiJs3Ba6EknCvGzalne4RGS0+KkOpRDxpohnNoRWJxq
         fVyA==
X-Gm-Message-State: AGi0PuakM7MD7+CduQ5CtCSxLvIFZlXGMpNRxgO20Wrei2uyHyLJ+IpS
        zj2txjXoHmPtqmW2wlKqicqidN9SOffOBsOEXJNg7bzoYaA=
X-Google-Smtp-Source: APiQypKJX0cgH9UX1zvl/KxFagV/iiKpTIDbbtgps7O8QHhbwEjork3xVWP02RmgYM8BlCpeFiPmZ92wI/HPw/80J8Q=
X-Received: by 2002:a67:ec81:: with SMTP id h1mr2530828vsp.96.1585414629166;
 Sat, 28 Mar 2020 09:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <202003281643.02SGhD4n009959@sdf.org>
In-Reply-To: <202003281643.02SGhD4n009959@sdf.org>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Sat, 28 Mar 2020 09:56:58 -0700
Message-ID: <CANP3RGean6M7PuTMXKJrXSdU+2RgzqsoEvnQK5C0RFoXGfFwBA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 18/50] net/ipv6/addrconf.c: Use prandom_u32_max for
 rfc3315 backoff time computation
To:     George Spelvin <lkml@sdf.org>
Cc:     Kernel hackers <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux NetDev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>         /* multiply 'initial retransmission time' by 0.9 .. 1.1 */
> -       u64 tmp = (900000 + prandom_u32() % 200001) * (u64)irt;
> -       do_div(tmp, 1000000);
> -       return (s32)tmp;
> +       s32 range = irt / 5;
> +       return irt - (s32)(range/2) + (s32)prandom_u32_max(range);

The cast on range/2 looks entirely spurious

>         /* multiply 'retransmission timeout' by 1.9 .. 2.1 */
> -       u64 tmp = (1900000 + prandom_u32() % 200001) * (u64)rt;
> -       do_div(tmp, 1000000);
> -       if ((s32)tmp > mrt) {
> +       s32 range = rt / 5;
> +       s32 tmp = 2*rt - (s32)(range/2) + (s32)prandom_u32_max(range);

Here as well.  Honestly the cast on prandom might also not be
necessary, but that at least has a reason.

> +       if (tmp > mrt) {
>                 /* multiply 'maximum retransmission time' by 0.9 .. 1.1 */
> -               tmp = (900000 + prandom_u32() % 200001) * (u64)mrt;
> -               do_div(tmp, 1000000);
> +               range = mrt / 5;
> +               tmp = mrt - (s32)(range/2) + (s32)prandom_u32_max(range);

Ditto.

>         }
>         return (s32)tmp;
>  }

- Maciej
