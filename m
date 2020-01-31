Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45049C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FAD215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlfrjcRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgAaNKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:10:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34371 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgAaNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:10:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so3442523pgi.1;
        Fri, 31 Jan 2020 05:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ABA8Gc/rIwSuk9yNeKLXZQ3+u7dy+VUPkUzWmHal5Bs=;
        b=MlfrjcRijE+sWoWfClWA3D1nCX8dFryivepO9XJXxylRaMg/MeaF4NnIJjrw0sgtpt
         urMc/dDyjFRgRWOfTJ4xV5fbdML/s2YcsrnytGbcUcvX+c0mJ9+SXb02AQtFHregCMGP
         VmFHq34xbEH3X7IkWO4d4uqAOzdgGpkhZXoojN7xOw1SgzVHW9s7epREvfBwwQcehlWo
         1YgEeMS9p6C6dkd2fdj2mJ6s6l6NvbFaRnFNwmAY02QyGzE8CpQOHUPrX3h4UYf8qgr3
         urIlZ21VQB9JPIZbF4Qud3oNNhyZmtyCGmTefiwI2kEZpRyXuTxEYhwC0q4xU2jDRFlb
         gR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ABA8Gc/rIwSuk9yNeKLXZQ3+u7dy+VUPkUzWmHal5Bs=;
        b=qvmGVaZCybg3h+aX3txBZXs4DaACXGw1OTgZpCRmuM8wUd7bkYp48fw32jL6wCfR7d
         TaRCzE+q+LfQ8JK/X47E4gJOcl0P57d5pPSRBvui+Tf3Ha6yP5cQK+bACRkWVs4r9uzH
         VtnMGw3AVthLYNwLVPhXXCsbnaguJY4341XHO2Xuliavl0tD0a4vERhVmC5113vK5hid
         7Uy8H6Sjb2qGw23UCBukQWUoUilVMBWwg5+Mcrg83bb8d/Z2dvkOP4IGuapkvveXXuQ5
         AU2kJYnfd+pC2sKp1cWmy610CLCNqrcjwYxCnptxNZYV42pgO+OcMGsENWhLVYuzvGBh
         B5Pg==
X-Gm-Message-State: APjAAAVrEfvqLxBImB/gXg+Q8J3cujwsHfndLQGDgCwsRglk1+pRsgq+
        Mx4RgISfd0dDXUGT7Lz4bgQ=
X-Google-Smtp-Source: APXvYqzE9mrpk2rqIoQNk72UknhVj+3SbtoVlh37mw2wUDg+S9OM4d98tNyUUe8l9BMlPwxxKfivog==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr10632074pfo.114.1580476214691;
        Fri, 31 Jan 2020 05:10:14 -0800 (PST)
Received: from localhost (g52.222-224-164.ppp.wakwak.ne.jp. [222.224.164.52])
        by smtp.gmail.com with ESMTPSA id p24sm10067351pgk.19.2020.01.31.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 05:10:13 -0800 (PST)
Date:   Fri, 31 Jan 2020 22:10:11 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Jonathan Corbet <corbet@lwn.net>,
        openrisc@lists.librecores.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2] openrisc: configs: Cleanup CONFIG_CROSS_COMPILE
Message-ID: <20200131131011.GX24874@lianli.shorne-pla.net>
References: <1580459313-16926-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580459313-16926-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 09:28:33AM +0100, Krzysztof Kozlowski wrote:
> CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
> CONFIG_CROSS_COMPILE support").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
 
Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks, I will queue this for 5.7.

> ---
> 
> Changes since v1:
> 1. Update also docs.
> ---
>  Documentation/openrisc/openrisc_port.rst   | 4 ++--
>  arch/openrisc/configs/or1ksim_defconfig    | 1 -
>  arch/openrisc/configs/simple_smp_defconfig | 1 -
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
> index a18747a8d191..4b2c437942a0 100644
> --- a/Documentation/openrisc/openrisc_port.rst
> +++ b/Documentation/openrisc/openrisc_port.rst
> @@ -37,8 +37,8 @@ or Stafford's toolchain build and release scripts.
>  
>  Build the Linux kernel as usual::
>  
> -	make ARCH=openrisc defconfig
> -	make ARCH=openrisc
> +	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" defconfig
> +	make ARCH=openrisc CROSS_COMPILE="or1k-linux-"
>  
>  3) Running on FPGA (optional)
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
> 2.7.4
> 
