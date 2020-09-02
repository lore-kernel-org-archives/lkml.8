Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF9AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10F4207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdj78YXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgIBQIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIBQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:08:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98A7C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:08:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so210798qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D8gITKza0XwTTApPFQOx1l+4YOSWzYngcKCGuzpi0AI=;
        b=Sdj78YXCXyAOtsbRsyIYWd2C4LqQGBRna79Z0k5t/Y9YX7cXle9zvQynGr8zta8b0S
         f9BTNAJDaJX0HlEH2CJ+X/J81LamaxdEjc2JXXnQpsn0enneQJ6SiB1TEy6IWyLw9Log
         sjJfW62YUFWPx49jINrjlaUCZu09SsczZGfT1C1dKBz/nXtQxb0D3njvdV14m6m0cwUP
         tlgJyhfRSKOSryGVt0Ei+cM4B1gl9hRY2efv1LmA8DTCdEST9W7MnIocJMgrIrS1RFf9
         WJjV/LVUnTvqyWrdr7xPgRcoqo1VQsaF9JGPEl9lavRYJzPMdePS0X9Sx1nLmp2oeiVE
         oBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=D8gITKza0XwTTApPFQOx1l+4YOSWzYngcKCGuzpi0AI=;
        b=QXRdy2VxcHyLE2A7vbbyHwXnVl/zpCIy8VcbySS+mGj8K8dFbarDC1iHoenPt/klmq
         lizSuU7kST9zoasp4SrGtlFqA+gm0phJGAbb9F3ucckB9/S4Mu/QEgAg+gM81sePFhqf
         eicjU6Utr6mBKmYcdOqMoFTC7nk+BiC5QpWVmudEzPl4dpL+hTcwVqFBQiPSIwxOM2pl
         rbnELZYhUuQZh/pQ/u0N0td9pD6U2Ub+7bctYvhQvN23BglY0pzeBZq+NkTVAF6rjJ+t
         dhLl/OUFB/2xHILMu9IuCfQvNjrtNuCPHY7k6NIJwhSIKWcb7t/8vzWMeyMGAEVP1myQ
         kQGQ==
X-Gm-Message-State: AOAM531J6VsRNAdU2G8ud4NWJCosF8pO2U+Egkpz2segqglBjzclMAPs
        JdjDNN30DShRzT1SP0ildxs=
X-Google-Smtp-Source: ABdhPJw6fJqZCc4rNA34EJERpQ+Ah6DSmZvaftJBfCz2vrBIMVQj/zh3An2RBiYsvzfaObEz2f3g1A==
X-Received: by 2002:a37:afc3:: with SMTP id y186mr7765891qke.36.1599062911863;
        Wed, 02 Sep 2020 09:08:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d76sm30180qkc.81.2020.09.02.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 09:08:30 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 2 Sep 2020 12:08:28 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>, nadav.amit@gmail.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] x86/asm: Replace __force_order with memory clobber
Message-ID: <20200902160828.GA3297881@rani.riverdale.lan>
References: <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <20200902153346.3296117-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902153346.3296117-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:33:46AM -0400, Arvind Sankar wrote:
> Fix this by:
> - Using a memory clobber for the write functions to additionally prevent
>   caching/reordering memory accesses across CRn writes.
> - Using a dummy input operand with an arbitrary constant address for the
>   read functions, instead of a global variable. This will prevent reads
>   from being reordered across writes, while allowing memory loads to be
>   cached/reordered across CRn reads, which should be safe.
> 

Any thoughts on whether FORCE_ORDER is worth it just for CRn? MSRs don't
use it, Nadav pointed out that PKRU doesn't use it (PKRU doesn't have a
memory clobber on write either). I would guess that most of the volatile
asm has not been written with the assumption that the compiler might
decide to reorder it, so protecting just CRn access doesn't mitigate the
impact of this bug.

Thanks.
