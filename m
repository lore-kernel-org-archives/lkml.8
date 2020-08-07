Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA15C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1342065E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596816798;
	bh=AfuvdFn3dMHqvQQoxBneF6L/AD9mtL8sc5x4o3BprDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KWOtS0TRci1vtFeDoP7QWMM+8T6ePjXY8pi9ms9s3ngg+LkNCN7eZOI+iD1TeAWtL
	 ZQjUHSkPCfWjMH4LZYbzkYDg9mCOasGGywBkK/HZWhadz6zg/FLiyyDffcbofWjaoc
	 xyOQbVTZFUHMgMnh93Zgwi1WN/fs758O6uSFBx2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHGQNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGQNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:13:16 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9873B2065E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596816795;
        bh=AfuvdFn3dMHqvQQoxBneF6L/AD9mtL8sc5x4o3BprDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DWJHBwYgk1neCdP4+TIFmGkZr41TsTc+6PXJ0l//hCW+xbq81LlM6pUlR0lRzpXMt
         UhuUAaSdNZZLoIRS0tB9mm6eK9q6/zjyfEV2wjKYq/1bH94H5UCrnEVXYYHzyO/LFZ
         YErF7gjHvlpWAP0ERaub9pCEqKgXxjldbBjY/EVA=
Received: by mail-oi1-f170.google.com with SMTP id u63so2383620oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:13:15 -0700 (PDT)
X-Gm-Message-State: AOAM530ogeuwRyTbqR7P5BYaT2wBdZoXf6dOTmsmTkHkAo98qeiA1rZF
        13UWP60tubaMgKcyItH7IsIBS3Dbrvl4CCsw6A==
X-Google-Smtp-Source: ABdhPJwvEIz202H+y8lt7/5urap/1s4x9MmUoqD47TMfOnZglCtDSfQblglc2OIFHIEzaeCAJcyGROSzQTGRmOwgWjE=
X-Received: by 2002:aca:c3d8:: with SMTP id t207mr12260276oif.152.1596816794972;
 Fri, 07 Aug 2020 09:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200710095409.407087-1-peron.clem@gmail.com>
In-Reply-To: <20200710095409.407087-1-peron.clem@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Aug 2020 10:13:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLnOGVbO5T92dyzt3K-v4BRNt72yMpYR_wW-z8dpdVSvA@mail.gmail.com>
Message-ID: <CAL_JsqLnOGVbO5T92dyzt3K-v4BRNt72yMpYR_wW-z8dpdVSvA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Add regulator devfreq support to Panfrost
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
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

On Fri, Jul 10, 2020 at 3:54 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
>
> Hi,
>
> This serie cleans and adds regulator support to Panfrost devfreq.
> This is mostly based on comment for the freshly introduced lima
> devfreq.
>
> We need to add regulator support because on Allwinner the GPU OPP
> table defines both frequencies and voltages.
>
> First patches [01-07] should not change the actual behavior
> and introduce a proper panfrost_devfreq struct.
>
> Regards,
> Cl=C3=A9ment
>
> Changes since v4:
>  - Fix missed a pfdev to &pfdev->devfreq during rebase
>
> Changes since v3:
>  - Collect Steven Price reviewed-by tags
>  - Rebase on next/master (next-20200709)
>
> Changes since v2:
>  - Collect Alyssa Rosenzweig reviewed-by tags
>  - Fix opp_set_regulator before adding opp_table (introduce in v2)
>  - Call err_fini in case opp_add_table failed
>
> Changes since v1:
>  - Collect Steven Price reviewed-by tags
>  - Fix spinlock comment
>  - Drop OPP clock-name patch
>  - Drop device_property_test patch
>  - Add rename error labels patch
>
> Cl=C3=A9ment P=C3=A9ron (14):
>   drm/panfrost: avoid static declaration
>   drm/panfrost: clean headers in devfreq
>   drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
>   drm/panfrost: introduce panfrost_devfreq struct
>   drm/panfrost: use spinlock instead of atomic
>   drm/panfrost: properly handle error in probe
>   drm/panfrost: rename error labels in device_init
>   drm/panfrost: move devfreq_init()/fini() in device
>   drm/panfrost: dynamically alloc regulators
>   drm/panfrost: add regulators to devfreq
>   arm64: defconfig: Enable devfreq cooling device
>   arm64: dts: allwinner: h6: Add cooling map for GPU
>   [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
>   [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always

Patches 1-10 applied to drm-misc.

Rob
