Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D352DC11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F78208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FB6lzG1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgBTPOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:14:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33819 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgBTPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:14:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so4639668ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyYfAxHT6CRHzAhL+Lfi1DTcyn2H/tLwm1L1QgCaoUc=;
        b=FB6lzG1QsIqJHCuslHP3XrKS96DyFbJ/GgtiTNNd+l2lp80jw0+yLLjt0yAnjFUU6/
         8WD/q9sg3t58MaC9meV35lDEcTrOtbdtPD1gGvBOTvftfV6FsjjVwS4RSzkAV6QEiTmI
         VkJrdusURrmMv0GCiczAYp9z8LUIdgMCgb5L33aNByuSoyffErjFIldKL9bea4/kpf8N
         RI/47mpW1GDKEPL7hpCsxbmnKlj2JtpAdfgYY/N13m1vHCq8UlzrBbEpSVbNXnebI2Jk
         7y7BA/Uxnxq6PfuBrRb+x1Z032LUiaaFim9zrrTNbinVCNYATV2YijjptrZYmbGw2eFb
         iKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyYfAxHT6CRHzAhL+Lfi1DTcyn2H/tLwm1L1QgCaoUc=;
        b=ErR+xqEsD2JoXWkj3MvIS5kV+jf7W7XFS8540unOXUx89GtsE+MY3fGJfXF3eMHiaG
         awnjc+TOdrRNLjDKOEI6RRn/7B95AymfxEdm9S7PuA+LA+9yA72ygMqwAFx/U+jmTV1S
         i1gfsvmMZ/+aKVUdpCot2vdn6gpztbXz7s9jhcnYSdzmJXOtwuAd3f2eMIlsD3p3V6w0
         uXVeni71QSYniNtIy1q+Ynjr9Ih22Q+j67Zlsc4gdiSCpF2RrheFrBHzUE+byA/cak/L
         qaWZAn41MryrZ/0EtYfsD6qxie4EDZhj3llNL/RzsrTxgU6W/DD7CEvgGMjQxCEkI2Zt
         YTag==
X-Gm-Message-State: APjAAAWILrHcFS7C66hWKdRVsvTYD8iQGdtCxVPdQ9Xnd7sJDqE8rrjo
        PoyZMoWhsb2ugTLg3ssMWFCjpinp2Q9QKPyUulvF0Q==
X-Google-Smtp-Source: APXvYqxtKVKfD5MHxlSSaj0Vz28Axw6Zu0+dlk/mKScpMhfCjU4oekoeWPt9CHiwud40m5c1q60F4dL0wXI2I30UJCs=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr18719210ljg.168.1582211654160;
 Thu, 20 Feb 2020 07:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20200218023625.14324-1-yuehaibing@huawei.com>
In-Reply-To: <20200218023625.14324-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Feb 2020 16:14:03 +0100
Message-ID: <CACRpkdbgWj3FtKP2S1BcNDphYRS5G-c6-Ms1HGyrcOox8EFpOA@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: mediatek: remove set but not used variable 'e'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-kernel@listd.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 3:36 AM YueHaibing <yuehaibing@huawei.com> wrote:

> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c: In function mtk_hw_pin_field_lookup:
> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c:70:39: warning:
>  variable e set but not used [-Wunused-but-set-variable]
>
> Since commit 3de7deefce69 ("pinctrl: mediatek: Check gpio pin
> number and use binary search in mtk_hw_pin_field_lookup()"),
> it is not used any more, so remove it, also remove redundant
> assignment to variable c, it will be assigned a new value later
> before used.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied with Matthias Review tag.

Yours,
Linus Walleij
