Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D969C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AF62078D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgGIFcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:32:16 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53513 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgGIFcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:32:15 -0400
X-Originating-IP: 90.112.45.105
Received: from [192.168.1.11] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6345740007;
        Thu,  9 Jul 2020 05:32:06 +0000 (UTC)
Subject: Re: [PATCH] riscv: Enable ELF-ASLR for riscv
To:     guoren@kernel.org, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, anup@brainfault.org,
        greentime.hu@sifive.com, zong.li@sifive.com, me@packi.ch,
        bjorn.topel@gmail.com, atish.patra@wdc.com
Cc:     Guo Ren <guoren@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        linux-riscv@lists.infradead.org
References: <1594269511-13340-1-git-send-email-guoren@kernel.org>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <5c7e9eb0-d811-2e08-87c4-12de9b869b79@ghiti.fr>
Date:   Thu, 9 Jul 2020 01:32:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594269511-13340-1-git-send-email-guoren@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

Le 7/9/20 à 12:38 AM, guoren@kernel.org a écrit :
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Let riscv enable randomizes the stack, heap and binary images of
> ELF binaries. Seems it's ok at all after qemu & chip test and
> there is no founded side effect.
> 
> So just simply select ARCH_HAS_ELF_RANDOMIZE :)
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Zong Li <zong.li@sifive.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> ---
>   arch/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 91bfc6c..eed6647 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -20,6 +20,7 @@ config RISCV
>   	select ARCH_HAS_GIGANTIC_PAGE
>   	select ARCH_HAS_MMIOWB
>   	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_ELF_RANDOMIZE
>   	select ARCH_HAS_SET_DIRECT_MAP
>   	select ARCH_HAS_SET_MEMORY
>   	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> 

Actually it is already the case: ARCH_HAS_ELF_RANDOMIZE is already 
selected by ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.

Thanks,

Alex
