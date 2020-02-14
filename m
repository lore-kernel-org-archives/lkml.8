Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F72C3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE921206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFDyq4vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbgBNKpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:45:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39281 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbgBNKpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:45:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id t23so6451387lfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvXb6lwZjce3PLG/MA2XMSg4vriIBn550FVcP/H65XE=;
        b=aFDyq4vu3uOf2uXlywW6qqw5sw0hsgKMMLwIvssQzEzgKkboCNOWJ1CXjmd0n8rtUL
         R4Fw2Kf9jQ/VrkF7xqX+426GH7bS+WIOmC655a0Sy0tMVlbdovzSyde1lrWxffpgkPUi
         ARRVuArlWlQ1oUkw8em5cZFmSZSVS8SmYZEcpMKEgLz2tmREUQy4ChyXuOaXOVi4zhmG
         Wp1B2WHpwJBu5s5PhmDOPhP3QItxtc2Sicr/geLXj2l4IQLTvYnrz51xsM0/y+MmeJhB
         IbB57deQrOeEeSzVyjZXCgEIJtTgtEsC8IZKeM1u5zX2zI8QNdPJgsXebwT1AuJmfnef
         yrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvXb6lwZjce3PLG/MA2XMSg4vriIBn550FVcP/H65XE=;
        b=C1no6tctlwTaL2vKMLz4N4y09NlNfhxTOkNKoZ4iEhqE2O1kTp128xFNhezV+OLO+Y
         ifqqHOZNIAj7LwS8ghe7DsKqyf+z29g1D23UVCdez3T9vMuLTmOZRjFo2W0DDmxe8Fe+
         gCzf48uhEGjI0l94HzCApuVqKvmeb0zfrZs2f6DjEpJ5yZH2yux99O656FtIlThKqgIR
         jiiq/ZNkIFDt3g/3DOAmO0N/6Po4zqlbAbUqoL+FuElTiWJFTSLTo5mjpctOSU0kivYW
         HX/iZXBG9td8vN6UpCYT9FLXpbrQA7YRItQFL6IVaL6Yb+Th8GDTmWgz8CZ1E41X9aOk
         wRBw==
X-Gm-Message-State: APjAAAUMQGFA7K0AHvDhzikliBY9J5oRHcb9ZUl4gFJAZVQ/gNBa+FmD
        l1Cz0NQYo9c0KDjcwK4i5gEWA+tSkpp1GtGDm2AoPQ==
X-Google-Smtp-Source: APXvYqzbavOHLFo0u6rpYEyH+TC6gjN1NBg1u/L6aiNTBOjJAVE43SE5VWcs0xtZh2jZ0iyBr5Mka2oROJIAqLxc8XE=
X-Received: by 2002:a19:850a:: with SMTP id h10mr1403689lfd.89.1581677103410;
 Fri, 14 Feb 2020 02:45:03 -0800 (PST)
MIME-Version: 1.0
References: <838d8378-1a6a-11c4-fad8-aeb4b861478b@castello.eng.br> <20200124133758.10089-1-matheus@castello.eng.br>
In-Reply-To: <20200124133758.10089-1-matheus@castello.eng.br>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Feb 2020 11:44:52 +0100
Message-ID: <CACRpkdaniAko8rP1JxcoVqXV5KijAR3AnEdRv0H2_u51MH8Ycg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: actions: Fix functions groups names
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     pn@denx.de, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 2:38 PM Matheus Castello
<matheus@castello.eng.br> wrote:

> Group names by function do not match their respective structures and
> documentation defined names.
>
> This fixes following errors when groups names defined on documentation are used:
> [    4.262778] pinctrl-s700 e01b0000.pinctrl: invalid group "sd0_d1_mfp" for function "sd0"
> [    4.271394] pinctrl-s700 e01b0000.pinctrl: invalid group "sd0_d2_d3_mfp" for function "sd0"
> [    4.280248] pinctrl-s700 e01b0000.pinctrl: invalid group "sd1_d0_d3_mfp" for function "sd0"
> [    4.289122] pinctrl-s700 e01b0000.pinctrl: invalid group "sd0_cmd_mfp" for function "sd0"
>
> Fixes: 81c9d563cc74 (pinctrl: actions: Add Actions Semi S700 pinctrl driver)
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>

Fixed up the subject as requested by Mani and applied!

Yours,
Linus Walleij
