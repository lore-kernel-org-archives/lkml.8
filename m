Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A43C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC71207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbIOSD1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgHSTpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgHSTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:44:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2431AC061757;
        Wed, 19 Aug 2020 12:44:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so26737946ljn.2;
        Wed, 19 Aug 2020 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0UfOuh7cDb+wZe62bSKwsSBp/aO8BCgxv52BBuf4cU=;
        b=lbIOSD1oIauZDpxA5QvPKSCX9E33WgWFlOHKsPF/9ojJ0Eh8VbPHn40QDvnGhKaoIf
         aFuOoXy/PMjeHGFgJSTNnt5Unc3977KHCDioF3fslCgBTkT++SwX8STKKPa5pAhRZhNu
         8Fiji6X1VtQHhVtE+oCBMyvJMqGsqZEAJPFwLhBs2ETRZPTzN/jhmDGTxs5MpHY4B1Db
         NAyzr5e4iQg1nTiycnTOgmlAGkwpt3UA8WlnkJRuNrsx+cVqcD5y0P5VgW5t84EWZX4y
         2gnLV4eNnM70VC32QGX56lxuYfqq+drDYLJg8h2rT5GvvJh2uX+5mMfOc2jUfpp6yPts
         iP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0UfOuh7cDb+wZe62bSKwsSBp/aO8BCgxv52BBuf4cU=;
        b=kgAFgSvEedDaNCCytdL5uZ5d7P9c2K7X3LlNjt4NFZZ4+BJNOijlD4Z5kLgDkCcNDo
         pbmBXZ0zhWt76JbE+XGT+KRQArLqkayzNoT4c6kUElTtFYAHNJuNfp7k3D+iSO+y6xKy
         x0yEW1U82lIT+qYTGTg8Psc48S0hzt7GAqeVp4BrlAy8LySvfc4ZY/6jqTZOl/samTYQ
         Clh/O6H6xla+hH5exFknQ/zK8xrV4QE+Gi7uFXFC0LgmjCdh2I6baFNTt3ydlO9keVlW
         Im1f4WLrX0FBUpKsk593k7BYMPVXFzeaX+w7FbuiCgSf3ni9h/4tr/vIAg/k0xDGUZiy
         GOhA==
X-Gm-Message-State: AOAM530vWzsoFu0/GRAfEop4mgr+WYLWZWP6uHlN386njmjMAwuvS570
        3wA1iCTf0Lf0b5/XvT4Yqr82QcyqY4HFfkRNiLs=
X-Google-Smtp-Source: ABdhPJw6tL+wyIp0MDHfKSdcmHhYe6qsiXh4e7Drz7scl0ADjMdYpEwN8mEw7EV7H2/5kImwDaHtNdjArIttcSjXPU8=
X-Received: by 2002:a2e:9899:: with SMTP id b25mr11649110ljj.178.1597866291520;
 Wed, 19 Aug 2020 12:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200819193559.2865826-1-aford173@gmail.com>
In-Reply-To: <20200819193559.2865826-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Aug 2020 16:44:40 -0300
Message-ID: <CAOMZO5Cz+v_isXs1mH6kmF0Ubs5mN08QTMO9m4HuP7mqggz-wQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6q-logicpd: Fix broken PWM
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Wed, Aug 19, 2020 at 4:36 PM Adam Ford <aford173@gmail.com> wrote:

>  &hdmi {
>         ddc-i2c-bus = <&i2c3>;
> -       status = "okay";
> +       status = "disabled";

Looks like an unrelated change.
