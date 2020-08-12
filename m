Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D60C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFE3208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n2CVCFb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHLKkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgHLKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:40:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDAC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qDIF+049UNMS9jSAYb//dXeP/I6AXbYU/f1+M6xpD5s=; b=n2CVCFb/w6yNnbPb17XycbJZmO
        Tj2B7+xz78H2FQGEZOTbbx1U45/N5KFY6TSzYXavM7/PiWmD0trtvC3zFCsSZi3zuKBgGpo8dNl0P
        VEDEbinhZRP/c6uKIY7J0bAnA5WXeSinw5VBKN+ku6aovjE8pdkLb49wmLDVgQV4nf8cEG8vfRmIT
        ND/Zx67w9XU0utCilvcaUa0gbdNWPFovdaP2QMiDkcQWp0QcAmmf0bvqV7avW9dh1VbXIs+Wggsu4
        5TRITkz1h+9tKODAIxsPX6KOkZ1KqEztiuxFprM8SkSPin6CjIIoBPqlOkaRwmCzHA5iYZMrbgQrv
        pnyC0dig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5oB1-0006Rg-9S; Wed, 12 Aug 2020 10:40:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E7193028C8;
        Wed, 12 Aug 2020 12:40:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20D0F25D0D543; Wed, 12 Aug 2020 12:40:05 +0200 (CEST)
Date:   Wed, 12 Aug 2020 12:40:05 +0200
From:   peterz@infradead.org
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200812104005.GN2674@hirez.programming.kicks-ass.net>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan>
 <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs>
 <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:56:56AM +0200, Ard Biesheuvel wrote:
> The module .lds has BYTE(0) in the section contents to prevent the
> linker from pruning them entirely. The (NOLOAD) is there to ensure
> that this byte does not end up in the .ko, which is more a matter of
> principle than anything else, so we can happily drop that if it helps.
> 
> However, this should only affect the PROGBITS vs NOBITS designation,
> and so I am not sure whether it makes a difference.
> 
> Depending on where the w^x check occurs, we might simply override the
> permissions of these sections, and strip the writable permission if it
> is set in the PLT handling init code, which manipulates the metadata
> of all these 3 sections before the module space is vmalloc'ed.

What's curious is that this seems the result of some recent binutils
change. Every build with binutils-2.34 (or older) does not seem to
generate these as WAX, but has the much more sensible WA.

I suppose we can change the kernel check and 'allow' W^X for 0 sized
sections, but I think we should still figure out why binutils-2.35 is
now generating WAX sections all of a sudden, it might come bite us
elsewhere.
