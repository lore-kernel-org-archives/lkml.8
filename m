Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A83C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FC921D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGNJBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:01:55 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:01:54 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MZl1l-1kP7ep3Vw7-00WrAn for <linux-kernel@vger.kernel.org>; Tue, 14 Jul
 2020 11:01:53 +0200
Received: by mail-qk1-f180.google.com with SMTP id k18so14891315qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:01:52 -0700 (PDT)
X-Gm-Message-State: AOAM533XDGawA3VyGa5j8TwmpHStcOIFd+k7Gj7b4IYxkXdXn7wLOIpN
        5pXn1asUrDNGfrs6WzIs1JUxbYWXwzYdx8zVEbg=
X-Google-Smtp-Source: ABdhPJxkrMxvJdjvUYRY5fiC0GTtBxjfbZiL+yUHXJNjoR52VcliI2+SPKZmoDOY77LuQlmc2P4+CLfJAhZaf6U+1/E=
X-Received: by 2002:a37:a496:: with SMTP id n144mr3539985qke.286.1594717311729;
 Tue, 14 Jul 2020 02:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200714083259.1313267-1-lee.jones@linaro.org>
In-Reply-To: <20200714083259.1313267-1-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jul 2020 11:01:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07SOgW0rKPcv2wjqUShtnO_rrRYbTC=FCuiGTDtkdPvw@mail.gmail.com>
Message-ID: <CAK8P3a07SOgW0rKPcv2wjqUShtnO_rrRYbTC=FCuiGTDtkdPvw@mail.gmail.com>
Subject: Re: [PATCH 1/1] misc: c2port: core: Make copying name from userspace
 more secure
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ozpfs08w3ZMFf93rHLIhJY2o0x5EydZCYTnNVZ7mgZhxgDtyxJc
 GwJB7wMeGLCWHOGGWwg3X2jeYxipIn1+yrLUK8QB4blMDIlccjOc0CUlOEFwH7h3UtD5xKy
 OsBCAvWAt12mxz6Rht/ehrStMlDxoZM4NGTHxTAbgXfxXGwsJjAt1cuMfmKd+gv6YPSisI2
 BQA592z9bHBw3LOWzb2Iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eMf2L3RiKQs=:3FtUDn/h9UTybaMWAwq2re
 MiC4/TjTcxTXxAYP5BYxUr2saqQ665JZt6IU4RBVBc/u9YCjUKB5vKVuCIv+e0YiOPDDy1Efj
 JJk/OoiH4gS5l7cQUgjjR9lTr89Mek70jgDSD0uMPeb42CbmKG3DP6t8NMZ50qtVP2W7SB3Tk
 Tou10byKAPd7tIKRF7xpa4zmX6P9NVoMwnp7ZzCexqVTvby9j44Z1PevOYUjTBuapWNZfiW0E
 OJHKrPOwb/25cL/sspLgrhfVs6TcU2WxpdBXvuHeTdkY29a8z/rXuP3n6ngle/T4sc+Lay5/O
 I9d64wT8ci1m6Mbr9wUzTx6GQ/2Yi/0oY4iGD/fciCPHW2YhGGFJQxVMKHRf0zmYthkoh8Cbm
 yG6OX2afTydvBfcnpnNf55akkDXHomkc2juCMiOlJIAo6scubyAwiTi1t0eONdLgubGfCeM0W
 2XEkXMTQkB17ueBtN8n/fyjZNSEyNrm/XUTqPwULQZ+PcnMN6jaUGcQfTK+TSIPpKtHROOBuK
 CEGzzp3HbnS0CCm+nLucbmKtkuF1mu7/uriS9mCwzMkvjIpo161MoEE+KvhUTHnIp5RzdKCx5
 1ZQjqE6BfjO/sr45DkIQX9jNX7gFQDZVkq6oHkmY57ZCen+isdqEzIjLiQ0PKyU3L9Bf/DxXD
 2vbfBVluDWTjpTAAnuAqzcLP/ccFPmJi4Jtq9HEoUieJ9q9RTge8g1K6AQFfebtz+CGDyC5AM
 t8kzdXceSD0q3XV5ETNaixZv2J5+tPyBZU8B6m8TWwOhsAyjcF4Ow9V4k2T+Tc5Q9F7dSmqv9
 b5auEjB8N5UAs1THZYO4dv1ZxWXN34FaHfbmx4m54z7tfYvl+bSBdEFEiuIBzyE6x4qoTWL2k
 9XhIDbH9oT2XsOZhOC/1n5+DpAmXpi9NBcaCgp2xpzQF6JpUmLdtYCTYLu8quFMxhlqkIoWK/
 v3alya5zhtSJ2XDPO/hBR7tRCah9Y0ahHGZ0I7Xq0/VvtSpPWBWKm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:33 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Currently the 'c2dev' device data is not zeroed when its allocated.
> Coupled with the fact strncpy() *may not* provide a NUL terminator
> means that a 1-byte leak would be possible *if* this was ever copied
> to userspace.
>
> To prevent such a failing, let's first ensure the 'c2dev' device data
> area is fully zeroed out and ensure the buffer will always be NUL
> terminated by using the kernel's strscpy() which a) uses the
> destination (instead of the source) size as the bytes to copy and b)
> is *always* NUL terminated.
>
> Cc: Rodolfo Giometti <giometti@enneenne.com>
> Cc: "Eurotech S.p.A" <info@eurotech.it>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
