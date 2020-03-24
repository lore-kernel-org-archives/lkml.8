Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD02C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1B920714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONu4l2SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgCXPjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:39:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45239 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgCXPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:39:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id c9so7259496otl.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gdNgUyovH3fFL036Rwp6qFNO07syiek5Tdf11PTq7yM=;
        b=ONu4l2SCV9dgZFVg2UfYC52IuLbDCEb5mUeYEhKuzsvwFmPCM5N8SJEEk4UafeWoac
         DoP3VVqPJ1Dk2LAERFmDMuVGBO0TY89uQuoBp7MFHclOAMl3bheWXApCowCeUXM/iSYl
         Nki8KGmmkSaOqM2fHh6N8WGQtlddbJhB3NDhpJ++w3NiESRoLgfLeVfr2rbE+cELcGxq
         o2DKUdhGkONXExSAuo9kb0sL0NAcnUZsgjhHgPJPpfzcsj07J5frb6YO7TEkmwK/jufN
         epMmVkXkVFOiJMmQSqJtLz6OILDjXl85QLHgLlYPCaP8HtfqS6wc3U9QgUQs5Zr3ATYI
         g9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gdNgUyovH3fFL036Rwp6qFNO07syiek5Tdf11PTq7yM=;
        b=ffLlfWVovlKobDzHDxaJNa0DVBRJ7nUTHQ9G2oze7Qtif7x1ByqZ6yY0YHB+H6Z/r8
         eTqKELxReLdtapFZQvQVAErSuOlxMuZVBJZJ12e+tCDf+bLoMF39ATXXaf0uXyNHsOuM
         J6Ni2P3DUhFO3zM/1xzjtwJYQYMYc+gueA9k4E5srPB98FujWE9+98V6pVSHeNwQKa5x
         8bSayJ5I/m3IEx8ddxGo2hv9lSjf2O0WcZtZ2dXRkUWZy4NF/iPYRqwgvdasOJLUuWj6
         /s5UDNpx36Q5W96I8bnMqN2UQofaIThtVl5Y7F7bJW18dryW3HJSuOBzqkCU+doWunF/
         IE3Q==
X-Gm-Message-State: ANhLgQ0Y5nblTSQDX1EBzNnvff2A207/BfJxZQnKwfNZaOXuft1ojO8j
        y0GCTJSM69rsmU/79BTperPVuY+ieL+8TWLyjAxoWg==
X-Google-Smtp-Source: ADFU+vtLsKQwanUzdtbf2Q0mesZdWrEI+84/TzmxAH6yGULo2vc9lF+1ZHeUnyQ0lDvVCPKemKF+dhoLeJTrSBfVjBc=
X-Received: by 2002:a4a:e48a:: with SMTP id s10mr2128023oov.10.1585064345759;
 Tue, 24 Mar 2020 08:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200317135740.19412-1-robert.foss@linaro.org>
 <20200317135740.19412-7-robert.foss@linaro.org> <2523204.mvXUDI8C0e@g550jk>
In-Reply-To: <2523204.mvXUDI8C0e@g550jk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 24 Mar 2020 16:38:54 +0100
Message-ID: <CAG3jFyuiVFHfNVwCAEynH0j8fK91k32m+nvZYYR79gju9cwPKQ@mail.gmail.com>
Subject: Re: [v2 6/6] arm64: defconfig: Enable QCOM CAMCC, CAMSS and CCI drivers
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, olof@lixom.net,
        maxime@cerno.tech, Anson.Huang@nxp.com, dinguyen@kernel.org,
        leonard.crestez@nxp.com,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Loic Poulain <loic.poulain@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Luca,

On Fri, 20 Mar 2020 at 20:52, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Hi Robert,
>
> On Dienstag, 17. M=C3=A4rz 2020 14:57:40 CET Robert Foss wrote:
> > Build camera clock, isp and controller drivers as modules.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/configs/defconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 4db223dbc549..7cb6989249ab 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -376,6 +376,7 @@ CONFIG_I2C_MESON=3Dy
> >  CONFIG_I2C_MV64XXX=3Dy
> >  CONFIG_I2C_OWL=3Dy
> >  CONFIG_I2C_PXA=3Dy
> > +CONFIG_I2C_QCOM_CCI=3Dm
> >  CONFIG_I2C_QCOM_GENI=3Dm
> >  CONFIG_I2C_QUP=3Dy
> >  CONFIG_I2C_RK3X=3Dy
> > @@ -530,6 +531,7 @@ CONFIG_VIDEO_SAMSUNG_S5P_MFC=3Dm
> >  CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=3Dm
> >  CONFIG_VIDEO_RENESAS_FCP=3Dm
> >  CONFIG_VIDEO_RENESAS_VSP1=3Dm
> > +CONFIG_VIDEO_QCOM_CAMSS=3Dm
> >  CONFIG_DRM=3Dm
> >  CONFIG_DRM_I2C_NXP_TDA998X=3Dm
> >  CONFIG_DRM_NOUVEAU=3Dm
> > @@ -732,6 +734,7 @@ CONFIG_MSM_GCC_8994=3Dy
> >  CONFIG_MSM_MMCC_8996=3Dy
> >  CONFIG_MSM_GCC_8998=3Dy
> >  CONFIG_QCS_GCC_404=3Dy
> > +CONFIG_SDM_CAMCC_845=3Dm
>
> You seem to have this option twice in this patch.

Thanks for catching this.
I'll send out a fix in v3.

>
> >  CONFIG_SDM_GCC_845=3Dy
> >  CONFIG_SM_GCC_8150=3Dy
> >  CONFIG_QCOM_HFPLL=3Dy
> > @@ -762,6 +765,7 @@ CONFIG_QCOM_COMMAND_DB=3Dy
> >  CONFIG_QCOM_GENI_SE=3Dy
> >  CONFIG_QCOM_GLINK_SSR=3Dm
> >  CONFIG_QCOM_RMTFS_MEM=3Dm
> > +CONFIG_SDM_CAMCC_845=3Dm
>
> ^
>
> >  CONFIG_QCOM_RPMH=3Dy
> >  CONFIG_QCOM_RPMHPD=3Dy
> >  CONFIG_QCOM_SMEM=3Dy
>
> Regards
> Luca
>
>
