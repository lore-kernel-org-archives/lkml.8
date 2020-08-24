Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A59C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C26206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgHXJJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:09:32 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50465 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgHXJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:08:53 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mnqfc-1ky6PI3bY2-00pNFx for <linux-kernel@vger.kernel.org>; Mon, 24 Aug
 2020 11:08:51 +0200
Received: by mail-qv1-f50.google.com with SMTP id o2so3390408qvk.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:08:50 -0700 (PDT)
X-Gm-Message-State: AOAM5316+0USBK8FHkP6DQFFYUgnqagO0YO7dB7EUWwMMxEA6V+QajnY
        DrgFgecUBabpIENew/SYI4NVPUb56tWegl9AR+U=
X-Google-Smtp-Source: ABdhPJwZX+cjJ6iQYsZP8QaU/HljAAPbR5R+V1AQGPTEA6x/4DhuNUmNMX30QFbj29m2jqEE9gD2C7ba4jC+Fn0bWIM=
X-Received: by 2002:ad4:450e:: with SMTP id k14mr3691202qvu.211.1598260129733;
 Mon, 24 Aug 2020 02:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
 <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
 <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
 <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
 <20200819065721.GA1375436@lahna.fi.intel.com> <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
 <20200819091123.GE1375436@lahna.fi.intel.com> <CAK8P3a19MLfQARXEWzCD-ySq4t9nsyryB+con33HsQ193+muMw@mail.gmail.com>
 <20200824082227.GU1375436@lahna.fi.intel.com>
In-Reply-To: <20200824082227.GU1375436@lahna.fi.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Aug 2020 11:08:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0==cZDHwZfqvCuvUg9jfjBOBG+AAomE9eqJ2xm-xNLvQ@mail.gmail.com>
Message-ID: <CAK8P3a0==cZDHwZfqvCuvUg9jfjBOBG+AAomE9eqJ2xm-xNLvQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:a08d9XdYqwQJRaN+BHtXnXhAQiHpBrlRf5hS48bbIwqQeXMGIkd
 jkqUFmYvcBIOYryduDgqbs4fsWfTlP+YRHfOpKkYcmjAtTrbVqeRnfxOjPrLSTJ9nSgmznb
 KuP4/Er5BiimTn6D22E0agGi3O93jtzKAbenOor0qWQ/J0UOqFFP7HFl3nJOMR/uQw77K9L
 0BJNBvgkIxWDzId4niX2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:71mz89eH4Iw=:m7/EElm538pE15lbdd2HF1
 89X46zuvzeXXAv+oc932+rq6EQRPbE/3DrJTvdhmy6EJ0/eUAgZ7jfBXhnh71JsJ8dtJEZKn+
 nNxuc+fyfc0kL2B/3L4ZY2NGNt4r/mW3yus4lThnumiSlxNJPKhltwxhMcNEhFzVHQ/pDaN5L
 nKN8oPPPhudH/b8OzvlQtDr/j2ZJPSATHj5hvoWout2xH/vRZw9yi0INSrJ5n4dxy5WTYuzc6
 akGC97vWB/MxFhw7TJyKarSJ6q9VeJJynFoJCELd2tlILBkTdPXZwKF9faWrj49BZ9scCwn5h
 ntP1nrVUW9oCI10KyMx14iz5JizFThVitOeWy7PvYIG8l60xPpkNQWveOfoYMe8ouKYX6G92h
 iRV1BtNk0cgwqtAfVHWKSaIaIYCPDjWG1dlGd2ot6ar5vU/aY/tck0FxNuIWQv8EpgWIt6ouQ
 1cJ6/dAnLEeYWmX+cIQGeToL/MzPJLImYBIMFCYBj88sTPGJL1xe9QktP+cFXHIYzjNfyKKTE
 kr1DQnOWos1oS1HomhBlvmqAZFWJC4cxsgTn+qHeHDWSnKINiwALjvyejGFRtkJCeC84QWcgG
 VWOq9dShOcfKc9HmqZiZNUOTfiPWTHr0gs1UFR7M8Zvvv3iIF3G+XzLiFfNrPbhFj21eT2jjt
 x/gccGUwWcE2yF7b669c6IFmSbwkBUf92YEH5pBUk0qglIILSvqxM8k5H7DfumGO61gQGuBbQ
 T7m46Ps5KA6uW1lJfuEai22BQQcfvSvjzHaQVtSz2HXMVkXjrlaiSt06LJFPPAeSumJob23eo
 YE7xhfFzJsjlsVM/YIH32IgyN0k7mVrxUtgEZavLoE1LQ6utKN4cu6Fhke4DtE+Un8z6zmm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:22 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Sat, Aug 22, 2020 at 06:06:03PM +0200, Arnd Bergmann wrote:
> > On Wed, Aug 19, 2020 at 11:11 AM Mika Westerberg
> >
> > The mtd core just checks both the permissions on the device node (which
> > default to 0600 without any special udev rules) and the MTD_WRITEABLE
> > on the underlying device that is controlled by the module parameter
> > in case of intel-spi{,-platform,-pci}.c.
>
> OK, thanks.
>
> Since we cannot really get rid of the module parameter (AFAIK there are
> users for it), I still think we should just make the "writeable" to
> apply to the PCI part as well. That should at least make it consistent,
> and it also solves Daniel's case.

Can you explain Daniel's case then? I still don't understand what he
actually wants.

As I keep repeating, the module parameter *does* apply to the pci
driver front-end since it determines whether the driver will disallow
writes to the mtd device without it. The only difference is that the pci
driver will attempt to set the hardware bit without checking the
module parameter first, while the platform driver does not. If the
module parameter is not set however, the state of the hardware
bit is never checked again.

    Arnd
