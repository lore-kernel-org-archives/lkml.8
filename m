Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C3C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C6420857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 14:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgBPOlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 09:41:16 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38011 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgBPOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 09:41:16 -0500
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A84D120003;
        Sun, 16 Feb 2020 14:41:11 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] riscv: Fix crash when flushing executable ioremap
 regions
To:     Jan Kiszka <jan.kiszka@web.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1581767384.git.jan.kiszka@web.de>
 <8a555b0b0934f0ba134de92f6cf9db8b1744316c.1581767384.git.jan.kiszka@web.de>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <e721c440-2baf-d962-62ef-41a4f3b1333b@ghiti.fr>
Date:   Sun, 16 Feb 2020 09:41:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <8a555b0b0934f0ba134de92f6cf9db8b1744316c.1581767384.git.jan.kiszka@web.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 2/15/20 6:49 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Those are not backed by page structs, and pte_page is returning an
> invalid pointer.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> =2D--
>   arch/riscv/mm/cacheflush.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 8930ab7278e6..9ee2c1a387cc 100644
> =2D-- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -84,7 +84,8 @@ void flush_icache_pte(pte_t pte)
>   {
>   	struct page *page =3D pte_page(pte);
> 
> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> +	if (!pfn_valid(pte_pfn(pte)) ||
> +	    !test_and_set_bit(PG_dcache_clean, &page->flags))
>   		flush_icache_all();
>   }
>   #endif /* CONFIG_MMU */
> =2D-
> 2.16.4
> 
> 

When did you encounter such a situation ? i.e. executable code that is 
not backed by struct page ?

Riscv uses the generic implementation of ioremap and the way 
_PAGE_IOREMAP is defined does not allow to map executable memory region 
using ioremap, so I'm interested to understand how we end up in 
flush_icache_pte for an executable region not backed by any struct page.

Thanks,

Alex
