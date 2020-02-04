Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F87C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5AB21741
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zOJkzAer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgBDKYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:24:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55432 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgBDKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:24:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so2583828wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=8Di6ASz/+t9ylQNviPiHg7bITLqqjwAhj0GpBFWGF/Y=;
        b=zOJkzAerIaHwyYFLOkvre+8Qel5FfFWyLAwjT6oztmUPSWMBUpaRiuuplB0HFoifef
         uiigqpqIXh2LT6Bm513iJXh3B1a0FguRcPs+J9BOrkRzeLiyT3fHcq+WGk6snS0jRxmY
         E/Vc5Vu20XZqZeqhKT3M1DPCX/6fpUpUyRExjkCWgN/axnj305t2H7W21yNVd3nS9tvv
         pqnqRKNSX0WMaOcvpWJczoqPQ8S3EmeOBJsUy2Xer+689hvsS6sikQ8QseRE7yiaz2Dm
         epujVaVZCVK9od8xZpdnlhVYcZ3zaHCkXlRDymuRd7p9wzEQb0NJwVzvwzkVKnNysoT1
         dqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=8Di6ASz/+t9ylQNviPiHg7bITLqqjwAhj0GpBFWGF/Y=;
        b=WmR+OUrefQ6/Zp/QoIhkCW4O1dHrfIUFttsqOvN4eKai39l6KJsaITVmHhm/xPu0jK
         GkPVJULpfTaZGpMLOtRFGQAZz4Oi6wH41PODlzgDz3VEC+ICQEE/46GZJpp+gKQjXrQW
         M7v5rYbmARXnh1KWUm9jImDyKFkLeys4qNBJhTGk835fqiIJM89qkoYP5dqImoDaQ8+w
         92XWRS8HYBl2/2/AsXNr4c1gqlhe/0BfdC83IYcMU8E4sZFQRTXit2Fcd3/9FnjUAcIn
         jWB3KmD+ERkYou9w29QYGNi1S2i/enfgXeVDQLDG24dcE64C10v/nNo9Pwjv4jX85Vks
         UMXA==
X-Gm-Message-State: APjAAAVwVKBK49tWjaiXvrlXjm4fMCOa5WRzmYFo09GxZm/rldGF64dg
        0LjKUwxsRkltbaMDt3t7NkrQFQ==
X-Google-Smtp-Source: APXvYqwwqM9TCMtr6da/jGSKzvje6iPqSV8lHHCFcFwGr4zlwY6+j32lU1xiv+kbQye4qsnhRqFCTg==
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr5242375wma.32.1580811853170;
        Tue, 04 Feb 2020 02:24:13 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l17sm28626715wro.77.2020.02.04.02.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 02:24:12 -0800 (PST)
References: <20200120034937.128600-1-jian.hu@amlogic.com> <20200120034937.128600-3-jian.hu@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/5] clk: meson: add support for A1 PLL clock ops
In-reply-to: <20200120034937.128600-3-jian.hu@amlogic.com>
Date:   Tue, 04 Feb 2020 11:24:11 +0100
Message-ID: <1jftfq7ir8.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 20 Jan 2020 at 04:49, Jian Hu <jian.hu@amlogic.com> wrote:

> Compared with the previous SoCs, self-adaption current module
> is newly added for A1, and there is no reset parm except the
> fixed pll. In A1 PLL, the PLL enable sequence is different, using
> the new power-on sequence to enable the PLL.

Things are getting clearer thanks to Martin's suggestions and I can
understand what your driver is doing now

However, I still have a problem with the fact that 2 different pll types
are getting intertwined in this driver. Parameters mandatory to one is
made optional to the other. Nothing clearly shows which needs what and
the combinatorial are quickly growing.

Apparently the only real difference is in enable/disable, So I would
prefer if the a1 had dedicated function for these ops.

I suppose you'll have to submit clk_hw_enable() and clk_hw_disable()
to the framework to call the appropriate ops dependind on the SoC.

>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/clk-pll.c | 47 +++++++++++++++++++++++++++++++------
>  drivers/clk/meson/clk-pll.h |  2 ++
>  2 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index ddb1e5634739..10926291440f 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -283,10 +283,14 @@ static void meson_clk_pll_init(struct clk_hw *hw)
>  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>  
>  	if (pll->init_count) {
> -		meson_parm_write(clk->map, &pll->rst, 1);
> +		if (MESON_PARM_APPLICABLE(&pll->rst))
> +			meson_parm_write(clk->map, &pll->rst, 1);
> +

replace by
        enabled = clk_hw_is_enabled(hw)
        if (enabled)
           clk_hw_disable(hw)

>  		regmap_multi_reg_write(clk->map, pll->init_regs,
>  				       pll->init_count);
> -		meson_parm_write(clk->map, &pll->rst, 0);
> +
> +		if (MESON_PARM_APPLICABLE(&pll->rst))
> +			meson_parm_write(clk->map, &pll->rst, 0);

       /* restore if necessary */
       if (enabled)
          clk_hw_enable(hw)

>  	}
>  }
>  
> @@ -295,8 +299,11 @@ static int meson_clk_pll_is_enabled(struct clk_hw *hw)
>  	struct clk_regmap *clk = to_clk_regmap(hw);
>  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>  
> -	if (meson_parm_read(clk->map, &pll->rst) ||
> -	    !meson_parm_read(clk->map, &pll->en) ||
> +	if (MESON_PARM_APPLICABLE(&pll->rst) &&
> +	    meson_parm_read(clk->map, &pll->rst))
> +		return 0;
> +
> +	if (!meson_parm_read(clk->map, &pll->en) ||
>  	    !meson_parm_read(clk->map, &pll->l))
>  		return 0;

I suppose the pll can't be locked if it was in reset, so we could drop
the check on `rst` entirely to simplify the function

>  
> @@ -323,13 +330,34 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>  		return 0;
>  
>  	/* Make sure the pll is in reset */
> -	meson_parm_write(clk->map, &pll->rst, 1);
> +	if (MESON_PARM_APPLICABLE(&pll->rst))
> +		meson_parm_write(clk->map, &pll->rst, 1);
>  
>  	/* Enable the pll */
>  	meson_parm_write(clk->map, &pll->en, 1);
>  
>  	/* Take the pll out reset */
> -	meson_parm_write(clk->map, &pll->rst, 0);
> +	if (MESON_PARM_APPLICABLE(&pll->rst))
> +		meson_parm_write(clk->map, &pll->rst, 0);
> +
> +	/*
> +	 * Compared with the previous SoCs, self-adaption current module
> +	 * is newly added for A1, keep the new power-on sequence to enable the
> +	 * PLL. The sequence is:
> +	 * 1. enable the pll, delay for 10us
> +	 * 2. enable the pll self-adaption current module, delay for 40us
> +	 * 3. enable the lock detect module
> +	 */
> +	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
> +		udelay(10);
> +		meson_parm_write(clk->map, &pll->current_en, 1);
> +		udelay(40);
> +	};
> +
> +	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
> +		meson_parm_write(clk->map, &pll->l_detect, 1);
> +		meson_parm_write(clk->map, &pll->l_detect, 0);
> +	}
>  
>  	if (meson_clk_pll_wait_lock(hw))
>  		return -EIO;
> @@ -343,10 +371,15 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
>  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>  
>  	/* Put the pll is in reset */
> -	meson_parm_write(clk->map, &pll->rst, 1);
> +	if (MESON_PARM_APPLICABLE(&pll->rst))
> +		meson_parm_write(clk->map, &pll->rst, 1);
>  
>  	/* Disable the pll */
>  	meson_parm_write(clk->map, &pll->en, 0);
> +
> +	/* Disable PLL internal self-adaption current module */
> +	if (MESON_PARM_APPLICABLE(&pll->current_en))
> +		meson_parm_write(clk->map, &pll->current_en, 0);
>  }

With the above clarified, it should be easy to properly split the
functions between the legacy type and the a1 type.

You'll need to update meson_clk_pll_set_rate() to call
 - clk_hw_is_enabled()
 - clk_hw_enable() and clk_hw_disable() (again, you'll need to add
 those in the framework first)

>  
>  static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
> index 367efd0f6410..a2228c0fdce5 100644
> --- a/drivers/clk/meson/clk-pll.h
> +++ b/drivers/clk/meson/clk-pll.h
> @@ -36,6 +36,8 @@ struct meson_clk_pll_data {
>  	struct parm frac;
>  	struct parm l;
>  	struct parm rst;
> +	struct parm current_en;
> +	struct parm l_detect;
>  	const struct reg_sequence *init_regs;
>  	unsigned int init_count;
>  	const struct pll_params_table *table;

