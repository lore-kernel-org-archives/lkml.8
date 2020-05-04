Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE3EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27ACD2495B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588612670;
	bh=dCSwoURg/C8WuYz953nT1u1P7ci5+Iuywwfdq+8bQsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aws6PFDX0s5P/XjYuThgs5EDkFLiiLHI2c84/osNktQZY+uLQGNr4VlwkhlFhgQ+B
	 hHn0VVvFz1AWbb+U7ikqrEC5KvXdejBFZ04qulsMvsD1N/xhtiMJS3Iayo5/yFyDbl
	 yS35zLTf33lXwSfRDul8ALMuBBuGwEkbHJC7cf+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgEDRRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbgEDRRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:17:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC9D24965;
        Mon,  4 May 2020 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588612667;
        bh=dCSwoURg/C8WuYz953nT1u1P7ci5+Iuywwfdq+8bQsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYVlkD3ky0vhySQ+he8eMrpB+9oRA0f7K691tEJQupuZthAvJ8Zf3avLOWd395wAG
         nzQgQKVBg6zolaNUp9QQHR2ZiuBG0enaXitVX3UwKT8Kijgua5bz2MUTXPQ/rPhqWD
         hTWVxPtsWyRqrrmGHWCr7fQSRMpwX4v3Bogk3asg=
Date:   Mon, 4 May 2020 18:17:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] arm64/crash_core: Export KERNELPACMASK in
 vmcoreinfo
Message-ID: <20200504171741.GD1833@willie-the-truck>
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:55:01AM +0530, Amit Daniel Kachhap wrote:
> Recently arm64 linux kernel added support for Armv8.3-A Pointer
> Authentication feature. If this feature is enabled in the kernel and the
> hardware supports address authentication then the return addresses are
> signed and stored in the stack to prevent ROP kind of attack. Kdump tool
> will now dump the kernel with signed lr values in the stack.
> 
> Any user analysis tool for this kernel dump may need the kernel pac mask
> information in vmcoreinfo to generate the correct return address for
> stacktrace purpose as well as to resolve the symbol name.
> 
> This patch is similar to commit ec6e822d1a22d0eef ("arm64: expose user PAC
> bit positions via ptrace") which exposes pac mask information via ptrace
> interfaces.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> ---
> Changes since v1:
> * Rebased to kernel 5.7-rc3.
> * commit log change.
> 
> An implementation of this new KERNELPACMASK vmcoreinfo field used by crash
> tool can be found here[1]. This change is accepted by crash utility
> maintainer [2].
> 
> [1]: https://www.redhat.com/archives/crash-utility/2020-April/msg00095.html
> [2]: https://www.redhat.com/archives/crash-utility/2020-April/msg00099.html
> 
>  arch/arm64/include/asm/compiler.h | 3 +++
>  arch/arm64/kernel/crash_core.c    | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
> index eece20d..32d5900 100644
> --- a/arch/arm64/include/asm/compiler.h
> +++ b/arch/arm64/include/asm/compiler.h
> @@ -19,6 +19,9 @@
>  #define __builtin_return_address(val)					\
>  	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
>  
> +#else  /* !CONFIG_ARM64_PTR_AUTH */
> +#define	ptrauth_user_pac_mask()		0ULL
> +#define	ptrauth_kernel_pac_mask()	0ULL

This doesn't look quite right to me, since you still have to take into
account the case where CONFIG_ARM64_PTR_AUTH=y but the feature is not
available at runtime:

> @@ -16,4 +17,7 @@ void arch_crash_save_vmcoreinfo(void)
>  	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>  						PHYS_OFFSET);
>  	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
> +	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
> +						system_supports_address_auth() ?
> +						ptrauth_kernel_pac_mask() : 0);

In which case, would it make more sense to define
ptrauth_{kernel,user}_pac_mask() unconditionally? In fact, I'd probably
just remove the guards completely from asm/compiler.h because I think
they're misleading.

Will

--->8

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index eece20d2c55f..51a7ce87cdfe 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_COMPILER_H
 #define __ASM_COMPILER_H
 
-#if defined(CONFIG_ARM64_PTR_AUTH)
-
 /*
  * The EL0/EL1 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
@@ -19,6 +17,4 @@
 #define __builtin_return_address(val)					\
 	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
 
-#endif /* CONFIG_ARM64_PTR_AUTH */
-
 #endif /* __ASM_COMPILER_H */
