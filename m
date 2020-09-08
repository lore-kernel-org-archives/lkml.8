Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB385C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FB32080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bB77eRFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgIHSpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbgIHSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:44:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81089C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:44:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n3so144737pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ijf6QmkQ3+9uUwxRLoc/HDr9ErzteWuryOz76OdVX7E=;
        b=bB77eRFy90tB1JU3npUD9G86g4+NzTtx3R+xzGrws+fQ8ALV+n8xGyQtOEUbn/pUyj
         qEv6ydWQqUXyehqVfll4/h9PF1AQ1FyMe08IhlDyEQ/3Uord94zJsfwyCFPTSep2+Ivr
         RWBviQsKx585gfbT5BpoFF8UkoAZgjxh+K0O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ijf6QmkQ3+9uUwxRLoc/HDr9ErzteWuryOz76OdVX7E=;
        b=ejn+GSRGaxHdUMDsbx0rxLH+Bj0FZ/7/YGorUAUhc2zFDo8downXXHYCoqowzac9FV
         3ADllaW6ysX+vcBFs0z7nR7u6U725oR8dVf2FNdlAP+ZvC/Hfd1jVic6cO7Bw2EvOS1/
         4v6jiItAcAzBE72hpMtnehpthZ/vi+I0Hyrdph0JAqDAbfMwaki4b+5qYMW14lO/Lekb
         JPtuTP6B9gHGwQAamAbze6qiIOW3QDpAmgLbj4HQDf24RwJJZFHVcHfTgWvpmuWg03ik
         k1soUWCyDvDceY+NLVLi9q+KgqiKi9cWqHS0U2OmJRyAOHblzd26rMd0MVLqyJEWK2vW
         Ha4g==
X-Gm-Message-State: AOAM530TwCY/pTvfRCKRSnTomuTy6f6FYW3n9oHioTLF1ewQLrwy3Mgi
        zbRvTY1nWyAVOMuAq/GzLTVDsWL1/teMPg==
X-Google-Smtp-Source: ABdhPJyaoM3nJkqNpoYCs6ReDHWks+qott//NSz4oM48gXg+rglcV8Hc1y2qIyDTSRw8C4uzmJfonQ==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr194379pjb.174.1599590647893;
        Tue, 08 Sep 2020 11:44:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id s187sm148269pfc.134.2020.09.08.11.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:44:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c53059ac-dd88-f8fb-5473-ebc6f70f00d4@marek.ca>
References: <20200902230215.3452712-1-swboyd@chromium.org> <20200902230215.3452712-9-swboyd@chromium.org> <c53059ac-dd88-f8fb-5473-ebc6f70f00d4@marek.ca>
Subject: Re: [PATCH v2 08/10] phy: qcom-qmp: Add support for sc7180 DP phy
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
To:     Jonathan Marek <jonathan@marek.ca>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Date:   Tue, 08 Sep 2020 11:44:05 -0700
Message-ID: <159959064579.454335.278344660530279025@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Marek (2020-09-03 16:29:43)
> On 9/2/20 7:02 PM, Stephen Boyd wrote:
>=20
> ...
>=20
> > +static const struct qmp_phy_cfg sc7180_dpphy_cfg =3D {
> > +     .type                   =3D PHY_TYPE_DP,
> > +     .nlanes                 =3D 1,
> > +
> > +     .serdes_tbl             =3D qmp_v3_dp_serdes_tbl,
> > +     .serdes_tbl_num         =3D ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
> > +     .tx_tbl                 =3D qmp_v3_dp_tx_tbl,
> > +     .tx_tbl_num             =3D ARRAY_SIZE(qmp_v3_dp_tx_tbl),
> > +
> > +     .serdes_tbl_rbr         =3D qmp_v3_dp_serdes_tbl_rbr,
> > +     .serdes_tbl_rbr_num     =3D ARRAY_SIZE(qmp_v3_dp_serdes_tbl_rbr),
> > +     .serdes_tbl_hbr         =3D qmp_v3_dp_serdes_tbl_hbr,
> > +     .serdes_tbl_hbr_num     =3D ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr),
> > +     .serdes_tbl_hbr2        =3D qmp_v3_dp_serdes_tbl_hbr2,
> > +     .serdes_tbl_hbr2_num    =3D ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr2),
> > +     .serdes_tbl_hbr3        =3D qmp_v3_dp_serdes_tbl_hbr3,
> > +     .serdes_tbl_hbr3_num    =3D ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr3),
> > +
> > +     .clk_list               =3D qmp_v3_phy_clk_l,
> > +     .num_clks               =3D ARRAY_SIZE(qmp_v3_phy_clk_l),
> > +     .reset_list             =3D sc7180_usb3phy_reset_l,
> > +     .num_resets             =3D ARRAY_SIZE(sc7180_usb3phy_reset_l),
> > +     .vreg_list              =3D qmp_phy_vreg_l,
> > +     .num_vregs              =3D ARRAY_SIZE(qmp_phy_vreg_l),
>=20
> You need a ".regs =3D qmp_v3_usb3phy_regs_layout," here, otherwise phy=20
> init functions like qcom_qmp_phy_serdes_init() can crash on a NULL=20
> reference.
>=20

Ah got it. I didn't see a problem because the USB phy probes first for
me.
