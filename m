Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B7CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BF320740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589360541;
	bh=CqsZkNMhhFEmwvrrSyan044GTPZoDUPfKqcy2R8Ls0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VmsdvD/ICjA5LyrJJUY6UGu+ExUaN4F1O7dkB0RCIJPxQ4kk9yfRm8eLRnTSIkaHB
	 xz3jwYEDPGtkUKaKzrcRiTEv45JrB0y1OcZlNp9puINWmPT44jarFcg9ZSU7tt2Ixd
	 Ycqv3XUlirRuXF1Y+vY5wL3cm8xBXWWddvqRnHPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbgEMJCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMJCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:02:19 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24654206CC;
        Wed, 13 May 2020 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589360539;
        bh=CqsZkNMhhFEmwvrrSyan044GTPZoDUPfKqcy2R8Ls0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRpAkENqc7CgUSrD1XHKcTgorVVSfpgABaWNQcjdHXZGtlULr1kxklX4v6396FkDp
         A15vbUz9LMe1qwuzG9N4aIg+VsyNXg/ouBOwoaogYUFx4AF7vWFUZvSp8zqgUompwE
         lRE5WW43G125cIf90oyBcY7q0z52qX9nXh9bAzDg=
Date:   Wed, 13 May 2020 17:02:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Samuel Zou <zou_wei@huawei.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     jun.nie@linaro.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ARM: zx: Make zx_smp_prepare_cpus static
Message-ID: <20200513090213.GH26997@dragon>
References: <1589250561-106088-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589250561-106088-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:29:21AM +0800, Samuel Zou wrote:
> Fix the following sparse warning:
> 
> arch/arm/mach-zx/platsmp.c:41:13: warning: symbol 'zx_smp_prepare_cpus' was not declared.
> 
> The zx_smp_prepare_cpus has only call site within platsmp.c
> It should be static
> 
> Fixes: 71bc724300e6 ("ARM: zx: enable SMP and hotplug for zx296702")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>

Hi Arnd,

Can you please apply it to arm-soc tree?

Shawn

> ---
>  arch/arm/mach-zx/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zx/platsmp.c b/arch/arm/mach-zx/platsmp.c
> index d4e1d37..43a33ea 100644
> --- a/arch/arm/mach-zx/platsmp.c
> +++ b/arch/arm/mach-zx/platsmp.c
> @@ -38,7 +38,7 @@ static void __iomem *pcu_base;
>  static void __iomem *matrix_base;
>  static void __iomem *scu_base;
>  
> -void __init zx_smp_prepare_cpus(unsigned int max_cpus)
> +static void __init zx_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	struct device_node *np;
>  	unsigned long base = 0;
> -- 
> 2.6.2
> 
