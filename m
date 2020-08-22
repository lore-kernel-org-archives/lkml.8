Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E36C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7409120825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgHVQGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:06:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgHVQGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:06:25 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M4s8v-1kAtTe0jgd-0020EX for <linux-kernel@vger.kernel.org>; Sat, 22 Aug
 2020 18:06:21 +0200
Received: by mail-qt1-f182.google.com with SMTP id s16so3381695qtn.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:06:20 -0700 (PDT)
X-Gm-Message-State: AOAM530QRFTEqMiRdbIsstZiCL3bDmBBQ6uOFWsWHI7VZL9xML03OHku
        VJHtf3ik2cEn0c60TJ8oQF7OstU1zL9odF4oeLo=
X-Google-Smtp-Source: ABdhPJyT8gBR8BmSvwz3zbJQjyfrlaM4r+sD3eEJ8Qx0Q3v3p8Rs4wmxx+2+wI2GzZkYD/jeoJkbSpCTJl77bkV2YH8=
X-Received: by 2002:ac8:688e:: with SMTP id m14mr7377100qtq.7.1598112379995;
 Sat, 22 Aug 2020 09:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
 <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
 <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
 <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
 <20200819065721.GA1375436@lahna.fi.intel.com> <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
 <20200819091123.GE1375436@lahna.fi.intel.com>
In-Reply-To: <20200819091123.GE1375436@lahna.fi.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 22 Aug 2020 18:06:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a19MLfQARXEWzCD-ySq4t9nsyryB+con33HsQ193+muMw@mail.gmail.com>
Message-ID: <CAK8P3a19MLfQARXEWzCD-ySq4t9nsyryB+con33HsQ193+muMw@mail.gmail.com>
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
X-Provags-ID: V03:K1:LIAa7epBaUs52AM+l/YygUBk8GcVWlsOsOaIYeWox/KVZFZTkTg
 g+MOzOcjk/cdLKyXgNiy2zpHgVlP+P8fx7IA+6SC6GFgytPR1utNBxuxX/vsRB76tzZ0w1e
 cL8ZTJrmuquUFjpICMe1hduzwYJrKyR820oT2PjYnF3n6+1b29TaX/tL7BN6GNaE/zo61wo
 UZK+6bsed/kqcMQ9tAxJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NL2cuBKNHo0=:PTQ1vEVf/Pbpmo8S2czCL+
 7Lf63EOX2HnvNYmqO0joFwHwN6OCyCFNTaisxVfyKhkDU0SfJ1nscBtDKRAwbgQEtViQZlstK
 n0zvvuQxvJtkp4eUh/gmr3t/6wAkstatKP4gGjBLzG0c4O08u2z9/5tgoVzC2ycmaCsrIlTuF
 pV063Z1+bJRCQDX9GcWIcJ/h5XLKIgCyF8njpfKsDtZE7huxCxTezcNKWC1ghAJqE4RDgJeZN
 ILXaH2OWVUwHX5DhFaW+0VrhBrE8EjpLMRBSFkPDoaQzhruGZhoB46a1Jd8L59jV0vUmGG8Kz
 tXSZTgEYTG5SmUzDXO8SdnnvsdJ7URO4mJGrchkxqrVGOw9/OsrgqM9AB0KFctTSPnAozSKJm
 Bf7i5y4XHg3iiSUdQkQra/CEuWuJmYxXykJttHsg7ECKnApRNsJ/1RBxRktiBYBdUOw9pjr1+
 ARYuqKeHWyOuTkKAynZ9kAodWIuZMVqq6DX2J743bOgFuwWZVmXLVS8w4zhdMinsGj6PiJqOa
 Nof0we7rQasgMuLYvr92C/X7zC/2bzV30zhwA4IRiscNFKAJqgATRCHcIpEowugZ/Mv6vIdPA
 ddgvWMBsBoiNNS9fkIZBANfUVL5/Uxh4ZrRBVsA8lg8E/82PnYR1XIpl8C0Vtt0MAx0lqdaiZ
 V86Q/8OvQFuWkEzobVKm92sqEW3OX/v6K5y9cXljPMkmhC7p1q+7kvcbM8/8gv6BTGixsxOay
 hPhOymbSkBkbdlzqJvVwfkZyoDm1OMvoufgHKMTsVTLpN8UoSPJJD8TFNV9oSZfwufPXFGETO
 yroQOBSajpnARmeH7jYeC8FRyYLrfMp9T2dlBQguEzReFZLykTHR6PQg1t9MDu2NVwQC+JCyJ
 NHV2B0iUPXYiaotD5rDaYYz5Ib/2Ui7JYRgRfmK/3OJzbCRLP6iWGq8rtVKoDjOH8306IRO0G
 /jOEClElaXbRe9ODbI6jwTs35RlF8AZwfq/8EJeHftg9SGXgb3CoKtbgLQme57DWvkwA3mCE7
 vnpr7ctBoI7NA8/6SNN5Hj4xlWA1jHCwrxauylMkcwKy/B/moNFAhthYRkSvbdVq1ehDPcgDI
 lRFh+P6PwVEmFa92+uNuRvBcGlEdxx8H4eXZJJqPLUXyYPV/C+SJaqHbaTLi3fvOcONuypfzp
 tOWVusBvGoox6SMgxR1mpnY4/BVR+4KdR15xTYcNx4omFIEb4/rPNywHCBqPCDHOpsWvaKgBH
 6/Agbb2w7MUIwecdb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:11 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Aug 19, 2020 at 10:38:24AM +0200, Arnd Bergmann wrote:
> > On Wed, Aug 19, 2020 at 8:57 AM Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
>
> > > Actually thinking about this bit more, to make PCI and the platform
> > > parts consistent we can make the "writeable" control this for the PCI
> > > part as well. So what if we add a callback to struct intel_spi_boardinfo
> > > that the PCI driver populates and then the "core" driver uses to enable
> > > writing when "writeable" is set to 1.
> >
> > If you are really worried about the write protection being bypassed by
> > a different driver or code injection, the best way would seem to be to
> > only enable writing in the mtd write callback and disable it immediately
> > after the write is complete. I still don't see why this hardware would
> > be more susceptible to this kind of attack than other drivers though,
> > as it already has the safeguard against writing through the MTD layer
> > without the module parameter.
>
> Hmm, is there already a mechanism at the MTD level to prevent writes? If
> that's the case then sure we can use that instead.

The mtd core just checks both the permissions on the device node (which
default to 0600 without any special udev rules) and the MTD_WRITEABLE
on the underlying device that is controlled by the module parameter
in case of intel-spi{,-platform,-pci}.c.

     Arnd
