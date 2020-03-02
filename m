Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39A9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0B22166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hfP1LWoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCBSiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:38:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34914 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCBSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:38:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id 7so242678pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ej0n7zujhXtajx5o0YH5Dp6SgQHR/F6Xm8CHAXoCQaY=;
        b=hfP1LWoF98HaakBzzPLisRZah3h5wcxUGYhbaD61bTzqmqylwvkkyeXaBM5Uqz1lvD
         SP4xhO+dyxePNM/RIfC19zhyCQYo9ixXDi1Bi+F7dTsIiw27aCNk70BeiYtqEM1fBQT4
         fVHiEK6TYtL1vi4GuRcbFCkXFIauPUBlT/dvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ej0n7zujhXtajx5o0YH5Dp6SgQHR/F6Xm8CHAXoCQaY=;
        b=kgcaxU3wDgJHODak4m+wDTTDmpNCQoPiDOZialyYiUfvggbirzH5K+R2WZe2Q4WPYR
         nQGvPdI5uI/UM98iOuXtuP11B77nEupiv990Ds1wiBkBUfy6Kmv0aywIyrTJoojLwjsU
         pDs/OsDq2peVZrfihBToH48Jdqqu09L4LsLzhmfdyXvImc0wY/Fph2ZHQHzU3OnifjLT
         OKpB/d8F4vbrEiSa1U0M7s84auDAhTbpEt+NuVqP5H9R8EeqheRkEDPqLGzU0+BetPvC
         yi+ANFh2ne+httCa3QY2btQDWgrh3HfkeZkr9ozkDdfMphTIYc3Vos4khIO8IIPKlrAD
         op1w==
X-Gm-Message-State: ANhLgQ27CK1Rzb57xyUDz/8HOcasxJ0oYe4KDH5TYRcB84ObGmEv+Rkv
        VHfYgLrMgO//aVsz67coBABlVQ==
X-Google-Smtp-Source: ADFU+vsv11PyBcLRZxqMDdAd1Q/RQi5ywoEpqoxJWiv3D/4XrUyhginfjW/qzBGk00VMyBgMmY42Fw==
X-Received: by 2002:a63:6202:: with SMTP id w2mr276745pgb.154.1583174333320;
        Mon, 02 Mar 2020 10:38:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a31sm7343219pgl.58.2020.03.02.10.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:38:52 -0800 (PST)
Date:   Mon, 2 Mar 2020 10:38:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     dave.hansen@linux.intel.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, me@tobin.cc,
        peterz@infradead.org, tycho@tycho.ws, x86@kernel.org
Subject: Re: [PATCH] x86/mm/init_32: Don't print out kernel memory layout if
 KASLR
Message-ID: <202003021038.8F0369D907@keescook>
References: <20200226215039.2842351-1-nivedita@alum.mit.edu>
 <202002291534.ED372CC@keescook>
 <20200301001123.GA1278373@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301001123.GA1278373@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 07:11:23PM -0500, Arvind Sankar wrote:
> On Sat, Feb 29, 2020 at 03:51:45PM -0800, Kees Cook wrote:
> > Arvind Sankar said:
> > > For security, only show the virtual kernel memory layout if KASLR is
> > > disabled.
> > 
> > These have been entirely removed on other architectures, so let's
> > just do the same for ia32 and remove it unconditionally.
> > 
> > 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> > 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> > 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> > fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> > adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> > 
> > -Kees
> > 
> > -- 
> > Kees Cook
> 
> microblaze (arch/microblaze/mm/init.c) and PPC32 (arch/powerpc/mm/mem.c)
> appear to still print it out. I can't test those, but will resubmit
> x86-32 with it removed.

Might as well fix those up too. :)

-- 
Kees Cook
