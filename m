Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67716C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B46C2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584482772;
	bh=jg1FxJQAmhdeplR39xeuAeUIFFGrx1NIE4MK8j7xaGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x58kVKS+j4MHiEgSj22fSeA53QKON5BLUShQa4H9XeAIM7ab5bI1MlKneDvAvz63G
	 Oj+LEO6BAFrfN3FixPpD+aMZ2JrS6RxikCV8Gx/PM2F/lfl/SJk+GzRnvSpLcEAdaw
	 Th5CqGGT8i51Tf6Y2dRT6HIyOmbKcPRRNXduH0mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgCQWGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgCQWGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:06:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5672B20714;
        Tue, 17 Mar 2020 22:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584482770;
        bh=jg1FxJQAmhdeplR39xeuAeUIFFGrx1NIE4MK8j7xaGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VERFBito2jxzIAn/ZE8ds7YhF97HaUU1BEXN6qy5jL0hkelyWgvRcmHGwmFmuE/kQ
         oRemJf6/sC3fcz2FEBjEbj3VZciyNAENHgXXClQ4YERLD8FZtnlwg7PhPvQWUnSdrm
         adBYiU9nqV7l2Jpyf1ZRbuIds2wC2o/f2CNzbFtA=
Date:   Tue, 17 Mar 2020 22:06:04 +0000
From:   Will Deacon <will@kernel.org>
To:     =?utf-8?B?6Z+p56eR5omN?= <hankecai@vivo.com>
Cc:     catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Dave.Martin@arm.com, broonie@kernel.org,
        amurray@thegoodpenguin.co.uk, jeremy.linton@arm.com,
        tglx@linutronix.de, =?utf-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>,
        trivial@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: remove redundant blank for '=' operator
Message-ID: <20200317220602.GC20788@willie-the-truck>
References: <ALsA-QB3CCyH77MiU4gx3arM.1.1583909569099.Hmail.hankecai@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ALsA-QB3CCyH77MiU4gx3arM.1.1583909569099.Hmail.hankecai@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 02:52:49PM +0800, 韩科才 wrote:
> remove redundant blank for '=' operator, it may be more elegant.
> 
> Signed-off-by: hankecai <hankecai@vivo.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 0b6715625cf6..ce60d1012bfa 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -551,7 +551,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  
>  	BUG_ON(!reg);
>  
> -	for (ftrp  = reg->ftr_bits; ftrp->width; ftrp++) {
> +	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
>  		u64 ftr_mask = arm64_ftr_mask(ftrp);
>  		s64 ftr_new = arm64_ftr_value(ftrp, new);

Acked-by: Will Deacon <will@kernel.org>

Will
