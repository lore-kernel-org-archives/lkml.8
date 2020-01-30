Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B2BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EC32083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPyBUjHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgA3Vip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:38:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38117 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgA3Vip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:38:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so2162112pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6QfJ9HBGO9DTorqtZWTK9u+KK3d3e9wCrmBq521y58Q=;
        b=EPyBUjHO+0MADFf3JZfdbf7bm5oiDhS6YiZE3gQdN4PQF3asAYW3Dx9ybew4QSCZ1+
         iuxrwyTedod0MtpIz+qbSWXUikGrEJEEoUctYtLvEmhjk1DrtTeHlV8m5r1986P1mQU+
         csU1Fj26m26RcbkfIG3DJNk/dKvO+7N++qCTLuNpOwvRRGd69mpREupGxpLzP82IBIsh
         WuIdeMP1ogcKcOB3RfkTACsZuiEkdDQ1QhNYPV9OUzs0I9vI3XnIu4a+lc6PpnuqLpEz
         zMw31VbkA5lD0VXvCy+bMNnm2F1GcBwE21roMKAkS28Jg/h7uDQnOdd/621Q4LOIsVT4
         VHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QfJ9HBGO9DTorqtZWTK9u+KK3d3e9wCrmBq521y58Q=;
        b=pB2lIWQtTDhgSxh3OYhnrH7CAQovBbl8yvLLC/kaCVDbGCOvfeV4uDZOv+B8XCl3tT
         eU8Q0CyLrMQ0nbJdngLlyJHEVn2BRLcWLj3/BOKmsj0XLiIJ/vPXdYu/1hMTYJ21CZGv
         Cz56DbQ+nX/eyZN+BQBxNaRUXvmwIBTRO9Uw7PdTiA1GO98Qly9MyCjCFSxLKOpOiRLh
         P2H2waPalef5def1Pg2u5YeILTOLF+QDo11NWk8ZbXf8lLQCE2tbxYGG/jNuomxsE38+
         zpF4FLOe3VqDm7pTGdEYEejUMoHO1XtnDgOtjeA4acNDK8jJxggYcsijsgBIDYtjBui0
         W/eg==
X-Gm-Message-State: APjAAAUwIMtenoJ5lpkK7lz/QmNhQAsAyK0tICUixX7uEb3DzrMvAD1a
        PZID/LPEE5DkR9ZBQBSUnjw=
X-Google-Smtp-Source: APXvYqyimoegvKT+KGccepH86/EUUGcZ71ZyKb0o/5V1Hw8ZGiezNG8fAAvzCNWZfHS0VOWLg0R65Q==
X-Received: by 2002:a63:f202:: with SMTP id v2mr6668424pgh.420.1580420322684;
        Thu, 30 Jan 2020 13:38:42 -0800 (PST)
Received: from localhost (g52.222-224-164.ppp.wakwak.ne.jp. [222.224.164.52])
        by smtp.gmail.com with ESMTPSA id 100sm8067781pjo.17.2020.01.30.13.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 13:38:41 -0800 (PST)
Date:   Fri, 31 Jan 2020 06:38:39 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH] openrisc: configs: Cleanup CONFIG_CROSS_COMPILE
Message-ID: <20200130213839.GW24874@lianli.shorne-pla.net>
References: <20200130191938.2444-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130191938.2444-1-krzk@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc: Masahiro,

On Thu, Jan 30, 2020 at 08:19:38PM +0100, Krzysztof Kozlowski wrote:
> CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
> CONFIG_CROSS_COMPILE support").

I see this patch is already in, but does it break 0-day test tools that depend
on this CONFIG_CROSS_COMPILE setup?  I guess its been in since 2018, so there
should be no problem.

Can you also help to update "Documentation/openrisc/openrisc_port.rst"?  It
mentions the build steps are:

    Build the Linux kernel as usual::                                               
                                                                                
        make ARCH=openrisc defconfig                                            
        make ARCH=openrisc

This now changes, I used to use `make ARCH=openrisc CROSS_COMPILE=or1k-linux-`
is this still going to work?

-Stafford

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/openrisc/configs/or1ksim_defconfig    | 1 -
>  arch/openrisc/configs/simple_smp_defconfig | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> index d8ff4f8ffb88..75f2da324d0e 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -1,4 +1,3 @@
> -CONFIG_CROSS_COMPILE="or1k-linux-"
>  CONFIG_NO_HZ=y
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_BLK_DEV_INITRD=y
> diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> index 64278992df9c..ff49d868e040 100644
> --- a/arch/openrisc/configs/simple_smp_defconfig
> +++ b/arch/openrisc/configs/simple_smp_defconfig
> @@ -1,4 +1,3 @@
> -CONFIG_CROSS_COMPILE="or1k-linux-"
>  CONFIG_LOCALVERSION="-simple-smp"
>  CONFIG_NO_HZ=y
>  CONFIG_LOG_BUF_SHIFT=14
> -- 
> 2.17.1
> 
