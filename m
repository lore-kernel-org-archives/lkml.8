Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1118C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A47320714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQkzamoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgG0JGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgG0JGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:06:37 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D838C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:06:37 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s144so3807668oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRIWnJYbdw6ZlkOW0iyNPITiiGcd1fenkAUWmQ+sE+c=;
        b=mQkzamoGG2dJfrAkjk0RKvKMPpFeaWFlnszQshNFpdCSSF7MnRaCjZ14VBeze06yzw
         npw+5Pn347bv4kmoDhRBKi42GpVBDUZuBYgfQ5tew4zulPGRXCYyMyfvjKZCZ5Kfvn8e
         T/Lc84X6+iufeU6MltcS4k9M4xhAtOWelCdSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRIWnJYbdw6ZlkOW0iyNPITiiGcd1fenkAUWmQ+sE+c=;
        b=WI6OOlcMYAJanTiUhiIZ4+C4XhDw4qb52O4ByupX8GaKUOoSE9Y+OTR5sUalCfOVQA
         WEP315SmKNzSVuso3wjHOzNHrt4NVdykU6oVr8AyHVVkGDTLp6UWPDgshwX/kJ98g24u
         p0wMap+SEIW8E1DwgyqbwHb/tcGY2LjKhZYL2DOnZGkrqEWbSA+iwtWGbrD1FMgRo9On
         1bnxJ9lc9qPmtzewigqc6d2PjFuFwf+hrSRUdFywtllTELD6NeM6caCK0pon0n3qti5X
         vnZ1v7lqRiUjdrON/WqCCTAlt+9AiJrTlSb+Qs8vdpseDpGpJT95hOzNWBHewfk6phlO
         7lOg==
X-Gm-Message-State: AOAM532y/6nxamFFCycTXv2CTmXxgUjD1Ss2eObA8s4ELOlNv37ZPV9m
        HzxEVLnnvWG3o9zHFe5LGHKsV6DFPWk=
X-Google-Smtp-Source: ABdhPJzIGP1Ef4OHb/8tZyTZT0byCU8dIwpfIIHtYTX697K8EIpngV5bEy2lBoKhjCgCluYFJHy18A==
X-Received: by 2002:a05:6808:7de:: with SMTP id f30mr17156601oij.15.1595840795278;
        Mon, 27 Jul 2020 02:06:35 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id s8sm3380344otk.36.2020.07.27.02.06.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 02:06:33 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id h1so11757372otq.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:06:33 -0700 (PDT)
X-Received: by 2002:a9d:5609:: with SMTP id e9mr18647732oti.141.1595840792802;
 Mon, 27 Jul 2020 02:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200520082723.96136-1-acourbot@chromium.org> <CAAEAJfCzmEj3X2NdgaD=YSS_fV7MnZw=4o5KJOOSoMOSejv7=g@mail.gmail.com>
In-Reply-To: <CAAEAJfCzmEj3X2NdgaD=YSS_fV7MnZw=4o5KJOOSoMOSejv7=g@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 27 Jul 2020 18:06:19 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUg9ua0gi8c3HSg-GOV=Akyp_KfhpWBZizvmxhc5QcJqA@mail.gmail.com>
Message-ID: <CAPBb6MUg9ua0gi8c3HSg-GOV=Akyp_KfhpWBZizvmxhc5QcJqA@mail.gmail.com>
Subject: Re: [PATCH 00/10] media: mtk-vcodec: venc: support for MT8183
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, thanks for the review!

On Sun, Jul 26, 2020 at 11:33 PM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> +Enric
>
> Hello Alexandre,
>
> Thanks for the series.
>
> On Wed, 20 May 2020 at 05:27, Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> > This series adds support for the encoder present on MT8183. It is very similar
> > to the one in MT8173, but with different capabilities and using a new firmware
> > interface (SCP, while MT8173 talked to the VPU).
> >
> > So this series starts with some preparatory work by putting the firmware
> > interface behind a small abstraction layer instead of directly talking to the
> > VPU, and by adding support for the SCP firmware. Next platform data is completed
> > with features that differ between the chips, like supported formats and bitrate,
> > before support for MT8183 is added.
> >
> > Alexandre Courbot (6):
> >   media: mtk-vcodec: venc: handle firmware version field
> >   media: mtk-vcodec: venc: specify bitrate range per-chip
> >   media: mtk-vcodec: venc: specify supported formats per-chip
> >   media: mtk-vcodec: venc: remove redundant code
> >   media: dt-bindings: mtk-vcodec: specify SCP node
> >   media: dt-bindings: mtk-vcodec: document mediatek,mt8183-vcodec-enc
> >
> > Yunfei Dong (4):
> >   media: mtk-vcodec: abstract firmware interface
> >   media: mtk-vcodec: add SCP firmware ops
> >   media: mtk-vcodec: venc: support SCP firmware
> >   media: mtk-vcodec: add support for MT8183 encoder
> >
> >  .../bindings/media/mediatek-vcodec.txt        |   9 +-
>
> Would it be possible to add the support in
> arch/arm64/boot/dts/mediatek/mt8183.dtsi ?
>
> Given the driver is stateful it should be possible
> for anyone to test it with standard userspace
> such as GStreamer.

Certainly.

>
> Is it possible for the firmware to be pushed to linux-firmware ?

The firmware is already there:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=3c213aa59661c4641f0c2166a315140ac0445230


>
> Thanks,
> Ezequiel
>
> >  drivers/media/platform/Kconfig                |   2 +
> >  drivers/media/platform/mtk-vcodec/Makefile    |   4 +-
> >  .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  53 ++--
> >  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   |   1 -
> >  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  38 ++-
> >  .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 141 ++++-------
> >  .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  | 149 ++++++++----
> >  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   |   2 -
> >  .../media/platform/mtk-vcodec/mtk_vcodec_fw.c | 228 ++++++++++++++++++
> >  .../media/platform/mtk-vcodec/mtk_vcodec_fw.h |  38 +++
> >  .../platform/mtk-vcodec/mtk_vcodec_util.c     |   1 -
> >  .../platform/mtk-vcodec/vdec/vdec_h264_if.c   |   1 -
> >  .../platform/mtk-vcodec/vdec/vdec_vp8_if.c    |   1 -
> >  .../platform/mtk-vcodec/vdec/vdec_vp9_if.c    |   1 -
> >  .../media/platform/mtk-vcodec/vdec_drv_base.h |   2 -
> >  .../media/platform/mtk-vcodec/vdec_drv_if.c   |   1 -
> >  .../media/platform/mtk-vcodec/vdec_vpu_if.c   |  12 +-
> >  .../media/platform/mtk-vcodec/vdec_vpu_if.h   |  11 +-
> >  .../platform/mtk-vcodec/venc/venc_h264_if.c   |  80 ++++--
> >  .../platform/mtk-vcodec/venc/venc_vp8_if.c    |  11 +-
> >  .../media/platform/mtk-vcodec/venc_drv_if.c   |   1 -
> >  .../media/platform/mtk-vcodec/venc_drv_if.h   |   6 +
> >  .../media/platform/mtk-vcodec/venc_ipi_msg.h  |  24 +-
> >  .../media/platform/mtk-vcodec/venc_vpu_if.c   | 141 ++++++++---
> >  .../media/platform/mtk-vcodec/venc_vpu_if.h   |   8 +-
> >  26 files changed, 711 insertions(+), 255 deletions(-)
> >  create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
> >  create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
> >
> > --
> > 2.26.2.761.g0e0b3e54be-goog
> >
