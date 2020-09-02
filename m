Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E92C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B962068E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RSQpFEpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIBBBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBBBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:01:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE0C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 18:01:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so1882036pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 18:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=UkJgTeg3xfjSFnYzyJfxJmqcdiGNUGU/6zuk7GQcL+w=;
        b=RSQpFEpeUTFjUHfqOy3hNsGVuRCN1Br+mW98SqxNyQEBGxySCXth9vsXYTA864H8eW
         HwpCVrmLIa5NlwaOY4X9YrYGG7Pa8v64judysHn7cii8Cz0ZZxSs0HnYuMcMKaHI1gPt
         iN+DDROXCuDz2ZRtAcjMpsLadDRSrzde6lC0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=UkJgTeg3xfjSFnYzyJfxJmqcdiGNUGU/6zuk7GQcL+w=;
        b=qZ7SVntXviorWVJmpJOYTk13GmzcHiiWyYyed7uxKv6PufFIrgW4V2kr037kt4evEv
         nD8E5Pv2m8iYxGssQB2C9m4NSvlV+4CzvcMj7OPTtc9dH8ECNvIIvfhKOd1B3qc7Uugn
         u3wIhoS2fzED1nGdp872EQZn7zTpxissrRtqbnPyYIspA+OL4jTlREy0ORM7AityoQW7
         k7G4xzr8G1y0VC86Ka+abGPrhmAbQbD5EvS8K+X+XJ5OCmf2TeiXwJzwvBp3mAvfVRks
         Hyz+WjYJEJ1mepSwvfzq9iuvbh98eNyaWqrQarw76LG3GtM9WF+bTXAaG6DWNYkJZq5j
         j5Rw==
X-Gm-Message-State: AOAM531E1DvHW5u0+EJeM7tDYyDp811NINCAzSOwt7QbFuito7Ijt2Gx
        U+fYHB1jV//J9nkmU7PkwU5dVf59kbafwQ==
X-Google-Smtp-Source: ABdhPJy7coz3C3VkEiPsuD+kMVsbJIuPu6/VEEWYIGA0BWBKTOEU3fATCtPBaO5QrFWvADMduuQPJA==
X-Received: by 2002:a62:1c4c:: with SMTP id c73mr907547pfc.124.1599008473026;
        Tue, 01 Sep 2020 18:01:13 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id q34sm3328712pgl.28.2020.09.01.18.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 18:01:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <335a0660-40e1-0c1e-3f7d-87f7024de18a@linaro.org>
References: <20200826024711.220080-1-swboyd@chromium.org> <20200826024711.220080-7-swboyd@chromium.org> <335a0660-40e1-0c1e-3f7d-87f7024de18a@linaro.org>
Subject: Re: [PATCH v1 6/9] phy: qcom-qmp: Add support for DP in USB3+DP combo phy
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@chromium.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Date:   Tue, 01 Sep 2020 18:01:10 -0700
Message-ID: <159900847014.334488.14041376759905055412@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2020-09-01 06:36:34)
> On 26/08/2020 05:47, Stephen Boyd wrote:
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm=
/phy-qcom-qmp.c
> > index 76d7a9e80f04..dd77c7dfa310 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > @@ -947,6 +947,130 @@ static const struct qmp_phy_init_tbl qmp_v3_usb3_=
tx_tbl[] =3D {
> >       QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x06),
> >   };
> >  =20
>=20
> I'd suggest to split common part of the following tables into=20
> dpphy_cfg->serdes_tbl and add the rest as "addon tables"=20
> (serdes_tbl_rbr, serdes_rbl_hbr/2/3) into the same dpphy_cfg.
> It would ease V4 QMP DP PHY support.

Ok. I tried to avoid doing that initially in case something is wrong
from the copy over from the DP driver. Also it means the sequence of
writes is different order but I don't think that matters.

>=20
> > +static const struct qmp_phy_init_tbl qmp_v3_dp_serdes_tbl_rbr[] =3D {
> > +     QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x01),
> > +     QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0x37),
> > +     QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
> > +     QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_ENABLE1, 0x0e),
> > +     QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_BUF_ENABLE, 0x06),
> > +     QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
> > +     QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x02),
> > +     QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x0c),
[...]
> > @@ -2475,6 +2613,329 @@ static void qcom_qmp_phy_configure(void __iomem=
 *base,
> >       qcom_qmp_phy_configure_lane(base, regs, tbl, num, 0xff);
> >   }
> >  =20
> > +static int qcom_qmp_phy_serdes_init(struct qmp_phy *qphy)
> > +{
> > +     struct qcom_qmp *qmp =3D qphy->qmp;
> > +     const struct qmp_phy_cfg *cfg =3D qphy->cfg;
> > +     void __iomem *serdes =3D qphy->serdes;
> > +     const struct phy_configure_opts_dp *dp_opts =3D &qphy->dp_opts;
> > +     const struct qmp_phy_init_tbl *serdes_tbl;
> > +     int serdes_tbl_num;
> > +     int ret;
> > +
> > +     if (cfg->type =3D=3D PHY_TYPE_DP) {
> > +             switch (dp_opts->link_rate) {
> > +             case 1620:
> > +                     serdes_tbl =3D qmp_v3_dp_serdes_tbl_rbr;
> > +                     serdes_tbl_num =3D ARRAY_SIZE(qmp_v3_dp_serdes_tb=
l_rbr);
> > +                     break;
> > +             case 2700:
> > +                     serdes_tbl =3D qmp_v3_dp_serdes_tbl_hbr;
> > +                     serdes_tbl_num =3D ARRAY_SIZE(qmp_v3_dp_serdes_tb=
l_hbr);
> > +                     break;
> > +             case 5400:
> > +                     serdes_tbl =3D qmp_v3_dp_serdes_tbl_hbr2;
> > +                     serdes_tbl_num =3D ARRAY_SIZE(qmp_v3_dp_serdes_tb=
l_hbr2);
> > +                     break;
> > +             case 8100:
> > +                     serdes_tbl =3D qmp_v3_dp_serdes_tbl_hbr3;
> > +                     serdes_tbl_num =3D ARRAY_SIZE(qmp_v3_dp_serdes_tb=
l_hbr3);
> > +                     break;
> > +             default:
> > +                     /* Other link rates aren't supported */
> > +                     return -EINVAL;
> > +             }
> > +     } else {
> > +             serdes_tbl =3D cfg->serdes_tbl;
> > +             serdes_tbl_num =3D cfg->serdes_tbl_num;
> > +     }
> > +     qcom_qmp_phy_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_=
num);
>=20
> If we split DP serdes tables, it would look lile:
>         qcom_qmp_phy_configure(serdes, cfg->regs, cfg->serdes_tbl,=20
> cfg->serdes_tbl_num);
>         if (cfg->type =3D=3D PHY_TYPE_DP) {
>                 switch (dp_opts->link_rate) {
>                 case 1620:
>                         qcom_qmp_phy_configure(serdes, cfg->regs, cfg->se=
rdes_tbl_rbr,=20
> cfg->serdes_tbl_rbr_num);
>                         break;
>                 case 2700:
>                         qcom_qmp_phy_configure(serdes, cfg->regs, cfg->se=
rdes_tbl_hbr,=20
> cfg->serdes_tbl_hbr_num);
>                         break;
>                 case 5400:
>                         qcom_qmp_phy_configure(serdes, cfg->regs, cfg->se=
rdes_tbl_hbr2,=20
> cfg->serdes_tbl_hbr2_num);
>                         break;
>                 case 8100:
>                         qcom_qmp_phy_configure(serdes, cfg->regs, cfg->se=
rdes_tbl_hbr3,=20
> cfg->serdes_tbl_hbr3_num);
>                         break;
>                 default:
>                         /* Other link rates aren't supported */
>                         return -EINVAL;
>                 }
>         }

Ok, sure!

>=20
>=20
>  > +    qcom_qmp_phy_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_=
num);
>=20
>=20
> > +
> > +     if (cfg->has_phy_com_ctrl) {
> > +             void __iomem *status;
> > +             unsigned int mask, val;
> > +
> > +             qphy_clrbits(serdes, cfg->regs[QPHY_COM_SW_RESET], SW_RES=
ET);
> > +             qphy_setbits(serdes, cfg->regs[QPHY_COM_START_CONTROL],
> > +                          SERDES_START | PCS_START);
> > +
> > +             status =3D serdes + cfg->regs[QPHY_COM_PCS_READY_STATUS];
> > +             mask =3D cfg->mask_com_pcs_ready;
> > +
> > +             ret =3D readl_poll_timeout(status, val, (val & mask), 10,
> > +                                      PHY_INIT_COMPLETE_TIMEOUT);
> > +             if (ret) {
> > +                     dev_err(qmp->dev,
> > +                             "phy common block init timed-out\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void qcom_qmp_phy_dp_aux_init(struct qmp_phy *qphy)
> > +{
> > +     writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
> > +            DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
> > +            qphy->pcs + QSERDES_V3_DP_PHY_PD_CTL);
> > +
> > +     /* Turn on BIAS current for PHY/PLL */
> > +     writel(QSERDES_V3_COM_BIAS_EN | QSERDES_V3_COM_BIAS_EN_MUX |
> > +            QSERDES_V3_COM_CLKBUF_L_EN | QSERDES_V3_COM_EN_SYSCLK_TX_S=
EL,
> > +            qphy->serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
> > +
> > +     writel(DP_PHY_PD_CTL_PSR_PWRDN, qphy->pcs + QSERDES_V3_DP_PHY_PD_=
CTL);
> > +
> > +     /* Make sure that hardware is done with  PSR power down */
> > +     wmb();
> > +     writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
> > +            DP_PHY_PD_CTL_LANE_0_1_PWRDN |
> > +            DP_PHY_PD_CTL_LANE_2_3_PWRDN | DP_PHY_PD_CTL_PLL_PWRDN |
> > +            DP_PHY_PD_CTL_DP_CLAMP_EN,
> > +            qphy->pcs + QSERDES_V3_DP_PHY_PD_CTL);
> > +
> > +     writel(QSERDES_V3_COM_BIAS_EN |
> > +            QSERDES_V3_COM_BIAS_EN_MUX | QSERDES_V3_COM_CLKBUF_R_EN |
> > +            QSERDES_V3_COM_CLKBUF_L_EN | QSERDES_V3_COM_EN_SYSCLK_TX_S=
EL |
> > +            QSERDES_V3_COM_CLKBUF_RX_DRIVE_L,
> > +            qphy->serdes + QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN);
> > +
> > +     writel(0x00, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG0);
> > +     writel(0x13, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG1);
> > +     writel(0x24, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG2);
> > +     writel(0x00, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG3);
> > +     writel(0x0a, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG4);
> > +     writel(0x26, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG5);
> > +     writel(0x0a, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG6);
> > +     writel(0x03, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG7);
> > +     writel(0xbb, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG8);
> > +     writel(0x03, qphy->pcs + QSERDES_V3_DP_PHY_AUX_CFG9);
> > +     qphy->dp_aux_cfg =3D 0;
> > +
> > +     writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
> > +            PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
> > +            PHY_AUX_REQ_ERR_MASK,
> > +            qphy->pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
> > +}
> > +
> > +static const u8 vm_pre_emphasis[4][4] =3D {
>=20
> Could you please prefix with v3? V4 will use different tables here

Done.

>=20
> > +     { 0x00, 0x0b, 0x12, 0xff },       /* pe0, 0 db */
> > +     { 0x00, 0x0a, 0x12, 0xff },       /* pe1, 3.5 db */
> > +     { 0x00, 0x0c, 0xff, 0xff },       /* pe2, 6.0 db */
> > +     { 0xff, 0xff, 0xff, 0xff }        /* pe3, 9.5 db */
> > +};
> > +
> > +/* voltage swing, 0.2v and 1.0v are not support */
> > +static const u8 vm_voltage_swing[4][4] =3D {
> > +     { 0x07, 0x0f, 0x14, 0xff }, /* sw0, 0.4v  */
> > +     { 0x11, 0x1d, 0x1f, 0xff }, /* sw1, 0.6 v */
> > +     { 0x18, 0x1f, 0xff, 0xff }, /* sw1, 0.8 v */
> > +     { 0xff, 0xff, 0xff, 0xff }  /* sw1, 1.2 v, optional */
> > +};
> > +
> > +static const u8 vm_pre_emphasis_hbr3_hbr2[4][4] =3D {
> > +     { 0x00, 0x0c, 0x15, 0x1a },
> > +     { 0x02, 0x0e, 0x16, 0xff },
> > +     { 0x02, 0x11, 0xff, 0xff },
> > +     { 0x04, 0xff, 0xff, 0xff }
> > +};
> > +
> > +static const u8 vm_voltage_swing_hbr3_hbr2[4][4] =3D {
> > +     { 0x02, 0x12, 0x16, 0x1a },
> > +     { 0x09, 0x19, 0x1f, 0xff },
> > +     { 0x10, 0x1f, 0xff, 0xff },
> > +     { 0x1f, 0xff, 0xff, 0xff }
> > +};
> > +
> > +static const u8 vm_pre_emphasis_hbr_rbr[4][4] =3D {
> > +     { 0x00, 0x0c, 0x14, 0x19 },
> > +     { 0x00, 0x0b, 0x12, 0xff },
> > +     { 0x00, 0x0b, 0xff, 0xff },
> > +     { 0x04, 0xff, 0xff, 0xff }
> > +};
> > +
> > +static const u8 vm_voltage_swing_hbr_rbr[4][4] =3D {
> > +     { 0x08, 0x0f, 0x16, 0x1f },
> > +     { 0x11, 0x1e, 0x1f, 0xff },
> > +     { 0x19, 0x1f, 0xff, 0xff },
> > +     { 0x1f, 0xff, 0xff, 0xff }
> > +};
> > +
> > +static void qcom_qmp_phy_configure_dp_tx(struct qmp_phy *qphy)
>=20
> With these functions I'm struggling between introducing=20
> PHY_TYPE_DP_V3/V4 and introducing callbacks into qmp_phy_cfg. What would =

> you prefer?
>=20
> What about the following struct?
>=20
> struct qmp_phy_dp_opts {
>         void (*dp_aux_init)(struct qmp_phy *qphy);
>         void (*dp_configure_tx)(struct qmp_phy *qphy);
>         void (*dp_configure_lanes)(struct qmp_phy *qphy);
> };
>=20
> I'm not sure about dp_calibrate().
>=20

Is there v4 code somewhere that I can see? Another level of indirection
is always a solution, so it is probably fine. This driver is currently
written with many conditionals instead of function tables so I'm not
sure it fits in with the style of how things are done though. The
alternative is to use an enum and call different functions?

The calibrate call is there to "turn the crank" on the aux settings.  I
need to cycle through the different values for that aux register so that
aux can be tuned properly. The AUX channel really has another phy that
needs tuning so we're sort of combining the aux and DP link phy together
here by letting the calibrate call tune the AUX phy and the configure
call tune the DP phy. I don't see any sort of concept of an AUX phy
though so this seemed ok. Does v4 need to tune more registers?
