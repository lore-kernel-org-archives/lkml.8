Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B8DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334B3207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D4Y7fZEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGBFFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBFFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:05:20 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E4AC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 22:05:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so13851489iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 22:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePm8K1YrKTYlTFOwBCRGn4xw8mI3+0R5ZwHfAbLgLak=;
        b=D4Y7fZElDuKkAbGQBTP7tnXJ9yxEYcJ1+lqoyHC2Q4j4RAG70CRzK84FdG5w43sSjw
         9IIsyPC8XLWKN4+EuqWpOq7nDJ9OrCSROZZ9x30dtGEgEwPw08WBGqZzPGLDzO+HM52/
         Ej5TSs+VoFSZkT1ZArqjX03JDC1rNspZXsfTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePm8K1YrKTYlTFOwBCRGn4xw8mI3+0R5ZwHfAbLgLak=;
        b=D0ycKAEAi9VwCW0G++UKN1zqMq8EHRZIqKpvybXZCcP/39jIdS8+KHWfmnHWs2Q7PW
         e82p4R2tKvxzXCQnxZaHK2NFZv1ijvk9FoIpT9JiOlNja8ZufaoNmekTkp97jcYRADAG
         dKMjZKpXNOM8tmKSpncqS32SmHMbM1F25XeQKZjgXhR6U2hcDiOh0V8enFiz7WTZbFw8
         a+oDMREikxXLfGik7+/SZyhQAGcBI2VUiSG5LKipI78kZPjwvPGLweVmUEUm2LYhMhtT
         dbYFM1sLRPMWzw+ZOtM44VFvHciHHjtljOTvtRmZ8iT/e6BOtqgrGB1cFjJBxw9uIYnr
         /rzw==
X-Gm-Message-State: AOAM533mwuw4dZGYRiT2w05Byi4smzge8vAfJCmIINvfDGK+BezTrw28
        XA/qbAboGo44/f4Cn81EpLf3/uCMwHmeirR+ab70wg==
X-Google-Smtp-Source: ABdhPJw2kPVQNy2tWis10zqAhHf5YpNiIQG11abVlOkUAhNPPsHAqxRbxQbJ1oKec7GIt0IdmyqCbGzt0U1S+2n9eq8=
X-Received: by 2002:a05:6602:2295:: with SMTP id d21mr5736965iod.0.1593666319420;
 Wed, 01 Jul 2020 22:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200625101757.101775-1-enric.balletbo@collabora.com> <20200625101757.101775-3-enric.balletbo@collabora.com>
In-Reply-To: <20200625101757.101775-3-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 2 Jul 2020 13:04:53 +0800
Message-ID: <CAJMQK-hGg0QUjZsWN3rXzbZVD3DQEmOjkcoJixEn7YfKRMC==g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] arm64: dts: mt6358: Add the compatible for the regulators
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        erwanaliasr1@gmail.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 6:18 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The regulators are expected to be instantiated with matching the
> device-tree compatible, so add the proper compatible name under the
> regulators node.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>
> Changes in v2: None
>
>  arch/arm64/boot/dts/mediatek/mt6358.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> index 9361ada0c497e..fa159b20379e4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> @@ -16,6 +16,8 @@ mt6358codec: mt6358codec {
>                 };
>
>                 mt6358regulator: mt6358regulator {
> +                       compatible = "mediatek,mt6358-regulator";
> +
>                         mt6358_vdram1_reg: buck_vdram1 {
>                                 regulator-name = "vdram1";
>                                 regulator-min-microvolt = <500000>;
> --
> 2.27.0
>
