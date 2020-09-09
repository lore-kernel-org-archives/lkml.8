Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BE4C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4DA216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599644168;
	bh=WhCbCOYAgVBM6ESgc/BWT45n0KWObYl8AhVF0LbOeRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZysWgwC9PiMXZHlua96FCTmcGvtc++qyHLzK5OjOVTOhNKmKDvD0MUyQkCEnSbgYY
	 73bQaODj9acpwGQDOek7wP3uUHzVW5Y/adoHIpVpgT3SsCBpUCzqtUsQclPvGb1JdU
	 wVhRkKh0YOLLP0v+ZcVIasJ0f9n3ZY/WBLMvZxxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgIIJgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730136AbgIIJgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:36:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EAD62087C;
        Wed,  9 Sep 2020 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599644159;
        bh=WhCbCOYAgVBM6ESgc/BWT45n0KWObYl8AhVF0LbOeRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FN3smRmor9Z1cEEK3TX/DIf7Jl/x7cExqmZOic2iQnUbIrI0hsCU00CqsGBJWuRmZ
         3XwgvBHoMCJf7aHNRVQ4/NwXAulPMLL1aeXx1WgLiTejGOVc3dBTVjuydHlnB9FeFU
         otjBmtLoOVgU+vP5aLGuqGj53acpQwMDaUfEq/NU=
Date:   Wed, 9 Sep 2020 11:36:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v3 02/17] x86/acrn: Introduce acrn_{setup,
 remove}_intr_handler()
Message-ID: <20200909093609.GA607744@kroah.com>
References: <20200909090836.46762-1-shuo.a.liu@intel.com>
 <20200909090836.46762-3-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909090836.46762-3-shuo.a.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 05:08:21PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> The ACRN Hypervisor builds an I/O request when a trapped I/O access
> happens in User VM. Then, ACRN Hypervisor issues an upcall by sending
> a notification interrupt to the Service VM. HSM in the Service VM needs
> to hook the notification interrupt to handle I/O requests.
> 
> Notification interrupts from ACRN Hypervisor are already supported and
> a, currently uninitialized, callback called.
> 
> Export two APIs for HSM to setup/remove its callback.
> 
> Originally-by: Yakui Zhao <yakui.zhao@intel.com>
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Fengwei Yin <fengwei.yin@intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Yu Wang <yu1.wang@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/include/asm/acrn.h |  8 ++++++++
>  arch/x86/kernel/cpu/acrn.c  | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 arch/x86/include/asm/acrn.h
> 
> diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
> new file mode 100644
> index 000000000000..ff259b69cde7
> --- /dev/null
> +++ b/arch/x86/include/asm/acrn.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_ACRN_H
> +#define _ASM_X86_ACRN_H
> +
> +void acrn_setup_intr_handler(void (*handler)(void));
> +void acrn_remove_intr_handler(void);
> +
> +#endif /* _ASM_X86_ACRN_H */
> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index 0b2c03943ac6..bd1d7e759a0f 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -9,7 +9,11 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) "acrn: " fmt
> +
>  #include <linux/interrupt.h>
> +
> +#include <asm/acrn.h>
>  #include <asm/apic.h>
>  #include <asm/cpufeatures.h>
>  #include <asm/desc.h>
> @@ -55,6 +59,21 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_acrn_hv_callback)
>  	set_irq_regs(old_regs);
>  }
>  
> +void acrn_setup_intr_handler(void (*handler)(void))
> +{
> +	if (acrn_intr_handler)
> +		pr_warn("Overwrite the acrn_intr_handler.\n");

What can someone do with this warning?  If it's really an "error", why
not prevent this from happening?

Don't scare users with things they can do nothing about.

thanks,

greg k-h
