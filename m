Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627E7C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 06:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F310D20796
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 06:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599372951;
	bh=3LOzpkhgg7KndiUMcaG1D3PMxKGP2Vve0vOfAnOeF+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i0MMfF3AKN27T0+v4kWp+JKffjl9mBGKw3Z+cA+4V3s3zNMp6J86HKf5MONqPG42C
	 cUemRn6opHHzrqTEZn5O3meqTQsaXRFjJ3fUOMVM+FlA5sLC5v+kgkwsNeARGEnW7c
	 l3/hDHhO4dLCCnRVQbESQBORN7MldEJA+BsyVCwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgIFGPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 02:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgIFGPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 02:15:45 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65E122075A;
        Sun,  6 Sep 2020 06:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599372944;
        bh=3LOzpkhgg7KndiUMcaG1D3PMxKGP2Vve0vOfAnOeF+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7efverp7pmqiAfzOuuPfYV/lyxn0zRTAEi7F3ORrVZGDSe+Lqv4FEP9x8LEjuyNA
         EgWjpDORzBb5XuR79NYIC3K/fSSa9VElLmWEXzCMedaqpkCmY9szpekWioUB0e+IFf
         sh39eedkR97+lUds13+pQwxoFCYMOtPHIbZKR9C0=
Date:   Sun, 6 Sep 2020 09:15:38 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 1/3] openrisc: Reserve memblock for initrd
Message-ID: <20200906061538.GB1213823@kernel.org>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905131935.972386-2-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 10:19:33PM +0900, Stafford Horne wrote:
> Recently OpenRISC added support for external initrd images, but I found
> some instability when using larger buildroot initrd images. It turned
> out that I forgot to reserve the memblock space for the initrd image.
> 
> This patch fixes the instability issue by reserving memblock space.
> 
> Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/openrisc/kernel/setup.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index b18e775f8be3..13c87f1f872b 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -80,6 +80,16 @@ static void __init setup_memory(void)
>  	 */
>  	memblock_reserve(__pa(_stext), _end - _stext);
>  
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	/* Then reserve the initrd, if any */
> +	if (initrd_start && (initrd_end > initrd_start)) {
> +		unsigned long aligned_start = ALIGN_DOWN(initrd_start, PAGE_SIZE);
> +		unsigned long aligned_end = ALIGN(initrd_end, PAGE_SIZE);
> +
> +		memblock_reserve(__pa(aligned_start), aligned_end - aligned_start);
> +	}
> +#endif /* CONFIG_BLK_DEV_INITRD */
> +
>  	early_init_fdt_reserve_self();
>  	early_init_fdt_scan_reserved_mem();
>  
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
