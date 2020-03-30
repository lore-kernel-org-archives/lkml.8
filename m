Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C966C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760E82082D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgC3LH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:07:56 -0400
Received: from foss.arm.com ([217.140.110.172]:50358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbgC3LH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:07:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE84D31B;
        Mon, 30 Mar 2020 04:07:55 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7A853F52E;
        Mon, 30 Mar 2020 04:07:53 -0700 (PDT)
Date:   Mon, 30 Mar 2020 12:07:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH v1 39/50] arm: kexec_file: Avoid temp buffer for RNG
 seed
Message-ID: <20200330110751.GC1309@C02TD0UTHF1T.local>
References: <202003281643.02SGhMtr029198@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281643.02SGhMtr029198@sdf.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

Nit: s/arm/arm64/ in the title

On Tue, Dec 10, 2019 at 10:45:27AM -0500, George Spelvin wrote:
> After using get_random_bytes(), you want to wipe the buffer
> afterward so the seed remains secret.
> 
> In this case, we can eliminate the temporary buffer entirely.
> fdt_setprop_placeholder returns a pointer to the property value
> buffer, allowing us to put the random data directy in there without
> using a temporary buffer at all.  Faster and less stack all in one.
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 7b08bf9499b6b..69e25bb96e3fb 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -106,12 +106,12 @@ static int setup_dtb(struct kimage *image,
>  
>  	/* add rng-seed */
>  	if (rng_is_initialized()) {
> -		u8 rng_seed[RNG_SEED_SIZE];
> -		get_random_bytes(rng_seed, RNG_SEED_SIZE);
> -		ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED, rng_seed,
> -				RNG_SEED_SIZE);
> +		void *rng_seed;
> +		ret = fdt_setprop_placeholder(dtb, off, FDT_PROP_RNG_SEED,
> +				RNG_SEED_SIZE, &rng_seed);
>  		if (ret)
>  			goto out;
> +		get_random_bytes(rng_seed, RNG_SEED_SIZE);

This looks sane to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  	} else {
>  		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
>  				FDT_PROP_RNG_SEED);
> -- 
> 2.26.0
> 
