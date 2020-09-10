Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F13C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C34421D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599759974;
	bh=TXUjfWQi9tM2HzGm/oaJfdPsQO5fWIgylvuQhOYz4m4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SOXG/E5LO/IAiPrWJRSRVUtqasHZ9SmO6IZFCMScVGNwxmXnY6w6/qLVhRSCBRPUL
	 PmpQO/8nmZxvF+J3uLpdEvbJHVPyNuEk3qHah1dNorfHGAvqhSzfA8cFiKbT7IJvtl
	 F/Q/RgRUtewvXdfTELshVn7CGkFExFrUNAAnOrH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIJRqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgIJRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:42:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E6C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:42:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c2so9258943ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tV9NvYryEbzez94zd9hdsCWt3FfBuGGawTOfDap0eBk=;
        b=CyoQUM+SKXH6085O6WtByg3nDuki2CTSBORvYvwm25BqShZutFnNs6mSZACayZwSEH
         qcd6gDs3XmrAOcCBysWWLpsCbEXmLRDCQnQxo0ENK46fWC+ppV/l5rSOr47qH79HuDsY
         BAC6cJAHl7u65bYmrM5WLZPBZBfoI7ltEXEKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tV9NvYryEbzez94zd9hdsCWt3FfBuGGawTOfDap0eBk=;
        b=gaxeIL1UgV6zoe7GWetUE3JjPlgTm/X5pVQ00k/OZDKQrq6c5PRLIVhi8kAemoy5ps
         0x86BFP2GZaLbIvFrB7LlPc1ObX6yWnx7PjT6Kl+uRgBQ7SYnH+WNNTKQVSOdoDLPSQ/
         KELD2jAX7P5H7vhpHm32HcMM5lphNrh3gM7ZRY6f4+Kfpz0x7La22mX54LTh68Fw3YDm
         PHFUyslCe3K/LjZuZ7dMMw4lMryBkx7FGOpaEjOP0rmiq97zsG1GHZpMdw1KaXz18CZk
         VH8ryN95hNffSAl1SoyHo7DAJnAST4ls4agqZyEZKVqVs7w8Tqhbu1F/ZVu1LwM32Sss
         goJw==
X-Gm-Message-State: AOAM531slHtsCwgFPVs39pmhW7QgBOfxIzDwG8u8VG9ExhEJkJywikrz
        27PB+TS+/Y0relb78Y0rP8T9ra/1bV4cCA==
X-Google-Smtp-Source: ABdhPJyhWTw2yd7niyvGkh6b2x2kXbNyNxMZaHZ+ZAMzB8ie0jBkLA6wBWwZ1pJ5m3lp16Kd/krN/w==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr4611377ljc.119.1599759759148;
        Thu, 10 Sep 2020 10:42:39 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id u18sm1489111lfg.86.2020.09.10.10.42.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 10:42:38 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id b19so9256106lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:42:38 -0700 (PDT)
X-Received: by 2002:a19:7d8b:: with SMTP id y133mr4765702lfc.152.1599759354367;
 Thu, 10 Sep 2020 10:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com> <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad> <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca> <20200910093925.GB29166@oc3871087118.ibm.com>
In-Reply-To: <20200910093925.GB29166@oc3871087118.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Sep 2020 10:35:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
Message-ID: <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 2:40 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> It is only gup_fast case that exposes the issue. It hits because
> pointers to stack copies are passed to gup_pXd_range iterators, not
> pointers to real page tables itself.

Can we possibly change fast-gup to not do the stack copies?

I'd actually rather do something like that, than the "addr_end" thing.

As you say, none of the other page table walking code does what the
GUP code does, and I don't think it's required.

The GUP code is kind of strange, I'm not quite sure why. Some of it
unusually came from the powerpc code that handled their special odd
hugepage model, and that may be why it's so different.

How painful would it be to just pass the pmd (etc) _pointers_ around,
rather than do the odd "take the address of local copies"?

                  Linus
