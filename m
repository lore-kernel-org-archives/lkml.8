Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3442C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2202078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFOABJHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgHQNpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgHQNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:45:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826DBC061342;
        Mon, 17 Aug 2020 06:45:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i19so8386736lfj.8;
        Mon, 17 Aug 2020 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/iBDacXcX7OwSA4OUPrTWuLWUns2JSALVFoWN0Hnw4=;
        b=jFOABJHtVyh8OD9ILSob0+1xRPgF2W3DKcjOLbosWx6OaSMc26YMNNoTZvEjsPDxkh
         ZJPvHpzWDDiJw2SpU+JU3dfw6TNLTMbFomyhyT1DIfpXWi4k5sEQv6gJ5Q60323mnuYj
         t2kobuIwRi0oHcEkQZ92MvE0mR4c0GP1nDyI8quVESDKMjD5hl2Lkks1DLcQfivVZ+ne
         DbYaBd7+yGMaI5xYVZM1lzBUuTJlvBYll1OohFF2efbCIL3vxjGELcmZhPXrXfHv14cY
         X/j4xqfdlynUZx+WIAgwBeWSR7N42cVvdS96Va6RiTS30OLxj4914yJ0H/hKKeIW0acI
         U2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/iBDacXcX7OwSA4OUPrTWuLWUns2JSALVFoWN0Hnw4=;
        b=K90UPM29jAAG32tCG4w6mBIboNCz4XhWLcHDCEnyNAvQctADfGDTsQQcoanaGQ/8s7
         O6hHHD8mR1D8fI7hjiceFtGN/pHCMA9ugYB4QlTT5k1BCHTbfZjvdfUJTwaOejgSM8Ff
         A1aS69JaUVlnQc39fznOgCQVJi07qb+msobeYlt82RKUORwKaIOLJlEHfF3aw17rQXmQ
         LidmzcluWE4nfL+vbBIUAc1OQ6RGn98Bkj2txGooHahcVbEjwMGUqGQT6MS0pu/PSVCf
         21ZjH6qOHepozxmJQZSgj+qvT6V8hb8/CGzGU64doQVg9kYoYOTx6TY4rQkOC/mObaMi
         umpQ==
X-Gm-Message-State: AOAM533xdPZJB2Ko184gesChkX2KJj5SElA8aWgpUDtpNpG+8NVhjU1B
        IqoQ+6ewPUQiE68da3OAiKGr7oxBMswuouNv6Ic=
X-Google-Smtp-Source: ABdhPJwH3ISurMR9Wexl6Jrj+lYrPT9IVRF5Hy/PJbqMIWyYWCnenIUGOmWF9TY6ZSmytMyUmfkz6bsdzHECzikGJk8=
X-Received: by 2002:a05:6512:3156:: with SMTP id s22mr7566533lfi.140.1597671901506;
 Mon, 17 Aug 2020 06:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <1596714617-16387-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1596714617-16387-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 17 Aug 2020 10:44:50 -0300
Message-ID: <CAOMZO5AjRB7BCdJvE64=W+uxXnOOWzrD1Ahvyk=5Rukpdy8-0A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound card
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Thu, Aug 6, 2020 at 8:55 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

>  &iomuxc {
>         imx6x-sdb {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_hog>;

Instead of adding a hog group, please add the headphone detect GPIO
under the audmux group like you did in the imx6sl-evk patch.

Thanks
