Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9EEC35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E2121D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oPPLUfN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBGDGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:06:33 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35232 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBGDGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:06:32 -0500
Received: by mail-qk1-f194.google.com with SMTP id q15so891158qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 19:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3TxFkwUBzoZxEqhHCb5Dpa2HZc5hJhUkqC/KNrkDQc=;
        b=oPPLUfN/w8TsNQT5FmZWFRbcL2X+OQPCnFdi3CoAh86Vc1akO5DDdEuhA4jXAT8Tgy
         +D48c/EPGWfn/tkt+76tePp/JgvcAiokBGkYgxFjqw/N5OST8Z+xEkNgfLWT5N+Mpp7E
         8jzLtZ/IP75iaFWsIKlT18p0KVqhZqOaK+zxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3TxFkwUBzoZxEqhHCb5Dpa2HZc5hJhUkqC/KNrkDQc=;
        b=SRjTmWg5y9Qg1e1nYfyS/XohvLJAJa3kNGzMXwhUuLUdrQ1Kjcy9ephfGz0o0ttSmn
         QDBMGHQ3oSBvbaN1SW7t0KeRymZltt7oSKRlfHpV/km/q+aT3Jg64ABbh2Ab2U3DYRt5
         R3Jodt/d0WR8DUKcDAHgJeTz7Pi8jhkTEAdzsjt61S7wnXkW0VApp6R+m+KizTMAM0GT
         VCD3Ywx4WVWu4bA3fQi40ivcKhkYapDVQZqM8w80hlhz606sAzEwz/yGQazGy+kFVPo8
         b5oNR3b2bW6eh9DTJK5hA71UHcYa+UKsBQGwFEiMS9xucAUiINJJhWWRGtOMNQ+wq7QV
         mMvA==
X-Gm-Message-State: APjAAAWX94//cx9TJCVkjvLRDH/l/uB2jGoFNAUz/P9sANIJ2eEksULm
        XPE93KTTfyQCC/Ez6MxJzEH4sJhkKG4OdGUKppHz4A==
X-Google-Smtp-Source: APXvYqyylJuMDkKA7gnAsAhliXtut7vEzHdVLf8fTNkkiclmjbUpYD2oxeEcbD7bCMDcK99RCxtzazSCPbnSooRDfo8=
X-Received: by 2002:ae9:f003:: with SMTP id l3mr5455012qkg.457.1581044792080;
 Thu, 06 Feb 2020 19:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20200114071602.47627-1-drinkcat@chromium.org> <20200114071602.47627-6-drinkcat@chromium.org>
 <8b300f30-aa6d-89ee-77e3-271e3fa013f8@arm.com>
In-Reply-To: <8b300f30-aa6d-89ee-77e3-271e3fa013f8@arm.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 7 Feb 2020 11:06:21 +0800
Message-ID: <CANMq1KDEdbiHWzfZhvfpKG4cNOnp_x3bMO5rOaCuLzNJ5W4zEA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] drm/panfrost: Add support for multiple power domains
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 10:53 PM Steven Price <steven.price@arm.com> wrote:
>
> On 14/01/2020 07:16, Nicolas Boichat wrote:
> [snip]
> >
> > +     err = panfrost_pm_domain_init(pfdev);
> > +     if (err) {
> > +             dev_err(pfdev->dev, "pm_domain init failed %d\n", err);
>
> No need for this print - panfrost_pm_domain_init() will output a (more
> appropriate) error message on failure.

Dropped.

> > +             goto err_out2;
> > +     }
> > +
> [snip]
> > @@ -196,6 +274,7 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
> >       panfrost_mmu_fini(pfdev);
> >       panfrost_gpu_fini(pfdev);
> >       panfrost_reset_fini(pfdev);
> > +     panfrost_pm_domain_fini(pfdev);
>
> NIT: The reverse of the construction order would be to do this before
> panfrost_reset_fini().

Oh right, fixed.

Thanks.

> [snip]
