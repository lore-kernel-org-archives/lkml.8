Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516D7C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAC820663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBPx9XDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgCLPgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:36:19 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40735 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgCLPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:36:18 -0400
Received: by mail-vk1-f193.google.com with SMTP id k63so1690994vka.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItaK786plfh9KkQVyoZ6Tvgm7U7BspaorwTITRYkRFc=;
        b=XBPx9XDFdcQlQtO0sfLYBzfLTIt6Rd5TvDrP9aLHPP7BKpYySz4vyjUciwhdNBl7iO
         N419sJMtK1ssgutjTDScHGBRnEQb6lGqUb/0h6ICfwDS8hXb3z0MqmyGAXMz+KUyScZ1
         1KNej7SBKjM5gd9WZVe+funDyMZ6vpSkDin6m041sG4KRhuiPfSPBLCle7Qow5Ot2+Qe
         L8JGYeBgfnGo4Ggw6yzdws+D7wr1bkQRtXEGrrEPDT+3rHZbg6wAy/A5GHtQMfprQhz8
         7twkRHcsQIHaLC/ayciTnH1iH3BFwJIn4+ae39J3ujZ/MT4/kyonZU4tnDmpAoUfX1pV
         VSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItaK786plfh9KkQVyoZ6Tvgm7U7BspaorwTITRYkRFc=;
        b=OF0Qr0eugHfA/3WaxxTkKU2cQExAP/g9vkFxrNm7Q9Q5wmgGWyFMK8wGwNiVNZD2ee
         vW4Ohax46sAnakkvDklv1TLsB0Uv51K13ufOC81YB6qq59aOh5yZXXoT8liN/82fsVOm
         Q0Mysw0WYSI3r+CuUJ3RkXoqsoZZX3ZSFrjlEs9hZkMrxLe0DZcIpAvkaFz7wefciJ7x
         0JdAbjP+RQqcsz8MuDwu73l5S6qJP6VUkVYLXRgXhgNbzyBqeUjEDqX+hM/1FnRaVte4
         24byH8NhUIFmPcGezLR91gmTss45UJER4BFc2vTTubTLOiro96OnZHkAtSJhCMy9SqQf
         vDkg==
X-Gm-Message-State: ANhLgQ0Tce6br58lZdd7+pKgBfeVfcfctqjQkvnkoXpH3m/gwh+VLRBg
        5+JPoZEy15P9VFMyP63+rUdTC8o2TyCzQ+gkU/8JfQ==
X-Google-Smtp-Source: ADFU+vtp2YzztepF0ByqDCsdpx/wxjPTae7z5wkbFT4j3VYmnzNKQ+GMvxjgwUcAW74SJSoAJAcalE+p8TSApJMHn28=
X-Received: by 2002:a1f:2947:: with SMTP id p68mr5727151vkp.43.1584027377545;
 Thu, 12 Mar 2020 08:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <1583886030-11339-1-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFpAgk0uboGXdmA_m1-2=GK2oRXVv+97ZFFFAtT-ZZo4fw@mail.gmail.com> <7bf5bfb5-b07c-96d3-2c33-124085a36a65@nvidia.com>
In-Reply-To: <7bf5bfb5-b07c-96d3-2c33-124085a36a65@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Mar 2020 16:35:41 +0100
Message-ID: <CAPDyKFoJvaCj=wkV_ok=sLJK18ukf1UavCvDN-E_oFVkpwPbmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sdhci: tegra: Implement Tegra specific set_timeout callback
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 at 16:28, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
>
> On 3/12/20 6:08 AM, Ulf Hansson wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > -trimmed cc list
> >
> > On Thu, 12 Mar 2020 at 00:51, Sowjanya Komatineni
> > <skomatineni@nvidia.com> wrote:
> >> Tegra host supports HW busy detection and timeouts based on the
> >> count programmed in SDHCI_TIMEOUT_CONTROL register and max busy
> >> timeout it supports is 11s in finite busy wait mode.
> >>
> >> Some operations like SLEEP_AWAKE, ERASE and flush cache through
> >> SWITCH commands take longer than 11s and Tegra host supports
> >> infinite HW busy wait mode where HW waits forever till the card
> >> is busy without HW timeout.
> >>
> >> This patch implements Tegra specific set_timeout sdhci_ops to allow
> >> switching between finite and infinite HW busy detection wait modes
> >> based on the device command expected operation time.
> >>
> >> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > Applied for next, thanks!
> >
> > We should probably tag this for stable as well, don't you think?
> >
> > Kind regards
> > Uffe
>
> Yes, we need this for stable as well. As this is applied for next, looks
> like can't re-send patch with tag.
>
> Can you please help to add tag if you don't mind?

Yes, I will amend the change to add the stable tag, no worries!

Thanks for confirming!

[...]

Kind regards
Uffe
