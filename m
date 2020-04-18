Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16FAC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA44221BE5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgDRTL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 15:11:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgDRTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:11:25 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MplLZ-1itsZi2HEb-00qEKQ for <linux-kernel@vger.kernel.org>; Sat, 18 Apr
 2020 21:11:23 +0200
Received: by mail-qt1-f176.google.com with SMTP id o10so5088085qtr.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 12:11:23 -0700 (PDT)
X-Gm-Message-State: AGi0Puatjr8ln1TD9BRyVfAaGoQzkASAwdA5xUhgHDazJl9E2N0VWnQm
        PxWS/FX5AIeYSuoo1PWtlnlYCLwoIMD/VvWoHTs=
X-Google-Smtp-Source: APiQypI5XWv+0v5CUPd6xcl5C/iLVZmU2I5uN+IAnHyrQzOErNeb/Vq46nsA5qUEtPCx2jH3AALWiUq8REeGQkl/9Vg=
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr2801144qtv.142.1587237082474;
 Sat, 18 Apr 2020 12:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200418162157.50428-1-wenhu.wang@vivo.com> <20200418162157.50428-5-wenhu.wang@vivo.com>
In-Reply-To: <20200418162157.50428-5-wenhu.wang@vivo.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 18 Apr 2020 21:11:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0-7mLhGb=LCAQSTL4kNoGVcBcQOca=-tJkZAj1w2Bxsg@mail.gmail.com>
Message-ID: <CAK8P3a0-7mLhGb=LCAQSTL4kNoGVcBcQOca=-tJkZAj1w2Bxsg@mail.gmail.com>
Subject: Re: [PATCH v6,4/4] drivers: misc: new driver sram_uapi for user level
 SRAM access
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        christophe leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kernel@vivo.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uiior6wTE+Nc8Xy6ROxk5d7Gl0fCXFymWBmYxRzqnaUV9iQsD3Y
 1SNbytK61CCgDvybTOJ+RZdkYAjRw60QdHDRRZvOpS+NDEVQDSz4MQDb+BfMqSHq4VZdM/4
 hQmrNOHlxN8vpCby0U8eJl6d8kW1cObz7iEyucSpWEAW2rBULnnELShjwsXUHPCqlS4W81E
 6bKnPc4zuTILv8NOwa8Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8pk3xkfJstQ=:AcY0KjOCY5BaKbtAFiyUnB
 GM40StUKPeB2olAHL+qSPDTHAKFRb+lJxHbZ8vNicgZmNeeqHLNEn34Edll9w6bAtGgbBcerF
 B682lDgKZWfwqvmyY0Jr0UdLVeiinJN5t+aSkuUm1UGQ91Q1nebJ7SrfWDGhVjDE8hCbv+qrK
 27vPg0k2S4kHfIb0lEcum7JunZEh8Fi4Ze7POQHAHwwsfrIUsZ6Yynv45Lyrm05dwbS2eYs2x
 JOYok9uBeazSVeEd0Ucpk2+OQF8RQRHFtkv/Zh0DWMNQW3xml8CeBpOniWWJOnuBsXU9wj/hG
 kotOO7kYUE5Xh7OqBr4IgXX5fk8IiSK3tUDbmgExyVQ1KxHs0teQ12zAC/B+6l8bFjiLGQZqh
 gOar9Txv6tlVD25lHdwyuVgI4clnCr0BQMYCsglqi6KE3T0WHk/l0YhZGkSVQDcS6CcKtqBm6
 kAK9dq7TP+gb6UIooZM5QhUvMgM9hwoYAOT4qr6V4fygijAge2lVigsDitF4+hW5voVF+yybR
 GlDW4qvJo7jclj20QR3M9HMK1FT0vhlqMWbjU5NruT70ssYW+jcBNiCZ+zq9SEvOZqPG4H1nk
 ATxgYwqLCp21Gjq/4YYkxmb4rK8glNv8qbfjiR2w6TY9Der4WuBdUZePGLExrdktHGggtdylh
 WOa2kHZsobCPWv3RmC2hIEF5pSWTa191uM14fq+6bwSPxvhAUoWNjTwkDuTajFYvmc/OcZHCH
 bdf3cQgqWMfJLOIiL0B84nrvl98bn5DwuVhMqbL6KM5qKl7jbtAfDcc0E2VUGf4YT4nXGO1mS
 OcBfBm72A7A1N4koY7TGcDmWvN6pW00XXsdqwatxveYJQUUlgk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 6:22 PM Wang Wenhu <wenhu.wang@vivo.com> wrote:
> +#define DRIVER_NAME    "sram_uapi"
> +
> +#define SRAM_UAPI_IOCTL_SET_SRAM_TYPE  0
> +#define SRAM_UAPI_IOCTL_ALLOC          1
> +#define SRAM_UAPI_IOCTL_FREE           2
> +
> +struct res_info {
> +       u32 offset;
> +       u32 size;
> +};

This is of course not a proper ioctl interface at all, please see
Documentation/driver-api/ioctl.rst for how to define the numbers
in a uapi header file.

The offset/size arguments should probably be 64 bit wide.

       Arnd
