Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707B6C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA2624695
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="M+1KJt5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgCJMkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:40:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJMkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:40:00 -0400
Received: from zn.tnic (p200300EC2F09B400B9A98D8D0B62C6C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b400:b9a9:8d8d:b62:c6c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A30A51EC0CD1;
        Tue, 10 Mar 2020 13:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583843998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JNxa356xMiMYcOhZxcJVg2pdOP2CCzDRhw8kQvxntFE=;
        b=M+1KJt5fj95okOKnzkUz0LTHzVcELFFy3zXGL4rWgw9FhLmqGtVxHOlM6h6722fvTU8YUF
        22OW56yTfootMxs8nUT83Pls1jOXkOqlsDVHkq5eTT60bxZ5IZeo1fEsJz5Jm1dolSNNlE
        yGt8xjj4gt1psneh6e92loQbj9CCLSI=
Date:   Tue, 10 Mar 2020 13:40:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bruce Rogers <brogers@suse.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted
 for SEV
Message-ID: <20200310124003.GE29372@zn.tnic>
References: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 09:42:07AM -0600, Tom Lendacky wrote:
> The dmidecode program fails to properly decode the SMBIOS data supplied
> by OVMF/UEFI when running on an SEV guest. The SMBIOS area, under SEV, is
> encrypted and resides in reserved memory that is marked as EFI runtime
> services data. As a result, when memremap() is attempted for the SMBIOS
> data, it can't be mapped as regular RAM (through try_ram_remap()) and,
> since the address isn't part of the iomem resources list, it isn't mapped
> encrypted through the fallback ioremap().
> 
> Update __ioremap_check_mem() to set the IORES_MAP_ENCRYPTED flag if SEV is
> active and the memory being mapped is part of EFI runtime services data.
> This allows any runtime services data, which has been created encrypted,
> to be mapped encrypted.
> 
> Cc: Bruce Rogers <brogers@suse.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/mm/ioremap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
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

Why isn't this done in __ioremap_check_encrypted() which is exactly for
SEV stuff like that?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
