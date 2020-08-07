Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31E4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E01A20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNCCYGsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHGQ26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:28:55 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C94C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 09:28:55 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p16so2292615ile.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=urdx1lDCi4hW3gy7vsIQcFrWIUTqXkOIttnIizLyY9k=;
        b=WNCCYGsxW+ASrgZsReTjZV3s5rXlvNA3Kpznvja+rCIXZ8VCC2tr9oR4i699RPBU5t
         5b7ovu6DHwYQNjxMYVE+H7Z2ML4J/Pidk0JiaM3MGG2eooJhi2rWXPE2yRLzztz3Y+iq
         ZOCHoGhJz3NJXm3p869Us2AANUjhaoBjjzPpfvpYdq3zzZdPm/fmEy7eeeeqqjQ7+uqr
         wrhssM4iknq4oQnoi8AldXTc4+/UYlZnhIui9u6UUcLP+adYQ9PLzM2Y01VMRUJ9CF8M
         +7OQamtZo1QPKUwT5yRtBT4mb0GrQ/MXh/zPyvmNl9/izQJlJSYecwuffUoIJ2IEFaf5
         3obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=urdx1lDCi4hW3gy7vsIQcFrWIUTqXkOIttnIizLyY9k=;
        b=mxdq4wPFn+sVvUpMxijg9R0XVWKt4ekA54Uvbx/hikBBELQ5kw9/97iDmMpEaMeJxv
         IxMiGAokagx8VsCH7s+IZZKNsyudayT6J1GlBoJ1TXIbzN/E7Isz6aO5yzGK+GW7qZQ8
         wUCZBxiRs5z4yoeye0aGQyeZtKL9Q8FSFzaPrI7llTxUSrSW9+PxgKGHA25mQxadATtX
         U7mTAV/WvUhPlm+UkLWNxyvl1HUqeyRcIDXci6ggrlocLBVouIGxmhoQMfrQzNWmyxR8
         InonDwBG/NcHv9qOW1oRLr3xfw9cOyqFAVFjh1Z+gRgfV80Pmv51xk4/mGj96Q3P5iaM
         WTfQ==
X-Gm-Message-State: AOAM532QyZzuPvvHsDeKM5dLYdCbkMsLlIn+ZAF0vchdCP15KE7U9wBK
        vedJuKGPr1IPdKTVAJhxUxRTrBvuVsXi74eBvyU=
X-Google-Smtp-Source: ABdhPJxsGc96PuX6gvseLk4/WW2Y/uZlIj/qKox35x1oE+cutdGb8+/VdEsU5lXA9pCRco3q4fhnDA+zOdcLCA3S2zs=
X-Received: by 2002:a05:6e02:5a7:: with SMTP id k7mr5167981ils.293.1596817734496;
 Fri, 07 Aug 2020 09:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200710095409.407087-1-peron.clem@gmail.com> <CAL_JsqLnOGVbO5T92dyzt3K-v4BRNt72yMpYR_wW-z8dpdVSvA@mail.gmail.com>
In-Reply-To: <CAL_JsqLnOGVbO5T92dyzt3K-v4BRNt72yMpYR_wW-z8dpdVSvA@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 7 Aug 2020 18:28:43 +0200
Message-ID: <CAJiuCcfezzr7w9=-G6WK0p6YS=6SBAKF8jv=yAOyNFJ59X80qw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Add regulator devfreq support to Panfrost
To:     Rob Herring <robh@kernel.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 7 Aug 2020 at 18:13, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jul 10, 2020 at 3:54 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >
> > Hi,
> >
> > This serie cleans and adds regulator support to Panfrost devfreq.
> > This is mostly based on comment for the freshly introduced lima
> > devfreq.
> >
> > We need to add regulator support because on Allwinner the GPU OPP
> > table defines both frequencies and voltages.
> >
> > First patches [01-07] should not change the actual behavior
> > and introduce a proper panfrost_devfreq struct.
> >
> > Regards,
> > Cl=C3=A9ment
> >
> > Changes since v4:
> >  - Fix missed a pfdev to &pfdev->devfreq during rebase
> >
> > Changes since v3:
> >  - Collect Steven Price reviewed-by tags
> >  - Rebase on next/master (next-20200709)
> >
> > Changes since v2:
> >  - Collect Alyssa Rosenzweig reviewed-by tags
> >  - Fix opp_set_regulator before adding opp_table (introduce in v2)
> >  - Call err_fini in case opp_add_table failed
> >
> > Changes since v1:
> >  - Collect Steven Price reviewed-by tags
> >  - Fix spinlock comment
> >  - Drop OPP clock-name patch
> >  - Drop device_property_test patch
> >  - Add rename error labels patch
> >
> > Cl=C3=A9ment P=C3=A9ron (14):
> >   drm/panfrost: avoid static declaration
> >   drm/panfrost: clean headers in devfreq
> >   drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
> >   drm/panfrost: introduce panfrost_devfreq struct
> >   drm/panfrost: use spinlock instead of atomic
> >   drm/panfrost: properly handle error in probe
> >   drm/panfrost: rename error labels in device_init
> >   drm/panfrost: move devfreq_init()/fini() in device
> >   drm/panfrost: dynamically alloc regulators
> >   drm/panfrost: add regulators to devfreq
> >   arm64: defconfig: Enable devfreq cooling device
> >   arm64: dts: allwinner: h6: Add cooling map for GPU
> >   [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
> >   [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be alway=
s
>
> Patches 1-10 applied to drm-misc.

This serie has been superseded by v5.

Could you apply the v5 instead.

Thanks
Cl=C3=A9ment

>
> Rob
