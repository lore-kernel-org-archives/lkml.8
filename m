Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C482C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5062420748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGQg/1fS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEUBIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgEUBIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:08:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C621BC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:08:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z18so6139132lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZ66C6YC6AB6BWsi5/n0Je4iQWMmi9GR4QVJ8dDpORA=;
        b=DGQg/1fSkhcfou1t+eGlXoSBIGSPP4X2yBvMqO8XYYfzhmdXJbxc1HqPK8sNTcj3yS
         fqtrojpPj3E7x/xcOMwbhkanZqE5LZuZy5FsJzWe1Ita+cpd14N7L92eITkYnR7A06WN
         Dq8Kkltan7iFT63Z51Qx3BI2MJNfv4v5lE3LXzq9rLrwZOnCsVBTtEsLASiKEW0CZzPr
         OAgj4e2nW35eOAAgWOfA1lIyi5Eu6ZnSbBYqroTlTuaHwqw6OXZppuOosnYA1MZ+yiI3
         5RxkecHPd/YDqxiDYIAlQI2v1NllUpO50ZtMNmxWZoRvgxXQrlzA79LUxQKpZG+NcJY6
         OvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZ66C6YC6AB6BWsi5/n0Je4iQWMmi9GR4QVJ8dDpORA=;
        b=uNSaeIPeIJeF3zRna6+aFQ9bpQansNdQRNqhhce/Kqv8w4wdN/We/Nu+hh0aFfujHR
         03izAOMk4EOypt+Z2N5pqQz7UoqNnH7dsT+g+wgFkInkYA7r34HzahqjQ8/CYcygsM7P
         uCQQekCOMeh9rlhJiH8v+l029O0sMUs7HW0NSHXkh4p/72tMYPdZ6g6BtWrgvBQ8bs7o
         5Ilh2cqMvQ1PFniE0/tVGD7lvBB2xPZ4/z4dInw/vr953SK4dqSVPg7/3UHr7dVTWVjp
         uwKjTXDKG6a5NosuFmRrSfenijhxNYPHwQ9zVa4wJ9XjkwYnxn+PmfzEDIFn2A7na5C2
         vt0Q==
X-Gm-Message-State: AOAM5323IB4hPc9fLK9Fg4WAu6z9EjczzYvJw1TDoj2YW5p5mIs1UT9I
        q/3XObGIdIA64S31l4YXal2UJQNDzSPnpoo1CoQ=
X-Google-Smtp-Source: ABdhPJw7LZwzxUoztHvAz1iYuQeTGCK5DItRAGSG4d9V0w4+4y0uQeNlQqEw2Kr6eo90HF4t0u42kXuqJ3lznf8odUg=
X-Received: by 2002:a2e:7610:: with SMTP id r16mr3871473ljc.88.1590023327675;
 Wed, 20 May 2020 18:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589623456.git.baolin.wang7@gmail.com> <db5adf754300bdc89d561ea3fb23afc4b6a3ee87.1589623456.git.baolin.wang7@gmail.com>
 <CAK8P3a38RVe0=i2pObgaOn+HP8cpdKefiac6DcyXuKnyH4xOyA@mail.gmail.com>
In-Reply-To: <CAK8P3a38RVe0=i2pObgaOn+HP8cpdKefiac6DcyXuKnyH4xOyA@mail.gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Thu, 21 May 2020 09:08:35 +0800
Message-ID: <CA+H2tpFyCoHHVRM1wcn7TKBwxkafg6ZAVWzrsP3wZRNH5kPR7A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mfd: syscon: Support physical regmap bus
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 9:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, May 16, 2020 at 12:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Some platforms such as Spreadtrum platform, define a special method to
> > update bits of the registers instead of reading and writing, which means
> > we should use a physical regmap bus to define the reg_update_bits()
> > operation instead of the MMIO regmap bus.
> >
> > Thus add a a __weak function  for the syscon driver to allow to register
> > a physical regmap bus to support this new requirement.
> >
> >  };
> >
> > +struct regmap * __weak syscon_regmap_init(struct device_node *np,
> > +                                         void __iomem *base,
> > +                                         struct regmap_config *syscon_config)
> > +{
> > +       return regmap_init_mmio(NULL, base, syscon_config);
> > +}
> > +
>
> Sorry, I don't think the __weak function is going to help here. I'm not
> sure whether it actually does what you want when both syscon and
> sprd_syscon are loadable modules (I would guess not), but it clearly
> won't work when syscon is built-in and sprd_syscon is a module, and
> even if the module loader knows how to resolve __weak symbols,


I happened to see module.c last week. It seems there's some code to handle
weak symbols by checking about STB_WEAK. But it is not in this case.
When syscon.c is built-in and sprd_syscon is module, this would not
work because the
__weak one has been built into kernel already. Maybe live patch
feature may work it out.
But it seems over expensive  to do things like this.

> I would not want to rely on module load ordering to make it behave
> the right way.

Agree. All other sprd modules would must be loaded behind sprd_syscon
and this will not be
handled by modprobe.

Thanks to pointing out this.

Best,
Orson

>
>       Arnd
