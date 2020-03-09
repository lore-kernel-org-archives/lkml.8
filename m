Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35082C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114832072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCINI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:08:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33067 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCINI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:08:28 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M42b8-1jBI8w3bhQ-0000JJ for <linux-kernel@vger.kernel.org>; Mon, 09 Mar
 2020 14:08:27 +0100
Received: by mail-qv1-f46.google.com with SMTP id r15so4300710qve.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:08:26 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1bn4muvpBdN/Lc2/GNDVjjMRgaailQZ7QzC6/6c9CgkrQDpm0i
        msZBeBzPcxgpf30v4/klqOKhrcP6uhPRNR9muZw=
X-Google-Smtp-Source: ADFU+vsZVVxYtB5oOB/iT8z19DtQWfGLEvcD/gO3C+R7aL9FH0z4WwozrZopkY4ufFbIIUjV9ApWazHzYlIPZftXiDA=
X-Received: by 2002:a0c:ba29:: with SMTP id w41mr5046678qvf.210.1583759305767;
 Mon, 09 Mar 2020 06:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200309021747.626-1-zhenzhong.duan@gmail.com> <20200309021747.626-2-zhenzhong.duan@gmail.com>
In-Reply-To: <20200309021747.626-2-zhenzhong.duan@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Mar 2020 14:08:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2jy3+7tPFPjN5pfrQdfkhReCdPFjAnw144pXzpHCGDdQ@mail.gmail.com>
Message-ID: <CAK8P3a2jy3+7tPFPjN5pfrQdfkhReCdPFjAnw144pXzpHCGDdQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] misc: cleanup minor number definitions in c file
 into miscdevice.h
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan@buzzard.org.uk,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Miller <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tv/wz6BNk560l8t603+lUotwIMsT34r6XJrY7MyqxmaJFpeM9As
 gEoMKaGohGws54wwYynU0I8gbleHbkW8Fv9/wn9S0+I2we7Ck+fAhoz9Yi9/dSQfz9U4gdu
 R0FcnIS8Ga1NpMtB8krXZCDzxYv5bEbiZI8QlDsBEJr3frV9dm99eQn38g+JPN1lz9ytPSE
 2hJ+W91LnNO9gHNYjlUxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tanUV2AwG54=:nfI0LZioL47jingywni/EM
 iUZ4+6M1QhnY0xuDwTo7a8hh6duJ+t0xlJp5QrZzJmIeCqhBvDBcsyAP1IfyDsei4hvg/XbPg
 puTyKRKcE2aa0392PSM95SdG9Jxri/AfmJD+2IKjb6l4TUEFlrJLc9fcwE9NKahYR0InRpK8O
 put+8cj6JE9j17oIDGGNAkSCUJgcBBQz6Zo6B0Eu4CIzSq80QOEtiRGItyRwJtBidv8KJe4xG
 RwN1n4oyhq1fX1vNNCO6J5MbYsBgD+fhqdbZ9e/J1BHI7KEwViM1Cfs5VkmFkDIXz+pRlZ/s9
 TNAQokenQSN/vS/dvSzBZ1zZluzLw9nODtesB/rHlfOlHi+htOPKHN2z4J11X27CqAihSvqGH
 KbQXDxuY8+2sc5NoMQ3ZIQqoeOD6sZr0F5rn6zNXLaTZvCITpVQel6f9bf9J0rI6R0TvRyWBu
 jJHKGzb2iYs5ntnqJp74ZJGMxb1//9dxLXlhoYIGSTEo3tImO5HxR1MGTjKoaaqXsB/mxUXWW
 wawK4MwZOt+MxmaXLuU/fc3HD4aBGKUm4QW/pWjpjeXDKccwMR/o/VqBei+AplEXYw1XLmcAo
 FOVPbLURWQrOGZX3zEn697wCtVYnSvLL+lwnaKeb9WqP5GnILzGbFmqFJ0RVcilp6Xhp4cgn7
 JkEa09BTkemYGuGkpkfqRvY0+whO6E5GKdMVGUpNXuxbG96iOt+tx/hkXUlHglhdwLuDHXBJ5
 AuMId9Ao9ENlPvJjI4h55wOj8kWnqn93LoRaaRUqsZABbH/fGD/nMuMcn8MHC0Rw1ggaDq9bZ
 rF3lzpKIXl0fw8insEP83cd4CFdbN5mGZMPj7mG1oHkacUSeX4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 3:18 AM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
>
> HWRNG_MINOR and RNG_MISCDEV_MINOR are duplicate definitions, use
> unified RNG_MINOR instead and moved into miscdevice.h
>
> ANSLCD_MINOR and LCD_MINOR are duplicate definitions, use unified
> LCD_MINOR instead and moved into miscdevice.h
>
> MISCDEV_MINOR is renamed to PXA3XXX_GCU_MINOR and moved into
> miscdevice.h

This should be PXA3XX_GCU_MINOR (with 2 X, not 3).

With that (and the other comments) addressed

Acked-by: Arnd Bergmann <arnd@arndb.de>
