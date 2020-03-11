Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6488C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825F020873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgCKJEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:04:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgCKJEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:04:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5E4CAD08;
        Wed, 11 Mar 2020 09:04:49 +0000 (UTC)
Date:   Wed, 11 Mar 2020 10:04:47 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted
 for SEV
Message-ID: <20200311090447.GI7028@suse.de>
References: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
 <20200310124003.GE29372@zn.tnic>
 <20200310130321.GH7028@suse.de>
 <20200310163738.GF29372@zn.tnic>
 <20200310174712.GG29372@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310174712.GG29372@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 10, 2020 at 06:47:31PM +0100, Borislav Petkov wrote:
> Ok, here's what I have. @joro, I know it is trivially different from the
> version you tested but I'd appreciate it if you ran it again, just to be
> sure.

Looks good and ested it, works fine.

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Joerg Roedel <jroedel@suse.de>

> ---
> >From 244b62ca142c6296361bde953488fc64db31f1bd Mon Sep 17 00:00:00 2001
> From: Tom Lendacky <thomas.lendacky@amd.com>
> Date: Tue, 10 Mar 2020 18:35:57 +0100
> Subject: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted for
>  SEV
> 
> The dmidecode program fails to properly decode the SMBIOS data supplied
> by OVMF/UEFI when running in an SEV guest. The SMBIOS area, under SEV, is
> encrypted and resides in reserved memory that is marked as EFI runtime
> services data.
> 
> As a result, when memremap() is attempted for the SMBIOS data, it
> can't be mapped as regular RAM (through try_ram_remap()) and, since
> the address isn't part of the iomem resources list, it isn't mapped
> encrypted through the fallback ioremap().
> 
> Add a new __ioremap_check_other() to deal with memory types like
> EFI_RUNTIME_SERVICES_DATA which are not covered by the resource ranges.
> 
> This allows any runtime services data, which has been created encrypted,
> to be mapped encrypted.
> 
>  [ bp: Move functionality to a separate function. ]
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org> # 5.3
> Link: https://lkml.kernel.org/r/2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com
> ---
>  arch/x86/mm/ioremap.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 44e4beb4239f..935a91e1fd77 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -106,6 +106,19 @@ static unsigned int __ioremap_check_encrypted(struct resource *res)
>  	return 0;
>  }
>  
> +/*
> + * The EFI runtime services data area is not covered by walk_mem_res(), but must
> + * be mapped encrypted when SEV is active.
> + */
> +static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *desc)
> +{
> +	if (!sev_active())
> +		return;
> +
> +	if (efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
> +		desc->flags |= IORES_MAP_ENCRYPTED;
> +}
> +
>  static int __ioremap_collect_map_flags(struct resource *res, void *arg)
>  {
>  	struct ioremap_desc *desc = arg;
> @@ -124,6 +137,9 @@ static int __ioremap_collect_map_flags(struct resource *res, void *arg)
>   * To avoid multiple resource walks, this function walks resources marked as
>   * IORESOURCE_MEM and IORESOURCE_BUSY and looking for system RAM and/or a
>   * resource described not as IORES_DESC_NONE (e.g. IORES_DESC_ACPI_TABLES).
> + *
> + * After that, deal with misc other ranges in __ioremap_check_other() which do
> + * not fall into the above category.
>   */
>  static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>  				struct ioremap_desc *desc)
> @@ -135,6 +151,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>  	memset(desc, 0, sizeof(struct ioremap_desc));
>  
>  	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
> +
> +	__ioremap_check_other(addr, desc);
>  }
>  
>  /*
> -- 
> 2.21.0
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
