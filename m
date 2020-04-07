Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A713C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772A9206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgDGFIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:08:17 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58413 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgDGFIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:08:17 -0400
X-Originating-IP: 2.7.45.25
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3A5D660004;
        Tue,  7 Apr 2020 05:08:14 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH RFC 1/8] riscv/kaslr: add interface to get kaslr offset
To:     Zong Li <zong.li@sifive.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1584352425.git.zong.li@sifive.com>
 <cf8585177e6798095b1af02f28dad5a3271a761e.1584352425.git.zong.li@sifive.com>
Message-ID: <d6201d21-9631-dd22-2ff1-af7520086c32@ghiti.fr>
Date:   Tue, 7 Apr 2020 01:08:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <cf8585177e6798095b1af02f28dad5a3271a761e.1584352425.git.zong.li@sifive.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20 3:30 AM, Zong Li wrote:
> Add interface to get the random offset.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>   arch/riscv/include/asm/page.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 92848e172a40..e2c2020f0a8d 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -101,6 +101,11 @@ extern unsigned long kernel_virt_addr;
>   extern unsigned long max_low_pfn;
>   extern unsigned long min_low_pfn;
>   
> +static inline unsigned long get_kaslr_offset(void)
> +{
> +	return kernel_virt_addr - PAGE_OFFSET;
> +}
> +
>   #define __pa_to_va_nodebug(x)	((void *)((unsigned long) (x) + va_pa_offset))
>   #define __va_to_pa_nodebug(x)	((unsigned long)(x) - va_pa_offset)
>   
> 

No problem for this one:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex
