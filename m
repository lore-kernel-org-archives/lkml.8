Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542C620674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5mH74j0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgGMFhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgGMFhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:37:22 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF1C08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:37:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id h28so11662340edz.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZ9NBtGhK+C5WPxWTTuXRE71ybFquUFtwgSFUSFj0PQ=;
        b=I5mH74j0x33+O0sPgotD8Ov+x9JEj3hMbYPLIByQegEOBjPBM32K858i9rvObt+Sh/
         ocvxgOpfDHSlT2f0SKViMGJgJmwBjhMeEx2X7/DyjvXhGxiQnsOogzSeGX8zdJiObqsC
         QjQN1y7TIoO0kt9LD+VH9awYEsgIzvu62leLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZ9NBtGhK+C5WPxWTTuXRE71ybFquUFtwgSFUSFj0PQ=;
        b=OeBjZ09Mimf0XofXSRoJ7Qhz4CzNO21KBhtSQ38TmlVQRmIub0SF64FPTRwvv3W8PH
         rgk56crS2P8VLIpgViy9bmsQbX0346fif6ijHRhpFTVHshymfB0tfaNSNcLUJLcr2W/9
         ZlPQJs/ts1lWCQV/ax+8SqW3hZEhEsLKmlFQkWT2iD28iRoltQfdrKfFqqO7uuqqA6WD
         Zi36mt0/b1T5ZZUrxX0CMvOBhjQLf9JK/bltVK6jW+d8Bbk7pwr4hzTo6dcOao1BvRKN
         3BrP/BAI2cC+HtPbElPUS2GECdPXy018WMQ0GVt/+1arO3zbwLJkhVazhgommNSqa4Or
         v0DA==
X-Gm-Message-State: AOAM532FKV4jbprMI/uFRdzqwdxRMwf0CbDPGNyJYg9e1G7IF3wMmK34
        W8AmwuENzVaf2J89w1+ZjgOd3j7bGZWVgJ2OQUAqWg==
X-Google-Smtp-Source: ABdhPJyYL23ot1CCgoFjUvfVTWVGWF6IlrkvQ5vJIbi1guEyZhVmenhpfLkf8+Ge8qIDirvrFYO43Tu8N+jHK5yWE5A=
X-Received: by 2002:a50:d908:: with SMTP id t8mr35579891edj.373.1594618640938;
 Sun, 12 Jul 2020 22:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200711064846.16007-1-yong.wu@mediatek.com> <20200711064846.16007-5-yong.wu@mediatek.com>
In-Reply-To: <20200711064846.16007-5-yong.wu@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 13 Jul 2020 13:36:45 +0800
Message-ID: <CANdKZ0cGNy7ckzD_NAOV613o62WHdYazRRM-J8jY2-4mx_sNDA@mail.gmail.com>
Subject: Re: [PATCH 04/21] dt-binding: mediatek: Add binding for mt8192 IOMMU
 and SMI
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 2:50 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> This patch adds decriptions for mt8192 IOMMU and SMI.
>
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
>
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
>
> All the connections are HW fixed, SW can NOT adjust it.
>
> mt8192 M4U support 0~16GB iova range. we preassign different engines
> into different iova ranges:
>
> domain-id  module     iova-range                  larbs
>    0       disp        0 ~ 4G                      larb0/1
>    1       vcodec      4G ~ 8G                     larb4/5/7
>    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
>    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
>
> The iova range for CCU0/1(camera control unit) is HW requirement.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.txt         |   8 +-
>  .../mediatek,smi-common.txt                   |   5 +-
>  .../memory-controllers/mediatek,smi-larb.txt  |   3 +-
>  include/dt-bindings/memory/mt8192-larb-port.h | 237 ++++++++++++++++++
>  4 files changed, 247 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> ...
> diff --git a/include/dt-bindings/memory/mt8192-larb-port.h b/include/dt-bindings/memory/mt8192-larb-port.h
> new file mode 100644
> index 000000000000..fbe0d5d50f1c
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8192-larb-port.h
> ...
> +/* larb7 */
> +#define M4U_PORT_L7_VENC_RCPU                  MTK_M4U_DOM_ID(1, 7, 0)
> +#define M4U_PORT_L7_VENC_REC                   MTK_M4U_DOM_ID(1, 7, 1)
> +#define M4U_PORT_L7_VENC_BSDMA                 MTK_M4U_DOM_ID(1, 7, 2)
> +#define M4U_PORT_L7_VENC_SV_COMV               MTK_M4U_DOM_ID(1, 7, 3)
> +#define M4U_PORT_L7_VENC_RD_COMV               MTK_M4U_DOM_ID(1, 7, 4)
> +#define M4U_PORT_L7_VENC_CUR_LUMA              MTK_M4U_DOM_ID(1, 7, 5)
> +#define M4U_PORT_L7_VENC_CUR_CHROMA            MTK_M4U_DOM_ID(1, 7, 6)
> +#define M4U_PORT_L7_VENC_REF_LUMA              MTK_M4U_DOM_ID(1, 7, 7)
> +#define M4U_PORT_L7_VENC_REF_CHROMA            MTK_M4U_DOM_ID(1, 7, 8)
> +#define M4U_PORT_L7_JPGENC_Y_RDMA              MTK_M4U_DOM_ID(1, 7, 9)
> +#define M4U_PORT_L7_JPGENC_Q_RDMA              MTK_M4U_DOM_ID(1, 7, 10)
> +#define M4U_PORT_L7_JPGENC_C_TABLE             MTK_M4U_DOM_ID(1, 7, 11)
> +#define M4U_PORT_L7_JPGENC_BSDMA               MTK_M4U_DOM_ID(1, 7, 12)
> +#define M4U_PORT_L7_VENC_SUB_R_LUMA            MTK_M4U_DOM_ID(1, 7, 13)
> +#define M4U_PORT_L7_VENC_SUB_W_LUMA            MTK_M4U_DOM_ID(1, 7, 14)
> +

Small nit, /* larb8: null */ is missing here.

> +/* larb9 */
> +#define M4U_PORT_L9_IMG_IMGI_D1                        MTK_M4U_DOM_ID(2, 9, 0)
> +#define M4U_PORT_L9_IMG_IMGBI_D1               MTK_M4U_DOM_ID(2, 9, 1)
> +#define M4U_PORT_L9_IMG_DMGI_D1                        MTK_M4U_DOM_ID(2, 9, 2)
> +#define M4U_PORT_L9_IMG_DEPI_D1                        MTK_M4U_DOM_ID(2, 9, 3)
> +#define M4U_PORT_L9_IMG_ICE_D1                 MTK_M4U_DOM_ID(2, 9, 4)
> +#define M4U_PORT_L9_IMG_SMTI_D1                        MTK_M4U_DOM_ID(2, 9, 5)
> +#define M4U_PORT_L9_IMG_SMTO_D2                        MTK_M4U_DOM_ID(2, 9, 6)
> +#define M4U_PORT_L9_IMG_SMTO_D1                        MTK_M4U_DOM_ID(2, 9, 7)
> +#define M4U_PORT_L9_IMG_CRZO_D1                        MTK_M4U_DOM_ID(2, 9, 8)
> +#define M4U_PORT_L9_IMG_IMG3O_D1               MTK_M4U_DOM_ID(2, 9, 9)
> +#define M4U_PORT_L9_IMG_VIPI_D1                        MTK_M4U_DOM_ID(2, 9, 10)
> +#define M4U_PORT_L9_IMG_SMTI_D5                        MTK_M4U_DOM_ID(2, 9, 11)
> +#define M4U_PORT_L9_IMG_TIMGO_D1               MTK_M4U_DOM_ID(2, 9, 12)
> +#define M4U_PORT_L9_IMG_UFBC_W0                        MTK_M4U_DOM_ID(2, 9, 13)
> +#define M4U_PORT_L9_IMG_UFBC_R0                        MTK_M4U_DOM_ID(2, 9, 14)
> +
> ...
