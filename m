Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBADC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058B220772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHSIis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:38:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgHSIip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:38:45 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MkpjD-1kW4ar3Nh1-00mHXE for <linux-kernel@vger.kernel.org>; Wed, 19 Aug
 2020 10:38:43 +0200
Received: by mail-qk1-f182.google.com with SMTP id b14so20889695qkn.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:38:42 -0700 (PDT)
X-Gm-Message-State: AOAM53153a/0i3ZMVJeGkiAWy+D1MZ5cH3+a5dMR4ERXDU6MnIwhEtx9
        0CHCmejndt5Qgm+FpXKLqzOSaOtGYzFKBbhDKHw=
X-Google-Smtp-Source: ABdhPJwfWJY4YQv36la+/0MD+QHocBF/Le7H2+CMgwAczLK9eQqrKeWrsZvvuug6OVTaAgPSIwj0wUbFD1Lx3Gr0TQ8=
X-Received: by 2002:a37:385:: with SMTP id 127mr19827899qkd.3.1597826321598;
 Wed, 19 Aug 2020 01:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
 <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
 <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
 <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com> <20200819065721.GA1375436@lahna.fi.intel.com>
In-Reply-To: <20200819065721.GA1375436@lahna.fi.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 Aug 2020 10:38:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
Message-ID: <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:d/RMUGGZPOqRElAyt8dQeC0t9y/bg7WSUEyl/pr5mlSo8Eba34R
 wMd6HZj1+Lj8i9RmkHB2T63NDmgT4U4su2V371yu67/HTkqVDZ7bp0nypE+ZqFVlUEB2WqX
 o5CXVnChKSrACtFvrINcB2AwmcJ1KPRtYdRddFz43frTU70FnPZyTbh/pUEKF+cIdgfV6Or
 2QvvNTjhReWGx9Yo1CyGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LHrKRA0xCA8=:S1dlnecLfeTQqIGH2uh9Ko
 JYKO1kE0ULJz9SSvX+2GyIt9ovyH1EISCGFyos15Hk2/Rha7H4ZAylSBbhwisu4KvEPI1HW8E
 AOPEN8078f/gfCnPuKIIVOQrm7Ex5SxBSySeNzW+r7lvIf7eQPQnpqe8BoGVyrfiTjCvFi7Kx
 e88xcUe6DALPFxgLd8CR4V+gEF+XaiVcmKvNB5WlslY8SMNsy3KmDJ2vBpUtSRna3kzPCzZrX
 HMDIY+1Gw9vEaDNLbX3ZNCbMuT+yBzG89inkrQ6xT+VHbMKYPq8RUb4yxS5R/zXTUZCnpT3H4
 TO0un1yIPvjG2DFC90whJQTku88mqONfYStAFsd1wI32iYTK3RmVpbgr+JMG5C9iRbeMPhMsH
 7NlbXICdTib2lfYF0aWLW5h4ovBuX1GLLTEz5bb5A6RLYoqBAqD0KXnojY/cuN6k75yxfto77
 YXVgUr9K3Eit4Y8n3SpiSaUSAmfDctCNzDtr+/gu2vzGmc+3QmyhGi8K1Ui5k5/03zxXrOVFG
 jdfvtfAbhzJkhoNRyzIxRzEFTQGbV0J6qrlhn8N9I5bWpqzFjB6RuV8QPaHprRO7xgaq+283w
 sPWb4Qj73wt7reSLTzH0jY7I2n1YVK4AuQtHp+Y3dXCf+6OZ+zCvOL3Dr8oTVO0uOjHlB3aEg
 SYI0RMWT6n0J0iWrYcPZ1dPk1wfJItGgQiErK1fhUR1UDBKuMfelxd5hgMhtpuKJ/wXkl4fgk
 TGxBf9bKD290fseFlicXRugmqvhKFjAe3+U3SRYF2Vj1wRevzKVA5lVeboYVLIxITU7HQ/d5B
 nncuVdzVTxyTVVYCkMsCXIpk7JzwnNXwDROsr8X4Hpb/OD0rNV/A93H26k6HnEkT7SLmQRPjM
 pqXsktt5YIeLP0tx1wPB1nVyzGQbTtytn+mJ4NGJwaNo+TIsygOTZrGXkR/ZNbVdrjnrIXO6c
 toZXn2s1lRT90a13pHQrLrNWRyvmAjC2udfuwnUgh0sAJoG7tklYf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 8:57 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Aug 18, 2020 at 12:55:59PM -0300, Daniel Gutson wrote:
> > > If you care about other (malicious) code writing to the driver, please explain
> > > what the specific attack scenario is that you are worried about, and
> > > why you think
> > > this is not sufficient. What code would be able to write to the device
> > > if not the
> > > device driver itself?
> >
> > Maybe Mika can answer this better, but what I'm trying to do is to
> > limit the possibility of
> > damage, as explained in the Kconfig:
> > "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> > "Say N here unless you know what you are doing. Overwriting the
> >   SPI flash may render the system unbootable."
>
> Right, the PCI part of the driver unconditionally (and wrongly) tried to
> set the chip writeable.
>
> What this whole thing tries to protect is that the user does not
> accidentally write to the flash chip. It contains BIOS and other
> important firmware so touching it (if it is not locked in the BIOS side)
> may potentially brick the system. That's why we also require that
> command line parameter so the user who knows what he or she is doing can
> enable it for writing.

The same thing can happen with the platform driver if you load it
once with 'writeable=1' and then unload, leaving the chip in writeable
state. If you load it a second time without the module parameter, it
will be in the same state as the PCI driver: the hardware bit allows
writing, but the MTD layer prevents writes from being issued to the
device.

> Actually thinking about this bit more, to make PCI and the platform
> parts consistent we can make the "writeable" control this for the PCI
> part as well. So what if we add a callback to struct intel_spi_boardinfo
> that the PCI driver populates and then the "core" driver uses to enable
> writing when "writeable" is set to 1.

If you are really worried about the write protection being bypassed by
a different driver or code injection, the best way would seem to be to
only enable writing in the mtd write callback and disable it immediately
after the write is complete. I still don't see why this hardware would
be more susceptible to this kind of attack than other drivers though,
as it already has the safeguard against writing through the MTD layer
without the module parameter.

       Arnd
