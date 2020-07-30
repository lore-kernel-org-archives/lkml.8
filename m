Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64FEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA82A206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgG3OJ2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:09:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgG3OJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:09:27 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MNfgZ-1kOzvB0q2F-00P9Oj for <linux-kernel@vger.kernel.org>; Thu, 30 Jul
 2020 16:09:26 +0200
Received: by mail-qt1-f176.google.com with SMTP id c12so11374418qtn.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:09:26 -0700 (PDT)
X-Gm-Message-State: AOAM532plOoj1RHSzksI5I7LItHRQkUfSnE0HRFaUKRHuFwep8knlCt/
        KcCPbl1PxSMJzvtr2t6RFW9s5a/6mOcKheoEvsk=
X-Google-Smtp-Source: ABdhPJyi9kI9tH2eVgfgqkCmMA+l204uFszK+oAlVJwFl1iWmPPCUPIZeVt8CBeEBpdFXQKzYRq+C/Bcofig8C3dcDg=
X-Received: by 2002:ac8:688e:: with SMTP id m14mr3126506qtq.7.1596118164881;
 Thu, 30 Jul 2020 07:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200725055649.GA1047853@kroah.com> <CAFmMkTE_dT9+WJYyb19uQ_HmgJWZSARBy6PveheQJk++NuGbkQ@mail.gmail.com>
 <20200726071723.GB441916@kroah.com> <CAFmMkTFzGfFDrJrdgHztzLK2K-zBWy6T2Tv+G4-rrbVpbahkgg@mail.gmail.com>
 <CAK8P3a1nA7K15Cxz84Q8Grw3tKfgkUmsfURcytJEWb_0Wjqm5w@mail.gmail.com>
 <CAFmMkTExBY3V_Ghej7Bzjatg+vFtWq3UZmKzjAiEoR9EqnFN9Q@mail.gmail.com>
 <CAFmMkTEO7VNKJeYz2uoHsS-yN_aY8UuiQ2GcCq9NyAD5481ZGA@mail.gmail.com>
 <20200730053108.GA3861609@kroah.com> <CAFmMkTHXjfG7zMr0i_h65PvjAe4opPgvzdABH8W1EUGOmcA4Zg@mail.gmail.com>
In-Reply-To: <CAFmMkTHXjfG7zMr0i_h65PvjAe4opPgvzdABH8W1EUGOmcA4Zg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Jul 2020 16:09:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2SN3pdXV8=0jXfrsz8L64yV46fEM4zrSXfA25QK0GNuA@mail.gmail.com>
Message-ID: <CAK8P3a2SN3pdXV8=0jXfrsz8L64yV46fEM4zrSXfA25QK0GNuA@mail.gmail.com>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci attempts
 to turn the SPI flash chip writeable
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:PaZdRPgyOTwoxdG5QIOY7aerP3XsVhhp5X0+6VM6UA7ZFmCzaCk
 YB09U/TzuHD0nCwWmohmroDO7KIUC1jSaiQ0mJm7oNxMsg6CtfvSSb7Nk874cAX5Eyl7S82
 HOnIyh3g4QMTTef3y8X+UzZZd8lTJGeBxL/fzPJfzhhY/jD9KeheTu8LF++0BUrwooVB116
 Pob7dfMIyW2XAUuIEdtlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mMUbIM3C6O4=:6eIgjwfPJutJOq76l6dOuN
 +lU7EAUFi/V6wHWvnAfqFE/ZA6qyGEValzD7OPsGv5grEBxCLwe41EKblkX7LMkj6Enbcm5WW
 mkOlsIIsE7CY74HtWS8U9li+i2qF9yeLxdiOPk2wcB9zemVayyRwZAFPKKhF7wYv81LBBEyEb
 ShCAl3lsCYQU8HR7RQNpoB1hOVkoC5lxYmDdSK6Qx5iLj20QMTUEnn61QXKIdGImIgCCqjXXH
 aNGO+a+lr3scGZuF3YOB8j/Kc+1umq/Mwwm6RfV3up5j27aycfa4fN9nuOxzKAK7WJEmezo1W
 Evdh9dHkTDgSiZTXbNhHaPL3Ue/jQzJ0ScNar44AgMUz7O1jYjYKbmPJoMJKzwWb+Bhm7zgIS
 BOh8Sv6j8LuuYm1OwCpDeXxPMzhxp8EJ5dnOop8S2MCSOyVV0l1MtI+OHVPKHsPmVLHcFTqyb
 pepJ4+4zaeSDLvo+BKezPeFYbNjXtu/i0elkEWtp7gAdPdULUh1GeqJc6czqqdA9mQcF5b7IA
 7otPioTr6ZFBJDAwv0NrQ4xWA/vxoDoXqJUcz01h9ALDbt/ElYNFJbREaXhTymqCStOIba0LP
 fp4lv5EphqrL/IF3NJZjmgCUDHhNQA/4he6PhEGgPokDN4rliJOdxdyzgTp8rLZnyZn2kkBHB
 tuyR9mPmxJDZI8pS4NT7+aeVDNQ/RrreTlrm8h2YPEZ6TXYSTgK0sa6wYTQQtPhR+H9fZrASI
 5pxsrexs6hIe+j3wWuBpHQS2s/pM3jIZ/91UN/ijH3kFeHeweIx1TciU9POROmVA+qlkE4XtZ
 gefK9f0wONY0Aw0Ib2tV35cv9dBassyil9/DKgYH6mWJ4sgoBM7lub4QLnXS2nf2u8bw3oQiT
 c7s3qldOYkIcWHm78v39klgAaFCnM7RqoZ0KWF0fbG/O8Hy9cw6h5G3v26OkBSW6P+FPeUn9c
 Hu1qEZlPFR3V+uECTTrQ7XnLCjmdyYbT+s1LINCH5YQpqqGWL7xSK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 2:21 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> El jue., 30 jul. 2020 2:31 a. m., Greg Kroah-Hartman <gregkh@linuxfoundation.org> escribió:
>>
>> Again, module parameters are working on a per-chunk-of-code basis, while
>> you want to work on a per-device basis,
>
>
> I think there is a misunderstanding.  What I want is to control (turn on or off) is a very specific code snippet that provides the "functionality" of trying to turn the chip writable. The rest of the device driver is fine.
> I assume that the one that doesn't understand is me.
>

I looked at the source code again and found that the existing module
parameter applies to both the platform and pci device front-ends, both
of which go through

        /* Prevent writes if not explicitly enabled */
        if (!ispi->writeable || !writeable)
                ispi->nor.mtd.flags &= ~MTD_WRITEABLE;

Setting the PCI device writable in hardware makes it possible to
actually write to it *only* if the module parameter is also set to '1'.
One might disagree with that design, but I don't think your patch
would make it any better, it just means one would have to set
two module parameters instead of one.

     Arnd
