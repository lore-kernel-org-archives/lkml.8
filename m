Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03198C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE508206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Ydmy5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDIGJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:09:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34495 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgDIGJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:09:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so1968854qtp.1;
        Wed, 08 Apr 2020 23:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxEhGz5UyIPVusyT6gNiVGR9tTVUKwc52tZdZCq8MK0=;
        b=a6Ydmy5JKYTw5OOcKe6O8mQC0kpMXmZ8iP0WuwzotU7b1kni7pBqZQ20c7JNP7LAmr
         0UsXEdQaGYzSF9tebFBJvaQs/By6+7f0Fnuc9K6nfKwtG6rFdMJDSBgkzvyEQIcZNC/d
         sgbgGIeRfl/QeapZ66gJm0yoY6Ss1iuVDPii+rBxeAC0GBuK7qzkDzY73/KfdSGDVC+x
         5irQz7Ls80+3Vf9Z/FfTof+NKJZlCLsE74SdMFSKV58IP0VLHlmuJC8NizNP1L4s0OMF
         R7GnY59c53Zqd2gO4JVqzz1e9anupipR+kVjh0oyGKGr0TpkgW1UyHcTeAagbKwRFRCx
         wcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxEhGz5UyIPVusyT6gNiVGR9tTVUKwc52tZdZCq8MK0=;
        b=Dk8QS5hdw6AZaMwQVxwOIqFt8d7/LmTzfr1eKaLh0zSjtSUeqZfrCmGFuUSE6iEmXX
         e15xV3VYd4n+grD0jBuN3ZUkOUgRHJBz901G4WYd7qAx39qd5ceEo87hPw9GeJIZAB5g
         ii6niaPR3hlIPSUsaH2Qgs4EbOyMOG92WBu7FV90HvGfQfYxmbbL4DMGCLUtZlnjYCY2
         roojwZUpe2wWc39tUddhseNL4bJy6n5EyMUvqm/s3yVpLB+4MrzWgCsn5fHewZWtfrl0
         VQF7K83tt4C+3rM2uANtvej2zBHXfMC6SiA7OKdDqKIUlB9ZmeH6RI9sFWdOIzcCcqJH
         Ye1Q==
X-Gm-Message-State: AGi0PuYjN6nRrNqNIIr0qkQUlhHRW1Lx9ucMCYsrutkAJerwr30hqKKL
        RBRL17BSUhui/HCwHiENZfDOnxPEDuTlOv+Uz+r+kWgh
X-Google-Smtp-Source: APiQypJDJKVPaiW2osqATHrnNzQrZDeGLTK3uOxKyZ8S4iPvkFtam8Xzjq8h9Aq8GBl72G+WAkd1j1MzyeeAiT6W8xs=
X-Received: by 2002:ac8:888:: with SMTP id v8mr3065428qth.194.1586412567849;
 Wed, 08 Apr 2020 23:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200408160044.2550437-1-arnd@arndb.de>
In-Reply-To: <20200408160044.2550437-1-arnd@arndb.de>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 9 Apr 2020 14:09:16 +0800
Message-ID: <CABOV4+UocLs3jLi7-vTi8muiFqACVdxH7Td8=U1ABveLnmyCuw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] clk: sprd: fix compile-testing
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org,
        orson.zhai@unisoc.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for finding out this and fixing it, but we have a minor concern
for changing ARCH_APRD back to bool.

On Thu, Apr 9, 2020 at 2:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I got a build failure with CONFIG_ARCH_SPRD=m when the
> main portion of the clock driver failed to get linked into
> the kernel:
>
> ERROR: modpost: "sprd_pll_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_comp_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_clk_probe" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_clk_regmap_init" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
> ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
> ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
>
> This is a combination of two trivial bugs:
>
> - A platform should not be 'tristate', it should be a 'bool' symbol
>   like the other platforms, if only for consistency, and to avoid
>   surprises like this one.

After a discussion, we decided to change ARCH_SPRD to tristate, the
idea was that we hope we can simply switch all sprd drivers' configs
(whose default is ARCH_SPRD) to 'm' by setting ARCH_SPRD=m, or switch
all them to 'y' by setting ARCH_SPRD=y, instead of changing them one
by one. This requirement originally came from that Google GKI project
asks all vendor drivers to be built as modules.

Thanks,
Chunyan

>
> - The clk Makefile does not traverse into the sprd subdirectory
>   if the platform is disabled but the drivers are enabled for
>   compile-testing.
>
> Fixing either of the two would be sufficient to address the link failure,
> but for correctness, both need to be changed.
>
> Fixes: 2b1b799d7630 ("arm64: change ARCH_SPRD Kconfig to tristate")
> Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig.platforms | 2 +-
>  drivers/clk/Makefile         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 55d70cfe0f9e..3c7e310fd8bf 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -248,7 +248,7 @@ config ARCH_TEGRA
>           This enables support for the NVIDIA Tegra SoC family.
>
>  config ARCH_SPRD
> -       tristate "Spreadtrum SoC platform"
> +       bool "Spreadtrum SoC platform"
>         help
>           Support for Spreadtrum ARM based SoCs
>
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index f4169cc2fd31..60e811d3f226 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -105,7 +105,7 @@ obj-$(CONFIG_CLK_SIFIVE)            += sifive/
>  obj-$(CONFIG_ARCH_SIRF)                        += sirf/
>  obj-$(CONFIG_ARCH_SOCFPGA)             += socfpga/
>  obj-$(CONFIG_PLAT_SPEAR)               += spear/
> -obj-$(CONFIG_ARCH_SPRD)                        += sprd/
> +obj-y                                  += sprd/
>  obj-$(CONFIG_ARCH_STI)                 += st/
>  obj-$(CONFIG_ARCH_STRATIX10)           += socfpga/
>  obj-$(CONFIG_ARCH_SUNXI)               += sunxi/
> --
> 2.26.0
>
