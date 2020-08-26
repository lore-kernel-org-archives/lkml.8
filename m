Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ABFC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF5D20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXVqn0s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgHZNB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbgHZNBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:01:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6832C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:01:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so2236128ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHl9xZEcuBSaRga/+aDJinT2xOJhaedDYtCpP29jqdg=;
        b=ZXVqn0s89wHs7We9qEl2Dco2ISgQw2fCkshzbrdWIDqNlEQYGoA3O7hQN+ziyNYVm8
         ivouw8gj8+qZsKmoArvrPgUOr84g+2vs97ee0h7t0GxUbCl7xsz6x+Q+wuBwr90eI7s5
         MXXWCSadyZ1kM40uQv1mb5nRqk6XIhTf5fQZCMJkJ8FIMUxpKqnUN3tBKjGshUouTdj/
         6lxSahwnGdgB+T+0lC0V+mhWYsagNXj0gBf3U+xCzpDKtKTmu/012VwZEoiNyNmZZn5l
         DB1trJvs6AfDjuNA27Av1TseZvbqe97/f6YTloBxqtRf0Fu6nqfYD4zax4sG5gDC4jWt
         kGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHl9xZEcuBSaRga/+aDJinT2xOJhaedDYtCpP29jqdg=;
        b=BgWGTKGyu+fFXPKbJJy+/lIRtM26G5JsY84AYcWGOAeYYGYXX4fcJTdNfSoSghNEp8
         d5Kt/NE419z0WPKcjTDS2D/iVr59GfSyaJnr91lBJiXpeUee5gRG3Iipyn5TDDYPBvyF
         9tFwPR0Zj1V9ua6ztbUDro87f2eeXOCUy1kCiKBmz1K1v10n/TNaYFXOmty6wtGdS1mJ
         zg6yN94OCgiU/tF6xZRA7ojaHbx+SJzqc/UZhNHLRXGEcnYaquK9/y6vJw+LQq8EHL29
         1c279xoau5+4LA6G9O7+uT1JVMtCL1UsqiMWP5xix7Fev9YLd6SLhe0ArIY2xRx6GPk/
         4kWw==
X-Gm-Message-State: AOAM531DAScvl8g6mVkTTSv/hvYeJC1grRizmCgXOOKfNWuMTFJZsLEW
        r+xeSN3QsYXwDahigwMTBmbLp29feiDbi9f+n14=
X-Google-Smtp-Source: ABdhPJyTe8ocMzgiOoaRd9kV8rdFs0ne162vxDKn9ElWAU4Cdb1g1eSXdCT0+O0qlzVHwVS17gJGMvtS+ZQsDfu1nYQ=
X-Received: by 2002:a2e:1417:: with SMTP id u23mr7630486ljd.44.1598446890165;
 Wed, 26 Aug 2020 06:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
 <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
 <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
 <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
 <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
 <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
 <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
 <CAOMZO5ADeXEHWiG7Xja1W1GnahV08ZEYSkNsrOzautn2mROCNA@mail.gmail.com> <aa0b7ad149a7bd4e681e4ebee12ffaaab2803832.camel@ew.tq-group.com>
In-Reply-To: <aa0b7ad149a7bd4e681e4ebee12ffaaab2803832.camel@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Aug 2020 10:01:18 -0300
Message-ID: <CAOMZO5B_Jm8SX9N9V5oq+LAa0Yc4CmrEp2n=2t3XUyBCtnGVTA@mail.gmail.com>
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH 2/2] ARM: dts:
 imx6qdl: tqma6: minor fixes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:54 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> Before 8cdcd8aeee281, num_chipselect was set to 3 for spi0 and to 1 for
> spi1 in arch/arm/mach-imx/mach-mx31lite.c. My understanding is that it
> would make sense to add this as num-cs to
> arch/arm/boot/dts/imx31-lite.dts.

Or just pass cs-gpios instead?
