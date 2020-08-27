Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FE420825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgH0ANz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgH0ANz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:13:55 -0400
Received: from [192.168.0.106] (193-116-198-1.tpgi.com.au [193.116.198.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63DE20791;
        Thu, 27 Aug 2020 00:13:53 +0000 (UTC)
Subject: Re: [PATCH] m68k: mm: Remove superfluous memblock_alloc*() casts
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
References: <20200826130444.25618-1-geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <c7d8b0fb-179b-878d-dd67-e0e6155581c3@linux-m68k.org>
Date:   Thu, 27 Aug 2020 10:13:50 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826130444.25618-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 26/8/20 11:04 pm, Geert Uytterhoeven wrote:
> The return type of memblock_alloc*() is a void pointer, so there is no
> need to cast it to "void *" or some other pointer type, before assigning
> it to a pointer variable.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


>   arch/m68k/mm/mcfmmu.c   | 2 +-
>   arch/m68k/mm/motorola.c | 5 ++---
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
> index 2b9cb4a622811390..eac9dde65193443e 100644
> --- a/arch/m68k/mm/mcfmmu.c
> +++ b/arch/m68k/mm/mcfmmu.c
> @@ -42,7 +42,7 @@ void __init paging_init(void)
>   	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
>   	int i;
>   
> -	empty_zero_page = (void *) memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>   	if (!empty_zero_page)
>   		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
>   		      __func__, PAGE_SIZE, PAGE_SIZE);
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index a9bdde54ca350197..3a653f0a4188d4af 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -227,7 +227,7 @@ static pte_t * __init kernel_page_table(void)
>   	pte_t *pte_table = last_pte_table;
>   
>   	if (PAGE_ALIGNED(last_pte_table)) {
> -		pte_table = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
> +		pte_table = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
>   		if (!pte_table) {
>   			panic("%s: Failed to allocate %lu bytes align=%lx\n",
>   					__func__, PAGE_SIZE, PAGE_SIZE);
> @@ -275,8 +275,7 @@ static pmd_t * __init kernel_ptr_table(void)
>   
>   	last_pmd_table += PTRS_PER_PMD;
>   	if (PAGE_ALIGNED(last_pmd_table)) {
> -		last_pmd_table = (pmd_t *)memblock_alloc_low(PAGE_SIZE,
> -							   PAGE_SIZE);
> +		last_pmd_table = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
>   		if (!last_pmd_table)
>   			panic("%s: Failed to allocate %lu bytes align=%lx\n",
>   			      __func__, PAGE_SIZE, PAGE_SIZE);
> 
