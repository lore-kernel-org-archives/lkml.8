Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8923D20679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfnWQd9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgFCMe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgFCMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:34:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FFC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:34:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c17so2460432lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PI7pydsdlkyMsOD6xUcLp/qzxqU4rnGyfjXgCb9CfWA=;
        b=xfnWQd9oEyAsFzOPGt1mBJdArDRnh2rm2HZKJiiufZ4G3XU4PfqVW12McDu5EdvBVb
         qyfCex95T6C8Tcy86/IPyXEU3S80ASk+HARGYDiI6ViBZrc8pU4AWMn1Jqp8fW1s8W1g
         rRcyu95uIpQjRNQ0t7A8VWRPB0Gjrr7ZjNixzNhSgX334YRru7RYUn5hqcPerbW9I/vk
         IUaQ8XN78CUAtwSMO7xGQaeSOXYyu8EoTuCMR15KHfh8nAVjRMCqTcvKmwNbafE99vnv
         TaEjAvcLgbbAIs3kQ8rZcHoQPOI3s29vSI6VHexaAO6k29daJjUDM2GVsCcOKfV0FEES
         j8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PI7pydsdlkyMsOD6xUcLp/qzxqU4rnGyfjXgCb9CfWA=;
        b=nCUFZOxXmnq6MQTUXVrXw6zxE/7nAMK/2x3eNcCBTtwC8QUK/1E5WViiKhNlaSFhAM
         tzzsMMiAPl6l5qMljQkwdDxl20uqdKpAHrXB1Ruq18qocWKr3napFzzwiC1giTnBlbPU
         8zqyrmk3QP74jSP+vkpq3+mntZwhpUnpjW1bbNLiqGYYy5XsC/pHBBBCvD8D/Y/nc95N
         SZr0qeO03QSYsXl+RvzMr3HsgbpGS0V/v4Q4hQ7ug7XwhEQKvB8ilNqCaJx5DjEgl6pv
         OCdlKaVPY+Mx472yZTnFTl5K3jwnTSrioPFhYDmGj7Dd+2+INUw3hrWyDQSTSf/RP+Ai
         Zo4w==
X-Gm-Message-State: AOAM533K68nU93WxlW/u1fOChLowEhQerMHHQQtq82R3snNzDNtFckzV
        Ko/vaHgubo2ppUikA7O3fzC02Yy0MC+nKOtz+D+9EQ==
X-Google-Smtp-Source: ABdhPJwzUPzaqApWBasR0U8pnoYQewI2Zvey0OigUC/P5cfEYrETfElS5dHa5BQgryE1VDaIwAKQXp5y9hxab/Kb4RY=
X-Received: by 2002:a2e:350a:: with SMTP id z10mr1926898ljz.104.1591187695709;
 Wed, 03 Jun 2020 05:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200530204955.588962-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200530204955.588962-1-christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jun 2020 14:34:44 +0200
Message-ID: <CACRpkdYR11Gy99N0TPCkNFoBKKQLP2x3JsnH9=_S7mxPXgYKig@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: freescale: imx: Fix an error handling path in 'imx_pinctrl_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 10:49 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> 'pinctrl_unregister()' should not be called to undo
> 'devm_pinctrl_register_and_init()', it is already handled by the framework.
>
> This simplifies the error handling paths of the probe function.
> The 'imx_free_resources()' can be removed as well.
>
> Fixes: a51c158bf0f7 ("pinctrl: imx: use radix trees for groups and functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied!

Yours,
Linus Walleij
