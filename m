Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB52BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87FD206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592892744;
	bh=l+hyYRnIVC2iQxdxfRPa2SesFK08shiTJw2oFJBHHxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ak0m4psT5WpgkdX5+NIaM/NU0jro7GJx5D/O0BcjC3nMixQGqn4ZwHrdAw5WnZk3L
	 M/iNM/Gz9MueHdN+YSC7ArmW7d2ceT/rAU/lyRHsFs2uakoZ20UjRYZcZ6nqbToMZj
	 sPyaucE93Jf7u9f8KAL546yHJkofxoyBJG5kU/nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgFWGMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:12:23 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:33226 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgFWGMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:12:23 -0400
Received: by mail-ej1-f68.google.com with SMTP id n24so20405977ejd.0;
        Mon, 22 Jun 2020 23:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UU0BBie9LvixRC2b0VCgla9jcvddFZdsxsNkOV1uCgY=;
        b=mDiEDt1dBuZzpUju4QiDC5ow2RAt3u4o0LPNP9t5SY/+yucR6QKgHvItN716nkEA5G
         /x1U720Jy0s9JgEGCOugPh6KoIJUds68zV6dGN3BwbIyQq7Np63s+6N/JWJIqgsbHlyO
         auqR2MbF/9f5RQ41omUvXF5vFXpeKGfmer1/+7eY7nO+n/6S7xty+of61VnDx5isTbqL
         dl/DxBU+35XDmKyGzW82M2J5t5PUUcjpqVs7lEKaUM6cfX9rOtcbmC/H6WFjTsj31mSP
         /ivPsXN3iB9a1ajhJ4BIejqKLAx98z1ZN00L9cMSDcNki/EJHqOOLM//afn5aHe8pTRl
         LJBw==
X-Gm-Message-State: AOAM532HWSolGB8kIp0NDwfJM3+3XMYB52Kv+cUyffVdzM1IPb0Nf33h
        w9KKMJBGWjheXP/n8beqQhRxPlmL
X-Google-Smtp-Source: ABdhPJyLkYTSryJbD7IOeU8SjtQo0ysz+5llL19wPNEplMV7hXqZDcVW4S36nDXL9fGWSXRLaxoKfw==
X-Received: by 2002:a17:906:16d3:: with SMTP id t19mr18156725ejd.297.1592892741168;
        Mon, 22 Jun 2020 23:12:21 -0700 (PDT)
Received: from kozik-lap ([194.230.155.235])
        by smtp.googlemail.com with ESMTPSA id v17sm143808edb.60.2020.06.22.23.12.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 23:12:20 -0700 (PDT)
Date:   Tue, 23 Jun 2020 08:12:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in
 default l2c_aux_val
Message-ID: <20200623061218.GA2983@kozik-lap>
References: <c6d979c0050502cd1bca8619cb5ff95db239db12.1591969825.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6d979c0050502cd1bca8619cb5ff95db239db12.1591969825.git.guillaume.tucker@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 02:58:37PM +0100, Guillaume Tucker wrote:
> This "alert" error message can be seen on exynos4412-odroidx2:
> 
>     L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
>     L2C: platform provided aux values permit register corruption.
> 
> Followed by this plain error message:
> 
>     L2C-310: enabling full line of zeros but not enabled in Cortex-A9
> 
> To fix it, don't set the L310_AUX_CTRL_FULL_LINE_ZERO flag (bit 0) in
> the default value of l2c_aux_val.  It may instead be enabled when
> applicable by the logic in l2c310_enable() if the attribute
> "arm,full-line-zero-disable" was set in the device tree.
> 
> The initial commit that introduced this default value was in v2.6.38:
> 
>   1cf0eb799759 "ARM: S5PV310: Add L2 cache init function in cpu.c"

Run checkpatch in the future on your patches.

I fixed it up.

Best regards,
Krzysztof

> 
> However, the code to set the L310_AUX_CTRL_FULL_LINE_ZERO flag and
> manage that feature was added much later and the default value was not
> updated then.  So this seems to have been a subtle oversight
> especially since enabling it only in the cache and not in the A9 core
> doesn't actually prevent the platform from running.  According to the
> TRM, the opposite would be a real issue, if the feature was enabled in
> the A9 core but not in the cache controller.
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 7a8d1555db40..36c37444485a 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -193,7 +193,7 @@ static void __init exynos_dt_fixup(void)
>  }
>  
>  DT_MACHINE_START(EXYNOS_DT, "Samsung Exynos (Flattened Device Tree)")
> -	.l2c_aux_val	= 0x3c400001,
> +	.l2c_aux_val	= 0x3c400000,
>  	.l2c_aux_mask	= 0xc20fffff,
>  	.smp		= smp_ops(exynos_smp_ops),
>  	.map_io		= exynos_init_io,
> -- 
> 2.20.1
> 
