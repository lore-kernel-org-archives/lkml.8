Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81CAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F782082E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592343603;
	bh=NAcC0C5+lhAkJJBBDMO+UHb5TJKRWin2TviSHE2JPPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0wxSmJiEcfRO83Dm+KgXMUG7HtYnWzn7/hJ2Bjx2AIRRkxcvRNlXXLS9PG9UevT+T
	 X5/ueAYEVIgHNPUjlKUiRGHTa6r3O/QLaWMIDWz6SzjtKYNNDmbEINQWrQ/zWkNZde
	 h3OQXjRAySna//irKqaBkEALIrSNPBQguC/mFu5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFPVj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgFPVj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:39:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9A742082E;
        Tue, 16 Jun 2020 21:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592343598;
        bh=NAcC0C5+lhAkJJBBDMO+UHb5TJKRWin2TviSHE2JPPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZ+vVY98S3MdQSrzT7nf8/jg2P0oOocyAto8BzVR96Ti+4lwAl7q/9m+10hINfM9u
         LrF0pCBZabIwXnZHACZ+2Hwcofw+zdq3R4f/o620KS7tOyZp+Iwbzcy/Da5x6QIXND
         46h54xMlmpCise5E7WEG12r2zcRmfOKR8Uy6w4fg=
Date:   Tue, 16 Jun 2020 22:39:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64/module: Optimize module load time by optimizing
 PLT counting
Message-ID: <20200616213953.GA2561@willie-the-truck>
References: <20200605222257.44882-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605222257.44882-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 03:22:57PM -0700, Saravana Kannan wrote:
> When loading a module, module_frob_arch_sections() tries to figure out
> the number of PLTs that'll be needed to handle all the RELAs. While
> doing this, it tries to dedupe PLT allocations for multiple
> R_AARCH64_CALL26 relocations to the same symbol. It does the same for
> R_AARCH64_JUMP26 relocations too.
> 
> To make checks for duplicates easier/faster, it sorts the relocation
> list by type, symbol and addend. That way, to check for a duplicate
> relocation, it just needs to compare with the previous entry.
> 
> However, sorting the entire relocation array is unnecessary and
> expensive (O(n log n)) because there are a lot of other relocation types
> that don't need deduping or can't be deduped.
> 
> So this commit partitions the array into entries that need deduping and
> those that don't. And then sorts just the part that needs deduping. And
> when CONFIG_RANDOMIZE_BASE is disabled, the sorting is skipped entirely
> because PLTs are not allocated for R_AARCH64_CALL26 and R_AARCH64_JUMP26
> if it's disabled.
> 
> This gives significant reduction in module load time for modules with
> large number of relocations with no measurable impact on modules with a
> small number of relocations. In my test setup with CONFIG_RANDOMIZE_BASE
> enabled, the load time for one module went down from 268ms to 100ms.
> Another module went down from 143ms to 83ms.

Whilst I can see that's a significant relative saving, what proportion of
actual boot time are we talking about here? It would be interesting to
know if there are bigger potential savings elsewhere.

> This commit also disables the sorting if CONFIG_RANDOMIZE_BASE is
> disabled because it looks like PLTs are not allocated for
> R_AARCH64_CALL26 and R_AARCH64_JUMP26 if it's disabled.
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  arch/arm64/kernel/module-plts.c | 37 ++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 65b08a74aec6..bf5118b3b828 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -253,6 +253,36 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
>  	return ret;
>  }
>  
> +static bool rela_needs_dedup(Elf64_Rela *rela)
> +{
> +	return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26
> +	       || ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
> +}

Does this handle A53 erratum 843419 correctly? I'm worried that we skip
the ADRP PLTs there.

> +
> +/* Group the CALL26/JUMP26 relas toward the beginning of the array. */
> +static int partition_dedup_relas(Elf64_Rela *rela, int numrels)
> +{
> +	int i = 0, j = numrels - 1;
> +	Elf64_Rela t;
> +
> +	while (i < j) {
> +		while (rela_needs_dedup(rela + i) && i < j)
> +			i++;
> +		while (!rela_needs_dedup(rela + j) && i < j)
> +			j--;
> +		if (i < j) {
> +			t = *(rela + j);
> +			*(rela + j) = *(rela + i);
> +			*(rela + i) = t;
> +		}
> +	}

This is very hard to read and I think some of the 'i < j' comparisons are
redundant. Would it make more sense to assign a temporary rather than
post-inc/decrement and recheck?

Will
