Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C79DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CAE207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAqCRnYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHTJNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHTJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:13:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC39AC061757;
        Thu, 20 Aug 2020 02:13:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c15so1271421wrs.11;
        Thu, 20 Aug 2020 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0JbEGUpzUPbEtjAsVmRvH6bX5043+AS9qSE1XvD9D/U=;
        b=HAqCRnYoKh4shWP1Bh6iF2OQL1zyAwfk3BldT7lyFCXSdpMbI5McqVXvAg1y2E5Fl/
         PJRjYvURrqHmVTi6+1hqi+MzoxqmfJjkbsv2yAi3BiinfthNgiMYJFXnlbqQFxa6Z2+Q
         9USt7O5dHznyME7cQG9Pc9EGe6vfd/GJApL4neO9QkscPj91V6pZwbPzo5LMTMmWFm4i
         09CDuv2FV4cv8RPcIHCuHvYNgUP7CdFzpNOfobwbe7AYSX2EcHEDaEsgAxgG925H7BnC
         rPm2/6G8Ne1qVDOcsLcg11RLDMNcmshDznM87XgprKE9l3MFiwpM9U3ZkEhOmcSSBTI4
         n0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0JbEGUpzUPbEtjAsVmRvH6bX5043+AS9qSE1XvD9D/U=;
        b=AY0PFv3Mec3shPqTh4k0x1fJRZh7VV2+tiYipIwASwKjuzZ2KjPN5rnwIR4WAWxlOY
         cclUHRpFrbmYQjH4lRXJdDvPyGxHm8josduALuYGpXm/cQhjTVUxut0O4a4jO0o98H1H
         2i7bD1ggU6tV/TPXjMo7x1XsJBLZBxMBTKsK5qoRLINWItmTHqGgmN16tDTVc3i/fDFh
         aYDRGJL8gAxeq9prvtmsDqryGuMw6msklcPwLrdIhPGPwZGdm/qjU6XXNSHLoNeDd4za
         QUSIhlW7+Iuq7Bk+B3KDlUxkB3thTG60k0kkXPUQI1m7PzGHH/Z2OVB+Gi8lOa82oNBf
         BbHg==
X-Gm-Message-State: AOAM532VrK9KwDF/civLR8mtm2vCcKgtDCMxd7FsNfzqjnMX//s1GFSL
        YDGJqLnmYvBgqbLtCDuNOA8FJxeZsWRDdg==
X-Google-Smtp-Source: ABdhPJxoY9JmdC2hvKhv7zPTHozm34JZIknaHlVUcr+Fi116POuZOZYfQqOQ5WVjgvJwAFPP1yh0VA==
X-Received: by 2002:a5d:464a:: with SMTP id j10mr2318764wrs.187.1597914807249;
        Thu, 20 Aug 2020 02:13:27 -0700 (PDT)
Received: from ziggy.stardust (81.172.57.81.dyn.user.ono.com. [81.172.57.81])
        by smtp.gmail.com with ESMTPSA id a3sm3045157wme.34.2020.08.20.02.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 02:13:26 -0700 (PDT)
Subject: Re: [PATCH v1 00/21] add drm support for MT8192
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d723ec4f-b251-5a94-4939-01f2df61f7d8@gmail.com>
Date:   Thu, 20 Aug 2020 11:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/08/2020 08:03, Yongqiang Niu wrote:
> Changes in v1:
> - add some more ddp component
> - add mt8192 mmsys support
> - add ovl mount on support
> - add 2 more clock into mutex device
> - fix ovl smi_id_en and fb null software bug
> - fix ddp compoent size config bug
> - add mt8192 drm support
> - add ddp bypass shadow register function
> - add 8192 dts description
> 
> Yongqiang Niu (21):
>    drm/mediatek: add component OVL_2L2
>    drm/mediatek: add component POSTMASK
>    drm/mediatek: add component RDMA4
>    mtk-mmsys: add mt8192 mmsys support
>    mtk-mmsys: add ovl mout on  support
>    drm/mediatek: add disp config and mm 26mhz clock into mutex device
>    drm/mediatek: enable OVL_LAYER_SMI_ID_EN for multi-layer usecase
>    drm/mediatek: check if fb is null
>    drm/mediatek: fix aal size config
>    drm/mediatek: fix dither size config
>    drm/mediatek: fix gamma size config
>    drm/mediatek: fix ccorr size config
>    drm/mediatek: add support for mediatek SOC MT8192
>    drm/mediatek: add bypass shadow register function call for ddp
>      component
>    drm/mediatek: add color bypass shadow register function
>    drm/mediatek: add ovl bypass shadow register function
>    drm/mediatek: add rdma bypass shadow register function
>    drm/mediatek: add dither bypass shadow register function
>    drm/mediatek: add aal bypass shadow register function
>    drm/mediatek: add ccorr bypass shadow register function
>    arm64: dts: mt8192: add display node
> 

At least regarding mmsys and dtsi patches, these are not based on upstream. 
Please rebase.

Regards,
Matthias

>   arch/arm64/boot/dts/mediatek/mt8192.dtsi    | 126 +++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_disp_color.c   |  22 ++++
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  41 ++++++-
>   drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |  27 +++++
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   3 +
>   drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |  84 +++++++++++--
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  80 +++++++++++-
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   8 ++
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  48 ++++++++
>   drivers/soc/mediatek/mmsys/Makefile         |   1 +
>   drivers/soc/mediatek/mmsys/mt8192-mmsys.c   | 182 ++++++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c            |   8 ++
>   include/linux/soc/mediatek/mtk-mmsys.h      |   6 +
>   13 files changed, 623 insertions(+), 13 deletions(-)
>   create mode 100644 drivers/soc/mediatek/mmsys/mt8192-mmsys.c
> 
