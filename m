Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DB4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57B32074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SkGAKM4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgG2FHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgG2FHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:07:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAC4C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:07:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so16741007wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7GpifdEc6/Oc47TVBKpBwXB5I1TE7MgsWaCzxZQmbVY=;
        b=SkGAKM4vmqg3Msrjk1lw+Z0tzr2H1O4AexEGpm1tkin8xvNP/5Y9RvAEmEjQrLa65U
         SbmI/Uo/tDJXmOJfmxH7xW5Jm+vVXpRPWQzRVnORHeFwhcyZd44wtmnd1ABDD7dW4CiB
         TTyrnTWqZJVt+A+yfI96ySNQv7mCbULcoyDM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GpifdEc6/Oc47TVBKpBwXB5I1TE7MgsWaCzxZQmbVY=;
        b=RNI7uVIF0QinaOOYzAmr6NXymwRmtVxeoK9GQRiuWfbWCQKtdvl+fk7Cq03JsTdssr
         i4WjEDPbHdzWYzPlq03Speqm5sY7opqetkuEXgGQAacXPq5i1RrcWoxtJ0+/v/nR8kmk
         1BT8j0JRJ0pStHpVAQDCO+VxACN8BBSHWT9sSILrGYnaG0KPyfVelzIWFEjtz6akbHw5
         VAXHshCUiy311ke+6qhzZLP274+TDkEXgknuSZvtbUWme5pyyvdTfR4rVtd1YxP/fbbB
         namaJMAdqCI9Lzm5VX1nUCOIwrUk9I/fkj/M4xZPFQ7Yvv49CMH1TUSIM/bn1bhaYZLX
         W7fQ==
X-Gm-Message-State: AOAM530fPc9I0jwh+RH1a3238X00tDSjhuSSqjD26BFa/qxFEet7/0ql
        JZS+7MYoG772p37DMgAQuhu1rxeveUMVHMpNNQ/Ml2gwKATvKw==
X-Google-Smtp-Source: ABdhPJxbnyDe18hT7bjCWGNi5c5AT3QkDh5H/5AFBe0xvxZwMfVY1VwpKS/VFk6Ivj9WACTb+i1bEnsFK4MGE1RYQkk=
X-Received: by 2002:a5d:5588:: with SMTP id i8mr27809549wrv.177.1595999219359;
 Tue, 28 Jul 2020 22:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <1595779727-31404-1-git-send-email-brent.lu@intel.com>
 <7dec7fcd-0381-d279-4dac-77c27ea5f6fe@linux.intel.com> <DM6PR11MB3642BE84A5C91504D6AF4ECB97730@DM6PR11MB3642.namprd11.prod.outlook.com>
 <14fde5e9-a11a-077d-b533-1e6db4b7a262@linux.intel.com> <DM6PR11MB3642AF0905E0CF57B094906297730@DM6PR11MB3642.namprd11.prod.outlook.com>
 <216b86eb-aec6-dab9-7901-9e0f2cc5af7f@linux.intel.com>
In-Reply-To: <216b86eb-aec6-dab9-7901-9e0f2cc5af7f@linux.intel.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 29 Jul 2020 13:06:32 +0800
Message-ID: <CAFv8NwLEHf=3ejrr1m74cRSjiX3mOKfx0oRyu51ENo6mktEgEQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: Atom: use hardware counter to update hw_ptr
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 1:31 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 7/28/20 12:02 PM, Lu, Brent wrote:
> >>
> >> So if there are already quirks in atom machine drivers to change the period
> >> size, why is this patch necessary?
> >>
> >
> > The story is: google implemented the constraint but doesn't know why it works
> > so asked us to explain. After checking the two counters I realized the increase of
> > ring buffer pointer follows the period size setting in hw_param (256) but the
> > period of interrupt is always 5ms instead of 5.33 so it's running little bit too fast.
> > It seems the LPE keeps tracking the difference of two counters. When the
> > difference exceeds 2160 samples, the next interrupt will be canceled so the
> > hardware counter could catch up a little.
> >
> > [   43.208299] intel_sst_acpi 808622A8:00: mrfld ring_buffer_counter 107520 hardware_counter 98880 pcm delay 8640 (in bytes)
> > [   43.208306] intel_sst_acpi 808622A8:00: buffer ptr 26880 pcm_delay rep: 2160
> > [   43.208321] sound pcmC1D0p: [Q] pos 26880 hw_ptr 26880 appl_ptr 40000 avail 191680
> > => one interrupt is skipped.
> > [   43.218299] intel_sst_acpi 808622A8:00: mrfld ring_buffer_counter 108544 hardware_counter 100800 pcm delay 7744 (in bytes)
> > [   43.218307] intel_sst_acpi 808622A8:00: buffer ptr 27136 pcm_delay rep: 1936
> > [   43.218336] sound pcmC1D0p: [Q] pos 27136 hw_ptr 27136 appl_ptr 40000 avail 191936
> >
> > So I think why not using the hardware counter? It increases 240 samples every 5ms
> > perfectly match the 48000 sample rate. The test result is good but I know there must
> > be a reason for the original designer to use ring buffer counter instead of hardware
> > counter. I uploaded this patch to see if anyone still remember the reason and share
> > some insight with me.
> >
> > I totally agree that we shouldn't touch this part of design. Do you think it make sense
> > to add a constraint to enforce the period size in machine driver? If yes then I would
> > upload patches for Chrome atom machines for google.
>
> I think it'd make sense to add this constraint, either in the machine
> driver or in the platform driver, so that we don't change the position
> updates and introduce more issues by accident by doing so. As you
> rightly said, I don't think anyone tested periods multiple of 256
> samples so it's not a regression, more aligning with the internal design.

Thanks for the explanation and discussion.
A slight correction in this thread is that CRAS does not set period size to 256.
It just uses whatever value that driver wants to use, which happens to be 256.
If the driver can limit the selection to only correct values that
would be the best.
Adding constraints in the machine driver or platform driver looks
good. Prefer to adding in platform driver so we don't need to add for
each machine driver.
Thanks!
