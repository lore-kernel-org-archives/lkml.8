Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AFEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DD82467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCJKZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:25:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:49108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgCJKZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:25:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D528B012;
        Tue, 10 Mar 2020 10:25:03 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:25:00 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted
 for SEV
Message-ID: <20200310102500.GG7028@suse.de>
References: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, Feb 25, 2020 at 09:42:07AM -0600, Tom Lendacky wrote:
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 44e4beb4239f..382b6ca66820 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -135,6 +135,13 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>  	memset(desc, 0, sizeof(struct ioremap_desc));
>  
>  	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
> +
> +	/*
> +	 * The EFI runtime services data area is not covered by walk_mem_res(),
> +	 * but must be mapped encrypted when SEV is active.
> +	 */
> +	if (sev_active() && efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
> +		desc->flags |= IORES_MAP_ENCRYPTED;
>  }

I can confirm that this fixes dmi-decode on my SEV guest. While
reviewing I looked into using walk_system_ram_range(), but since this is
only for the EFI_RUNTIME_SERVICES_DATA, it is not needed, so:

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Joerg Roedel <jroedel@suse.de>
