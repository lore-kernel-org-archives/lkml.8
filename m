Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71459C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3533F214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RnIhoBca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgCCE6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:58:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36891 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgCCE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:58:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id q4so757848pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 20:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hSEdVVVDgZdy6He5V0A4/AbbMgeYMefEzhdDiEiHlHk=;
        b=RnIhoBcaB7jH8YQOwFFgO92FuxnDQmHa9imv8vTTArH8ajkDJWyLLyaKulhmHp7Lj5
         GO2zjQoyqFOy9oXOfdkNNmrWBHrG0SjZo4J79mpYevRQemiYanOy6cYBBpyZkb2wJQ3s
         vo3cTr109M5rsMFMAVQznkfEL42U3sCNv8Q80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hSEdVVVDgZdy6He5V0A4/AbbMgeYMefEzhdDiEiHlHk=;
        b=f8+cQzRcRQoDvMtACCuV5k/o+mIDTAy23hgUicp+kCbD5SeOBEf0fyeJtRQPF5unCN
         mTIyXSruy0qjffukxZOL3EALtUiFSyizsljPOBnxrfpBWmkwYJTT24qmVoO5y/hBwz0E
         AyqlJJihMWHoFrtSwh5bCkN985J6DonS2nTizn4xDtEbvgifW4rMVMzKX68fyGwSacEo
         X83l5XbsPJjhbHsSgnH6vDNeoKxHqaB+adB3HsAXQuWcD0IF2nZEolCd2cm/Q0sL9Vka
         LmvHaXpfdNizp/MwGouO9ybQ1sq/ZC6rBnT0s6px3vxiEbmL6wKDSCp0BrPTUgklTr0V
         af0w==
X-Gm-Message-State: ANhLgQ1OiAreDqp07dhDeB4SzJfyRNAE5ncvzJ+ocNtqiL+aAyodI4r2
        C2II3aXqf4mqYGdH71sjMsvqhg==
X-Google-Smtp-Source: ADFU+vvvTc8b/TBz9AayPpivbmrvSUk1WS3OUl1FwD7+cwBqVmBrUoTOPnfNlb/H3D562V7xX1GFLw==
X-Received: by 2002:a17:90a:1951:: with SMTP id 17mr2136103pjh.101.1583211481829;
        Mon, 02 Mar 2020 20:58:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t19sm22450658pgg.23.2020.03.02.20.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:58:01 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:58:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 06/11] x86/CPU: Adapt assembly for PIE support
Message-ID: <202003022057.D84B66E042@keescook>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <20200228000105.165012-7-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228000105.165012-7-thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:00:51PM -0800, Thomas Garnier wrote:
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible.
> 
> Signed-off-by: Thomas Garnier <thgarnie@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/processor.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 09705ccc393c..fdf6366c482d 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -746,11 +746,13 @@ static inline void sync_core(void)
>  		"pushfq\n\t"
>  		"mov %%cs, %0\n\t"
>  		"pushq %q0\n\t"
> -		"pushq $1f\n\t"
> +		"leaq 1f(%%rip), %q0\n\t"
> +		"pushq %q0\n\t"
>  		"iretq\n\t"
>  		UNWIND_HINT_RESTORE
>  		"1:"
> -		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
> +		: "=&r" (tmp), ASM_CALL_CONSTRAINT
> +		: : "cc", "memory");
>  #endif
>  }
>  
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

-- 
Kees Cook
