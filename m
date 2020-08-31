Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5928AC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296E52083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KKOc6D3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgHaRZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:25:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40066 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgHaRZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:25:24 -0400
Received: from zn.tnic (p200300ec2f085000329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:5000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B10141EC0428;
        Mon, 31 Aug 2020 19:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598894722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=55N3m19xFX+WeTO1FbLrZJGhHueve9LBb3xbHqo4WZc=;
        b=KKOc6D3lpnJoODJ4KbKeLr28wdnjbr7+fuvuUwJFH3E1UBaA9FaDiFbEBYxtFN6cvGCm+R
        FuSByUuFImwEoa9FnyY60HLjv3klMPCT+V7r1V+IretyrkuZfTUATjBpn2jIqUjwG4iJmH
        ebRA+zcZsrYhOplPjtq9nsOHjKNQP5k=
Date:   Mon, 31 Aug 2020 19:25:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v6 70/76] x86/smpboot: Setup TSS for starting AP
Message-ID: <20200831172519.GL27517@zn.tnic>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-71-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824085511.7553-71-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:55:05AM +0200, Joerg Roedel wrote:
> @@ -1814,27 +1814,26 @@ static inline void ucode_cpu_init(int cpu)
>  		load_ucode_ap();
>  }
>  
> -static inline void tss_setup_ist(struct tss_struct *tss)
> +static inline void tss_setup_ist(struct tss_struct *tss,
> +				 struct cpu_entry_area *cea)
>  {
>  	/* Set up the per-CPU TSS IST stacks */
> -	tss->x86_tss.ist[IST_INDEX_DF] = __this_cpu_ist_top_va(DF);
> -	tss->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
> -	tss->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
> -	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
> +	tss->x86_tss.ist[IST_INDEX_DF]  = CEA_ESTACK_TOP(&cea->estacks, DF);
> +	tss->x86_tss.ist[IST_INDEX_NMI] = CEA_ESTACK_TOP(&cea->estacks, NMI);
> +	tss->x86_tss.ist[IST_INDEX_DB]  = CEA_ESTACK_TOP(&cea->estacks, DB);
> +	tss->x86_tss.ist[IST_INDEX_MCE] = CEA_ESTACK_TOP(&cea->estacks, MCE);

#ifdef CONFIG_AMD_MEM_ENCRYPT

>  	/* Only mapped when SEV-ES is active */
> -	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
> +	tss->x86_tss.ist[IST_INDEX_VC]	= CEA_ESTACK_TOP(&cea->estacks, VC);

#endif

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
