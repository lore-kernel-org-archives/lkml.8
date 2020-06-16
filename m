Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6501C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE266207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgFPM16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:27:58 -0400
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:38296 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgFPM15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:27:57 -0400
Received: from av3.ics.forth.gr (av3in [139.91.1.77])
        by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id 05GCRU4N019960;
        Tue, 16 Jun 2020 12:27:37 GMT
X-AuditID: 8b5b014d-257ff700000045c5-e8-5ee8bab847aa
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 9D.6F.17861.8BAB8EE5; Tue, 16 Jun 2020 15:27:37 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 16 Jun 2020 15:27:36 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Zong Li <zong.li@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Support CONFIG_STRICT_DEVMEM
Organization: FORTH
In-Reply-To: <7faa60aa4a606b5c5c1ae374d82a7eee6c764b38.1592292685.git.zong.li@sifive.com>
References: <cover.1592292685.git.zong.li@sifive.com>
 <7faa60aa4a606b5c5c1ae374d82a7eee6c764b38.1592292685.git.zong.li@sifive.com>
Message-ID: <29425dbf7d54bab2733d28480d3adb61@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.9
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXSHT1dWXfnrhdxBm9WMFtc3jWHzWLb5xY2
        i5eXe5gt2mbxW3y4O5vNgdXjzcuXLB6bl9R7XGq+zu7xeZNcAEsUl01Kak5mWWqRvl0CV8bK
        tytZCjokKu4suMzawLhVuIuRk0NCwETi2NzzLF2MXBxCAkcZJZ7ebWWGSJhKzN7byQhi8woI
        Spyc+YQFxGYWsJCYemU/I4QtL9G8dTZYPYuAqsT0y6vBbDYBTYn5lw6C1YsIKEhcWbIRqrdC
        Yuu/30wgtrCAjcSvFyvA4vwCwhKf7l5kBbE5BSIl7rfdZoQ4qIVRovnIVRaII1wkOpa8gjpO
        ReLD7wfsILaogLLEzcPP2ScwCs5CcussJLfOQnLrAkbmVYwCiWXGepnJxXpp+UUlGXrpRZsY
        wSHN6LuD8fbmt3qHGJk4GA8xSnAwK4nwRtu+iBPiTUmsrEotyo8vKs1JLT7EKM3BoiTOm8e9
        PFZIID2xJDU7NbUgtQgmy8TBKdXAJD7956upAdVMwrJLpxRv+vSV67lgUnLd2fuSuW+8JYIL
        07aZWqzl43s6/7LXxlsMNaL/Gb3Puxw5r39N9eiVq6nen+Z+yZIVzP5b41rIYHD8s+FRw6l+
        b2YJ7WS8/VrA6WhSm+5CkY/yn1yEDjQ0FAqs13VyZ1LRY552t9GQLcMwTebXoR3H5NZPTyhw
        4yyc4dEnVhO34eaZptWefirfvU7OKOn93sZe2G3cu3V6q8oLzpLnlp9bt9bt0IyXPj/bbSLH
        HeHFc6b/4nPIWOXwok+x2kG4oXXlizdRRTdMj5ZdN7v1tnB71NajLfPeT6nImJb75tKv154z
        BGednTnBIvnc3ntNW07PeDbV0E7siRJLcUaioRZzUXEiAAwwNb3YAgAA
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Tue, 16 Jun 2020 12:27:37 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in' HELO:'av3.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Tue, 16 Jun 2020 12:27:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2020-06-16 10:45, Zong Li έγραψε:
> Implement the 'devmem_is_allowed()' interface for RISC-V, like some of
> other architectures have done. It will be called from 
> range_is_allowed()
> when userpsace attempts to access /dev/mem.
> 
> Access to exclusive IOMEM and kernel RAM is denied unless
> CONFIG_STRICT_DEVMEM is set to 'n'.
> 
> Test it by devmem, the result as follows:
> 
>  - CONFIG_STRICT_DEVMEM=y
> 	$ devmem 0x10010000
> 	0x00000000
> 	$ devmem 0x80200000
> 	0x0000106F
> 
>  - CONFIG_STRICT_DEVMEM is not set
> 	$ devmem 0x10010000
> 	devmem: mmap: Operation not permitted
> 	$ devmem 0x80200000
> 	devmem: mmap: Operation not permitted
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Kconfig          |  1 +
>  arch/riscv/include/asm/io.h |  2 ++
>  arch/riscv/mm/init.c        | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 128192e14ff2..ffd7841ede4c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,7 @@ config RISCV
>  	select ARCH_HAS_BINFMT_FLAT
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEBUG_WX
> +	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_MMIOWB
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 3835c3295dc5..04ac65ab93ce 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -147,4 +147,6 @@ __io_writes_outs(outs, u64, q, __io_pbr(), 
> __io_paw())
> 
>  #include <asm-generic/io.h>
> 
> +extern int devmem_is_allowed(unsigned long pfn);
> +
>  #endif /* _ASM_RISCV_IO_H */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index bbe816e03b2f..5e7e61519acc 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -517,6 +517,25 @@ void mark_rodata_ro(void)
>  }
>  #endif
> 
> +#ifdef CONFIG_STRICT_DEVMEM
> +#include <linux/ioport.h>
> +/*
> + * devmem_is_allowed() checks to see if /dev/mem access to a certain 
> address
> + * is valid. The argument is a physical page number.
> + *
> + * Disallow access to system RAM as well as device-exclusive MMIO 
> regions.
> + * This effectively disable read()/write() on /dev/mem.
> + */
> +int devmem_is_allowed(unsigned long pfn)
> +{
> +	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
> +		return 0;
> +	if (!page_is_ram(pfn))
> +		return 1;
> +	return 0;
> +}
> +#endif
> +
>  void __init resource_init(void)
>  {
>  	struct memblock_region *region;

This shouldn't be part of /mm/init.c, it has nothing to do with memory 
initialization, I suggest we move it to another file like mmap.c on 
arm/arm64. Also before using iomem_is_exclusive we should probably also 
mark any reserved regions with the no-map attribute as busy|exclusive, 
reserved-memory regions are not necessarily part of the main memory so 
the page_is_ram check may pass and iomem_is_exclusive won't do any good.
