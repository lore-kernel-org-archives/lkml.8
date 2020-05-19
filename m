Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28D120825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589900783;
	bh=29TXNGWd/fhmzxIwOPHw0n8O5RIe1LfOq81Iyfco7wA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Fh+bemxaKTQJeU5OyUSVH6UFeKZaaHph4Dh3qfJDtKqdzHblCGnjbWM7rBkAgYLC
	 ZPoptyT6F37JpN+SlpAqfYri7B3bndS8/5fqlVFC0H5JjslL7rGzzfRRmnFIE2A40N
	 Axj3xWwRBEuYWZ7WbtdUpc64cGaQiIrnu1F7nPDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgESPGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgESPGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:06:22 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02EF820842;
        Tue, 19 May 2020 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589900782;
        bh=29TXNGWd/fhmzxIwOPHw0n8O5RIe1LfOq81Iyfco7wA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1lncfq4bQRql8j2TS2Wgze6M/ZcGlwO1+fkIQdkV/IW8TfwyMJhtgMCTFcF4VgJ6Z
         8wrfyiDhSj6IpSkVByeGUSjrJkmtgJPElPcdodb+2Gj+0CJDHVPeiB4KdveoMQj0X/
         wUhqBT3fvzumGtyJKbV99u7XSH2jt+4vK0BuQ7ks=
Received: by mail-ej1-f43.google.com with SMTP id x1so12172320ejd.8;
        Tue, 19 May 2020 08:06:21 -0700 (PDT)
X-Gm-Message-State: AOAM53009rEustHcqM6mDrqwzasYQu88MuVr30WtxAYF2azZp2yus/Hs
        qJ3hYLwMD+lxJqeOs5RxuWBywyzc0kxJ4+T2gg==
X-Google-Smtp-Source: ABdhPJxqywpflae8clvRSoz205FDG3+5j2OG7HiXGl7nWU2mgAQwazM8mHI+SRKZTW7x6x9DfTSufqtqAiC8fcsPHqY=
X-Received: by 2002:a17:907:724e:: with SMTP id ds14mr13708797ejc.260.1589900780280;
 Tue, 19 May 2020 08:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200518113156.25009-1-matthias.bgg@kernel.org> <20200518113156.25009-4-matthias.bgg@kernel.org>
In-Reply-To: <20200518113156.25009-4-matthias.bgg@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 19 May 2020 23:06:08 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-Lh=4N2L9ZOrVw+wK1tSrCA=UuOH+7xs0U=12B3Qi7Ug@mail.gmail.com>
Message-ID: <CAAOTY_-Lh=4N2L9ZOrVw+wK1tSrCA=UuOH+7xs0U=12B3Qi7Ug@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: mt6797: Fix mmsys node name
To:     matthias.bgg@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

<matthias.bgg@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8818=E6=97=A5 =E9=
=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> Node names are supposed to match the class of the device. The
> mmsys node is a syscon as it provides more then just a clock controller.
> Update the name.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt6797.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6797.dtsi
> index 136ef9527a0d..3efd032481ce 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> @@ -233,7 +233,7 @@ uart3: serial@11005000 {
>                 status =3D "disabled";
>         };
>
> -       mmsys: mmsys_config@14000000 {
> +       mmsys: syscon@14000000 {
>                 compatible =3D "mediatek,mt6797-mmsys", "syscon";
>                 reg =3D <0 0x14000000 0 0x1000>;
>                 #clock-cells =3D <1>;
> --
> 2.26.2
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
