Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA22C433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1722820720
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgGOIMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:12:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39717 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbgGOIMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:12:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id w17so1568947oie.6;
        Wed, 15 Jul 2020 01:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLIr/bHsu0xgPfdJu86Cng7NJgjZSRi3Z8007yksKT4=;
        b=BptyDE3tZo4SGQ7Kkr4tMIaL4b+LA7QRNXOoiDGSew0pWtokELqwhkVKmrv7av9aVb
         /OZeGy3Hdn3xHfW+j28UrKbAz4qb20HIlrTI8jI1vYnwnej8U0LeCCtxHpCr4WtkuM8V
         swyBztOfZOerH4ywSa6k3fSlu4FFkf+EKjwD0bXluDe8RHgoeL/Ag8W39rmySwrL8egi
         Zoc6GHiknZ/j9YSRkyjNqso04I5IgYqL0RbYs7KfKPj4zyhoU/cOmJYIzt2/MP0a62gf
         WewsvaAz7/ewNXj/iie4vgUqAaPLIUE2/ZL9eoq/mbadDuV7X2RUlzWhDZfbqCrWNQDA
         54QQ==
X-Gm-Message-State: AOAM533dUr0JwshbOBy8OzW8h/ZZ+RFrfEX7QTjNkxi5mgwWBIAFGR4u
        LIULXVIFHzDWEzlGaI+SVhHxMC/k2qa7+bZ8iQo=
X-Google-Smtp-Source: ABdhPJzpiyDbZuCmwFj6qnOI1cpJc3PY4hw97ZV/0NiMOzcY149LnJ7slrP077BWKalmPhu9wLzjTqHwvNc3B0i4QEY=
X-Received: by 2002:a05:6808:64a:: with SMTP id z10mr6889533oih.54.1594800725023;
 Wed, 15 Jul 2020 01:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de> <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
In-Reply-To: <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 10:11:54 +0200
Message-ID: <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Jul 15, 2020 at 9:51 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 7/15/20 9:46 AM, John Paul Adrian Glaubitz wrote:
> > Indeed, it does. This patch should be picked up as well.
> >
> > Kernel boots without any errors now.
>
> Btw, booting with systemd as init causes a lot of hickups which I didn't see with 3.16:

> [   25.184000] BUG: Bad page state in process systemd-hiberna  pfn:5d91a

Lemme gues: does commit 002ae7057069538a ("mm, dump_page(): do not crash
with invalid mapping pointer") in v5.8-rc1 help?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
