Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A825C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFAE20707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJgoPeGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgA3Tkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:40:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36424 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA3Tkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:40:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id 185so2019763pfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 11:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DVn6zbqy7bvZdTzwM8BmdQE5K+7bxb6nlu5mnSErUpY=;
        b=BJgoPeGNtguEc08sRtnri1L2Fp3wrVFyIvN9w/oiBfOkSfQrhgwQODRJcjlocCfbgT
         bQz8ymHSya7KffQ8tIp17+5tx9GSMrmV5lZVBFM+XI/VH0YrCCwpzu7ry3YQcDkpqmKN
         kmvQ6TjemqI+feJDJxrUWbSuozUtFoB+al26o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DVn6zbqy7bvZdTzwM8BmdQE5K+7bxb6nlu5mnSErUpY=;
        b=Y2zV1ZdmNa7421lKpCtTui3wHxtqJMqeaMixHDM8vQ4SD8xsyAOpK9Ff0RkYIAqQ0h
         XQU1Qn4cKIltPTzvhU8XcWb6usiHszLv7KWfeVMusmJOeZSPlmOoslPn9ak+hJUkW5PF
         710CzGuXn9PePZ2ftOLtn6rBNzyQXjTPvv6P6MHCXsvlzEIV9FSwp67F7Pa1KqNeTLNW
         IqzJoh4u7E96NkyIv3tqcRdPlnsBQTyFG7bOy+oS19EFJF2ICDhPsg8ItHputGCygVKO
         fd+Th3EDzPU7K8UFUfVwuSJG3NFPxXom+J14udazwo53OI8YYELDnuL9bXkykRVdFYRm
         Wglw==
X-Gm-Message-State: APjAAAWNW9HW38Bwu8iK4XCjIajXFhrZkjukEkPa5jBREhhwU6fSN5I9
        3hWpEGUrlQacdBb7cgXwMKOvDA==
X-Google-Smtp-Source: APXvYqzH5KF5EcZIxk0wMeMAL8h3j+AnDMn6/vcruHtTmLB/P3BDW3QMj3wD1FLunx2J1zGgGW3EEA==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr6544241pfd.70.1580413246643;
        Thu, 30 Jan 2020 11:40:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q8sm7334400pgg.92.2020.01.30.11.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 11:40:45 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:40:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] x86: Don't discard .exit.text and .exit.data at link-time
Message-ID: <202001301139.F8859A4@keescook>
References: <20200130180048.2901-1-hjl.tools@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130180048.2901-1-hjl.tools@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 10:00:48AM -0800, H.J. Lu wrote:
> Since .exit.text and .exit.data sections are discarded at runtime, we
> should undefine EXIT_TEXT and EXIT_DATA to exclude .exit.text and
> .exit.data sections from default discarded sections.

This is just a correctness fix, yes? The EXIT_TEXT and EXIT_DATA were
already included before the /DISCARD/ section here, so there's no
behavioral change with this patch, correct?

-Kees

> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index d1b942365d27..fb2c45cb1d1f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -416,6 +416,12 @@ SECTIONS
>  	STABS_DEBUG
>  	DWARF_DEBUG
>  
> +	/* Sections to be discarded.  EXIT_TEXT and EXIT_DATA discard at runtime.
> +	 * not link time.  */
> +#undef EXIT_TEXT
> +#define EXIT_TEXT
> +#undef EXIT_DATA
> +#define EXIT_DATA
>  	DISCARDS
>  	/DISCARD/ : {
>  		*(.eh_frame)
> -- 
> 2.24.1
> 

-- 
Kees Cook
