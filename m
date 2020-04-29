Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EA6C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA182085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RB2S6Kbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgD2MhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726740AbgD2MhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:37:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA92C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:37:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so1842157wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=NkpmzV5D80JNy4ts2YZIu3+YM84vR2UzyeLRZ8y2XUk=;
        b=RB2S6Kbc+kfXu6qf/y6WSvhN9KPpKce18ars9tpM2GQHKrokwDv6/gMX4kdak20F6j
         KXNYe2U3QdGzROWkaeE5+5esEhR6IdymhTSFRH5is6PbUfFZjdXEhNZXda8pGH9KVC2H
         wX/PkvDEyEKQ+60pRvswRIlPgDyTsEywC3MJkTI+LCDEJ//QbLAJ0qmL31Ql306LvGM6
         5o+o682PQZk5WTzs0jbP/ePdF4FvqO+2vokdsZ2rnTvaqBsOLpIvsOr3AmoToWMeieYb
         HoJxSlRteoXodvsrMnkadcgDRcAmpXv/EkkM0q4N6XjFvFN+jDEk1BF908zvESsOTGvR
         Znrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=NkpmzV5D80JNy4ts2YZIu3+YM84vR2UzyeLRZ8y2XUk=;
        b=X2mhGNbV0Y6v2bMDz71Rbvk2qzz+67hhmdEMoIhcJLpUy1WDdKETS4VVwakAgyJ9l3
         dM5y1rpAMAzWGxH7g49kx+tovJAv7+d9q2/hCR6BebhuLdlvJCsr0PLuwpU0HyYBbOZW
         GhmTkN31E4GHqZY6Pcv6Mq8kBGF+/rYf4WfiT4+LWN4BuJHa4ZemAFBMSJBZheSrlA5s
         8rn3/4X329fZJLkVjVE6NshpyduT+B7RIrocNFuZaMHjOMAg3WTw2Vt1AS9TVNvfha9o
         /W1p0MFSn4dSWCR9Z58LTbRXEEvIM25kJlpcYzJsYEH5dtB+cUr05Hz3vHfRLV/v42I1
         Wmzw==
X-Gm-Message-State: AGi0PuZsQfDcc68go3GMPbyAyooAR8/6Sht6aw+xGSO2gYhUe1lnLiRu
        64nsF0Zk9MtwsI5IhkYCD0Jlvw==
X-Google-Smtp-Source: APiQypJ9Jp2lZbXV6sSejvUm+Db6rvnl5p9Dp9DKoDBbqDndVu48hMIlklKxV/5CTB1MdnSh1tZZ3A==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr3302337wmb.10.1588163830921;
        Wed, 29 Apr 2020 05:37:10 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id k23sm7597481wmi.46.2020.04.29.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:37:10 -0700 (PDT)
References: <20200429031416.3900-1-bernard@vivo.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bernard Zhao <bernard@vivo.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: Re: [PATCH] clk/meson: fixes memleak issue in init err branch
In-reply-to: <20200429031416.3900-1-bernard@vivo.com>
Date:   Wed, 29 Apr 2020 14:37:09 +0200
Message-ID: <1jpnbqii2y.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 29 Apr 2020 at 05:14, Bernard Zhao <bernard@vivo.com> wrote:

> In common init function, when run into err branch, we didn`t
> use kfree to release kzmalloc area, this may bring in memleak

Thx for reporting this Bernard.
I'm not a fan of adding kfree everywhere. I'd much prefer a label and
clear error exit path.

That being said, the allocation is probably not the only thing that
needs to be undone in case of error. I guess this is due to conversion
to CLK_OF_DECLARE_DRIVER() which forced to drop all the devm_
This was done because the clock controller was required early in the
boot sequence.

There is 2 paths to properly solve this:
1) Old school: manually undo everything with every error exit condition
   Doable but probably a bit messy
2) Convert back the driver to a real platform driver and use devm_.
   We would still need the controller to register early but I wonder if
   we could use the same method as drivers/clk/mediatek/clk-mt2701.c and
   use arch_initcall() ?

Martin, you did the initial conversion, what do you think of option 2 ?
Would it still answer the problem you were trying to solve back then ?

One added benefit of option 2 is we could drop CLK_OF_DECLARE_DRIVER().
We could even do the same in for the other SoCs, which I suppose would
avoid a fair amount of probe deferral.

>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/clk/meson/meson8b.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 34a70c4b4899..0f07d5a4cd16 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -3687,6 +3687,7 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
>  	if (ret) {
>  		pr_err("%s: Failed to register clkc reset controller: %d\n",
>  		       __func__, ret);
> +		kfree(rstc);
>  		return;
>  	}
>  
> @@ -3710,8 +3711,10 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
>  			continue;
>  
>  		ret = of_clk_hw_register(np, clk_hw_onecell_data->hws[i]);
> -		if (ret)
> +		if (ret) {
> +			kfree(rstc);
>  			return;
> +		}
>  	}
>  
>  	meson8b_cpu_nb_data.cpu_clk = clk_hw_onecell_data->hws[CLKID_CPUCLK];
> @@ -3727,13 +3730,16 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
>  	if (ret) {
>  		pr_err("%s: failed to register the CPU clock notifier\n",
>  		       __func__);
> +		kfree(rstc);
>  		return;
>  	}
>  
>  	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
>  				     clk_hw_onecell_data);
> -	if (ret)
> +	if (ret) {
>  		pr_err("%s: failed to register clock provider\n", __func__);
> +		kfree(rstc);
> +	}
>  }
>  
>  static void __init meson8_clkc_init(struct device_node *np)

