Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1212C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C699A22B48
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580906634;
	bh=0nhgLoKBd1xmo2Khpi4Cvrfth35BI8Ya1ztqYzurtSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1Xaj593UIWX7UlT/TpA6rto6yW0VWGvWgrXr/cMeVl7UeAL0cX25h4mDHdRWxwZgk
	 1TulS0U6hMFRD9jiCDMXyWtLnpjaVfijK6WQcT1YVVBdkya6eHpzZNnEYFZAmsvGqb
	 WFBPyBbe+2RKPeO3yEeci3R1DT7x8GIWx0A1SyzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgBEMnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgBEMnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:43:53 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8D720674;
        Wed,  5 Feb 2020 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580906632;
        bh=0nhgLoKBd1xmo2Khpi4Cvrfth35BI8Ya1ztqYzurtSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ICzBZX/JpwWLiHlmX/jL53ordUZGAjB3KgThNSGl7YnfS+Km/wWA9MXDeaLBS9Xta
         gGo1PV4ZFrDtjw6ClU4/t2BIFlGX7Wfm6ErX7tcYlvNUnnFNf5xj3BJOcCBAInbLY+
         tAG0Jvn/abpxb0agK7YlmJQOt1cMwzaNZI+xBo8E=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1izK23-00386f-1b; Wed, 05 Feb 2020 12:43:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Feb 2020 12:43:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, tglx@linutronix.de,
        jason@lakedaemon.net, wanghaibin.wang@huawei.com
Subject: Re: [PATCH 1/5] irqchip/gic-v4.1: Fix programming of
 GICR_VPROPBASER_4_1_SIZE
In-Reply-To: <20200204090940.1225-2-yuzenghui@huawei.com>
References: <20200204090940.1225-1-yuzenghui@huawei.com>
 <20200204090940.1225-2-yuzenghui@huawei.com>
Message-ID: <29e6c483b71dcf28e9b140f4edfe566d@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-04 09:09, Zenghui Yu wrote:
> The Size field of GICv4.1 VPROPBASER register indicates number of
> pages minus one and together Page_Size and Size control the vPEID
> width. Let's respect this requirement of the architecture.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index e5a25d97f8db..992bc72cab6f 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2531,7 +2531,7 @@ static int allocate_vpe_l1_table(void)
>  		npg = 1;
>  	}
> 
> -	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg);
> +	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg - 1);
> 
>  	/* Right, that's the number of CPU pages we need for L1 */
>  	np = DIV_ROUND_UP(npg * psz, PAGE_SIZE);

Indeed, nice catch.

         M.
-- 
Jazz is not dead. It just smells funny...
