Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E13C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEDC2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPEioIaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgG3Byi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 21:54:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51692 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726480AbgG3Byi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596074076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RRu2DjMF0v0Jv3loZnZu2suQTSJCldR+3yWZSkhX+qw=;
        b=WPEioIaUVuT+NXE+mbDAAoYgyszkhwTBNFKCjBxYVVL9b5eej71Tz/jno9YwO9mYf/jKLr
        xF5DiZFUAsSSwVLtMqCL3P/zxV5aYd+ScBHlGrJoXztQWM4yXS7CeatxRxpszbLrghhZ04
        kNLbRDYZUPxM1ZI6kYeq783wR9lAHrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-MKISxg0TPU6a-4FvLzbZhQ-1; Wed, 29 Jul 2020 21:54:32 -0400
X-MC-Unique: MKISxg0TPU6a-4FvLzbZhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6832D1005510;
        Thu, 30 Jul 2020 01:54:27 +0000 (UTC)
Received: from localhost (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56EE9619B5;
        Thu, 30 Jul 2020 01:54:26 +0000 (UTC)
Date:   Thu, 30 Jul 2020 09:54:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: Re: [PATCH 10/15] memblock: make memblock_debug and related
 functionality private
Message-ID: <20200730015424.GJ14854@MiWiFi-R3L-srv>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-11-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728051153.1590-11-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/20 at 08:11am, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The only user of memblock_dbg() outside memblock was s390 setup code and it
> is converted to use pr_debug() instead.
> This allows to stop exposing memblock_debug and memblock_dbg() to the rest
> of the kernel.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/s390/kernel/setup.c |  4 ++--
>  include/linux/memblock.h | 12 +-----------
>  mm/memblock.c            | 13 +++++++++++--
>  3 files changed, 14 insertions(+), 15 deletions(-)

Nice clean up.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 07aa15ba43b3..8b284cf6e199 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -776,8 +776,8 @@ static void __init memblock_add_mem_detect_info(void)
>  	unsigned long start, end;
>  	int i;
>  
> -	memblock_dbg("physmem info source: %s (%hhd)\n",
> -		     get_mem_info_source(), mem_detect.info_source);
> +	pr_debug("physmem info source: %s (%hhd)\n",
> +		 get_mem_info_source(), mem_detect.info_source);
>  	/* keep memblock lists close to the kernel */
>  	memblock_set_bottom_up(true);
>  	for_each_mem_detect_block(i, &start, &end) {
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 220b5f0dad42..e6a23b3db696 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -90,7 +90,6 @@ struct memblock {
>  };
>  
>  extern struct memblock memblock;
> -extern int memblock_debug;
>  
>  #ifndef CONFIG_ARCH_KEEP_MEMBLOCK
>  #define __init_memblock __meminit
> @@ -102,9 +101,6 @@ void memblock_discard(void);
>  static inline void memblock_discard(void) {}
>  #endif
>  
> -#define memblock_dbg(fmt, ...) \
> -	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> -
>  phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
>  				   phys_addr_t size, phys_addr_t align);
>  void memblock_allow_resize(void);
> @@ -456,13 +452,7 @@ bool memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
>  bool memblock_is_reserved(phys_addr_t addr);
>  bool memblock_is_region_reserved(phys_addr_t base, phys_addr_t size);
>  
> -extern void __memblock_dump_all(void);
> -
> -static inline void memblock_dump_all(void)
> -{
> -	if (memblock_debug)
> -		__memblock_dump_all();
> -}
> +void memblock_dump_all(void);
>  
>  /**
>   * memblock_set_current_limit - Set the current allocation limit to allow
> diff --git a/mm/memblock.c b/mm/memblock.c
> index a5b9b3df81fc..824938849f6d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -134,7 +134,10 @@ struct memblock memblock __initdata_memblock = {
>  	     i < memblock_type->cnt;					\
>  	     i++, rgn = &memblock_type->regions[i])
>  
> -int memblock_debug __initdata_memblock;
> +#define memblock_dbg(fmt, ...) \
> +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> +
> +static int memblock_debug __initdata_memblock;
>  static bool system_has_some_mirror __initdata_memblock = false;
>  static int memblock_can_resize __initdata_memblock;
>  static int memblock_memory_in_slab __initdata_memblock = 0;
> @@ -1919,7 +1922,7 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
>  	}
>  }
>  
> -void __init_memblock __memblock_dump_all(void)
> +static void __init_memblock __memblock_dump_all(void)
>  {
>  	pr_info("MEMBLOCK configuration:\n");
>  	pr_info(" memory size = %pa reserved size = %pa\n",
> @@ -1933,6 +1936,12 @@ void __init_memblock __memblock_dump_all(void)
>  #endif
>  }
>  
> +void __init_memblock memblock_dump_all(void)
> +{
> +	if (memblock_debug)
> +		__memblock_dump_all();
> +}
> +
>  void __init memblock_allow_resize(void)
>  {
>  	memblock_can_resize = 1;
> -- 
> 2.26.2
> 
> 

