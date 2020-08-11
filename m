Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B889C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B81A206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lpt7Jm9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHKTac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgHKTab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:30:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19948C061788
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:30:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z20so10175plo.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=+n9PUP/yu05/9MDe2VuxcN4yg1PRKAeGWVDeYP991FY=;
        b=lpt7Jm9cDHqdN9rwJn9az98LIyC8PWOAXXdc78UL2gjQNuYua8XrdpG+POwMqKX9XB
         VyYODz3OKowxSXkD5UMXyRoCr6j1yD6TQBP1AMmD2lNsNEIMj9+9D9uEG7figGQCkTI9
         4PaMD18uQVJm6IdYI6oiKA3MPtbWp8CC8dFG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=+n9PUP/yu05/9MDe2VuxcN4yg1PRKAeGWVDeYP991FY=;
        b=k5p2yROf2Tak2nAQje5QQzrxzTUAdjbwsjrspN/VQZir/3KdX6eNa4bU6TxLMqBBOv
         eRl27qh6Qx25yF4KeKNHZBLHnI5NrioSMWIR9lNvBwYKHyX3Kcov7EVbif17bdaCl89M
         1KIGan1f1EhG5Th6HKJ/uz4bAAFVvh/exCzwm+tNppuwq0Qc/CGPNtCE8A2C0Vn3D4J/
         uyRKfKkzt5NohqGHD1iWqxXJ4vPDTeXynCsmWfP5ZvZvoktXgR+oYVRvtflhsVdwiRMY
         hksXWm1gZuW7s3/UfzG8gasZj+XXQ8klfPrLdIavl0gBMJ+zsS+VJpHdaDVUJttNdApc
         Z0hg==
X-Gm-Message-State: AOAM5302AaKRo50Kwe/QCwhfmXghuFUw2SIUp2YA1a7t/3Bx6mTIHZ8r
        Tz+DnRKWqS44NjJSaTU8uCEHdxbwyFk=
X-Google-Smtp-Source: ABdhPJwe4qk4u80qb7K6M0UTxshn2s9EH/901eeU60PzedzdUY+tVv6ME7a5eBT8eA4fvUg13Z569w==
X-Received: by 2002:a17:902:82c1:: with SMTP id u1mr2289880plz.224.1597174230361;
        Tue, 11 Aug 2020 12:30:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y12sm16694716pgi.75.2020.08.11.12.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 12:30:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200811021553.25023-1-tanmay@codeaurora.org>
References: <20200811021553.25023-1-tanmay@codeaurora.org>
Subject: Re: [PATCH v5] arm64: dts: qcom: sc7180: Add Display Port dt node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        seanpaul@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        aravindh@codeaurora.org, abhinavk@codeaurora.org,
        khsieh@codeaurora.org, Tanmay Shah <tanmay@codeaurora.org>
To:     Tanmay Shah <tanmay@codeaurora.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robdclark@gmail.com
Date:   Tue, 11 Aug 2020 12:30:28 -0700
Message-ID: <159717422853.1360974.2200109790995932014@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tanmay Shah (2020-08-10 19:15:53)
> @@ -2440,6 +2447,71 @@ dsi_phy: dsi-phy@ae94400 {
> =20
>                                 status =3D "disabled";
>                         };
> +
> +                       msm_dp: displayport-controller@ae90000 {
> +                               status =3D "disabled";
> +                               compatible =3D "qcom,sc7180-dp";
> +
> +                               reg =3D <0 0x0ae90000 0 0x1400>;
> +
> +                               interrupt-parent =3D <&mdss>;
> +                               interrupts =3D <12 IRQ_TYPE_NONE>;

Please drop the flags. It's not required per the binding. It should just
be a single number, i.e. <12>.

> +
> +                               clocks =3D <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                                        <&dispcc DISP_CC_MDSS_DP_AUX_CLK=
>,
> +                                        <&dispcc DISP_CC_MDSS_DP_LINK_CL=
K>,
> +                                        <&dispcc DISP_CC_MDSS_DP_LINK_IN=
TF_CLK>,
> +                                        <&dispcc DISP_CC_MDSS_DP_PIXEL_C=
LK>;
> +                               clock-names =3D "core_iface", "core_aux",=
 "ctrl_link",
> +                                             "ctrl_link_iface", "stream_=
pixel";
> +                               #clock-cells =3D <1>;
> +                               assigned-clocks =3D <&dispcc DISP_CC_MDSS=
_DP_LINK_CLK_SRC>,
> +                                                 <&dispcc DISP_CC_MDSS_D=
P_PIXEL_CLK_SRC>;
> +                               assigned-clock-parents =3D <&msm_dp 0>, <=
&msm_dp 1>;
> +
> +                               operating-points-v2 =3D <&dp_opp_table>;
> +                               power-domains =3D <&rpmhpd SC7180_CX>;

Can you send another patch to add the hpd pinctrl binding for the hpd
function? It would be useful to have that in the SoC level in case any
board wants to use the hpd pin on this SoC without having to implement
it themselves. It could be assigned here too as the pinctrl but I'm not
sure if that is correct. Probably better to just have it in the SoC file
and then let boards pick to use it.

> +
> +                               ports {
> +                                       #address-cells =3D <1>;
> +                                       #size-cells =3D <0>;
> +                                       port@0 {
> +                                               reg =3D <0>;
> +                                               dp_in: endpoint {
> +                                                       remote-endpoint =
=3D <&dpu_intf0_out>;
> +                                               };
> +                                       };
> +
> +                                       port@1 {
> +                                               reg =3D <1>;
> +                                               dp_out: endpoint { };
> +                                       };
> +                               };
> +
> +                               dp_opp_table: dp-opp-table {

Can this be called opp-table? I don't see the need to make it more
specific given that it doesn't share the namespace at this level with
anything else that is an opp table.

> +                                       compatible =3D "operating-points-=
v2";
> +
> +                                       opp-160000000 {
> +                                               opp-hz =3D /bits/ 64 <160=
000000>;
> +                                               required-opps =3D <&rpmhp=
d_opp_low_svs>;
> +                                       };
> +
> +                                       opp-270000000 {
> +                                               opp-hz =3D /bits/ 64 <270=
000000>;
> +                                               required-opps =3D <&rpmhp=
d_opp_svs>;
> +                                       };
> +
> +                                       opp-540000000 {
> +                                               opp-hz =3D /bits/ 64 <540=
000000>;
> +                                               required-opps =3D <&rpmhp=
d_opp_svs_l1>;
> +                                       };
> +
> +                                       opp-810000000 {
> +                                               opp-hz =3D /bits/ 64 <810=
000000>;
> +                                               required-opps =3D <&rpmhp=
d_opp_nom>;
> +                                       };
> +                               };
> +                       };
>                 };
> =20
>                 dispcc: clock-controller@af00000 {
> @@ -2449,8 +2521,8 @@ dispcc: clock-controller@af00000 {
>                                  <&gcc GCC_DISP_GPLL0_CLK_SRC>,
>                                  <&dsi_phy 0>,
>                                  <&dsi_phy 1>,
> -                                <0>,
> -                                <0>;
> +                                <&msm_dp 0>,
> +                                <&msm_dp 1>;

This bit will have to change when the DP phy is split off into the qmp
driver.

>                         clock-names =3D "bi_tcxo",
>                                       "gcc_disp_gpll0_clk_src",
>                                       "dsi0_phy_pll_out_byteclk",
