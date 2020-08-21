Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D7AC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B544820748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNZJcPBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHUUMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:12:19 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05C6C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:12:19 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so2583816oik.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qU809CtNTXkjajhW2wh13M18DwibA6ul0FCeVgUG8A=;
        b=uNZJcPBuLQI6ASFZUw8QkZ9k3ruDXi+NR0Kt7euvSfH4mOkI5/9P8eZwp0n3pWGIA2
         BJ4j8yy0xBhrOtnOZFZLMc7a8rXqPwypZyipI8fq6RvAnmAgwpFzG81/j/WOGXKiGiPo
         8VAAvITRLMHZv00OrfzzKV4vVj3SWkldqmfvMNhMXywEZI2IPy/6TmMblhy2pRgEfzgz
         yFCi2m/o0WvrnQqp8VkEwh/4O4HMWoET8SG+sn0fYfLw24j101w3Sjs9gBVrCR3pZ9Dm
         STC2SEsoODBbxumcSiZ4huToeiteGnz0EWJmsz9eJevZQlzg1H+uKLuUeJotQ86iS3yf
         yOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qU809CtNTXkjajhW2wh13M18DwibA6ul0FCeVgUG8A=;
        b=EyWi6D+U0ZB58CROLbsmsglxGCdFFQkBH9OjSA2BxGjJizRdFyLJHJrtYd3ybiFjdo
         kF2bG0S4BNpAby/YTKonlNg5hJ+3/8W9FSSox3u56hvlBw5W6ireHQnMzLuEg6GIihiD
         6kl9hM+ra6xrU8NmiSUzC/x4rSpSMaTohb1XtsJ68wfUHgkhy/ctD76vmK/p4ytod6yC
         nxBDaOIJoXSOCbQIyajfhvOrvOjeMtgZG4ve+m+czd0EY26TLr2nZdUEIXIcrCJq3+sU
         q1MwPbEavQfNMGk1/PvcTp6pLUfkplHwQw785r53WOqTWpBpMWcj0tlLVG7uZaHkMuJt
         eaGA==
X-Gm-Message-State: AOAM532JjzIRo0mB9DhMs612bRruodYHVS+EGatzLfCVgzYYi0TndVfW
        D+qV5LHuFMOpOIyv/mMoomYmK4/fZS1GZ/Jgk8jQPA==
X-Google-Smtp-Source: ABdhPJxeOwH2KU0W0WI97zQrIKn2g+YzpfFe6sDTwlBDqKWlmQ7wcHROHsB8ml5rNCQ/tdEe6QqSYj9jep2a15MAg8c=
X-Received: by 2002:aca:1c15:: with SMTP id c21mr2982966oic.10.1598040738933;
 Fri, 21 Aug 2020 13:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
 <9fa944021373ec5b82c2c1e118c15d9effe7f964.1597833138.git.mchehab+huawei@kernel.org>
 <CALAqxLV-LaMPKD-ddRM1EehFh+JZfh1eUsKobXgVG9R+q0EF2w@mail.gmail.com> <20200820102332.7223d38d@coco.lan>
In-Reply-To: <20200820102332.7223d38d@coco.lan>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 21 Aug 2020 13:12:06 -0700
Message-ID: <CALAqxLV1vskvo7MFsKdCiS_XcTy76B5hu2ZfWJbY6p2fVpYCVA@mail.gmail.com>
Subject: Re: [PATCH 25/49] staging: hikey9xx/gpu: do some code cleanups
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 1:23 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> (added c/c Rob Herring)
>
> Em Wed, 19 Aug 2020 18:53:06 -0700
> John Stultz <john.stultz@linaro.org> escreveu:
>
> > On Wed, Aug 19, 2020 at 4:46 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > > @@ -376,7 +355,7 @@ static int kirin_drm_platform_resume(struct platform_device *pdev)
> > >  }
> > >
> > >  static const struct of_device_id kirin_drm_dt_ids[] = {
> > > -       { .compatible = "hisilicon,hi3660-dpe",
> > > +       { .compatible = "hisilicon,kirin960-dpe",
> >
> >
> > One issue, elsewhere in your patch stack you still refer to the
> > hisilicon,hi3660-dpe compatible string. This should probably be
> > consistent one way or the other.
>
> Agreed with regards to consistency.
>
> It sounds to me that calling those as Kirin 9xx (and the previous one
> as Kirin 620) is better than using the part number.
>
> Here, googling for "Kirin 970" gave about 6.9 million hits, while "Hi3670"
> gave only 75,5K hits.
>
> Kirin 620 has similar results: 6.85 million hits, against 61,9 hits
> for "Hi3620".

Hi6620 is kirin 620 I believe.

> With "Kirin 960", the numbers are a lot higher: had 21,4 million hits,
> against 423K hits for "Hi3660".
>
> So, my preference is to use "Kirin 620, 960 and 970" for future changes.

I think traditionally the DTS is developed with the hardware
documentation sometimes before the SoC is announced, so they tend to
stick with whatever those documents call it, rather than (later more
google-able) marketing names.

That said, I don't have a preference, as long as it's consistent, and
we don't change compatible strings that are already upstream.

> I would love to make this consistent among the Kernel. However,
> I'm not sure if changing "compatible" would be acceptable
> by DT maintainers.
>

Existing bindings are already ABI. So we can't change those. New
bindings can be set to what makes the most sense.

thanks
-john
