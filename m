Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437BFC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD9021D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5CGUP+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439521AbgDPPQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392194AbgDPNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:49:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E25C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:49:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so1393855ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UE8qp+81osGQ/vh3/Y+rhgiTl0PGyWDCyZHRpE1JJoQ=;
        b=s5CGUP+pRQEiXUJUB4FTGzRDtgvpsZeNaZp/+uyyvFoJbkZrdcURrZIvWrk6CGFfp+
         m6MQ83hGGS69jB4+kzlsWvaf6PXdOYkNKr5qmus02HQjC8BV1/GoIFZ67P1nJzXiuEAK
         qyy9n+eUiWZh+1DJg5n/5wwb8M6zE1Id3XQWNVdG9jwxcn7sNAc3c2NFNWuKyRM8fqIN
         flWdPfT9C1rK7XW+gg+qFC4G7ZH8JsY7xBX28zs4JnnRPOAcy1KBOGUu9ZazrM9rxdHM
         eD8c8EMlT8/iPaC9kQnilPnrL89V+eo9FRpyNTr7PiZFBGtEG8aji45SDSkGn8Y7+sHZ
         WRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UE8qp+81osGQ/vh3/Y+rhgiTl0PGyWDCyZHRpE1JJoQ=;
        b=lcjaxzPQ0CFrd/ce5Ev/DYnG7ddDjml3Xk/rgGumV7/T00IqWJO8jPE/Xs4Lxo8lFQ
         nju7vCYEGWvCsA8P80fGwXE2HUUtSpwDNBMYD+LtX+0w9ci3hUdSMkXysOrVH3+bZJBF
         Hl4giHFQ8WvOxA0qq/4Ul4A9uA5M0twB4upKa3itq/N75c5u+EsJiMvegjnnmyrparpk
         xYuXVJlcoxiIkW5ZGFy+0Ycu/FLvdFCumcusbFackFrTtIcA2zA4DPKxG/liOkJzH/fE
         u6zMsiRMIK8arVf4HjDgPE8MW/gSV0D1fGfdB1I+EyYsXHrsoTn9WymOK8o7GhB20UVO
         lzUg==
X-Gm-Message-State: AGi0PuZ51XRhSiIELkwXhL84d/aIVMFpWFe1az1hqHOG3FSzd1AJbpCq
        mi42cO9D46BoY7FjtXNOpJEa4mCMYDgh/BgBJQc=
X-Google-Smtp-Source: APiQypJYcnRghK2+jf2kZRFLrgp66LuhSXu6/lhhbiEuxQWvP6cAEOhERshN1dyUiP6C+mv8cquTG8L//tCPzalHvhw=
X-Received: by 2002:a2e:5746:: with SMTP id r6mr6352117ljd.15.1587044953181;
 Thu, 16 Apr 2020 06:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586757922.git.baolin.wang7@gmail.com> <ca403b816af38eae68ca7399640c82d0345a2296.1586757922.git.baolin.wang7@gmail.com>
 <CAK8P3a06fed_WVmO84iod2VpY386_3J+V=A-M+W7yE57N04a8w@mail.gmail.com>
 <CADBw62r06X6mMTx3eLY1iU5KLOK644d1vA49Kp9JXzUtm2CpCw@mail.gmail.com> <CAK8P3a3jnpRDjWwAOJa1EmbMzu+vKXmG3DBzhjHtVFz8NHfP8A@mail.gmail.com>
In-Reply-To: <CAK8P3a3jnpRDjWwAOJa1EmbMzu+vKXmG3DBzhjHtVFz8NHfP8A@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 16 Apr 2020 21:49:01 +0800
Message-ID: <CADBw62oNApMo_rCz1W6_tG8Z72ENjrAtHkWZ1Z4NsN0qWFctXg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] soc: sprd: Add Spreadtrum special bits
 updating support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 8:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 16, 2020 at 5:49 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > On Wed, Apr 15, 2020 at 11:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Mon, Apr 13, 2020 at 8:14 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > The spreadtrum platform uses a special set/clear method to update
> > > > registers' bits, which can remove the race of updating the global
> > > > registers between the multiple subsystems. Thus we can register
> > > > a physical regmap bus into syscon core to support this.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > >
> > > I'd hope to avoid complicating the syscon driver further for this.
> > > Have you tried to use something other than syscon here to
> > > provide the regmap?
> >
> > I did not figure out other better solutions, since we still want to
> > use the common syscon driver with related APIs and node properties.
> >
> > Otherwise, I am afraid I should copy the common syscon driver into the
> > Spreadtrum SoC syscon driver with providing a new regmap bus, and
> > invent other similar APIs for users, but I think this is not good. We
> > still want to use the standard syscon APIs to keep consistent.
>
> Right, that is certainly a problem.
>
> One option would be modifying the syscon driver itself, making it support
> the spreadtrum specific update_bits function natively when a matching
> syscon node is used and CONFIG_ARCH_SPRD is enabled.
>
> We do support endianess properties and hwspinlocksin syscon, so adding
> another variant of regmap there isn't too much of a stretch.

I still prefer to use the compatible string as you suggested in this mail.

>
> > > > +       void __iomem *base = context;
> > > > +       unsigned int set, clr;
> > > > +
> > > > +       set = val & mask;
> > > > +       clr = ~set & mask;
> > > > +
> > > > +       if (set)
> > > > +               writel(set, base + reg + SPRD_REG_SET_OFFSET);
> > > > +
> > > > +       if (clr)
> > > > +               writel(clr, base + reg + SPRD_REG_CLR_OFFSET);
> > > > +
> > > > +       return 0;
> > > > +}
> > >
> > > Regarding the implementation: Doesn't this introduce a new race
> > > between setting and clearing bits if you do both at the same time?
> > >
> > > This may not be a problem if you never do.
> >
> > I think this is not a issue, we just make sure the set bits updating
> > and clear bits updating both are atomic operation, which is safe to
> > update bits, right?
> > If user want to protect a series of bits updating operation between
> > the multiple subsystems, ( such as including several bits setting and
> > bit clearing operations), you still need use hwlocks. But that's
> > another topic, which is not set/clr method can solve.
>
> One thing that breaks is setting a multi-bit field atomically. We have
> other drivers doing for instance
>
> static void cdce925_clk_set_pdiv(struct clk_cdce925_output *data, u16 pdiv)
> {
>         switch (data->index) {
>         case 0:
>                 regmap_update_bits(data->chip->regmap,
>                         CDCE925_REG_Y1SPIPDIVH,
>                         0x03, (pdiv >> 8) & 0x03);
>                 regmap_write(data->chip->regmap, 0x03, pdiv & 0xFF);
>                 break;
>         case 1:
>                 regmap_update_bits(data->chip->regmap, 0x16, 0x7F, pdiv);
>                 break;
>         case 2:
>                 regmap_update_bits(data->chip->regmap, 0x17, 0x7F, pdiv);
>                 break;
>         case 3:
>                 regmap_update_bits(data->chip->regmap, 0x26, 0x7F, pdiv);
>                 break;
> ...
> }
>
> This works with the read-modify-write method under a lock, but
> it would risk setting a dangerous (i.e. crashing the system or
> damaging the hardware) clock divider value if we first enable some
> bits and then disable some others.

Ah, I undersood your concern, yes, this is a potential risk. But we
have not met this issue with using set/clr method on our platform
until now.
I can add some comments in this file to describe this potential risk.
Thanks for pointing this out.

>
> Hardware registers only have bits you set or clear independently
> it is not a problem.
>
> > > > +static int sprd_syscon_init(void)
> > > > +{
> > > > +       syscon_register_phys_regmap_bus(&sprd_syscon_regmap);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +core_initcall_sync(sprd_syscon_init);
> > >
> > > I don't think this part can be done at all: If you load the module on a
> > > generic kernel running on a random other platform, it will break as
> > > there is no check at all to ensure the platform is compatible.
> > >
> > > The same thing happens on a platform that may have multiple
> > > syscon nodes, when not all of them use the same register layout.
> > >
> > > The only sane way that I can see would be to do it based on
> > > properties of the syscon node itself.
> >
> > OK, so what about adding a new property for the syscon node? and we
> > can check if need to register a new physical regmap bus from the
> > syscon node.
> >
> > if (of_property_read_bool(np, "physical-regmap-bus") && syscon_phy_regmap_bus)
> >         regmap = regmap_init(NULL, syscon_phy_regmap_bus, base, &syscon_config);
> > else
> >         regmap = regmap_init_mmio(NULL, base, &syscon_config);
>
> The property also needs to encode which implementation is used,
> either describing the way that spreadtrum does the bit set/clear,
> or just naming it something with spreadtrum.
>
> This could be either in the compatible string as a more specific
> identifier, or it could be a separate property.

OK, I think adding a Spreadtrum compatible string will be an easy and
clear way, so what about below sample code?

DT:
ap_ahb_regs: syscon@20210000 {
         compatible = "sprd,sc9860-syscon", "syscon";
         reg = <0 0x20210000 0 0x10000>;
};

/* The Spreadtrum syscon need register a real physical regmap bus with
new bits updating method. */
if (of_device_is_compatible(np, "sprd,sc9860-syscon") && syscon_phy_regmap_bus)
       regmap = regmap_init(NULL, syscon_phy_regmap_bus, base, &syscon_config);
else
       regmap = regmap_init_mmio(NULL, base, &syscon_config);

-- 
Baolin Wang
