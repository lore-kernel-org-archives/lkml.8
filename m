Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD78C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A05206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTAxsHI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440280AbgDPIAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440117AbgDPIAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:00:12 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120AFC061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:00:11 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id f8so4821725lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSf8uFnlnhLwj095+FU8Hbn9FbYIuI6qLS2jyiMbwJQ=;
        b=HTAxsHI4NFhxBaCaDB1DX0kXLNVIdVACrlSB7snYNia/S5Dxaduy0HAuEa14nLUnwh
         NjZ4+XYPjdEbGPlQtY7xdMJfc4wJ/ln5C9TgyMxTXtHwoH/3GbMtvLTxpiYS9aqcmyYW
         mbmmqyhMSBrFgMNqsZX+qMFEZjAGKsUeyE7JBzpLP+9Up/4SXYnUWGousajsyQ4e/gG/
         tp7ZiTkE0B16NNSEFY2ltXz8lNF4pGmLiLTfLBUnAHZV/4xyXmd7/wSkdV3an3765q5j
         BOERqjZVvDAeOKg/YdyD/hrlM9y2S5+Lf1xyea9woIZQAmW4/C6KW/yyDMkY+8oW3KCN
         +2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSf8uFnlnhLwj095+FU8Hbn9FbYIuI6qLS2jyiMbwJQ=;
        b=Bos1auPYB73/NQMImdZVDpDBHmdPMpHlKtpm2A/MZ6yWZyQnjyeMDshfpkvLo2KmZl
         aG51zlH9cg4dO06xRgf+LnwG/YD0pmM5ytv5ZrIQ75PNlbhbB9V6KmHn3tzIp0g77i6M
         DAYEeoo6ZAkYX2eff0QQbbctphLLYszjRv3ANayVK7Btg1xQFG8M57t1coCtMkjn7CfF
         S3SoEvcBAJah9BOA7SFdLEtntgPbJtxMWiogvtI2ADrG2y49sUXfzdr9a6sqVrlVhaev
         1R0VygKjM91IMJsh9Aw7Dn92uzIYAmXsOULzyocijwew4LgepjYdtD3KMkMCHzBM9tFA
         +rmA==
X-Gm-Message-State: AGi0PuYGBSi9dPImLEpxEPd4UAvtpEdNh8cWq1BrU+WeSB0FI41ATCvo
        buwP9nhYEnGHoyY+mVxOmVFgxUXRKNoKrsbkfR2gWA==
X-Google-Smtp-Source: APiQypKLGba57Vds1+EwidDyrePfi8s/BtJ+tvZbYfVRkMJ5bQ1HEXGS3YVge49dJY0iO94c5gudWNVEvYyk1g0PZ68=
X-Received: by 2002:ac2:4a9d:: with SMTP id l29mr5028454lfp.4.1587024009374;
 Thu, 16 Apr 2020 01:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <9feeb04805e5a406fe22a92e3f280abda39ddda4.1586289920.git.sean.wang@mediatek.com>
In-Reply-To: <9feeb04805e5a406fe22a92e3f280abda39ddda4.1586289920.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 09:59:58 +0200
Message-ID: <CACRpkdbUzwwcJqqPb=HVcDptMb1OqmRnYNzPuTMLz75LOsmSrQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] pinctrl: mediatek: make MediaTek pinctrl v2 driver
 ready for buidling loadable module
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Light Hsieh <light.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 10:08 PM <sean.wang@mediatek.com> wrote:

> From: Light Hsieh <light.hsieh@mediatek.com>
>
> In the future we want to be able to build the MediaTek pinctrl driver,
> based on paris, as kernel module. This patch allows pinctrl-paris.c, the
> external interrupt controller mtk-eint.c, and pinctrl-mtk-common-v2.c to
> be loadable as module.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Light Hsieh <light.hsieh@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> v6->v7: no change

Managed to extract and apply the v7 version using the b4 tool,
thanks!

Yours,
Linus Walleij
