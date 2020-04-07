Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE32C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F38206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnfVn5XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDGCVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:21:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43971 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgDGCVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:21:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id 13so201148qko.10;
        Mon, 06 Apr 2020 19:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d3OTp6P4iJBpO32UtjNgagNZnorXfs0OTex38lW1SVE=;
        b=VnfVn5XD09eRBnimploj/xWSm6LUt5UTw/kdQVNivaRARmZcQGlEg0ad4AT/uNyH1U
         OICvUgi3Xpnt2oRVXzDo8+rmnXTVKpFPZAcjvfNnHEsh5Iw3sKVsbIHngQYJ5LVTvWja
         D7sth7PFP/9nYi+ybYpJiAKZBd68zGWO7rLNIrbr4993aEZSgqLDpRfEziYa3W+tsKb3
         UKDmiz3Tf/cQuT3gpDdnwDOesFS1OYz7YX5dgNFrpFYQAokyLNI+cnG6jQb2A0Muzaq5
         6xz35Kffsdl7kPHOIBI3SunSe3bweGHZg6MMRa6TFOf4JlXyRea75KaGNMyKZ2QqkPpW
         YAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=d3OTp6P4iJBpO32UtjNgagNZnorXfs0OTex38lW1SVE=;
        b=ZL3+zDCtSqk+OcbsAbvyXRVWuESw0iN622UCD1auB4IdpAjvfSs2tsHfLvrCKE4Thm
         ne4Zk/8w8WLXSxxZosgWj5tNX4pXRoehB5fWPSK5ZQuIdSPVzG0RpqVFbb5WOSlgEHk8
         o1rwkj/7OtxwVNkD3HYv47tNNxyojQAwPa3jXCVgOz4mzvknPWWPNVm6+fEyJRuRmRFX
         hb/acuh2K3WZl14JXMVrM4u/LGtf2XMdx1HMClBh2LvuyyBAGuQI9s9JUzmgk4NTuiPe
         GJ/QPfLlHicsc34sXNmT7hhKaco+Bq13BoSYA6YDaNGQCaZMyuOzzJmHSzcMt4s1fDWH
         WNpQ==
X-Gm-Message-State: AGi0PuYkKc9QrPZQ8e4lnxOaZNmMsjMr5ygsU9392flSRDqJ0Xoi+Wod
        +DLiGrAR2ebK/57+V5zAK8g=
X-Google-Smtp-Source: APiQypIydvdBhUMkPT6s6y1cRhEQzSVdFhl/CvA7uUrUF13mPI2T18OjaVpSbnNpSv+yYFZuowPa+w==
X-Received: by 2002:a37:7fc3:: with SMTP id a186mr46264qkd.251.1586226090068;
        Mon, 06 Apr 2020 19:21:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f68sm15720856qtb.19.2020.04.06.19.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 19:21:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 6 Apr 2020 22:21:27 -0400
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 12/70] x86/boot/compressed/64: Add IDT Infrastructure
Message-ID: <20200407022127.GA1048595@rani.riverdale.lan>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-13-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319091407.1481-13-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:13:09AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add code needed to setup an IDT in the early pre-decompression
> boot-code. The IDT is loaded first in startup_64, which is after
> EfiExitBootServices() has been called, and later reloaded when the
> kernel image has been relocated to the end of the decompression area.
> 
> This allows to setup different IDT handlers before and after the
> relocation.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 1f1f6c8139b3..d27a9ce1bcb0 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -465,6 +470,16 @@ SYM_FUNC_END_ALIAS(efi_stub_entry)
>  	.text
>  SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>  
> +/*
> + * Reload GDT after relocation - The GDT at the non-relocated position
> + * might be overwritten soon by the in-place decompression, so reload
> + * GDT at the relocated address. The GDT is referenced by exception
> + * handling and needs to be set up correctly.
> + */
> +	leaq	gdt(%rip), %rax
> +	movq	%rax, gdt64+2(%rip)
> +	lgdt	gdt64(%rip)
> +
>  /*
>   * Clear BSS (stack is currently empty)
>   */

Note that this is now done in mainline as of commit c98a76eabbb6e, just
prior to jumping to .Lrelocated, so this can be dropped on the next
rebase.

Thanks.
