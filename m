Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E736CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0CB2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592105233;
	bh=qvlEooqb/QRVp+lH3E3ELUViJHiT65J+THRseprWAaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZsdzLtwl4+nHGMrP2IrlY8QDRHc0+T+4A89/zvZEesA+9Sk1N0lGUrla8cGpx8zW2
	 w3xsm2mItWKEUU2/yF/A1sTyfL7v6cY2Ta8aTVmi89Q5dyK24rm6Y5mMg09rQ3/dAu
	 K6JxMosoTjAaPp7IqLuEwtb9fYxsLx8zUxpow4kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgFND0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 23:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgFND0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 23:26:35 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56643207BC;
        Sun, 14 Jun 2020 03:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592105194;
        bh=qvlEooqb/QRVp+lH3E3ELUViJHiT65J+THRseprWAaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eon4nXGoInfcbJ2DApkv30ONI4y4tgc3ZVBLeJJML95S9RcnB4CcVgCsDPZsiO5Xr
         noJ8CfgAeox5VQ+EtJ4FKFzDc5fX9tTir0Lpl+5YOo6DQruoPTYkBScuUHbGNxM0j9
         uRgY3SvxlXhN8E5VDYbK9NfGn5tzzEz4C170TxnA=
Received: by mail-ej1-f41.google.com with SMTP id x1so13884458ejd.8;
        Sat, 13 Jun 2020 20:26:34 -0700 (PDT)
X-Gm-Message-State: AOAM5317Ug04ZF/jKUoJGGpNrywn2EJ2aZTpGItvFXHyCufqYSOGlv0T
        b09DESZ65pWGVY5/OVfgp3l/tE4CgEXpTVEqeA==
X-Google-Smtp-Source: ABdhPJygZ7+s9E2uvJLRmzF/ZlQdQNkUgdnyD0VfMuR6Y68ATgx7MtpXGPqODUSOl8hq5eaKX9phvJjtfPuGGjD6oXA=
X-Received: by 2002:a17:906:7696:: with SMTP id o22mr19140394ejm.245.1592105192907;
 Sat, 13 Jun 2020 20:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com> <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 14 Jun 2020 11:26:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8W7FLrjKbNt+WHXjsBzgn_E7n5stKjv94RBnF7ktVuiA@mail.gmail.com>
Message-ID: <CAAOTY_8W7FLrjKbNt+WHXjsBzgn_E7n5stKjv94RBnF7ktVuiA@mail.gmail.com>
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

> +
> +       /* 50 */
> +       {-1, -1, 50, "OOB_way_en", true},
> +       {-1, -1, 51, "OOB_way_en", true},
> +       {-1, -1, 52, "OOB_way_en", true},
> +       {-1, -1, 53, "OOB_way_en", true},
> +       {-1, -1, 54, "OOB_way_en", true},
> +       {-1, -1, 55, "OOB_way_en", true},
> +       {-1, -1, 56, "Decode_error", true},
> +       {-1, -1, 57, "Decode_error", true},
> +       {-1, -1, 58, "DISP_PWM", false},
> +       {-1, -1, 59, "IMP_IIC_WRAP", false},
> +
> +       /* 60 */
> +       {-1, -1, 60, "DEVICE_APC_PERI_PAR__AO", false},
> +       {-1, -1, 61, "DEVICE_APC_PERI_PAR_PDN", false},

You does not process the item whose enable_vio_irq is false, so I
think you should remove these items and remove enable_vio_irq because
the rest item's enable_vio_irq would always be true.

> +};
> +
> +static struct mtk_device_num mtk6873_devices_num[] =3D {
> +       {SLAVE_TYPE_INFRA, VIO_SLAVE_NUM_INFRA},
> +       {SLAVE_TYPE_PERI, VIO_SLAVE_NUM_PERI},
> +       {SLAVE_TYPE_PERI2, VIO_SLAVE_NUM_PERI2},
> +       {SLAVE_TYPE_PERI_PAR, VIO_SLAVE_NUM_PERI_PAR},
> +};
> +
> +static struct PERIAXI_ID_INFO peri_mi_id_to_master[] =3D {
> +       {"THERM2",       { 0, 0, 0 } },
> +       {"SPM",          { 0, 1, 0 } },
> +       {"CCU",          { 0, 0, 1 } },
> +       {"THERM",        { 0, 1, 1 } },
> +       {"SPM_DRAMC",    { 1, 1, 0 } },

The bits { 1, 1, 0 } equal to a number 0x3, I thiink you should use a
number instead of bits and everything would be more easy.

> +};
> +

[snip]

> +
> +/*
> + * mtk_devapc_vio_check - check violation shift status is raised or not.
> + *
> + * Returns the value of violation shift status reg
> + */
> +static void mtk_devapc_vio_check(int slave_type, int *shift_bit)
> +{
> +       u32 slave_type_num =3D mtk_devapc_ctx->soc->slave_type_num;
> +       struct mtk_devapc_vio_info *vio_info;
> +       u32 vio_shift_sta;
> +       int i;
> +
> +       if (slave_type >=3D slave_type_num) {

This never happen, so remove it.

> +               pr_err(PFX "%s: param check failed, %s:0x%x\n",
> +                      __func__, "slave_type", slave_type);
> +               return;
> +       }
> +
> +       vio_info =3D mtk_devapc_ctx->soc->vio_info;
> +       vio_shift_sta =3D readl(mtk_devapc_pd_get(slave_type, VIO_SHIFT_S=
TA, 0));
> +
> +       if (!vio_shift_sta) {
> +               pr_info(PFX "violation is triggered before. %s:0x%x\n",
> +                       "shift_bit", *shift_bit);
> +
> +       } else if (vio_shift_sta & (0x1UL << *shift_bit)) {
> +               pr_debug(PFX "%s: 0x%x is matched with %s:%d\n",
> +                        "vio_shift_sta", vio_shift_sta,
> +                        "shift_bit", *shift_bit);
> +
> +       } else {
> +               pr_info(PFX "%s: 0x%x is not matched with %s:%d\n",
> +                       "vio_shift_sta", vio_shift_sta,
> +                       "shift_bit", *shift_bit);
> +
> +               for (i =3D 0; i < MOD_NO_IN_1_DEVAPC * 2; i++) {
> +                       if (vio_shift_sta & (0x1 << i)) {
> +                               *shift_bit =3D i;
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       vio_info->shift_sta_bit =3D *shift_bit;
> +}
> +
> +static void devapc_extract_vio_dbg(int slave_type)
> +{
> +       u32 slave_type_num =3D mtk_devapc_ctx->soc->slave_type_num;
> +       void __iomem *vio_dbg0_reg, *vio_dbg1_reg, *vio_dbg2_reg;
> +       const struct mtk_infra_vio_dbg_desc *vio_dbgs;
> +       struct mtk_devapc_vio_info *vio_info;
> +       u32 dbg0;
> +
> +       if (slave_type >=3D slave_type_num) {

Ditto.

Regards,
Chun-Kuang.

> +               pr_err(PFX "%s: param check failed, %s:0x%x\n",
> +                      __func__, "slave_type", slave_type);
> +               return;
> +       }
> +
> +       vio_dbg0_reg =3D mtk_devapc_pd_get(slave_type, VIO_DBG0, 0);
> +       vio_dbg1_reg =3D mtk_devapc_pd_get(slave_type, VIO_DBG1, 0);
> +       vio_dbg2_reg =3D mtk_devapc_pd_get(slave_type, VIO_DBG2, 0);
> +
> +       vio_dbgs =3D mtk_devapc_ctx->soc->vio_dbgs;
> +       vio_info =3D mtk_devapc_ctx->soc->vio_info;
> +
> +       /* Extract violation information */
> +       dbg0 =3D readl(vio_dbg0_reg);
> +       vio_info->master_id =3D readl(vio_dbg1_reg);
> +       vio_info->vio_addr =3D readl(vio_dbg2_reg);
> +
> +       vio_info->domain_id =3D (dbg0 & vio_dbgs->vio_dbg_dmnid)
> +               >> vio_dbgs->vio_dbg_dmnid_start_bit;
> +       vio_info->write =3D ((dbg0 & vio_dbgs->vio_dbg_w_vio)
> +                       >> vio_dbgs->vio_dbg_w_vio_start_bit) =3D=3D 1;
> +       vio_info->read =3D ((dbg0 & vio_dbgs->vio_dbg_r_vio)
> +                       >> vio_dbgs->vio_dbg_r_vio_start_bit) =3D=3D 1;
> +       vio_info->vio_addr_high =3D (dbg0 & vio_dbgs->vio_addr_high)
> +               >> vio_dbgs->vio_addr_high_start_bit;
> +
> +       devapc_vio_info_print();
> +}
> +
> +/*
