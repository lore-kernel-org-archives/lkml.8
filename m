Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B59C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CC2207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595963888;
	bh=EU5ct3aw8AQbancyApjQExQvAf+xqB4OEQvinl7PmT0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Mn+6rBMsI/AbP4mphU4aBUbRWKGxeIQ2XbZwZ7QBt0NpUZurcNrw9MRfaJ7KEQw1L
	 0VfOZZnLvD2MbauWgv9wuCmGP+ffwjcjaCKKL+gZtzh/mVliRoUKp12xtJ9BmwW+n+
	 dOYl3OOTdakHwRuDxS96vF/upSBpEsKPIl33p+bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbgG1TSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728751AbgG1TSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:18:06 -0400
Received: from [192.168.1.28] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E412065C;
        Tue, 28 Jul 2020 19:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595963885;
        bh=EU5ct3aw8AQbancyApjQExQvAf+xqB4OEQvinl7PmT0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GsThgcJB0BIaHq80ejFFkhu3aeVoptFldUM1NzpFguUpLKbSb9HJ9m7KEowUpHtgn
         vGjRRjyGEHfe9hTCNtHsYHBc8IZcjBTzrSLVnDiNnyzGw12dy80tw6xvBILmAudD4o
         fj/jB2uQ1+VWdor1+kGmSEC6FpKzCzKlBVDBeKvc=
Subject: Re: [PATCH] ARM: socfpga: PM: add missing put_device() call in
 socfpga_setup_ocram_self_refresh()
To:     Yu Kuai <yukuai3@huawei.com>, linux@armlinux.org.uk,
        atull@opensource.altera.com, khilman@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20200721134551.1276641-1-yukuai3@huawei.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8d06f69f-6560-aa98-ff12-004e77a26f01@kernel.org>
Date:   Tue, 28 Jul 2020 14:18:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721134551.1276641-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/20 8:45 AM, Yu Kuai wrote:
> if of_find_device_by_node() succeed, socfpga_setup_ocram_self_refresh
> doesn't have a corresponding put_device(). Thus add a jump target to
> fix the exception handling for this function implementation.
> 
> Fixes: 44fd8c7d4005 ("ARM: socfpga: support suspend to ram")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  arch/arm/mach-socfpga/pm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
> index 6ed887cf8dc9..365c0428b21b 100644
> --- a/arch/arm/mach-socfpga/pm.c
> +++ b/arch/arm/mach-socfpga/pm.c
> @@ -49,14 +49,14 @@ static int socfpga_setup_ocram_self_refresh(void)
>  	if (!ocram_pool) {
>  		pr_warn("%s: ocram pool unavailable!\n", __func__);
>  		ret = -ENODEV;
> -		goto put_node;
> +		goto put_device;
>  	}
>  
>  	ocram_base = gen_pool_alloc(ocram_pool, socfpga_sdram_self_refresh_sz);
>  	if (!ocram_base) {
>  		pr_warn("%s: unable to alloc ocram!\n", __func__);
>  		ret = -ENOMEM;
> -		goto put_node;
> +		goto put_device;
>  	}
>  
>  	ocram_pbase = gen_pool_virt_to_phys(ocram_pool, ocram_base);
> @@ -67,7 +67,7 @@ static int socfpga_setup_ocram_self_refresh(void)
>  	if (!suspend_ocram_base) {
>  		pr_warn("%s: __arm_ioremap_exec failed!\n", __func__);
>  		ret = -ENOMEM;
> -		goto put_node;
> +		goto put_device;
>  	}
>  
>  	/* Copy the code that puts DDR in self refresh to ocram */
> @@ -81,6 +81,8 @@ static int socfpga_setup_ocram_self_refresh(void)
>  	if (!socfpga_sdram_self_refresh_in_ocram)
>  		ret = -EFAULT;
>  
> +put_device:
> +	put_device(&pdev->dev);
>  put_node:
>  	of_node_put(np);
>  
> 

Applied!

Thanks,
Dinh
