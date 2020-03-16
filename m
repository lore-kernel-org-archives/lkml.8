Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98074C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E7E20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NC5C6doT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgCPUyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:54:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45189 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPUyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:54:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id m15so10400817pgv.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8zaBBvQDtHAjHEbDBvVjsaeN/s+0x2io0CGlb7cqMuk=;
        b=NC5C6doT6AV4hlrji55WQRv2ak6KZA54MIACHybf9hYpmGdaQvZ5lqKUD9ww5OWaab
         EZsNrn06nhTAfOUb72zCr5pH6xiWjtjY6IsodW1jMXEH+eF53vW312XumTTpWljyZ8wE
         wEkT0WMsSVGjb6GvfDpP49Cp/iJS2YAi33ARk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8zaBBvQDtHAjHEbDBvVjsaeN/s+0x2io0CGlb7cqMuk=;
        b=nSqEXGJAfANwo5zlsvfKmqovc363rViqxygJnB+XJzz5lGS0kMbGRBAG+DmymecYvn
         enR1/4LU/LK4Zs7RExAJqpcobBjJjw7P7AqzwETY4DvOCXP9mCCUGpt/OCZ8ZdzLl0mi
         vsVF+5gsk0U2rYOXqwiljVN4ruIwP7xADbVcOmOiEEqq+auYFHnypuBdgjmxrtwQg82q
         GEYq9LFW//KC8/9surDATR0TEi4olKVYcihuIQCmAn1FXc7xzxnltMjsUGyhJxickCfR
         L0RF253mglLcQ3yDj4k5r55LrglDs99jVLSoP0fv1Qox1oBVnRpxjD9qrhgLdYYC8W0u
         v0Zw==
X-Gm-Message-State: ANhLgQ1un//yaU0g61GjFJXKpZn5Gm17Xm3O/Zdjm7zRiB0Mz1edrcFf
        UehYa4UaMfyhOwZBobPp2eJY4A==
X-Google-Smtp-Source: ADFU+vvE7G4Rh/cPZyrk4V/K67aeMmLDEO8ABilE2ePX/BPd0FpssbnC0NcQjOjCNteMmCCgiD+oWw==
X-Received: by 2002:a63:1e44:: with SMTP id p4mr1614833pgm.367.1584392077826;
        Mon, 16 Mar 2020 13:54:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm391580pge.48.2020.03.16.13.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 13:54:36 -0700 (PDT)
Date:   Mon, 16 Mar 2020 13:54:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Message-ID: <202003161354.538479F16@keescook>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
 <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316160259.GN26126@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 05:02:59PM +0100, Borislav Petkov wrote:
> Long overdue patch, see below.
> 
> Plan is to queue it after 5.7-rc1.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Mon, 16 Mar 2020 16:28:36 +0100
> Subject: [PATCH] Documentation/changes: Raise minimum supported binutilsa version to 2.23
> 
> The currently minimum-supported binutils version 2.21 has the problem of
> promoting symbols which are defined outside of a section into absolute.
> According to Arvind:
> 
>   binutils-2.21 and -2.22. An x86-64 defconfig will fail with
>           Invalid absolute R_X86_64_32S relocation: _etext
>   and after fixing that one, with
>           Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> 
> Those two versions of binutils have a bug when it comes to handling
> symbols defined outside of a section and binutils 2.23 has the proper
> fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html
> 
> Therefore, up to the fixed version directly, skipping the broken ones.
> 
> Currently shipping distros already have the fixed binutils version so
> there should be no breakage resulting from this.
> 
> For more details about the whole thing, see the thread in Link.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> Link: https://lkml.kernel.org/r/20200110202349.1881840-1-nivedita@alum.mit.edu
> ---
>  Documentation/process/changes.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index e47863575917..7a842655142c 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
>  ====================== ===============  ========================================
>  GNU C                  4.6              gcc --version
>  GNU make               3.81             make --version
> -binutils               2.21             ld -v
> +binutils               2.23             ld -v
>  flex                   2.5.35           flex --version
>  bison                  2.0              bison --version
>  util-linux             2.10o            fdformat --version
> -- 
> 2.21.0
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Kees Cook
