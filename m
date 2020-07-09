Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE2EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A942074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evO2b+NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGIOT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgGIOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:19:26 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE103C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:19:26 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a11so2185460ilk.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yyTk6JnzuB+6AJzk46UVONqrdhWhla94soaQwotr7mY=;
        b=evO2b+NGHqDs7esJV54GOrqtSMtDd5WZ2hvUUE9vz9LXVfkTJ+XGA/QlGaVtSvaNVY
         YwmcMWuWFnG4c3A/P5XZW/eAbKJVHZ7ZVouLxJeR70kE+iar6oXOemB5qQMzoJ2ZnBTW
         xEiB6wbwD6phkstnwa3JflNxb+kOT/IfEn8+OAWJcnB6AlVTPgPxhIcLe/u9aUCZkxC+
         PIJV7E8XlQ5ULmQe6d+87Lt7lKyhbgS435egBWH1wsiM1nlAQcIw2lurz8kGLcaKD35Z
         gu/0iPaGLNfKgiozBpxtBAECIkt2iAlRCuC7LOke0jC5M9ta8K4CXDyQKFegh5Cryf2s
         5/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yyTk6JnzuB+6AJzk46UVONqrdhWhla94soaQwotr7mY=;
        b=R8q8uMMIe5wvo1fab11hip1uZ3WuZAXVyB4lmVSOupOL8Lg83fhxxr50iThCpDbbaE
         h1gqn66G7zohm4bzLP9pVOxx46mgi/1eZuue3fahRwOrkWbNvAEOI7fqJFUPttML8Z/f
         z8VY3vUL2nn4MHKYZwcHwkEexR6aJzi3fzJ245lGGkJjJeVsCew+CVY4J0Qf0Nf1hgJk
         uJQ1NHpTZ85EjJVquyjL5UceBNuzKYi2GjRi2rD6p1jUWsT1caqt8jvVnwaYFCBn6odY
         JyJXvrLUYzmTEYLlNqu0iqKOiaPUWKPIDL9/7Q3iJlHReN4NqnfYRSk4H0mN/eYeOZAF
         YeIg==
X-Gm-Message-State: AOAM531BE8B7iiTVpzIxBUUbFtBlUMiqS/aN5cmXo3c1DFkJKttmPKJt
        EUXyDdLEOm1EL1vLXBo0cj/+P0+L19ZT2I+kiAA=
X-Google-Smtp-Source: ABdhPJzlf+b1KgiUbcjVMUS0N4HWsZdJIbmumIkqsvzYa0CfQiQ7QW9DlQt/UH6FKbef1ssVDxXvYUqiurOJnPvJwiQ=
X-Received: by 2002:a92:52:: with SMTP id 79mr43127196ila.59.1594304365847;
 Thu, 09 Jul 2020 07:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200709140322.131320-1-peron.clem@gmail.com>
In-Reply-To: <20200709140322.131320-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 9 Jul 2020 16:19:14 +0200
Message-ID: <CAJiuCcdRB-ZLepes9BuypR4pErkhiJoOqk6R1meCksuaez-7xQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Add regulator devfreq support to Panfrost
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Jul 2020 at 16:03, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
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

Just saw that some changes have been made and pushed to 5.8-rc4.

I will push a v4 up to date.

Regards,
Clement


>
> Regards,
> Cl=C3=A9ment
>
> Changes since v2:
>  - Collect Alyssa Rosenzweig reviewed-by tags
>  - Fix opp_set_regulator before adding opp_table (introduce in v2)
>  - Call err_fini in case opp_add_table failed
>
> Changes since v1:
>  - Collect Steven Price reviewed-by tags
>  - Fix spinlock comment
>  - Drop OPP clock-name path
>  - Drop device_property_test patch
>  - Add rename error labels patch
>
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
>
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 102 ++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 175 ++++++++++++------
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h   |  30 ++-
>  drivers/gpu/drm/panfrost/panfrost_device.c    |  61 +++---
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  14 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  15 +-
>  drivers/gpu/drm/panfrost/panfrost_job.c       |  10 +-
>  9 files changed, 296 insertions(+), 113 deletions(-)
>
> --
> 2.25.1
>
