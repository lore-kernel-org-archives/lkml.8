Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4C8C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C42C20730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjG3bXlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgDHPs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40814 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgDHPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:48:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id z15so599275qki.7;
        Wed, 08 Apr 2020 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+eGFsLGGWL0hFZoo3T4TQK9gJ4JHOSPbWbKxqCC7yc=;
        b=fjG3bXlOYQCEmTAhE3aDsX6GZwLes9ZflbLRHjwVFdgrveZ3HnI+b6RJBkuoDANCdj
         ZHulRjlfPetgLiQ8wTg7fsvhL49fIvhhhMC9x8t7sbB7KbKzf3d3MIbo+oNoBhW0a3PR
         s/IzUrBYCQRKSsl9hWq70bNlyV8qVDa8hQaAZSuEMyZiWeZBKL2gyF30vCK/Upwrif2D
         D0ZoaaiJCJ9xOgC9SUhk2m8AogAYKfvuEqJcwUlHnah9TBoSsgsgrxdH1dqmTa+MMwPG
         Zza8FsyB6tJQe4SL1NmRZ8eM1ybf16RTOck6iluSQIMDTkDdGnFZ7ED4SXZpuVKjbN/t
         5cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+eGFsLGGWL0hFZoo3T4TQK9gJ4JHOSPbWbKxqCC7yc=;
        b=Nn8sGQYmpMtaRmp3WiJNH8vhIQjXf2UGkL7ljnSwZ2BPraHXMp30vY+jLUbz7Dmnt0
         pVGKcx2YT1DaWMzUXLqyXDYuhCg94MzgfEUiaHlnUFOJmGWBfemHqyxIkT3nfKwwV7Ix
         kcWX8DFhsGjCEFeCUiJtXVpb/ZgcnXNPkpl4ZZVLnU5gB4ww2WWJaqn9lNzisYZm4ogz
         YVghbqteGMiuBsL0OQ2f7rEEi1VRPhkLEgzPZy53/7Yv4ZiqH5nIR9wLTJTswmVfGzKY
         9bKklkb9FKD2Nhg77xExiUEaYaFJd+AADaJuCatNTMuaCewlV+BD4SaPKpg9rqygFpFO
         XuGQ==
X-Gm-Message-State: AGi0PubNcJsTzrNeTEDDuYhOnd7uh7oWoRAAUEdWLjQyIRFQcgErVWZP
        myUYJyyYHTBUWEiVO6zKrASDNfPr7M0DrWQ05b8=
X-Google-Smtp-Source: APiQypJfn2wnXFL9j9EyznimHBwrBbDfxxbx3yC43znzRXh7g8S7mBwYqGH4WtP2+jqGLilI9BccVEwBZMw+aO7/ff8=
X-Received: by 2002:a37:6c81:: with SMTP id h123mr8156567qkc.290.1586360904353;
 Wed, 08 Apr 2020 08:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191118104252.228406-1-hsinyi@chromium.org>
In-Reply-To: <20191118104252.228406-1-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 8 Apr 2020 17:48:12 +0200
Message-ID: <CAFqH_528vidMhTFxNZ=b7SFD2K12UwtdX3uTUzW4YUgeDWkg5A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173: Add gce setting in mmsys and display node
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 18 de nov.
2019 a les 11:43:
>
> In order to use GCE function, we need add some informations
> into display node (mboxes, mediatek,gce-client-reg, mediatek,gce-events).
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

With the fix provided by Hsin-Yi [1] and after the mmsys patches
landed I get GCE function working on mt8173, so

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[1] https://lore.kernel.org/lkml/20200406051131.225748-1-hsinyi@chromium.org/

Thanks,
 Enric

> ---
> - This is based on series "support gce on mt8183 platform"
>   https://patchwork.kernel.org/cover/11208309/
> - gce setting in 8183:
>   https://patchwork.kernel.org/patch/11127105/
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 15f1842f6df3..e84ec3f95d81 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -911,6 +911,11 @@ mmsys: clock-controller@14000000 {
>                         assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
>                         assigned-clock-rates = <400000000>;
>                         #clock-cells = <1>;
> +                       mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
> +                                <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
> +                       mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
> +                                             <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
>                 };
>
>                 mdp_rdma0: rdma@14001000 {
> @@ -991,6 +996,7 @@ ovl0: ovl@1400c000 {
>                         clocks = <&mmsys CLK_MM_DISP_OVL0>;
>                         iommus = <&iommu M4U_PORT_DISP_OVL0>;
>                         mediatek,larb = <&larb0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
>                 };
>
>                 ovl1: ovl@1400d000 {
> @@ -1001,6 +1007,7 @@ ovl1: ovl@1400d000 {
>                         clocks = <&mmsys CLK_MM_DISP_OVL1>;
>                         iommus = <&iommu M4U_PORT_DISP_OVL1>;
>                         mediatek,larb = <&larb4>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
>                 };
>
>                 rdma0: rdma@1400e000 {
> @@ -1011,6 +1018,7 @@ rdma0: rdma@1400e000 {
>                         clocks = <&mmsys CLK_MM_DISP_RDMA0>;
>                         iommus = <&iommu M4U_PORT_DISP_RDMA0>;
>                         mediatek,larb = <&larb0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
>                 };
>
>                 rdma1: rdma@1400f000 {
> @@ -1021,6 +1029,7 @@ rdma1: rdma@1400f000 {
>                         clocks = <&mmsys CLK_MM_DISP_RDMA1>;
>                         iommus = <&iommu M4U_PORT_DISP_RDMA1>;
>                         mediatek,larb = <&larb4>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
>                 };
>
>                 rdma2: rdma@14010000 {
> @@ -1031,6 +1040,7 @@ rdma2: rdma@14010000 {
>                         clocks = <&mmsys CLK_MM_DISP_RDMA2>;
>                         iommus = <&iommu M4U_PORT_DISP_RDMA2>;
>                         mediatek,larb = <&larb4>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0 0x1000>;
>                 };
>
>                 wdma0: wdma@14011000 {
> @@ -1041,6 +1051,7 @@ wdma0: wdma@14011000 {
>                         clocks = <&mmsys CLK_MM_DISP_WDMA0>;
>                         iommus = <&iommu M4U_PORT_DISP_WDMA0>;
>                         mediatek,larb = <&larb0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
>                 };
>
>                 wdma1: wdma@14012000 {
> @@ -1051,6 +1062,7 @@ wdma1: wdma@14012000 {
>                         clocks = <&mmsys CLK_MM_DISP_WDMA1>;
>                         iommus = <&iommu M4U_PORT_DISP_WDMA1>;
>                         mediatek,larb = <&larb4>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
>                 };
>
>                 color0: color@14013000 {
> @@ -1059,6 +1071,7 @@ color0: color@14013000 {
>                         interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>                         clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x3000 0x1000>;
>                 };
>
>                 color1: color@14014000 {
> @@ -1067,6 +1080,7 @@ color1: color@14014000 {
>                         interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>                         clocks = <&mmsys CLK_MM_DISP_COLOR1>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
>                 };
>
>                 aal@14015000 {
> @@ -1075,6 +1089,7 @@ aal@14015000 {
>                         interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>                         clocks = <&mmsys CLK_MM_DISP_AAL>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
>                 };
>
>                 gamma@14016000 {
> @@ -1083,6 +1098,7 @@ gamma@14016000 {
>                         interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>                         clocks = <&mmsys CLK_MM_DISP_GAMMA>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x6000 0x1000>;
>                 };
>
>                 merge@14017000 {
> --
> 2.24.0.432.g9d3f5f5b63-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
