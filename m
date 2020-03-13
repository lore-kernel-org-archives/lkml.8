Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765BCC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411C6206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fft2c0p2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCMRXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:23:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37162 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgCMRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ih+nG2Kiw8hT76L/vmQQGrhSjnKlvJyhcVO353Dkwk8=; b=fft2c0p2/PiiLEOjg+q4csveQL
        HdaNCQ88a2DRCpddJW8217lXe47Gfz+RkrPHQugjHG3TVz0d4vz+sM3aKc8awh1GCAQwGlk8X22LA
        m9FfoGi5uZS93fR0QSHP2U+LY/QtoRnOhB9HigJRqe6fr3tEYZy9AcjTZQbQ6DCWfBNc5aC8H4nDQ
        fNt/yFAz4fNRI7frO5my3/LGKd8YsB6PKORs67HHxn8xNXZf3RIQR1nBNePiki2jKc54jLiUYZNvX
        +8YG0VjC8c5iuQfox+VykKymQkHB6S+NsN7iXfAynzFou3dymyYIEWNRxeaJZOfbVOfYVqt20fY1k
        +oRnEkmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCo1U-0002dd-AZ; Fri, 13 Mar 2020 17:23:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC47A305F2E;
        Fri, 13 Mar 2020 18:22:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A18A92BE08CBC; Fri, 13 Mar 2020 18:22:57 +0100 (CET)
Date:   Fri, 13 Mar 2020 18:22:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [RFC][PATCH 04/16] objtool: Annotate identity_mapped()
Message-ID: <20200313172257.GC12521@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.641079164@infradead.org>
 <CAMzpN2gkRGEYEzgO55rBhkTdQO3XhEEfHrq6+j1dy5kzn-C5AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2gkRGEYEzgO55rBhkTdQO3XhEEfHrq6+j1dy5kzn-C5AA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 12:46:05PM -0400, Brian Gerst wrote:
> On Thu, Mar 12, 2020 at 9:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Normally identity_mapped is not visible to objtool, due to:
> >
> >   arch/x86/kernel/Makefile:OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o := y
> >
> > However, when we want to run objtool on vmlinux.o there is no hiding
> > it. Without the annotation we'll get complaints about the:
> >
>          call 1f
> 1:      popq %r8
>         subq $(1b - relocate_kernel), %r8
> 
> It looks to me that this code is simply trying to get the virtual
> address of relocate_kernel using the old 32-bit method of PIC address
> calculation.  On 64-bit can be done with leaq relocate_kernel(%rip),
> %r8.

Indeed. Objtool would be happy with that. And it seems I can still kexec
a kernel too.

Thanks!
