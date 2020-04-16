Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5788C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9FB22209
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587072280;
	bh=RRSObpGdrqNjfvIEEsG9Z/f7yPIRU00BfWL00R3oQI4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=upKg24RMccbf5NEg/QoOlAW537/8obNwRWnjuYulRpA0Syp05s35pqJWq5o7R2xrj
	 Iyq84baDAQJAAQ4A0W3374MvR6SMS4Gieyfc73POkehycUYHYIT2lDxkDGt8BO2CJ1
	 LZQGT2EpzmpbhXqRr/re67usGBh7xW27R2KYgs2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgDPVYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgDPVYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:24:38 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5977322201;
        Thu, 16 Apr 2020 21:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587072278;
        bh=RRSObpGdrqNjfvIEEsG9Z/f7yPIRU00BfWL00R3oQI4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jI3mqniXkjRzCj5RdMnIQkietwemkVIBM4mQtulV72/U7JOWC8lpxOr4B+KyrKssC
         upzZmCbx89P2OYVS8pe6EyeWIgs9QcbA55HfYWaLbt86LykbuIQOQ7oQnzpPpWxQIa
         rDe0O27DWQeHq+pIexYRjp1VA2dURAAspGXaOq1Q=
Date:   Thu, 16 Apr 2020 14:24:37 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jason Yan <yanaijie@huawei.com>
cc:     sstabellini@kernel.org, linux@armlinux.org.uk,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>, jgross@suse.com
Subject: Re: [PATCH] arm/xen: make _xen_start_info static
In-Reply-To: <20200415084853.5808-1-yanaijie@huawei.com>
Message-ID: <alpine.DEB.2.21.2004161424090.8316@sstabellini-ThinkPad-T480s>
References: <20200415084853.5808-1-yanaijie@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, Jason Yan wrote:
> Fix the following sparse warning:
> 
> arch/arm64/xen/../../arm/xen/enlighten.c:39:19: warning: symbol
> '_xen_start_info' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  arch/arm/xen/enlighten.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index dd6804a64f1a..fd4e1ce1daf9 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -36,7 +36,7 @@
>  
>  #include <linux/mm.h>
>  
> -struct start_info _xen_start_info;
> +static struct start_info _xen_start_info;
>  struct start_info *xen_start_info = &_xen_start_info;
>  EXPORT_SYMBOL(xen_start_info);
>  
> -- 
> 2.21.1
> 
