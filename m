Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD69C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D529320829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7UnrF+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgG1Gy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgG1Gy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:54:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF73DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:54:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so16211600wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P6Lqe4llSuecNdw86Pntzf7Skr9CgvSQhntZY8kiVRI=;
        b=Y7UnrF+zQ6RZzUtdCmLwHT+qGIIM+SlR11df3sIrCsX1Sv04XzTX5+BxERbzoBt0aw
         JoioAp2JBQTwRD8ooaOCRM530mFZ7NuigqOGzkUfCJrJzjCS7OwxLHz4kOEO2FJVGe3F
         urTrZnT/cIpsJEP2KqX1j/c30vtKXd94FVVwHpUfMIb+ix93g7BWgmq7T4mpI30EWWYn
         ZDnzLesDqL4vtv2aPHjCLn29iN1UjEyak9K9eFCOM1C6C2f2MiTBkWMiVr1JPx1UHU5q
         FKKGya97qY63gog7LwWxVuclmifG8KeTPe/mQUkVnCpkqbY2tSUNA8RDgy4I2Zevf2ZZ
         sKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P6Lqe4llSuecNdw86Pntzf7Skr9CgvSQhntZY8kiVRI=;
        b=Urx/VKIvzrqDDpSNSoahUCYBvTcFEfQOz0N6PLGYo7bmbHJOVt5T+acbFcmW441I8K
         XDWumq+nArZoT7Q4rXwiGImkdyacppvrhRmDiW/+6ELhzL8EL8g6y7G1XCm0jJINfmOg
         oW1BhONnySxl2EbMyExZFiz1YyC+Xs3/JvwFgV4qDV6Cr4zZbekuRVVgujaf1yggNTcZ
         amvID2gEiYtUfS8A7TyudkO2MbYJImb3yIrPEy2rYBgV6L6dhMhRuSmIPDzgXBW+8TKr
         nqVrBg6PVX21+tEV/GNijLuQq60UGeQU6WFkx9rIRtSupxTb2NiiKgOr6PTb5Ix/ny14
         zTag==
X-Gm-Message-State: AOAM532mKQyPOmwPsEPQxjnHZDcWOCumu43957J+3RtZtgMN/Sn9+dIT
        2D8vLioJsa48vy7SKC2B2xvwrhUo7dbumg==
X-Google-Smtp-Source: ABdhPJyYHSILXD2MIwfCFMGk9+lW5DTHp7MxrU7c6jTiPIN7VeIarin13dG2nNifravck2a1bhTjMQ==
X-Received: by 2002:a1c:7f91:: with SMTP id a139mr2450962wmd.153.1595919265386;
        Mon, 27 Jul 2020 23:54:25 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id w125sm2823355wma.15.2020.07.27.23.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 23:54:24 -0700 (PDT)
Date:   Tue, 28 Jul 2020 07:54:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 4/9] mfd: mt6360: Combine mt6360 pmic/ldo resouces
 into mt6360 regulator resources
Message-ID: <20200728065422.GB1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-5-git-send-email-gene.chen.richtek@gmail.com>
 <20200727112921.GK1850026@dell>
 <CAE+NS36cxY9KqxxcmuctK_W_3ZmZnC_xK8VVVaTZqC3vSoqbUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS36cxY9KqxxcmuctK_W_3ZmZnC_xK8VVVaTZqC3vSoqbUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年7月27日 週一 下午7:29寫道：
> >
> > On Fri, 17 Jul 2020, Gene Chen wrote:
> >
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Combine mt6360 pmic/ldo resouces into mt6360 regulator resources
> > > to simplify the similar resources object.
> >
> > Do the sub-devices actually share these resources, or are you doing
> > this just to make the code simpler?
> >
> 
> They are different resources used by different bucks and ldos without
> sharing relations.
> I just to make the code simpler.

I don't think that's sensible.

You should only share resources with child devices that consume them.

> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > ---
> > >  drivers/mfd/mt6360-core.c | 11 +++--------
> > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > index 7cc1b59..665e26f 100644
> > > --- a/drivers/mfd/mt6360-core.c
> > > +++ b/drivers/mfd/mt6360-core.c
> > > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
> > >  };
> > >
> > > -static const struct resource mt6360_pmic_resources[] = {
> > > +static const struct resource mt6360_regulator_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > > -};
> > > -
> > > -static const struct resource mt6360_ldo_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
> > >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> > >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> > >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> > > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
> > >       OF_MFD_CELL("mt6360-tcpc", NULL,
> > >                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
> > >  };
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
