Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889EDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DB2221F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894569AbgDPMzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:55:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894377AbgDPMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:55:04 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MqK2d-1ivFKg0nSd-00nRFg for <linux-kernel@vger.kernel.org>; Thu, 16 Apr
 2020 14:55:01 +0200
Received: by mail-lj1-f169.google.com with SMTP id u6so6077799ljl.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:55:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuYoJbYh1+QdfJCPWxDTAhhqPNs93z4IaxRpe9WXRyonkHQK9ewN
        X6CkUoiXnPl0lYe/ipetl9dvHA30wodPvzEu+qE=
X-Google-Smtp-Source: APiQypIAIEVik5FsrgFmEvkjQhsTYhTh1nhITMoegpu8C+90ArmDd1XwwhW1JwxW5ljfYlKAIROZLp0BMRHis8jM//o=
X-Received: by 2002:a2e:b888:: with SMTP id r8mr6519458ljp.128.1587041700605;
 Thu, 16 Apr 2020 05:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586757922.git.baolin.wang7@gmail.com> <ca403b816af38eae68ca7399640c82d0345a2296.1586757922.git.baolin.wang7@gmail.com>
 <CAK8P3a06fed_WVmO84iod2VpY386_3J+V=A-M+W7yE57N04a8w@mail.gmail.com> <CADBw62r06X6mMTx3eLY1iU5KLOK644d1vA49Kp9JXzUtm2CpCw@mail.gmail.com>
In-Reply-To: <CADBw62r06X6mMTx3eLY1iU5KLOK644d1vA49Kp9JXzUtm2CpCw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Apr 2020 14:54:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3jnpRDjWwAOJa1EmbMzu+vKXmG3DBzhjHtVFz8NHfP8A@mail.gmail.com>
Message-ID: <CAK8P3a3jnpRDjWwAOJa1EmbMzu+vKXmG3DBzhjHtVFz8NHfP8A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] soc: sprd: Add Spreadtrum special bits
 updating support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:S1VtNc0DQCU/+cVc+TCwgsKYeCbevWEURuBZxK0Tlt+mt15qaJK
 OlW0YRgu2fpv8CW8HZNdBUYd+uBop5DXtFN7k0oViy4kC0KnLWqcgAIDNSFNfeSzRmivhyZ
 JLp8AnMb/6B6p6MFe5Ye1BvKsMcZ+8uXEQTwdGFOIZfGt1YpAQPnvdnykuNG5CnN9WA1u7a
 S41eDD+175zL1BMMp6V5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UMFHcJWeNR8=:JaI9i+eoUrTXfKTENVCInm
 msVbcGqfmgtx62y1+holZCui7i0rJUywhVO1LIkV5QIYSfmPc9kkeMmiVKRBKKIwSmvFDBTbL
 IcHw7f+cQYYIaxko1Sad/JkJ8kCsTZDOvm9KQ78W4nN3uqb0CemKEeLLsozD7BuLXIsibS0L2
 nycrdoePaGfxT8ZNIpG42dXSpoBsMGCmgp9spDCxS2sc1OASJqcW+buvntUtuWfZvoEno6mvT
 doBghwBmjBd6VfNhaOEqBra/Pbl0+30tuNf+RdNjYz4UQtxrqtV7K1r3ePt+Wswo1dTMHJljL
 X12RSSsKaMjao6fmsv8UV1hJ4xlsSCbDBr3G1ATD0Oc/qlhmYOtDEWumfCKD+iOhvj+OPkpXv
 5qBghSv0A+0lVWXwqsuCewuyvvDk6FM87aGPw9vNchJ6yET4wUNphDqmLx1FCpvSz2LO0I2vY
 6h9WXRdnxqKJRS5FEkfcR5ne4qtkE/SnNBucx8qTXVL5zCw3TOKCzjlXQ94ZreQm6v4FRz9yU
 7r22brBcwnEgM/qEj4O8nBFgnn6BWtuIzN9ouRYY16AeN6J5odtzPJQLPoW7u7kl6iXIPfWCd
 TPnE4vopJv+4MwTKvsQwgBIZpwHjroM2fINgC5P25nTJoMKmF/WYY20PWTHngK7v0WhX3AHtw
 RzKlg4jFeSZq63rEikytz5PYH1NnaQfJJfu1hlZC9bNr2nbTd6NSawVMyrclbnC031Sm3/bSA
 /btYP+mk2YoPYWs8fdmxQK7LVAsouO3oMdBYWKzx9SGNeLtV8vYrNBEt2BNBMtKCUwz/CRgM1
 KbzqlOTeIJ/jmqjgaowB5uURWeZ6xKYM3zjYeSbaxA/ZnhWnAk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 5:49 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Wed, Apr 15, 2020 at 11:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Apr 13, 2020 at 8:14 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > The spreadtrum platform uses a special set/clear method to update
> > > registers' bits, which can remove the race of updating the global
> > > registers between the multiple subsystems. Thus we can register
> > > a physical regmap bus into syscon core to support this.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> >
> > I'd hope to avoid complicating the syscon driver further for this.
> > Have you tried to use something other than syscon here to
> > provide the regmap?
>
> I did not figure out other better solutions, since we still want to
> use the common syscon driver with related APIs and node properties.
>
> Otherwise, I am afraid I should copy the common syscon driver into the
> Spreadtrum SoC syscon driver with providing a new regmap bus, and
> invent other similar APIs for users, but I think this is not good. We
> still want to use the standard syscon APIs to keep consistent.

Right, that is certainly a problem.

One option would be modifying the syscon driver itself, making it support
the spreadtrum specific update_bits function natively when a matching
syscon node is used and CONFIG_ARCH_SPRD is enabled.

We do support endianess properties and hwspinlocksin syscon, so adding
another variant of regmap there isn't too much of a stretch.

> > > +       void __iomem *base = context;
> > > +       unsigned int set, clr;
> > > +
> > > +       set = val & mask;
> > > +       clr = ~set & mask;
> > > +
> > > +       if (set)
> > > +               writel(set, base + reg + SPRD_REG_SET_OFFSET);
> > > +
> > > +       if (clr)
> > > +               writel(clr, base + reg + SPRD_REG_CLR_OFFSET);
> > > +
> > > +       return 0;
> > > +}
> >
> > Regarding the implementation: Doesn't this introduce a new race
> > between setting and clearing bits if you do both at the same time?
> >
> > This may not be a problem if you never do.
>
> I think this is not a issue, we just make sure the set bits updating
> and clear bits updating both are atomic operation, which is safe to
> update bits, right?
> If user want to protect a series of bits updating operation between
> the multiple subsystems, ( such as including several bits setting and
> bit clearing operations), you still need use hwlocks. But that's
> another topic, which is not set/clr method can solve.

One thing that breaks is setting a multi-bit field atomically. We have
other drivers doing for instance

static void cdce925_clk_set_pdiv(struct clk_cdce925_output *data, u16 pdiv)
{
        switch (data->index) {
        case 0:
                regmap_update_bits(data->chip->regmap,
                        CDCE925_REG_Y1SPIPDIVH,
                        0x03, (pdiv >> 8) & 0x03);
                regmap_write(data->chip->regmap, 0x03, pdiv & 0xFF);
                break;
        case 1:
                regmap_update_bits(data->chip->regmap, 0x16, 0x7F, pdiv);
                break;
        case 2:
                regmap_update_bits(data->chip->regmap, 0x17, 0x7F, pdiv);
                break;
        case 3:
                regmap_update_bits(data->chip->regmap, 0x26, 0x7F, pdiv);
                break;
...
}

This works with the read-modify-write method under a lock, but
it would risk setting a dangerous (i.e. crashing the system or
damaging the hardware) clock divider value if we first enable some
bits and then disable some others.

Hardware registers only have bits you set or clear independently
it is not a problem.

> > > +static int sprd_syscon_init(void)
> > > +{
> > > +       syscon_register_phys_regmap_bus(&sprd_syscon_regmap);
> > > +
> > > +       return 0;
> > > +}
> > > +core_initcall_sync(sprd_syscon_init);
> >
> > I don't think this part can be done at all: If you load the module on a
> > generic kernel running on a random other platform, it will break as
> > there is no check at all to ensure the platform is compatible.
> >
> > The same thing happens on a platform that may have multiple
> > syscon nodes, when not all of them use the same register layout.
> >
> > The only sane way that I can see would be to do it based on
> > properties of the syscon node itself.
>
> OK, so what about adding a new property for the syscon node? and we
> can check if need to register a new physical regmap bus from the
> syscon node.
>
> if (of_property_read_bool(np, "physical-regmap-bus") && syscon_phy_regmap_bus)
>         regmap = regmap_init(NULL, syscon_phy_regmap_bus, base, &syscon_config);
> else
>         regmap = regmap_init_mmio(NULL, base, &syscon_config);

The property also needs to encode which implementation is used,
either describing the way that spreadtrum does the bit set/clear,
or just naming it something with spreadtrum.

This could be either in the compatible string as a more specific
identifier, or it could be a separate property.

          Arnd
