Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC2C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E219248A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rM5SW1yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgDFP0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:26:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34936 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgDFP0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:26:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id v2so15727478oto.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLkFZg4uKjsIykk7BTwvQ1u38EFobfLrFUiH9V7o1sk=;
        b=rM5SW1yckf32vIPkw90xBqCzGHKCy/iHgCoXE6hqaPFebS750iSbilzPRpBtU5Twz1
         b2EPRdimrtONwJqOGXXuG7cCPfzkuJI8GXEitZW1DZvfdhnT+acAbHbzVSl8DwHhX8eb
         SApEs/7LmbMvmXeBcvhGT+g+A9YosMhrHBoZRH4R+i6X4axPNRraO1HMVjVhgvOB0GKH
         WPncSG4ks6mq3alyrF7YtXCdmZfEJzBoLgaNXPzH6SWsiJwYvEENNhoU/8vX/V/x+0az
         qPVZh46IQouMAk0ky8JWRrmDASEJ5HZtxWIWRo/hnssv1o7eOH9jGhV+0d+i44iYN0/t
         8uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLkFZg4uKjsIykk7BTwvQ1u38EFobfLrFUiH9V7o1sk=;
        b=BnpTUqv4evclLQQ42cFsJDtMX185DTuHCQO75nxV8hxvoVLlyr07Bjsb6gf8Rf9Xry
         +sVvpoue3ia01EWeZ7G0rJFYnLV/XPpAm0RiDOQ9qWxIN9PHPnk5Zyb5LMYcFC5IfKVi
         x0GUZplcRBAiql8lowcYItYUYkz8Bg9aqxHkqDpZQUEyT+0A2o4XTqYeywbCzfLdTYrq
         EL2V93JJQM6Tl1tkl2IT316nTiofqmNhLvK//ywmthcT5sUphmliEu1YNT9/GA3JftfH
         sFfEJ5dE3T33INdEjB2VRi6M5s4VoUIhqS+PROupjcljEDicoIdQpF/YhjiPPML1v2Sa
         efCw==
X-Gm-Message-State: AGi0PuZuecsrULW+0adIRdIZ6wgroTeXBMdTweJsBZ8/3DI/LLDKrG+r
        RV7OIETpIJTMGd3jgfs7zVkn7kdwr0oC07sGKnNxBQM8xDCGjg==
X-Google-Smtp-Source: APiQypKLKKYLmPxZPCftzf+0SBlZXHZMIwDor9EtVAxYxuQ+W8VWcYMwc6GcICK2n6IQIOMhasirVAdBnijIMJ7TltU=
X-Received: by 2002:a4a:c595:: with SMTP id x21mr17831239oop.10.1586186770118;
 Mon, 06 Apr 2020 08:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133346.372517-1-robert.foss@linaro.org>
 <20200331133346.372517-3-robert.foss@linaro.org> <CAHp75VfFKY6nzb8aEWmop73v2haZ0P5+aTsKDEU8M=uUPn0u3g@mail.gmail.com>
 <CAG3jFyuH5Kad16R7Oit-c_7RasiEfPycOpA68JYLVopbyQ749w@mail.gmail.com> <20200406150626.GW3676135@smile.fi.intel.com>
In-Reply-To: <20200406150626.GW3676135@smile.fi.intel.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 6 Apr 2020 17:25:58 +0200
Message-ID: <CAG3jFyvRD3MTQHKVgnneNutJ_e-eykrZHNF-GBe1F5c1TjYLqg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] media: ov8856: Add devicetree support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 at 17:06, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 06, 2020 at 03:37:24PM +0200, Robert Foss wrote:
> > On Tue, 31 Mar 2020 at 16:01, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Mar 31, 2020 at 4:36 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> ...
>
> > > > +       if (ret < 0) {
> > >
> > > Do you need all ' < 0' parts all over the series?
> >
> > Some checks are needed due to ACPI and DT support co-existing.
> > Maybe it would be better to just split the probing into an ACPI path
> > and a DT path.
> >
> > I'll have a look through the series for redundant retval checks.
>
> Drop where it is redundant.
>
> ...
>
> > > > -       ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
> > > > -       if (ret)
> > > > -               return ret;
> > >
> > > Where is it gone? Why?
> >
> > It was replaced by a clk_get_rate call, which as Sakari pointed out,
> > isn't correct.
> > I'll rework the clock handling for v4.
>
> If it was in the driver it should stay -- properties is an ABI (between firmware and kernel).

Ack.

>
> > > > +       ov8856->xvclk = devm_clk_get_optional(dev, "xvclk");
> > > > +       if (IS_ERR(ov8856->xvclk)) {
> > >
> > > > +               dev_err(dev, "could not get xvclk clock (%ld)\n",
> > > > +                       PTR_ERR(ov8856->xvclk));
> > >
> > > Also you may use %pe here and in similar cases.
> >
> > Weirdly checkpatch complains about this.
> > But it builds and runs cleanly, so I'll add it in v4.
>
> %pe requires pointer, PTR_ERR converts pointer to integer.

Ack.

>
> ...
>
> > > > +       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ov8856_supply_names),
> > > > +                                     ov8856->supplies);
> > > > +       if (ret) {
> > >
> > > > +               dev_warn(dev, "failed to get regulators\n");
> > >
> > > If it's a warning, why we return from here?
> > > Same question to all other places with same issue.
> >
> > The issue I was seeing was the driver having to return a EDEFER here,
> > so this warning sheds some light on which exact component is returning
> > an EDEFER.
> >
> > [   15.962623] ov8856 16-0010: Dropping the link to regulator.29
> > [   15.968464] ov8856 16-0010: failed to get regulators
> > [   15.973493] ov8856 16-0010: failed to get HW configuration: -517
> > [   15.979591] ov8856 16-0010: removing from PM domain titan_top_gdsc
> > [   15.985855] ov8856 16-0010: genpd_remove_device()
> > [   15.990672] i2c 16-0010: Driver ov8856 requests probe deferral
> >
> > Personally I found it helpful to speed up debugging, but I'll happily
> > remove it if you prefer no warning.
>
> My point is that you have it in align:
>  - if it is an error, print as an error and bail out, otherwise
>  - if it is a warning, print it and continue.

I see what you're saying now, let's remove it then :)
I guess in the specific case of EDEFER, it doesn't fit neatly into
either of those categories, in the sense that the way you continue is
to return and then try to probe again later.

There are some other locations where this is handled wrong, I'll align
them properly for v4.

>
> > > > +               return ret;
> > > >         }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
