Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8573C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A7E206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQuGNfVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgBVSOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:14:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37447 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgBVSOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:14:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id q84so5042009oic.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8hX/FaRljJV5KsRO4w2p+JOJK5twqcG/ZN1GiH8f9cg=;
        b=HQuGNfVdh0zLFlmkG3cIW7Sdue6KkPyQp8s06d6cUO82rddaBgx9zKU+zMmQ94TYtz
         C2IRFTaDv4UIBMr644N+ecYBq8Pm+rWTytgwlfh+VDGlO4/A0VNqDIr7Ukv37gI5AxDN
         rC5HpookpaAvUycQO2VPNDYcdFd5Loy08Yr7/Z35dYzvLrXXa8lpTkt1tAeply+fuAMX
         onl/KbpwQu+KitVoTABxmi9es16UQCv71UPqGS5X0tkaJ2fqG8L5G9WdmCFIqoClRcwb
         37pY9kidp5c/C2uEpDPZ2yIHvOQUHyxtBb8Q/N3bhvetTAUzsIyAT2Wuyj1SuuBrp7XZ
         nXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hX/FaRljJV5KsRO4w2p+JOJK5twqcG/ZN1GiH8f9cg=;
        b=Y6F4l8w4w+aCmXJFjIqduYV5xQlrrK6DPRWDpSkNCz+A4oO2ogYMBWF2QPKwFbrnT2
         MRs96OgLmVuMFZGkbxnH77p1yXXqJaKfMbk90wDBDrK9T001uu3qUBu1ksf8HT1Dg2sL
         4P5vCQchHFuPOEpbig9PZdbE+vm0dXpNAzqWtCcowHG22dh1D1uNnnWGh3EJjWFcLoCe
         IZpV28CZvt7BjJNRcV1vl2lKEI7DI9S2CwAs60v98vUlTaK76WGBxbW8sOb6E9djg2tY
         UtFVEMyURU1y02Md22fEi52GhMd7KxoR9wfHAc2ZwZAGo18vqxFDYCTQlvZWv1iyvQxy
         Z6QA==
X-Gm-Message-State: APjAAAVIQJek6tMLroXKrQHMPyBGF7c81TxjjOzCFDE3qWuBvQjdGPDR
        CZHVkf7MiSviJ9BasV9MQ24=
X-Google-Smtp-Source: APXvYqzfmqVuVXB+gZX+rxiZecjABHc7rN/lMn8FGOEU4mCXS+6EoEXHmh5KexVq1Nl7vTWMNQBQ8w==
X-Received: by 2002:a05:6808:7dd:: with SMTP id f29mr7135326oij.67.1582395255944;
        Sat, 22 Feb 2020 10:14:15 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id p65sm2231612oif.47.2020.02.22.10.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Feb 2020 10:14:15 -0800 (PST)
Date:   Sat, 22 Feb 2020 11:14:13 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Fangrui Song <maskray@google.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/boot/compressed: Fix compressed kernel linking with
 lld
Message-ID: <20200222181413.GA22627@ubuntu-m2-xlarge-x86>
References: <20200222164419.GB3326744@rani.riverdale.lan>
 <20200222171859.3594058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222171859.3594058-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 12:18:59PM -0500, Arvind Sankar wrote:
> Commit TBD ("x86/boot/compressed: Remove unnecessary sections from
> bzImage") discarded unnecessary sections with *(*). While this works
> fine with the bfd linker, lld tries to also discard essential sections
> like .shstrtab, .symtab and .strtab, which results in the link failing
> since .shstrtab is required by the ELF specification. .symtab and
> .strtab are also necessary to generate the zoffset.h file for the
> bzImage header.
> 
> Since the only sizeable section that can be discarded is .eh_frame,
> restrict the discard to only .eh_frame to be safe.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
> Sending as a fix on top of tip/x86/boot.
> 
>  arch/x86/boot/compressed/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 12a20603d92e..469dcf800a2c 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -74,8 +74,8 @@ SECTIONS
>  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
>  	_end = .;
>  
> -	/* Discard all remaining sections */
> +	/* Discard .eh_frame to save some space */
>  	/DISCARD/ : {
> -		*(*)
> +		*(.eh_frame)
>  	}
>  }
> -- 
> 2.24.1
> 

FWIW:

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
