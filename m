Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11CAC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FE520CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le1Nz8N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgBYRt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:49:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43518 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731017AbgBYRt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:49:57 -0500
Received: by mail-qt1-f196.google.com with SMTP id g21so228909qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xRRmwcNUsR+GhcUjy9+SyPV6XEYtfd5D5Ja+YQokWiA=;
        b=Le1Nz8N5wJimx6Cq77znmKci4x87K/gkTCkMfK1j7bJ8Fv9ymgm/XdiSiOnPcw59Uw
         rLt/1/ZWyfPowrtLXK1HsrBUNyO7hODU7ZiV/uvlIkSSg+i8Fr+zjxZ4w+DPEe74w7fn
         Zf6eXtWvTOQnAMfHADwvdXdfpmgR1iX4ijn446/439PzTmMu+JjT6M99asMiUWlI4ioc
         FyiGlNwsZOT9MUA/7uMaUcqfyjRPMSBEaBRs92XACg/xV5HOCOPGbjeFQUrwfIR8F0R7
         m8/NWnpniNXJAuTgdF+aFLOsWCOZCNNSALWVB641OGBBw7N8SkAD154cauwtYpJJ9W7Q
         K1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xRRmwcNUsR+GhcUjy9+SyPV6XEYtfd5D5Ja+YQokWiA=;
        b=KbpelOtPrVIX7QCt2+TPhRM3Kd7GeAqu/ulcYAAngsAF8Nd6jyddbxyQeQE5Cymrcw
         OGqGisFONKXy8S8pFM93CuenNkx9APpkCpnpQM3p6arZe6GvP7fPxJb92lAmsoTyL/CC
         Uc3U1Mct5V+GajLZhLqjE/+N32I5EWEMNHFkoGkGkGyDrmECN/RM1O4eRscj4nK7SdOG
         3I6TLgwOCRpOZ+/XhoredS5cxbsOfC7R445IzzsaGixmlZXchfoqBN10wthrelQYFWIT
         73cuiNYQrz51qe6Tcf5ikRJaumal44SINTKGYpM+7vAt56xMKfdO1lZspGD/fy3nBjye
         8UCQ==
X-Gm-Message-State: APjAAAWQyMs21N6Y+aSPzmwxAP5XQurJJvB3PPzjqW8Bo9Rrf94X7sT9
        53+Rs7OG72qArM07Lst2mvc=
X-Google-Smtp-Source: APXvYqzZa4ogNVvT5VxJnr40/hfAfIF63UJfQH6ZI2z+wrgJCDPOis9RIBPDS3YG3vDgxX31ODwTXQ==
X-Received: by 2002:ac8:1308:: with SMTP id e8mr56613876qtj.242.1582652995139;
        Tue, 25 Feb 2020 09:49:55 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o17sm7919334qtj.80.2020.02.25.09.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:49:55 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 25 Feb 2020 12:49:53 -0500
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
Message-ID: <20200225174951.GA1373392@rani.riverdale.lan>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-9-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205223950.1212394-9-kristen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:39:47PM -0800, Kristen Carlson Accardi wrote:
> At boot time, find all the function sections that have separate .text
> sections, shuffle them, and then copy them to new locations. Adjust
> any relocations accordingly.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  arch/x86/boot/compressed/Makefile        |   1 +
>  arch/x86/boot/compressed/fgkaslr.c       | 751 +++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.c          | 106 +++-
>  arch/x86/boot/compressed/misc.h          |  26 +
>  arch/x86/boot/compressed/vmlinux.symbols |  15 +
>  arch/x86/include/asm/boot.h              |  15 +-
>  arch/x86/include/asm/kaslr.h             |   1 +
>  arch/x86/lib/kaslr.c                     |  15 +
>  scripts/kallsyms.c                       |  14 +-
>  scripts/link-vmlinux.sh                  |   4 +
>  10 files changed, 939 insertions(+), 9 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/fgkaslr.c
>  create mode 100644 arch/x86/boot/compressed/vmlinux.symbols
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index b7e5ea757ef4..60d4c4e59c05 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -122,6 +122,7 @@ OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
>  
>  ifdef CONFIG_FG_KASLR
>  	RELOCS_ARGS += --fg-kaslr
> +	OBJCOPYFLAGS += --keep-symbols=$(obj)/vmlinux.symbols

I think this should be $(srctree)/$(src) rather than $(obj)? Using a
separate build directory fails currently.
