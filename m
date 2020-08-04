Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E4CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C542076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqh/K0Z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHDB47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDB46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:56:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C71C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 18:56:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b25so29836362qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 18:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ah+PGP8o/FyvN4G1VIxPhld3lHPU5Vf3p/CKy9L7JHU=;
        b=rqh/K0Z8o4cRv/wOXznVBNzevV2V7Bh/f9d4Lhgj36/+jmZgclumX4v86fggvH70lh
         MPHYaNd+ARKYE81oPUXg3zpmFjoIGL8esu+97xyTg1VVsBLLS+DYcz4cNM8jbtxM0yMW
         Uarj6gDquGsCwurCHH4fGkU/vlDrIn0MfdA5bSTvi0yXVAOOOEimkTNJGt5PA8Q2B+c+
         TdQ50aaVMqc+WUmnoeECBIKuv4kcWFI9iCWIWQEV3C2E4Zo3xyVjd/9XH1WYaipgfwlJ
         iiDnNZDKY0d6WlSdlXd4maNP6qYcMpcN2dk0QMxBNA11TzC3eso/XHIWtKbTxzMr/n1E
         X0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ah+PGP8o/FyvN4G1VIxPhld3lHPU5Vf3p/CKy9L7JHU=;
        b=oz2M6uYxybzkYEjQ1y1U+8X3KN6iRiJJAl4I7IvsNepIDx+y1t+sWy3+Gm7mwHVhg4
         +J7HixMIZQxWYhNZx6MPbon9I9muiIDcYAwcK3RaFl92x+BhYqkeeNDPXCfZdLzYcfCI
         oTDR0d3F5QgrpMLadD0bVKrUwXIYyolVF0+l6W7aHhbA1rzfeKztSzNq/B2DvvqLBRNv
         zF8A6fuJkzwfwbeAE8jfpyoBTlpPKdyV+DyMn+d0Cub0zoSMKshEtvSNT4hLEXylSicA
         hKVpnw2JQntMQFj9inbLH4r8V00z1laT71S3mTIbRbROVQFBeSXPeYXbGyTvd0FmWtSh
         Mw5w==
X-Gm-Message-State: AOAM5320mnfOZNpfToZgByxS6GRyYeJ05mKPw7jLM4TB4pvzR8kSAWwQ
        pZQgF6dJgprN3n2CgMtUj7g=
X-Google-Smtp-Source: ABdhPJwAiwO+ABOtDXxy0Oamvfv2f26RhXUHELDzXlv6x1NDV2Sx0ONVeB+ARJD4O80zsRsmI0IwcQ==
X-Received: by 2002:ac8:1e0e:: with SMTP id n14mr19245064qtl.109.1596506217315;
        Mon, 03 Aug 2020 18:56:57 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y3sm24273096qtj.55.2020.08.03.18.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:56:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 3 Aug 2020 21:56:54 -0400
To:     Nick Terrell <terrelln@fb.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Terrell <nickrterrell@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lz4: Fix kernel decompression speed
Message-ID: <20200804015654.GA1943218@rani.riverdale.lan>
References: <20200803194022.2966806-1-nickrterrell@gmail.com>
 <20200803215747.GA1644409@rani.riverdale.lan>
 <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 10:55:01PM +0000, Nick Terrell wrote:
> 
> 
> > On Aug 3, 2020, at 2:57 PM, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > 
> > On Mon, Aug 03, 2020 at 12:40:22PM -0700, Nick Terrell wrote:
> >> From: Nick Terrell <terrelln@fb.com>
> >> 
> >> This patch replaces all memcpy() calls with LZ4_memcpy() which calls
> >> __builtin_memcpy() so the compiler can inline it.
> >> 
> >> LZ4 relies heavily on memcpy() with a constant size being inlined. In
> >> x86 and i386 pre-boot environments memcpy() cannot be inlined because
> >> memcpy() doesn't get defined as __builtin_memcpy().
> >> 
> >> An equivalent patch has been applied upstream so that the next import
> >> won't lose this change [1].
> >> 
> >> I've measured the kernel decompression speed using QEMU before and after
> >> this patch for the x86_64 and i386 architectures. The speed-up is about
> >> 10x as shown below.
> >> 
> >> Code	Arch	Kernel Size	Time	Speed
> >> v5.8	x86_64	11504832 B	148 ms	 79 MB/s
> >> patch	x86_64	11503872 B	 13 ms	885 MB/s
> >> v5.8	i386	 9621216 B	 91 ms	106 MB/s
> >> patch	i386	 9620224 B	 10 ms	962 MB/s
> >> 
> >> I also measured the time to decompress the initramfs on x86_64, i386,
> >> and arm. All three show the same decompression speed before and after,
> >> as expected.
> >> 
> >> [1] https://github.com/lz4/lz4/pull/890
> >> 
> > 
> > Hi Nick, would you be able to test the below patch's performance to
> > verify it gives the same speedup? It removes the #undef in misc.c which
> > causes the decompressors to not use the builtin version. It should be
> > equivalent to yours except for applying it to all the decompressors.
> > 
> > Thanks.
> 
> I will measure it. I would expect it to provide the same speed up. It would be great to fix
> the problem for x86/i386 in general.

Thanks. I tried using RDTSC to get some timings under QEMU, and I get
similar speedup as you have for LZ4, and around 15-20% or so for ZSTD
(on 64-bit) -- I see that ZSTD_copy8 is already using __builtin_memcpy,
but there must be more that can be optimized? There's a couple 1/2-byte
sized copies in huf_decompress.c.

For the rest of the algos there seems to be no difference, likely
because some casual grepping doesn't show any constant-size copies in
the other algorithms.
