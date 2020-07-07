Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7836C20720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRxCuE1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGGLeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGGLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:34:22 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D168AC08C5DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:34:21 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so24523982lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWFCdEUgk5dfzDM3fhNe+v2tWxrsCvDUWA3/QI1yjsA=;
        b=dRxCuE1+l4lJyQ2YbJAaOdam3ofJb8lgOtEdWezxKOyRRyDMxmvt7gEf0x6w0E8JX6
         zfj7ZoIxtLjX0RoOMTlhhp7h2JjwzRPmSlFeghxpjgBnoebMvd8IizTdR+RZTz7Tb7e8
         GWLtSt2RMzfl/2xH9EXD3CfW9B5mBTWTW6Qi28YrmmDUD8WfYzAp+GMW/NX1sf2jcim9
         p9TV40K9JWSp95sXcbLXnhApLLu0A0ABHN7alxdXkM1r9I/97RVRvjvbSl0rwCFDnrds
         MgVQ5wl2VKBhy5HWTXFp0joV93UB52d4AMRaTt7+yi4p9Oni+yYVsyZGW1Ys135suUi7
         NP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWFCdEUgk5dfzDM3fhNe+v2tWxrsCvDUWA3/QI1yjsA=;
        b=ZMJ2sXo1E2B/07YDMGjoDxUZGhdxhq0CbASVxrbRk3qOykkdy0fYuq0422SY+H4/rN
         g7DbETpTEqDdryrkD1AFxaNTaVUpUadVpRXRnYVi9wlImhyXpBjO6TkaDDK+KVpFjAyf
         5MsBaN6L+ewuRPUeCEaUI1WeYeV80uA6PuQv1H7gBwKb/WjPpAwjH14+oQfILY7yE/Ha
         rJHfAkfh/8K+ygE2z+Xc45IeNe8uyTKQt68n1NShfns+PlA8GZfQSyT32ExTHA0zTPup
         bzHpPPcmowh4Ai4Vdu3RocA1/+4KEykvVs4c4hmUW3OWf9m18qP3ww1edtO0hl8vUf+v
         d2kw==
X-Gm-Message-State: AOAM533JOADJT+7mmiEb08PL/M2IVU6msxFxmSyVPG9HHGKAcArVn3tJ
        BH3RlbjSja5SVLX+n+38dVC+JIsKp6cpinDdlhit8w==
X-Google-Smtp-Source: ABdhPJyIiIuyUQqHN3zlh6wrnfN64GqNkLKnTcdf/MuoVjXEMgRphXgXP3Wlti/RgXHlE/J8tuuX/mMRGR2kcN3VA8g=
X-Received: by 2002:a19:745:: with SMTP id 66mr32821101lfh.77.1594121660274;
 Tue, 07 Jul 2020 04:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <1592480018-3340-1-git-send-email-hanks.chen@mediatek.com>
 <1592480018-3340-4-git-send-email-hanks.chen@mediatek.com> <CACRpkdavqjcma8A1y9Sh=WWLu-n0+mQOhyNw2dHenA8ZnQkvgg@mail.gmail.com>
In-Reply-To: <CACRpkdavqjcma8A1y9Sh=WWLu-n0+mQOhyNw2dHenA8ZnQkvgg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 13:34:09 +0200
Message-ID: <CACRpkdb5TyictD3j_PE5JtBJmxX87Bk04YkxF1ErsbHwO4TSOg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] pinctrl: mediatek: avoid virtual gpio trying to
 set reg
To:     Hanks Chen <hanks.chen@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Andy Teng <andy.teng@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, wsd_upstream@mediatek.com,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 1:31 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jun 18, 2020 at 1:34 PM Hanks Chen <hanks.chen@mediatek.com> wrote:
>
> > for virtual gpios, they should not do reg setting and
> > should behave as expected for eint function.
> >
> > Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
>
> Sean if you're OK with this patch I can just apply it separately.

Ah nevermind since the next patch has your ACK I just applied this
too since it's a dependency. Yell if this is wrong.

Yours,
Linus Walleij
