Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138AC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B311C20702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcFvntn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgGLRXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgGLRXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:23:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F03C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:23:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a14so4945715pfi.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GeTQs3D/cNDA8Tjxq+vMi2V5s57uFOOQMK3sBvWwCGo=;
        b=HcFvntn9K8RL/4KQJnsNN0lUyOiIxmOGZ3+b6yblZ0WAzTC4kXwSTreT6G/ov52i+t
         cJQQjGyMX2By4td5snDYhmXclRR0UkC/v3q5y4udnzSs8fTiCJ2QFmHmJiRUy1A6ZYMe
         +ifiA5NNhUD1qMv9pwDYq7n3Wqkr8qXgMkhBLfaG/FAKwk1e14qcpOpYgkY4jhhzG71F
         +FGgPf07nGy8E/oVrTl3NGsfi+5jFVcJ2BkIBKEipIhckqmlUJVeQ/iKv5m9wgI2wmWD
         QJ5DZx5Qf7IW59TU3z3w8sj3korbYLQ5vUvzdx4hTVvcI6oPbxKTdTv6AHfhAg5a8pCN
         GOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GeTQs3D/cNDA8Tjxq+vMi2V5s57uFOOQMK3sBvWwCGo=;
        b=Iyy35f3HqJBzT75lWoBWmiGKiq1HVGhUahH8yC8ycPuTFSK816kxmSD5E34ZpZMv/w
         6Z5QWi6UTClu9Phlepe3hgpkExkwmMYQjI8iehcRwXd0DOEyOtfzml150wuqA91Wtr/Y
         LDuoLHptCia0so5Zr6UhtzTfB6uoS4wrJbV2/O3/47gsWdyMOGxtFx/BsTtZXu0aKCVA
         sa78nCBp1JlFmsEtlZrHdC8yutBHdI1eEnuIW95DhTrAPXuDkinNTVX4ysrZ+elmod0H
         +8trCLRg3QPv2m9TwhusPI2zOC5EE0/BAqpClAlrrjcvjg9hjHIXSNBvINch7k9n9krd
         8GMw==
X-Gm-Message-State: AOAM533Bb2F39hqk6VQ/rD8fR2lwxesVxfiZqImgy+EJMHQJEmbVWNPP
        +SSmtjMofHX5bpmON5yK8Z3G
X-Google-Smtp-Source: ABdhPJxBQq7Z3Qlu5syHfuA7EwuKPGBT75/5pfn81Icpk5sqlbaVJtGGFEZOnhbdOGJRNL3AKlFiWA==
X-Received: by 2002:a63:3151:: with SMTP id x78mr67693505pgx.210.1594574631814;
        Sun, 12 Jul 2020 10:23:51 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id nl5sm12783337pjb.36.2020.07.12.10.23.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 10:23:51 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:53:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 05/10] arm64: dts: actions: limit address range for
 pinctrl node
Message-ID: <20200712172345.GG6110@Mani-XPS-13-9360>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-6-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593701576-28580-6-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:22:51PM +0530, Amit Singh Tomar wrote:
> After commit 7cdf8446ed1d ("arm64: dts: actions: Add pinctrl node for
> Actions Semi S700") following error has been observed while booting
> Linux on Cubieboard7-lite(based on S700 SoC).
> 
> [    0.257415] pinctrl-s700 e01b0000.pinctrl: can't request region for
> resource [mem 0xe01b0000-0xe01b0fff]
> [    0.266902] pinctrl-s700: probe of e01b0000.pinctrl failed with error -16
> 
> This is due to the fact that memory range for "sps" power domain controller
> clashes with pinctrl.
> 
> One way to fix it, is to limit pinctrl address range which is safe
> to do as current pinctrl driver uses address range only up to 0x100.
> 
> This commit limits the pinctrl address range to 0x100 so that it doesn't
> conflict with sps range.
> 
> Fixes: 7cdf8446ed1d ("arm64: dts: actions: Add pinctrl node for Actions
> Semi S700")
> 
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes since v4:
> 	* Reordered it from 04/10 to 05/10.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * this is no more don't merge and fixed
>           the broken S700 boot by limiting pinctrl
>           address range.
>         * Modified the subject to reflect the changes.
> Changes since v1:
>         * No change.
> Changes since RFC:
>         * kept as do not merge.
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 2006ad5424fa..f8eb72bb4125 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -231,7 +231,7 @@
>  
>  		pinctrl: pinctrl@e01b0000 {
>  			compatible = "actions,s700-pinctrl";
> -			reg = <0x0 0xe01b0000 0x0 0x1000>;
> +			reg = <0x0 0xe01b0000 0x0 0x100>;
>  			clocks = <&cmu CLK_GPIO>;
>  			gpio-controller;
>  			gpio-ranges = <&pinctrl 0 0 136>;
> -- 
> 2.7.4
> 
