Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D4C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEE5206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgELOpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgELOpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:45:12 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E64CB206A3;
        Tue, 12 May 2020 14:45:03 +0000 (UTC)
Subject: Re: [PATCH 16/31] m68knommu: use asm-generic/cacheflush.h
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-17-hch@lst.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <fb98853b-c02a-a682-443e-2ae62d0502d9@linux-m68k.org>
Date:   Wed, 13 May 2020 00:44:59 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510075510.987823-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 10/5/20 5:54 pm, Christoph Hellwig wrote:
> m68knommu needs almost no cache flushing routines of its own.  Rely on
> asm-generic/cacheflush.h for the defaults.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
>   arch/m68k/include/asm/cacheflush_no.h | 19 ++-----------------
>   1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/cacheflush_no.h b/arch/m68k/include/asm/cacheflush_no.h
> index 11e9a9dcbfb24..2731f07e7be8c 100644
> --- a/arch/m68k/include/asm/cacheflush_no.h
> +++ b/arch/m68k/include/asm/cacheflush_no.h
> @@ -9,25 +9,8 @@
>   #include <asm/mcfsim.h>
>   
>   #define flush_cache_all()			__flush_cache_all()
> -#define flush_cache_mm(mm)			do { } while (0)
> -#define flush_cache_dup_mm(mm)			do { } while (0)
> -#define flush_cache_range(vma, start, end)	do { } while (0)
> -#define flush_cache_page(vma, vmaddr)		do { } while (0)
>   #define flush_dcache_range(start, len)		__flush_dcache_all()
> -#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> -#define flush_dcache_page(page)			do { } while (0)
> -#define flush_dcache_mmap_lock(mapping)		do { } while (0)
> -#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
>   #define flush_icache_range(start, len)		__flush_icache_all()
> -#define flush_icache_page(vma,pg)		do { } while (0)
> -#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
> -#define flush_cache_vmap(start, end)		do { } while (0)
> -#define flush_cache_vunmap(start, end)		do { } while (0)
> -
> -#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> -	memcpy(dst, src, len)
> -#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
> -	memcpy(dst, src, len)
>   
>   void mcf_cache_push(void);
>   
> @@ -98,4 +81,6 @@ static inline void cache_clear(unsigned long paddr, int len)
>   	__clear_cache_all();
>   }
>   
> +#include <asm-generic/cacheflush.h>
> +
>   #endif /* _M68KNOMMU_CACHEFLUSH_H */
> 
