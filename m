Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D3AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B872C2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S9F2yfa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKSQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHKSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:16:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7700C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d2angCcfziZJsj+jE5k0KH3MCZIXsKjqVtB9YbQL44w=; b=S9F2yfa/UzmRITxVoNJ9lYraVf
        Dy6MZ/M1ZBoBbV+p6eAQcY0VezPPFBCRlz6gqSuqC23Xcz2ebJ1urP9Gr4WE+izj+2ltXOAqd2QRG
        XT3q1CfhnyfcEQwSwTLEt3ITXI8YkMcZX3WgZM/f4VbwtJ4hUfnQqouRsm1XNTOZmKxrus69f4AF3
        E89nzV8iJViywqhN+D1abbdpG2hHKMw3L4Si6M1UWVTg1vLUVQmQjpCcFeR5j3ZavvHx+NVMhQUKR
        N9Hvsq7cORsmxq2k8uyLJdhfgVc/0isUCN1i7dVuql95XYZMgJFB8asOHsj0aOuJqZGcIPD1XKw6W
        TqKbkyhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Yp6-0007wb-7O; Tue, 11 Aug 2020 18:16:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B5BD3060AE;
        Tue, 11 Aug 2020 19:59:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32C1820BFC4E4; Tue, 11 Aug 2020 19:59:12 +0200 (CEST)
Date:   Tue, 11 Aug 2020 19:59:12 +0200
From:   peterz@infradead.org
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200811175912.GF2674@hirez.programming.kicks-ass.net>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan>
 <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs>
 <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811160134.GA13652@linux-8ccs>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 06:01:35PM +0200, Jessica Yu wrote:

> > > On Tue, Aug 11, 2020 at 04:34:27PM +0200, Mauro Carvalho Chehab wrote:
> > > >   [33] .plt              PROGBITS         0000000000000340  00035c80
> > > >        0000000000000001  0000000000000000 WAX       0     0     1
> > > >   [34] .init.plt         NOBITS           0000000000000341  00035c81
> > > >        0000000000000001  0000000000000000  WA       0     0     1
> > > >   [35] .text.ftrace[...] PROGBITS         0000000000000342  00035c81
> > > >        0000000000000001  0000000000000000 WAX       0     0     1

> Interesting, my cross-compiled modules do not have the executable flag -
> 
>  [38] .plt              NOBITS           0000000000000340  00038fc0
>       0000000000000001  0000000000000000  WA       0     0     1
>  [39] .init.plt         NOBITS           0000000000000341  00038fc0
>       0000000000000001  0000000000000000  WA       0     0     1
>  [40] .text.ftrace_tram NOBITS           0000000000000342  00038fc0
>       0000000000000001  0000000000000000  WA       0     0     1

> I'm a bit confused about what NOLOAD actually implies in this context. From the
> ld documentation - "The `(NOLOAD)' directive will mark a section to not be
> loaded at run time." But these sections are marked SHF_ALLOC and are referenced
> to in the module plt code. Or does it just tell the linker to not initialize it?

Yeah, that confusion is wide-spread, so much so that bfd-ld and gold,
both in bintils, had different behaviour at some point.

Anyway, another clue is that your build has all NOBITS, while Mauro's
build has PROGBITS for the broken sections.

Anyway, my gcc-10.1/binutils-2.34 cross tool chain (from k.org)
generates the same as Jessica's too. I wonder if binutils-2.35 is
wonky...
