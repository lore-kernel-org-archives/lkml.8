Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A4EC47258
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083C62184D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TLRUgGZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgEBAB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEBAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:01:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107FC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 17:01:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h9so3407051wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=mnpsimwuy1HsCYdnivLxUTPWGJ+CV1JI9EBiJoWcRMA=;
        b=TLRUgGZlzXDwbdGjCQKtFdsgwYIYywxs6IL2aaocBIxiHaukVw6K6LresyCp6t4BIr
         FTTqJD0TWaAqQ2cKqNfZCrGdiVU2fCHPQMSCdmbAEe0y4PHtHyhEWhvURKhanRCb1hVR
         kLuKs6W7wbYYvOLdaGsw24wZJs61iX329BFV267Vdr8wcbvzrQFRC/+J428L9qnwZi1T
         oPEz5vYKrQR6JTs4y3wBPMagXasiimuMJ6TsOukYAb75lv58yhPH5QSXAaxWsB3WmNrk
         vJjh89QVZWYh3QkCxQn2vVvnhG5PoD9c3EF/g4L8f4HsuNYe2dpvatNA2XZyCPqoUgTE
         2aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=mnpsimwuy1HsCYdnivLxUTPWGJ+CV1JI9EBiJoWcRMA=;
        b=qyaRJ5mxvf7Ie3H/fAOI69dRGuCwDTQIR/GckA1C/a4MoA/B1RWvN4dbNWJrp3YCd7
         aY71Y3Q/7uu5BVSpFzEMr6me7+NKaGW/duEn82B+xasV5DCC4g/MVak1afwdgujMdtUb
         XJL12ECGRJQL/YU1202GIZsvSQvVYptfRl5OyQJVh7ehbFBmZAKTU4bvgwSeX9anuLb0
         Vnq/bbFWI/O1cNrVKJKyXPiCvIt7g30+1PoDZeN9OX2gOtzXIxeTHnuAQacN92OUa1Jb
         Fak9Urjtl5RCarVOzcee8pkmwHTeP9LrxxYKrj3DQ7WwcbQJUTiMdMu0zteXdQyv7Ndm
         92Tg==
X-Gm-Message-State: AGi0PuYpdm50igcBXpabaIenpfSxzAKIAsifn8RlKSz00xGgbeb+ll1O
        afWUBIhJ0IQTcAAV5mkGOc582A==
X-Google-Smtp-Source: APiQypIC1GGFwHeCAXP+xnmsMVu4bX6+mXS0f6uQUk++cUTQ7edzDBG/oInezxMVoP8L2WvMnSlbPQ==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr6556110wrq.368.1588377713218;
        Fri, 01 May 2020 17:01:53 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id s9sm7330900wrg.27.2020.05.01.17.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 17:01:52 -0700 (PDT)
References: <20200501215717.735393-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: meson8b: Don't rely on u-boot to init all GP_PLL registers
In-reply-to: <20200501215717.735393-1-martin.blumenstingl@googlemail.com>
Date:   Sat, 02 May 2020 02:01:50 +0200
Message-ID: <1jees3i4r5.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 01 May 2020 at 23:57, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Not all u-boot versions initialize the HHI_GP_PLL_CNTL[2-5] registers.
> In that case all HHI_GPLL_PLL_CNTL[1-5] registers are 0x0 and when
> booting Linux the PLL fails to lock.
> The initialization sequence from u-boot is:
> - put the PLL into reset
> - write 0x59C88000 to HHI_GP_PLL_CNTL2
> - write 0xCA463823 to HHI_GP_PLL_CNTL3
> - write 0x0286A027 to HHI_GP_PLL_CNTL4
> - write 0x00003000 to HHI_GP_PLL_CNTL5
> - set M, N, OD and the enable bit
> - take the PLL out of reset
> - check if it has locked
> - disable the PLL
>
> In Linux we already initialize M, N, OD, the enable and the reset bits.
> Also the HHI_GP_PLL_CNTL[2-5] registers with these magic values (the
> exact meaning is unknown) so the PLL can lock when the vendor u-boot did
> not initialize these registers yet.
>
> Fixes: b882964b376f21 ("clk: meson: meson8b: add support for the GP_PLL clock on Meson8m2")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Jerome, this one is also not critical because we don't enable the VPU
> yet. So I based this on commit 16afd70af5b21b ("clk: meson: meson8b:
> Make the CCF use the glitch-free VPU mux").
>
>
>  drivers/clk/meson/meson8b.c | 9 +++++++++
>  drivers/clk/meson/meson8b.h | 4 ++++
>  2 files changed, 13 insertions(+)

Applied, Thx

>
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 811af1c11456..edc09d050ecf 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -1918,6 +1918,13 @@ static struct clk_regmap meson8b_mali = {
>  	},
>  };
>  
> +static const struct reg_sequence meson8m2_gp_pll_init_regs[] = {
> +	{ .reg = HHI_GP_PLL_CNTL2,	.def = 0x59c88000 },
> +	{ .reg = HHI_GP_PLL_CNTL3,	.def = 0xca463823 },
> +	{ .reg = HHI_GP_PLL_CNTL4,	.def = 0x0286a027 },
> +	{ .reg = HHI_GP_PLL_CNTL5,	.def = 0x00003000 },
> +};
> +
>  static const struct pll_params_table meson8m2_gp_pll_params_table[] = {
>  	PLL_PARAMS(182, 3),
>  	{ /* sentinel */ },
> @@ -1951,6 +1958,8 @@ static struct clk_regmap meson8m2_gp_pll_dco = {
>  			.width   = 1,
>  		},
>  		.table = meson8m2_gp_pll_params_table,
> +		.init_regs = meson8m2_gp_pll_init_regs,
> +		.init_count = ARRAY_SIZE(meson8m2_gp_pll_init_regs),
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "gp_pll_dco",
> diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
> index 94ce3ef0c1d5..cd38ae2a9cb5 100644
> --- a/drivers/clk/meson/meson8b.h
> +++ b/drivers/clk/meson/meson8b.h
> @@ -20,6 +20,10 @@
>   * [0] http://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
>   */
>  #define HHI_GP_PLL_CNTL			0x40  /* 0x10 offset in data sheet */
> +#define HHI_GP_PLL_CNTL2		0x44  /* 0x11 offset in data sheet */
> +#define HHI_GP_PLL_CNTL3		0x48  /* 0x12 offset in data sheet */
> +#define HHI_GP_PLL_CNTL4		0x4C  /* 0x13 offset in data sheet */
> +#define HHI_GP_PLL_CNTL5		0x50  /* 0x14 offset in data sheet */
>  #define HHI_VIID_CLK_DIV		0x128 /* 0x4a offset in data sheet */
>  #define HHI_VIID_CLK_CNTL		0x12c /* 0x4b offset in data sheet */
>  #define HHI_GCLK_MPEG0			0x140 /* 0x50 offset in data sheet */

