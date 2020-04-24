Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF2AC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6776320767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C703FsBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgDXIni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgDXIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:43:38 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACADCC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:43:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w145so7033437lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KahPbvSltMlEDsEeg/YpqC1aWuwrm7i/vom/fz3t8MI=;
        b=C703FsBfCivIr01X565R4eJgDHh8uASs3zFuWvMLo/hE3YFmCWq+LAQ0DAzJ90H2qi
         hfnk5TMBcpnzYH5PJM+tdQ7Cre0RrzZpIsy/mrvpDCpQModeebB6J57Ah5SZJ5EJwn+/
         cSU/BT7koyaVe37mc5yxU0gYsKjoUAguafi01CF8BYn08Q61u/VZo0da49x10gtimv/L
         1bEkra85Rjt2fXE0LhqxFNq8bZHMcbIBqt64wi7hNbYzCIyRyzsTVXE0drtl9jtGbVTj
         Ujo28NPeTShbEJAAtoYNVHMjV4t8HPgRI4Q4//1qJh48V3RgnmXJgzvqbhEM6WBL2v11
         qV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KahPbvSltMlEDsEeg/YpqC1aWuwrm7i/vom/fz3t8MI=;
        b=hAW9Exr8LTj3e+lZ3lAXYUChX42PnMYYSu3cDs4ZeLcfSPz/UYEFAKvJwzaXjsZc6A
         MnQj88TSpcH10xMrMRbuuFdHNzgRYSSSjAirpW7oxDNc8N4V4pltyXX5NZY5B9X9essh
         N0TH4XGIXk5dMA7R86hlhUQ3o4q8dlISHDgfzmL/ca/lCRbjhI0kUGKlO5xukLg01seR
         igWpaz7zeav3Bvo8kC6Ea2PUT/pUpT3bf1Cz4LRt0MRP7vzgFM2VSi/u/V2yLpWaJWiT
         2n3tTFjaL8mqwAPGKNv4CfzbjcRYAUqjW3LkIinSHs0oAQ4cFBRVi5qp/ZzoazvHg/of
         83CA==
X-Gm-Message-State: AGi0PubidXBBKRMVJsv6R5W/kVpz75g7vSHtf2so0TfSrs670lI3YgYf
        aND8Zs5BAfQWsLEqhD0mUHHg+REhsJtS8gLz1uM=
X-Google-Smtp-Source: APiQypIFfHxSBQ292OjLSgV6e0RPypU6rNufaQLpxum7bV4atU8dJuyEW/rwmU2ysS0JW6NiM8Fy0CpmZYYRJ4X9r5w=
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr5537416lfo.19.1587717816207;
 Fri, 24 Apr 2020 01:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587088646.git.baolin.wang7@gmail.com> <96d444cd73239e0166316bd8f44082031cf72491.1587088646.git.baolin.wang7@gmail.com>
 <20200424081138.GP3612@dell> <CAK8P3a1e15P6xRUgYLYxT8XUx7FREbs5mMbfL1Qj+qwoDfFX+Q@mail.gmail.com>
 <20200424083255.GQ3612@dell> <CADBw62pisHz=ejgnhL=Y_qufCoZjPDLT90X2bztTZzMgbNMvmQ@mail.gmail.com>
In-Reply-To: <CADBw62pisHz=ejgnhL=Y_qufCoZjPDLT90X2bztTZzMgbNMvmQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 24 Apr 2020 16:43:24 +0800
Message-ID: <CADBw62o778f8HWgbbQMFXUQFw1AC0yV+AM8R6_g53HO0CujMaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: syscon: Support physical regmap bus
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 4:42 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Fri, Apr 24, 2020 at 4:32 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 24 Apr 2020, Arnd Bergmann wrote:
> >
> > > On Fri, Apr 24, 2020 at 10:11 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > On Fri, 17 Apr 2020, Baolin Wang wrote:
> > > > > @@ -106,14 +107,25 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> > > > >       syscon_config.val_bits = reg_io_width * 8;
> > > > >       syscon_config.max_register = resource_size(&res) - reg_io_width;
> > > > >
> > > > > -     regmap = regmap_init_mmio(NULL, base, &syscon_config);
> > > > > +      /*
> > > > > +       * The Spreadtrum syscon need register a real physical regmap bus
> > > > > +       * with new atomic bits updating operation instead of using
> > > > > +       * read-modify-write.
> > > > > +       */
> > > > > +     if (IS_ENABLED(CONFIG_ARCH_SPRD) &&
> > > > > +         of_device_is_compatible(np, "sprd,atomic-syscon") &&
> > > >
> > > > Please find a more generic way of supporting your use-case.  This is a
> > > > generic driver, and as such I am vehemently against adding any sort of
> > > > vendor specific code in here.
> > >
> > > I suggested doing it this way, as all alternatives seemed worse than this.
> >
> > If we're using a registration function (could probably be swapped out
> > for or accompanied by a Device Tree property) anyway, then why conduct
> > the vendor platform checks?
>
> Actually I've send out the v3 patch according to Arnd's suggestion. In
> v3 patch, I removed the registration function, but we agreed that
> adding the vendor specific support in the syscon driver seems a better
> way than others.

Sorry, I forgot the link:
https://lore.kernel.org/patchwork/patch/1228160/

-- 
Baolin Wang
