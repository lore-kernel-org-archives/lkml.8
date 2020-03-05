Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DBEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D6C2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCEJpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:45:04 -0500
Received: from foss.arm.com ([217.140.110.172]:45864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgCEJpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:45:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A33E031B;
        Thu,  5 Mar 2020 01:45:03 -0800 (PST)
Received: from [192.168.1.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB4823F534;
        Thu,  5 Mar 2020 01:45:01 -0800 (PST)
Subject: Re: [PATCH] arm64: efi: add efi-entry.o to targets instead of
 extra-$(CONFIG_EFI)
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Torsten Duwe <duwe@lst.de>
References: <20200305052052.30757-1-masahiroy@kernel.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <518c0334-ab67-42fb-15c0-3c6a312b8207@arm.com>
Date:   Thu, 5 Mar 2020 09:45:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200305052052.30757-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 5:20 AM, Masahiro Yamada wrote:
> efi-entry.o is built on demand for efi-entry.stub.o, so you do not have
> to repeat $(CONFIG_EFI) here. Adding it to 'targets' is enough.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
> 
>  arch/arm64/kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index fc6488660f64..4e5b8ee31442 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -21,7 +21,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
>  			   smp.o smp_spin_table.o topology.o smccc-call.o	\
>  			   syscall.o
>  
> -extra-$(CONFIG_EFI)			:= efi-entry.o
> +targets			+= efi-entry.o
>  
>  OBJCOPYFLAGS := --prefix-symbols=__efistub_
>  $(obj)/%.stub.o: $(obj)/%.o FORCE
> 

-- 
Regards,
Vincenzo
