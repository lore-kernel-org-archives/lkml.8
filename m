Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927E1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E71C207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592236304;
	bh=7cnR4E7asa1RK9PUH2DYXnuXh4kNAztWrAPs91Uf2zg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qd+eq4NJjzAoB9QyQf1eS+0HKwlJz5N0bjUwjWrc0aVOTckibC+JVWSWCgRPFH9gt
	 r2eMn7MxPX9bYL5cONphCLuV8UeNMfOxnWo0yPeOeAKDlQjOpgoozIk0dv0+W0A40N
	 484QafQQkAa8bXvrcyC2OOHI3zPjijnEMoPuFEWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgFOPvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgFOPvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:51:42 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9D3207DA;
        Mon, 15 Jun 2020 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592236301;
        bh=7cnR4E7asa1RK9PUH2DYXnuXh4kNAztWrAPs91Uf2zg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M9tWDPSyXmVBU/0iTVK5zFYtBmlBVxp0aGi8g0WFUhD9YirPgML5vwZXl6OQaS80E
         eF7Uq4k0+l8G48PHr5XAoMrFjy5j2L7apmEF11W6NhNI4qyblACSDoON/nO/NO9AAA
         cPGTpm28Y0KGeRgTT2fhjsaxOzN1dF3FB+5682XQ=
Received: by mail-ed1-f46.google.com with SMTP id p18so11884311eds.7;
        Mon, 15 Jun 2020 08:51:41 -0700 (PDT)
X-Gm-Message-State: AOAM533sxPyHhphJ2Seszpg0ushL5sc19aV8nZ5eUEwEkMxFGmfDzzL/
        4xfwsRmdSJu/jHcEwlwHEsaSv7mxJJo83MI54A==
X-Google-Smtp-Source: ABdhPJwjNOgOXm2x6DCEIqtw7qCfmjT2LCj7Obv/jiia9ojrOBQU0H3QCrBYoCfJym7Fuo1N/UkczRt+4FIEiGtpnHg=
X-Received: by 2002:a05:6402:22e4:: with SMTP id dn4mr24670457edb.288.1592236300114;
 Mon, 15 Jun 2020 08:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com> <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 15 Jun 2020 23:51:28 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-T7L5Cj3UOXDgwTo7jGw+PbcM9Fyy9StX35PwU533zLQ@mail.gmail.com>
Message-ID: <CAAOTY_-T7L5Cj3UOXDgwTo7jGw+PbcM9Fyy9StX35PwU533zLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=889=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MT6873 bus frabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violations are logged and sent to the processor for
> further analysis or countermeasures.
>
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by devapc-mt6873 driver. The violation
> information is printed in order to find the murderer.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---

[snip]

> +       {1, 0, 22, "MMSYS", true},
> +       {1, 1, 23, "MMSYS_DISP", true},
> +       {1, 2, 24, "SMI", true},
> +       {1, 3, 25, "SMI", true},
> +       {1, 4, 26, "SMI", true},
> +       {1, 5, 27, "MMSYS_DISP", true},
> +       {1, 6, 28, "MMSYS_DISP", true},
> +
> +       /* 30 */
> +       {1, 7, 29, "MMSYS_DISP", true},
> +       {1, 8, 30, "MMSYS_DISP", true},
> +       {1, 9, 31, "MMSYS_DISP", true},
> +       {1, 10, 32, "MMSYS_DISP", true},
> +       {1, 11, 33, "MMSYS_DISP", true},
> +       {1, 12, 34, "MMSYS_DISP", true},
> +       {1, 13, 35, "MMSYS_DISP", true},
> +       {1, 14, 36, "MMSYS_DISP", true},
> +       {1, 15, 37, "MMSYS_DISP", true},
> +       {1, 16, 38, "MMSYS_DISP", true},
> +
> +       /* 40 */
> +       {1, 17, 39, "MMSYS_DISP", true},
> +       {1, 18, 40, "MMSYS_DISP", true},
> +       {1, 19, 41, "MMSYS_DISP", true},
> +       {1, 20, 42, "MMSYS_DISP", true},
> +       {1, 21, 43, "MMSYS_DISP", true},
> +       {1, 22, 44, "MMSYS_DISP", true},

I think the device name, such as "MMSYS_DISP" does not help for debug.
When DevAPC print "MMSYS_DISP" has error, how does us know that to do
next? WHERE is the code may related to this error, and WHO should us
to find help? I think we just need vio address. Using mt8173 for
example, if the vio address is 0x1400d03c, we could find the device in
mt8173.dtsi [1],

ovl1: ovl@1400d000 {
        compatible =3D "mediatek,mt8173-disp-ovl";
        reg =3D <0 0x1400d000 0 0x1000>;
};

we could know error occur in ovl1, and we could find the compatible
string "mediatek,mt8173-disp-ovl" in
drivers/gpu/drm/mediatek/mtk_drm_drv.c, so we know WHERE is the code
may related to this error. And we could find maintainer list [2] to
find out the maintainer of this code:

DRM DRIVERS FOR MEDIATEK
M: Chun-Kuang Hu <chunkuang.hu@kernel.org>
M: Philipp Zabel <p.zabel@pengutronix.de>
L: dri-devel@lists.freedesktop.org
S: Supported
F: Documentation/devicetree/bindings/display/mediatek/
F: drivers/gpu/drm/mediatek/

and we know find WHO for help.
So I think we should drop device name and just print vio address is
enough for debug.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/boot/dts/mediatek/mt8173.dtsi?h=3Dv5.8-rc1
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/MAINTAINERS?h=3Dv5.8-rc1

> +       {1, 23, 45, "MMSYS_MDP", true},
> +       {1, 24, 46, "MMSYS_MDP", true},
> +       {1, 25, 47, "MMSYS_MDP", true},
> +       {1, 26, 48, "MMSYS_MDP", true},
> +

[snip]

> +
> +int mtk_devapc_probe(struct platform_device *pdev, struct mtk_devapc_soc=
 *soc)
> +{
> +       struct device_node *node =3D pdev->dev.of_node;
> +       u32 slave_type_num;
> +       int slave_type;
> +       int ret;
> +
> +       if (IS_ERR(node))
> +               return -ENODEV;
> +
> +       mtk_devapc_ctx->soc =3D soc;
> +       slave_type_num =3D mtk_devapc_ctx->soc->slave_type_num;
> +
> +       for (slave_type =3D 0; slave_type < slave_type_num; slave_type++)=
 {
> +               mtk_devapc_ctx->devapc_pd_base[slave_type] =3D
> +                       of_iomap(node, slave_type);
> +               if (!mtk_devapc_ctx->devapc_pd_base[slave_type])
> +                       return -EINVAL;
> +       }
> +
> +       mtk_devapc_ctx->infracfg_base =3D of_iomap(node, slave_type_num +=
 1);
> +       if (!mtk_devapc_ctx->infracfg_base)
> +               return -EINVAL;
> +
> +       mtk_devapc_ctx->devapc_irq =3D irq_of_parse_and_map(node, 0);
> +       if (!mtk_devapc_ctx->devapc_irq)
> +               return -EINVAL;
> +
> +       /* CCF (Common Clock Framework) */
> +       mtk_devapc_ctx->devapc_infra_clk =3D devm_clk_get(&pdev->dev,
> +                                                       "devapc-infra-clo=
ck");
> +
> +       if (IS_ERR(mtk_devapc_ctx->devapc_infra_clk))
> +               return -EINVAL;
> +
> +       proc_create("devapc_dbg", 0664, NULL, &devapc_dbg_fops);

I think debugfs is not a basic function, so move debugfs function to
another patch.

Regards,
Chun-Kuang.

> +
> +       if (clk_prepare_enable(mtk_devapc_ctx->devapc_infra_clk))
> +               return -EINVAL;
> +
> +       start_devapc();
> +
> +       ret =3D devm_request_irq(&pdev->dev, mtk_devapc_ctx->devapc_irq,
> +                              (irq_handler_t)devapc_violation_irq,
> +                              IRQF_TRIGGER_NONE, "devapc", NULL);
> +       if (ret) {
> +               pr_err(PFX "request devapc irq failed, ret:%d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_devapc_probe);
> +
>
