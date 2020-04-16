Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E909C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379272076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpex2hAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391727AbgDPDt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391279AbgDPDtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:49:16 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C50BC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:49:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 198so4480211lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3JNvCdZgbFSQz7mQJpHJcPKtGpsAZ4Y0IkkDDj6gpg=;
        b=gpex2hAcHUsmi+tyoml6G6ol2ENqtPsx+9vpeeWViSzlwbBwaRSIfpFUZemDCMQHx/
         KRb0l/Cd8gLrVJtkNN3bHYXXc2tKPPZhvi6gOxZFtE8jNUB84EnR0wMICYHA7BpBo1Hj
         UIDbGTiKYcv9pYnz32RGJ1W3IO5V8+y4yhGPMQHEPV6QQsJ+R8XbE3zJzp+foDake7qK
         G9veh3xdQyU1mmVsIBOfMc/VYCOT45UulYFLYrBDytA28sab/fFQAksJ7UWGd4iSCxCi
         ABj4l3mBINjx02t/6FZ2eyIgphE7W472GOQW5PhsJDDMmI4f7Cn3bY7j/O74eRC/OxGT
         tZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3JNvCdZgbFSQz7mQJpHJcPKtGpsAZ4Y0IkkDDj6gpg=;
        b=O19Za2sxyExhn+dH933AvSH8Hj1ubLv4nOkks2Apa+LGSDA4nlWJZuRpVhhIRCANJA
         mhTdzCOk6EDBYt9yOgmHZ7MQoqSo3fp/yNLJLkNEyjeSbnYS5Rq7Z6ZBt/i0i+pSLE5r
         NZW4R+IWxa39Z5gdN75Gmx3AwDzgTr00pmAyg0R/98Z9HFXgKdRltGffwEtQg2hc+BOV
         DmorjhQT5S5GgPL1f7SXUtnuca7Axonq6ikKCVpd4hMHF/62ThCf2yDt0yEi05ueYkw1
         yjZ0DbDBaRhfszUG0BiH67x6yWpgnsAmb9ZulYlB4Uardok8iQCnNdH+MOaVlhh9CDTH
         vL0A==
X-Gm-Message-State: AGi0PuYlvxSn0alrFA/IkaMTFGhVfyOhl89px9YM2SqNTx0GiX2ajVui
        7e5L5B0B0UBC8nrWJ08rSTETeXd2lbVOfvpmGj0=
X-Google-Smtp-Source: APiQypJBOrPxHgHXHERVsr13f92KjCKk198TkiNUWnCwtUcvXdY8ubArZjXj/iPODNhiBSK4yfiTkbZThYg8PtfYV0o=
X-Received: by 2002:a05:6512:74:: with SMTP id i20mr4801706lfo.104.1587008954864;
 Wed, 15 Apr 2020 20:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586757922.git.baolin.wang7@gmail.com> <ca403b816af38eae68ca7399640c82d0345a2296.1586757922.git.baolin.wang7@gmail.com>
 <CAK8P3a06fed_WVmO84iod2VpY386_3J+V=A-M+W7yE57N04a8w@mail.gmail.com>
In-Reply-To: <CAK8P3a06fed_WVmO84iod2VpY386_3J+V=A-M+W7yE57N04a8w@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 16 Apr 2020 11:49:03 +0800
Message-ID: <CADBw62r06X6mMTx3eLY1iU5KLOK644d1vA49Kp9JXzUtm2CpCw@mail.gmail.com>
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

On Wed, Apr 15, 2020 at 11:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 13, 2020 at 8:14 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > The spreadtrum platform uses a special set/clear method to update
> > registers' bits, which can remove the race of updating the global
> > registers between the multiple subsystems. Thus we can register
> > a physical regmap bus into syscon core to support this.
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>
> I'd hope to avoid complicating the syscon driver further for this.
> Have you tried to use something other than syscon here to
> provide the regmap?

I did not figure out other better solutions, since we still want to
use the common syscon driver with related APIs and node properties.

Otherwise, I am afraid I should copy the common syscon driver into the
Spreadtrum SoC syscon driver with providing a new regmap bus, and
invent other similar APIs for users, but I think this is not good. We
still want to use the standard syscon APIs to keep consistent.

>
> > +#define SPRD_REG_SET_OFFSET    0x1000
> > +#define SPRD_REG_CLR_OFFSET    0x2000
> > +
> > +/*
> > + * The Spreadtrum platform defines a special set/clear method to update
> > + * registers' bits, which means it can write values to the register's SET
> > + * address (offset is 0x1000) to set bits, and write values to the register's
> > + * CLEAR address (offset is 0x2000) to clear bits.
> > + *
> > + * This set/clear method can help to remove the race of accessing the global
> > + * registers between the multiple subsystems instead of using hardware
> > + * spinlocks.
> > + */
> > +static int sprd_syscon_update_bits(void *context, unsigned int reg,
> > +                                  unsigned int mask, unsigned int val)
> > +{
> > +       void __iomem *base = context;
> > +       unsigned int set, clr;
> > +
> > +       set = val & mask;
> > +       clr = ~set & mask;
> > +
> > +       if (set)
> > +               writel(set, base + reg + SPRD_REG_SET_OFFSET);
> > +
> > +       if (clr)
> > +               writel(clr, base + reg + SPRD_REG_CLR_OFFSET);
> > +
> > +       return 0;
> > +}
>
> Regarding the implementation: Doesn't this introduce a new race
> between setting and clearing bits if you do both at the same time?
>
> This may not be a problem if you never do.

I think this is not a issue, we just make sure the set bits updating
and clear bits updating both are atomic operation, which is safe to
update bits, right?
If user want to protect a series of bits updating operation between
the multiple subsystems, ( such as including several bits setting and
bit clearing operations), you still need use hwlocks. But that's
another topic, which is not set/clr method can solve.

> > +static int sprd_syscon_init(void)
> > +{
> > +       syscon_register_phys_regmap_bus(&sprd_syscon_regmap);
> > +
> > +       return 0;
> > +}
> > +core_initcall_sync(sprd_syscon_init);
>
> I don't think this part can be done at all: If you load the module on a
> generic kernel running on a random other platform, it will break as
> there is no check at all to ensure the platform is compatible.
>
> The same thing happens on a platform that may have multiple
> syscon nodes, when not all of them use the same register layout.
>
> The only sane way that I can see would be to do it based on
> properties of the syscon node itself.

OK, so what about adding a new property for the syscon node? and we
can check if need to register a new physical regmap bus from the
syscon node.

if (of_property_read_bool(np, "physical-regmap-bus") && syscon_phy_regmap_bus)
        regmap = regmap_init(NULL, syscon_phy_regmap_bus, base, &syscon_config);
else
        regmap = regmap_init_mmio(NULL, base, &syscon_config);

-- 
Baolin Wang
