Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D579CC2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3BE2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEzpxnaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgDMMTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728344AbgDMMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:19:43 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 08:19:42 EDT
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794AC03BC80;
        Mon, 13 Apr 2020 05:11:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h2so9096521wmb.4;
        Mon, 13 Apr 2020 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDwufY0StyILZp3PnMldwC+D1HdNes1kw0On06OjlNc=;
        b=QEzpxnaj561i77JZ7ZNh0LM/iLxJwlEiaDrn7dsRcTFkvaNFGcumBPUMQd05Ux0BYK
         F/LQz2RoIXPuCmlpR76yCbRN9I70l2370ijzF+kRxy9jalAJyGuw8oRjzV4dq6/WfQLA
         1b6dQQ6pHi4qr7xjcNZCPjIj9RwKCkhvRK2pG3DCLjtXA10xkqEBk2uXl3VuYdsFYv2c
         0SBzg344UBOVx8gVqvNXNFcHm3KwQz3sfbJCw/Xn2MhLH39M8TPPW92ksyfb0E6ZJnC+
         P6r4CBTAipE7aAh8117KNByDS8XzKiQ8VVF3+dlC6uAtij0JqI6dA3PtcT4d8n1vCPiH
         DRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDwufY0StyILZp3PnMldwC+D1HdNes1kw0On06OjlNc=;
        b=GqCJPp1Uyp31UWUX1Ujby/AFQT8wcm76JbtWKIcQN7Cm1myQknQJKiH0xzpMyXuDsu
         U1xVM1UqrmAES1PSB6vASwBISVEqb7jdyP1DYwIC1pVkHMNhYrKvElPhUMgmO17asG4n
         Y9vwZs5MTUiJKDJAjJMiTZUkhNzr36T1FuH/g0T9mX93qlE3a8lldSRk/L36yEyIeaAl
         13PwbhvlumvNZaUfTGnWTDQZ3R2wGsa/+RMDQa+wHPkF7MiWS3JX7M3WrkJ4qpJlTMn7
         PQ72wMvVYR9GKLEfULyn+mQgXBOU+1wnQUgVtMcjFf99ol6rSLw6BFxqziOVyxU/Y8kN
         HoSw==
X-Gm-Message-State: AGi0PuYpUDYJoMztYHAQNJ+4x73XRrSNK/poWo9JNPnwfWZo+IPREzdL
        H8Ixean4+cIpqMRWZzBZBmWSDJbYyZ4=
X-Google-Smtp-Source: APiQypJQ7DrprTjeXvq8sveC8OXT02qGyxyLpRoUKZrLIBevOvVFkBeHAB/K6XO4aeY6ZcAxdyiibQ==
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr19342632wmj.95.1586779863908;
        Mon, 13 Apr 2020 05:11:03 -0700 (PDT)
Received: from linux-gy6r.site ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id p16sm8136294wro.21.2020.04.13.05.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 05:11:03 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: mt8173: Add gce setting in mmsys and
 display node
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20200409055012.199320-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
X-Pep-Version: 2.0
Message-ID: <032911c9-ba57-4586-969b-90358be19a10@gmail.com>
Date:   Mon, 13 Apr 2020 14:11:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409055012.199320-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/20 7:50 AM, Hsin-Yi Wang wrote:
> In order to use GCE function, we need add some informations
> into display node (mboxes, mediatek,gce-client-reg, mediatek,gce-events=
).
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---

Applied to v5.7-next/dts64

Thanks!

> change log:
> v1->v2: align with
> 19d8e335d58a ("dt-binding: gce: remove atomic_exec in mboxes property")=

> 60fa8c13ab1a ("drm/mediatek: Move gce event property to mutex device no=
de")
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8173.dtsi
> index ccb8e88a60c5..8337ba42845d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -549,7 +549,7 @@ gce: mailbox@10212000 {
>  			interrupts =3D <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
>  			clocks =3D <&infracfg CLK_INFRA_GCE>;
>  			clock-names =3D "gce";
> -			#mbox-cells =3D <3>;
> +			#mbox-cells =3D <2>;
>  		};
> =20
>  		mipi_tx0: mipi-dphy@10215000 {
> @@ -916,6 +916,9 @@ mmsys: clock-controller@14000000 {
>  			assigned-clocks =3D <&topckgen CLK_TOP_MM_SEL>;
>  			assigned-clock-rates =3D <400000000>;
>  			#clock-cells =3D <1>;
> +			mboxes =3D <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX 0 0x1000>;
>  		};
> =20
>  		mdp_rdma0: rdma@14001000 {
> @@ -996,6 +999,7 @@ ovl0: ovl@1400c000 {
>  			clocks =3D <&mmsys CLK_MM_DISP_OVL0>;
>  			iommus =3D <&iommu M4U_PORT_DISP_OVL0>;
>  			mediatek,larb =3D <&larb0>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
>  		};
> =20
>  		ovl1: ovl@1400d000 {
> @@ -1006,6 +1010,7 @@ ovl1: ovl@1400d000 {
>  			clocks =3D <&mmsys CLK_MM_DISP_OVL1>;
>  			iommus =3D <&iommu M4U_PORT_DISP_OVL1>;
>  			mediatek,larb =3D <&larb4>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
>  		};
> =20
>  		rdma0: rdma@1400e000 {
> @@ -1016,6 +1021,7 @@ rdma0: rdma@1400e000 {
>  			clocks =3D <&mmsys CLK_MM_DISP_RDMA0>;
>  			iommus =3D <&iommu M4U_PORT_DISP_RDMA0>;
>  			mediatek,larb =3D <&larb0>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
>  		};
> =20
>  		rdma1: rdma@1400f000 {
> @@ -1026,6 +1032,7 @@ rdma1: rdma@1400f000 {
>  			clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
>  			iommus =3D <&iommu M4U_PORT_DISP_RDMA1>;
>  			mediatek,larb =3D <&larb4>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
>  		};
> =20
>  		rdma2: rdma@14010000 {
> @@ -1036,6 +1043,7 @@ rdma2: rdma@14010000 {
>  			clocks =3D <&mmsys CLK_MM_DISP_RDMA2>;
>  			iommus =3D <&iommu M4U_PORT_DISP_RDMA2>;
>  			mediatek,larb =3D <&larb4>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX 0 0x1000>;
>  		};
> =20
>  		wdma0: wdma@14011000 {
> @@ -1046,6 +1054,7 @@ wdma0: wdma@14011000 {
>  			clocks =3D <&mmsys CLK_MM_DISP_WDMA0>;
>  			iommus =3D <&iommu M4U_PORT_DISP_WDMA0>;
>  			mediatek,larb =3D <&larb0>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
>  		};
> =20
>  		wdma1: wdma@14012000 {
> @@ -1056,6 +1065,7 @@ wdma1: wdma@14012000 {
>  			clocks =3D <&mmsys CLK_MM_DISP_WDMA1>;
>  			iommus =3D <&iommu M4U_PORT_DISP_WDMA1>;
>  			mediatek,larb =3D <&larb4>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
>  		};
> =20
>  		color0: color@14013000 {
> @@ -1064,6 +1074,7 @@ color0: color@14013000 {
>  			interrupts =3D <GIC_SPI 187 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
>  			clocks =3D <&mmsys CLK_MM_DISP_COLOR0>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX 0x3000 0x1000>;
>  		};
> =20
>  		color1: color@14014000 {
> @@ -1072,6 +1083,7 @@ color1: color@14014000 {
>  			interrupts =3D <GIC_SPI 188 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
>  			clocks =3D <&mmsys CLK_MM_DISP_COLOR1>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
>  		};
> =20
>  		aal@14015000 {
> @@ -1080,6 +1092,7 @@ aal@14015000 {
>  			interrupts =3D <GIC_SPI 189 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
>  			clocks =3D <&mmsys CLK_MM_DISP_AAL>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
>  		};
> =20
>  		gamma@14016000 {
> @@ -1088,6 +1101,7 @@ gamma@14016000 {
>  			interrupts =3D <GIC_SPI 190 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
>  			clocks =3D <&mmsys CLK_MM_DISP_GAMMA>;
> +			mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX 0x6000 0x1000>;
>  		};
> =20
>  		merge@14017000 {
> @@ -1193,6 +1207,8 @@ mutex: mutex@14020000 {
>  			interrupts =3D <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
>  			clocks =3D <&mmsys CLK_MM_MUTEX_32K>;
> +			mediatek,gce-events =3D <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
> +                                              <CMDQ_EVENT_MUTEX1_STREA=
M_EOF>;
>  		};
> =20
>  		larb0: larb@14021000 {
>=20

