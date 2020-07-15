Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF2C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7624E20674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GwQiBY/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGOBke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 21:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGOBkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:40:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8106C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:40:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a14so771596pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yB4mfZhVGgML4uV5FJMaGcIbxMBeIJoUsQc2RIfPst4=;
        b=GwQiBY/mF/gzosD/19uNdGcObWYOeTnMNqoTyK/Mra8Yom+dF+q9WqmgL3exkJj5Ks
         ThzoIIqFrRVrwrBf2ezFEZbzlcV88k6koT1GBJS+RPZz5MUcJE4VyIexZyZoQNMN4biB
         mYfToQLkYNPG5zuJGNEKuZc80GG84FkVaqIOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yB4mfZhVGgML4uV5FJMaGcIbxMBeIJoUsQc2RIfPst4=;
        b=TWExj/ErSAN6bncbXpbTqtS7tgZr5rFdBeOYzTEndLpN1qa/umUn/STDDnFQjxbGfx
         KCXJZGRmW6nbnVFPqvuCfsx2Bum97MVn1xJK4XHZqAUkSzkt6RI/G3uNzolWy/wEza1U
         niGwY4JE5hU52QGzmhDLO1kwIW3Vse8qOXBQoNJlkJ5UYF24bbt/vINWFzrPCvEBswRi
         PxcKbc6Q+O1PKXcuvc9axgV6KyDHQ4EO9PjPqgrYbQmSF6xvejgNziMvIbm3XyzNonBY
         gJpwFlnH09Eqa7eqEqFEvx6Bbg/MN6DFaLsIJlFusHp+85+mf/GhZzJT0iNX7kcaoyER
         Vp6Q==
X-Gm-Message-State: AOAM530d5U/FJtQx9xuc3gSejADpVO8jh6WLiSH8pvnmRTbBoGXoZ1c6
        9vanRJPt50TKbm6/jS+JUJbKpQ==
X-Google-Smtp-Source: ABdhPJwZlZG81xgIsES7Sgk18FpcVoLdUj5ncFZJKakDpHjmEazwsdHMNLs36Zv3OD5kEjNWNMDBAg==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr5461349pgj.19.1594777232199;
        Tue, 14 Jul 2020 18:40:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11sm345567pfr.71.2020.07.14.18.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 18:40:31 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:40:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 70/75] x86/head/64: Don't call verify_cpu() on
 starting APs
Message-ID: <202007141837.2B93BBD78@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-71-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-71-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:09:12PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The APs are not ready to handle exceptions when verify_cpu() is called
> in secondary_startup_64.

Eek, no. MSR_IA32_MISC_ENABLE_XD_DISABLE needs to be cleared very early
during CPU startup; this can't just be skipped.

Also, is UNWIND_HINT_EMPTY needed for the new target?

-Kees

> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/realmode.h | 1 +
>  arch/x86/kernel/head_64.S       | 1 +
>  arch/x86/realmode/init.c        | 6 ++++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
> index 6590394af309..5c97807c38a4 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -69,6 +69,7 @@ extern unsigned char startup_32_smp[];
>  extern unsigned char boot_gdt[];
>  #else
>  extern unsigned char secondary_startup_64[];
> +extern unsigned char secondary_startup_64_no_verify[];
>  #endif
>  
>  static inline size_t real_mode_size_needed(void)
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 5b577d6bce7a..8b43ed0592e8 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -165,6 +165,7 @@ SYM_CODE_START(secondary_startup_64)
>  	/* Sanitize CPU configuration */
>  	call verify_cpu
>  
> +SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	/*
>  	 * Retrieve the modifier (SME encryption mask if SME is active) to be
>  	 * added to the initial pgdir entry that will be programmed into CR3.
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 61a52b925d15..df701f87ddef 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -46,6 +46,12 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
>  		th->flags |= TH_FLAGS_SME_ACTIVE;
>  
>  	if (sev_es_active()) {
> +		/*
> +		 * Skip the call to verify_cpu() in secondary_startup_64 as it
> +		 * will cause #VC exceptions when the AP can't handle them yet.
> +		 */
> +		th->start = (u64) secondary_startup_64_no_verify;
> +
>  		if (sev_es_setup_ap_jump_table(real_mode_header))
>  			panic("Failed to update SEV-ES AP Jump Table");
>  	}
> -- 
> 2.27.0
> 

-- 
Kees Cook
