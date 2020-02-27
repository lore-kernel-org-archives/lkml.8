Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A303C4BA3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0EC2467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFusVLMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgB0Jn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:43:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47094 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgB0Jn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:43:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so899864pll.13;
        Thu, 27 Feb 2020 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PS1fdE4OWrB2AkicxBBGpwBY93VCzMfCd/vvRM7GyAk=;
        b=oFusVLMiMD7bn94C3X0+16pfZ6f0JZxPmR7fxKb9j+awruyEQrahxlhOemwW+hQzIr
         opF3bnkw7xoPozKiBlNEwOFdekITaG45Rx5BgojGPVHXjHnv6d7yiftVeZtVKi9VTGOz
         TygRkhGDPoqYvNJBxY0nDEW/PAXOLBrEXUxwE+C/7LsgKFWdKrnhu+tY+e4tfZK6YXop
         InZNn/cwyytsTh3nBgaHCAhk/ExSp3seO6pJObGFhrv+LkesQgR0paxs8qMPfDRhZBMH
         z/dD3uDkGs2X53+mMKoK28afw+b1fQAyWXTjnniX0B9O+ME4r/321AQ0FA3ADcamE4jG
         /igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PS1fdE4OWrB2AkicxBBGpwBY93VCzMfCd/vvRM7GyAk=;
        b=Pv1D2s9YFHAYmmV36VFAqwXMpAqJT/8yEeUNBCSMvU8hdmhVOog5m0n+wdCEXAiwCe
         VrTcWkB5lLfpgKegE5G/Ik5AU5UyLKBpzpBKE/z31aLHl1TW+B3KsCqUvYbHqrBQV+fC
         Q9cFZCqmOcgK/DhWo5Hc8qFBpzfI/GJM2AxpHUZr69BONySrYCCEDbwv4u8nwc6nakr5
         IETqK6gFyL4JsFoL1JszQP8UsN9cQmo58kJtSxuwLqUwID2KoQy0uG5Pt4Ca7/kJjxfS
         yRtskpjnwuDaSo1unqe8+aOpLer3ew6B64KS2ATMcw8X6bbAjkBk9m6PEsD4exbsIlGk
         73nw==
X-Gm-Message-State: APjAAAVj4TcOMJr7OMSxrc5bNgnpLgmGf19a/BfBpMr5PA9bNjMA6ba4
        np9WS5InsYzUxz5Y0dgWcYCV2+odCVD47BhnlgE=
X-Google-Smtp-Source: APXvYqzAgYaiT8ekNCP8XrmAwQ07X5LfLH/zISjybm2/aCfZtVIlqXQeFsK+KBgmsLpSlkESUJdMB/a9EwuPtG/rNek=
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr3835223plo.18.1582796604992;
 Thu, 27 Feb 2020 01:43:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582709320.git.eswara.kota@linux.intel.com>
 <48dbbe705a1f22fb9e088827ca0be149e8fbcd85.1582709320.git.eswara.kota@linux.intel.com>
 <20200226144147.GQ10400@smile.fi.intel.com> <371e50f1-cab6-56f4-d12d-371d1b1f9c67@linux.intel.com>
In-Reply-To: <371e50f1-cab6-56f4-d12d-371d1b1f9c67@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Feb 2020 11:43:17 +0200
Message-ID: <CAHp75VfJHvtLBueHJnU6xEuSrehiXH4Pvj880TqpyDBBnx1RuQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] phy: intel: Add driver support for Combophy
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 9:54 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
> Thanks Andy for reviewing and giving the inputs.
> I will update them as per your comments, but for couple of cases of i
> have a different opinion. Please check and give your inputs.

...

> >> +enum {
> >> +    PHY_0,
> >> +    PHY_1,
> >> +    PHY_MAX_NUM,
> > But here we don't need it since it's a terminator line.
> > Ditto for the rest of enumerators with a terminator / max entry.
>
> Sure i will remove them.
>
> To be meaningful, i will remove the max entry for the enums representing
> the value of register bitfields.

It will work.

...

> >> +static int intel_cbphy_iphy_dt_parse(struct intel_combo_phy *cbphy,
> > dt -> fwnode
> > Ditto for other similar function names.
> Sure, it looks appropriate for intel_cbphy_iphy_dt_parse() ->
> intel_cbphy_iphy_fwnode_parse().
> Whereas for intel_cbphy_dt_parse() i will keep it unchanged, because it
> is calling devm_*, devm_platform_*, fwnode_* APIs to traverse dt node.

How do you know that it will be DT node?
I can't say it from the function parameters: Is any of them takes of_node?

> >> +                                 struct fwnode_handle *fwnode, int idx)

...

> >> +    struct fwnode_reference_args ref;
> >> +    struct device *dev = cbphy->dev;
> >> +    struct fwnode_handle *fwnode;
> >> +    struct platform_device *pdev;
> >> +    int i, ret;
> >> +    u32 prop;
> > I guess the following would be better:
> In the v2 patch, for int i = 0 you mentioned to do initialization at the
> user, instead of doing at declaration.

> So i followed the same for "pdev" and "fwnode" which are being used
> after few lines of the code . It looked good in the perspective of code
> readability.

No, it is different. For the loop counter is better to have closer to
the loop, for the more global thingy like platform device it makes it
actually harder to find.
When you do assignments you have to think about the variable meaning
and scope. Scope is different for loop counter versus the mentioned
rest.

> >       struct device *dev = cbphy->dev;
> >       struct platform_device *pdev = to_platform_device(dev);
> >       struct fwnode_handle *fwnode = dev_fwnode(dev);
> >       struct fwnode_reference_args ref;
> >       int i, ret;
> >       u32 prop;
> >
> >> +    pdev = to_platform_device(dev);
> > See above.
> >
> >> +    fwnode = dev_fwnode(dev);
> > See above.

-- 
With Best Regards,
Andy Shevchenko
