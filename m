Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E988C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B74D206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBDN+kJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEEJGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgEEJGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 05:06:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D10C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 02:06:32 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 188so728364lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nO6ukHcZ3A2s0DjR/Sbge6NFlDUm1cYVWdAlZ6rxYbs=;
        b=yBDN+kJtFtreoIQShuVrrpbfggrRgrQroU1Jlch/wI7siJg8UatQT2wuM2vHyBFrPn
         VbQYdTFURvS7dwFYRzHHjdOJm7phI0thy7YOmpPj1nMfksJSY16Yo8VvB5q0PClq9D1A
         njGkmIMyXUqrW7mRf/KA4TkXqvmReVxhHBUoygXMQcQ0i+ZTkQzImmKYA1cLmVvSiq6c
         2ewTFwIjP0qzbYL48k+CgRtr6Td0/R1n+nzW0hbLi/dYBilMdWvuVqAV1Hve39PlyBcl
         dxOG19T7mExPkLdSASwhdv0TNaBnDatj2LNGWhmylqN0mSfi7oM57L4P4NBmboEi2iju
         wBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nO6ukHcZ3A2s0DjR/Sbge6NFlDUm1cYVWdAlZ6rxYbs=;
        b=nTt/ahqT4hrKfiyoGbU8AG5EK+qKqJ4xTvSaXRpuWsZZetiFBu+ugTplO3EFOiWBoI
         tVS8711c7xuxrVZqbYpld8YJBNjbQ45kz6aHSVACUlzOy8Gp5cpW7Kw6PLeVXT2XSp8a
         pH/6RWY6t8lT6dtcDGEMkxMAHzFOQ0KhiMo8BvC1pO7Qa0p4aIFmoGLzG3WjXYV+Vtxi
         nrTzPaOhsgkb/iDHZ93zu3MSjWIUnfnS35XA6eY57qkIFrP9iH5qxrwlVjDuLLV26YuY
         sikkv7gvArod5P1QMWGcbxmaPaVZg869+DaRPh9OYTnpVvj+7FoFZIkyPOMxj4hCXRFR
         oBtg==
X-Gm-Message-State: AGi0PuZbyKUc61cC86Uo0VdDHEivzyhpN9PqjRkfMRbXpaAvJzNbGf5/
        jPwHBD4U45nwawYVadwx7J8ZIynb/LZgKgOMrp1dWg==
X-Google-Smtp-Source: APiQypJwoVCHWmXH/6fevEAsP9bi0U+ixeJ1CzTbJIy0zTggYHWzUCRHaeTFmFZj3tCWKqSLBmW/uhcymDPK2nimKsc=
X-Received: by 2002:a19:7004:: with SMTP id h4mr966365lfc.148.1588669591097;
 Tue, 05 May 2020 02:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200505171548.6e1388f4@canb.auug.org.au>
In-Reply-To: <20200505171548.6e1388f4@canb.auug.org.au>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 5 May 2020 11:06:20 +0200
Message-ID: <CADYN=9K90_GQVuc=X-kcryRm0xKDVwfza6RpriNe6ehwsp+-Ew@mail.gmail.com>
Subject: Re: linux-next: Tree for May 5
To:     Stephen Rothwell <sfr@canb.auug.org.au>, grygorii.strashko@ti.com,
        David Miller <davem@davemloft.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 09:16, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Changes since 20200504:
>
> New tree: ti-k3
>
> My fixes tree contains:
>
>   bbefc924d0ff ("ubsan: disable UBSAN_ALIGNMENT under COMPILE_TEST")
>   7cb1d38f52b1 ("drm/msm: Fix undefined "rd_full" link error")
>
> The qcom tree still had its build failure for which I reverted a commit.
>
> Non-merge commits (relative to Linus' tree): 5888
>  6922 files changed, 233385 insertions(+), 91859 deletions(-)
>

I did an arm64 allmodconfig build and got this undefined symbol:

aarch64-linux-gnu-ld: drivers/net/ethernet/ti/am65-cpsw-nuss.o: in
function `am65_cpsw_init_cpts':
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-nuss.c:1685:
undefined reference to `am65_cpts_create'
aarch64-linux-gnu-ld:
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-nuss.c:1685:(.text+0x2e20):
relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
`am65_cpts_create'
aarch64-linux-gnu-ld: drivers/net/ethernet/ti/am65-cpsw-nuss.o: in
function `am65_cpsw_nuss_tx_compl_packets':
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-nuss.c:923:
undefined reference to `am65_cpts_tx_timestamp'
aarch64-linux-gnu-ld:
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-nuss.c:923:(.text+0x4cf0):
relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
`am65_cpts_tx_timestamp'
aarch64-linux-gnu-ld: drivers/net/ethernet/ti/am65-cpsw-nuss.o: in
function `am65_cpsw_nuss_ndo_slave_xmit':
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-nuss.c:1018:
undefined reference to `am65_cpts_prep_tx_timestamp'
aarch64-linux-gnu-ld:
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-nuss.c:1018:(.text+0x58fc):
relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
`am65_cpts_prep_tx_timestamp'
aarch64-linux-gnu-ld: drivers/net/ethernet/ti/am65-cpsw-nuss.o: in
function `am65_cpsw_nuss_hwtstamp_set':
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-nuss.c:1265:
undefined reference to `am65_cpts_rx_enable'
aarch64-linux-gnu-ld:
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-nuss.c:1265:(.text+0x7564):
relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
`am65_cpts_rx_enable'
aarch64-linux-gnu-ld: drivers/net/ethernet/ti/am65-cpsw-ethtool.o: in
function `am65_cpsw_get_ethtool_ts_info':
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-ethtool.c:713:
undefined reference to `am65_cpts_phc_index'
aarch64-linux-gnu-ld:
/srv/src/kernel/next/obj-arm64-next-20200505/../drivers/net/ethernet/ti/am65-cpsw-ethtool.c:713:(.text+0xbe8):
relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
`am65_cpts_phc_index'
make[1]: *** [/srv/src/kernel/next/Makefile:1114: vmlinux] Error 1
make[1]: Target 'Image' not remade because of errors.
make: *** [Makefile:180: sub-make] Error 2
make: Target 'Image' not remade because of errors.


I was able to build if I reverted this patch:
b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet
timestamping support")


Cheers,
Anders
