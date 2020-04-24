Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A211C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA232071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDXKBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:01:46 -0400
Received: from foss.arm.com ([217.140.110.172]:58726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgDXKBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:01:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F26AF1FB;
        Fri, 24 Apr 2020 03:01:44 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D755C3F73D;
        Fri, 24 Apr 2020 03:01:42 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:01:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        broonie@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH] arm64/kernel: Fix range on invalidating dcache for boot
 page tables
Message-ID: <20200424100131.GB1167@C02TD0UTHF1T.local>
References: <20200424050230.16720-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424050230.16720-1-gshan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On Fri, Apr 24, 2020 at 03:02:30PM +1000, Gavin Shan wrote:
> The MMU is disabled when __create_page_tables() is called. The data
> cache corresponding to these two page tables, which are tracked by
> @idmap_pg_dir and @init_pg_dir, is invalidated after the page tables
> are populated. However, the wrong or inappropriate size have been used
> and more data cache are invalidated than it need.
> 
> This fixes the issue by invalidating the data cache for these two
> page tables separately as they aren't necessarily physically adjacent.

Thanks for this!

I think the commit message needs to explain the issue more explicitly,
e.g.

| Prior to commit:
| 
|   8eb7e28d4c642c31i ("arm64/mm: move runtime pgds to rodata")
|
| ... idmap_pgd_dir, tramp_pg_dir, reserved_ttbr0, swapper_pg_dir, and
| init_pg_dir were contiguous at the end of the kernel image. The
| maintenance at the end of __create_page_tables assumed these were
| contiguous, and affected everything from the start of idmap_pg_dir to
| the end of init_pg_dir.
|
| That commit moved all but init_pg_dir into the .rodata section, with
| other data placed between idmap_pg_dir and init_pg_dir, but did not
| update the maintenance. Hence the maintenance is performed on much
| more data than necessary (but as the bootloader previously made this
| clean to the PoC there is no functional problem).
|
| As we only alter idmap_pg_dir, and init_pg_dir, we only need to
| perform maintenance for these. As the other dirs are in .rodata, the
| bootloader will have initialised them as expected and cleaned them to
| the PoC. The kernel will initialize them as necessary after enabling
| the MMU.
|
| This patch reworks the maintenance to only cover the idmap_pg_dir and
| init_pg_dir to avoid this unnecessary work.

> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kernel/head.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 57a91032b4c2..66947873c9e7 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -398,6 +398,10 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  	 * tables again to remove any speculatively loaded cache lines.
>  	 */

The comment above has been stale for a while, since it says:

| 	/*
| 	 * Since the page tables have been populated with non-cacheable
| 	 * accesses (MMU disabled), invalidate the idmap and swapper page
| 	 * tables again to remove any speculatively loaded cache lines.
| 	 */

... can we please update that at the same time? We can avoid mention of
the specific tables and say:

| 	/*
| 	 * Since the page tables have been populated with non-cacheable
| 	 * accesses (MMU disabled), invalidate those tables again to
| 	 * remove any speculatively loaded cache lines.
| 	 */

>  	adrp	x0, idmap_pg_dir
> +	mov	x1, #IDMAP_DIR_SIZE
> +	dmb	sy
> +	bl	__inval_dcache_area
> +	adrp	x0, init_pg_dir
>  	adrp	x1, init_pg_end
>  	sub	x1, x1, x0
>  	dmb	sy

The existing DMB is to order prior non-cacheable accesses against cache
maintenance, so we only need one of those at the start of the sequence.
For consistency, we should use the same idiom to generate the size of
both dirs. Given we use ADRP+ADRP+SUB here and elsewhere in head.S, I
think that's preferable for now.

So I reckon this should be:

|	dmb	sy
|
|	adrp	x0, idmap_pg_dir
|	adrp	x1, idmap_pg_end
|	sub	x1, x1, x0
|	bl	__inval_dcache_area
|
|	adrp	x0, init_pg_dir
|	adrp	x1, init_pg_end
|	sub	x1, x1, x0
|	bl	__inval_dcache_area

... with those line gaps to make the distinct blocks clearer.

Thanks,
Mark.
