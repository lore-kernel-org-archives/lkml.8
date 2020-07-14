Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DAFC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB3F20658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594761257;
	bh=xJEt28yG5snfGCRRjw3wSQrw/eSHAemNaNv10dkyRQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cSNViXhc2UpFXc4YDNEgSb/jYCIF5JkrJ9yK2islMqq0xf6YGTKsvdAthKCBGx6ch
	 QYL0XiGux0FrxejWyqB0pK0ZLnB5Y1X0ofDngK8pWt5pRyeigqsYqxOY6WAFhiWQ/G
	 IMuqSinn1C19l02naegKIHKB1jNePSTYGl7uMLmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgGNVOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgGNVOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:14:15 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3318B206F5;
        Tue, 14 Jul 2020 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594761255;
        bh=xJEt28yG5snfGCRRjw3wSQrw/eSHAemNaNv10dkyRQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M0Ss25Afg10HiK/2HBQRFfzW42VJzF+YbzTW+RJiRBO0ah3qJU9xYlM7eECwM6+w5
         MOZ3ssvMvLhbFxn+19w4O+JVkZGcmHeOPH296mS5x/oo/pEqVfOAZQV+34ulZcJHRK
         JoBjKpf8NUYpeMWnT0WUM7mxZD1mcMvmHbAYYQLA=
Received: by mail-il1-f172.google.com with SMTP id t4so94808iln.1;
        Tue, 14 Jul 2020 14:14:15 -0700 (PDT)
X-Gm-Message-State: AOAM533D6Sg6GxavqWxV3IiA56/G2dmjMN5wQwu5DaJpnI1+CJ9ezppq
        rVSIJKSqxZGaQpybhvDOXPuvhx0Tf7v6SYcnJ9s=
X-Google-Smtp-Source: ABdhPJwXf/Rm5ypnIxr57TkPPI0oKtuKdoZqvr9Ssu+Eyqx3vf6EQCyBT1vgH+wRyKZZO+SRh5TiFGRfhBGQQ+0Ymy8=
X-Received: by 2002:a92:cbd1:: with SMTP id s17mr6620228ilq.43.1594761254567;
 Tue, 14 Jul 2020 14:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200710072717.3056-1-zhiyong.tao@mediatek.com> <20200710072717.3056-4-zhiyong.tao@mediatek.com>
In-Reply-To: <20200710072717.3056-4-zhiyong.tao@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 14 Jul 2020 14:14:03 -0700
X-Gmail-Original-Message-ID: <CAGp9LzpVTRX6CrU7nErqyznP6QFS10mKuvt5oEXUGL+_FAyYNQ@mail.gmail.com>
Message-ID: <CAGp9LzpVTRX6CrU7nErqyznP6QFS10mKuvt5oEXUGL+_FAyYNQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: add pinctrl driver on mt8192
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?UTF-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <chuanjia.liu@mediatek.com>, Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        =?UTF-8?B?RXJpbiBMbyAo576F6ZuF6b2hKQ==?= <erin.lo@mediatek.com>,
        =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:28 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> This commit includes pinctrl driver for mt8192.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

It is good to see the clean driver with mtk-common-v2.

Acked-by: Sean Wang <sean.wang@kernel.org>

> ---
>  drivers/pinctrl/mediatek/Kconfig              |    7 +
>  drivers/pinctrl/mediatek/Makefile             |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mt8192.c     | 1453 +++++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt8192.h | 2228 +++++++++++++++++
>  4 files changed, 3689 insertions(+)
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8192.c
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8192.h
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index f32d3644c509..8d5ffc6aa8dc 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -121,6 +121,13 @@ config PINCTRL_MT8183
>         default ARM64 && ARCH_MEDIATEK
>         select PINCTRL_MTK_PARIS
>
> +config PINCTRL_MT8192
> +       bool "Mediatek MT8192 pin control"
> +       depends on OF
> +       depends on ARM64 || COMPILE_TEST
> +       default ARM64 && ARCH_MEDIATEK
> +       select PINCTRL_MTK_PARIS
> +

<snip>
