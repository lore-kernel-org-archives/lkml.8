Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7EFC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEACD20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584484340;
	bh=pZTJ/8UKR7bf2a0aOzgxZOTLFw+VBYwUntAVVeJQlh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rjKd5CfiW91mNi361dFzzLYDlemFrI76zJ1JKuwBH7iBJYiRlXU4j4j0yqhxoKNAf
	 8dkrjvKRAojUnkhMTpeLp9L+2Px0RRrHP0CmrammleAhqASBUJGQZYNhYwjYZaKG/W
	 ZhVbpJ5j3PF1jvVqGgMsjT0zT8J+3ahJVd4VXwfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCQWcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQWcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:32:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E7720409;
        Tue, 17 Mar 2020 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584484338;
        bh=pZTJ/8UKR7bf2a0aOzgxZOTLFw+VBYwUntAVVeJQlh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3Spbdfdq+dp39kywq8qbf1OKNQQfGGu6sD69qgCgIFfNjYeeG0d2iCOpwidhDSH+
         7PCV8eRewGVknqlhQKeqaBJzWeF2MRwdSspUJ0DLT70dtDz2jLej+SVGMQb1f10xZs
         jVnX5ynoYN8q4wQ5ymnUEOAziw0G8bX+TQFKMv3k=
Date:   Tue, 17 Mar 2020 22:32:14 +0000
From:   Will Deacon <will@kernel.org>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64/sdei: gather trampolines' .rodata
Message-ID: <20200317223214.GK20788@willie-the-truck>
References: <20200316124046.103844-2-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316124046.103844-2-remi@remlab.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:40:45PM +0200, Rémi Denis-Courmont wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This gathers the two bits of data together for clarity.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  arch/arm64/kernel/entry.S | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 24f828739696..af17fcb4aaea 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -859,6 +859,11 @@ SYM_CODE_END(tramp_exit_compat)
>  #ifdef CONFIG_RANDOMIZE_BASE
>  	.pushsection ".rodata", "a"
>  	.align PAGE_SHIFT
> +#ifdef CONFIG_ARM_SDE_INTERFACE
> +SYM_DATA_START(__sdei_asm_trampoline_next_handler)
> +	.quad	__sdei_asm_handler
> +SYM_DATA_END(__sdei_asm_trampoline_next_handler)
> +#endif
>  SYM_DATA_START(__entry_tramp_data_start)
>  	.quad	vectors
>  SYM_DATA_END(__entry_tramp_data_start)
> @@ -980,13 +985,6 @@ SYM_CODE_END(__sdei_asm_exit_trampoline)
>  NOKPROBE(__sdei_asm_exit_trampoline)
>  	.ltorg
>  .popsection		// .entry.tramp.text
> -#ifdef CONFIG_RANDOMIZE_BASE
> -.pushsection ".rodata", "a"
> -SYM_DATA_START(__sdei_asm_trampoline_next_handler)
> -	.quad	__sdei_asm_handler
> -SYM_DATA_END(__sdei_asm_trampoline_next_handler)
> -.popsection		// .rodata
> -#endif /* CONFIG_RANDOMIZE_BASE */
>  #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */

Acked-by: Will Deacon <will@kernel.org>

Will
