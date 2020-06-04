Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E277C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164C2206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mt4XsxS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgFDJiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgFDJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:38:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E97C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zrLTzYxyJqV84+FF3atSEpW9Q4goWRUhgJ9kglnt33c=; b=Mt4XsxS11qwMxYORBYdLcFCa7v
        7zHlBhW05kBLoe6zAm0uvwDQG1YfOgiKaYj8gL2jyIzZHaPd4pVNpdCx//PRo5ImwQj0glo9ZTsbJ
        tD6HykJoeR8T3Ydz0Gvj0qCaz1Izyi4909nxbh2eT2qXB6asW+8J/WV8YfcZGWxNXoybJGWFw7tFe
        t3CMGBq8vZF/heBnrB5nKIfJCQlpgu4dsKLhE8bp0blaItBiqpo9duA3lLGmjdrNG4eY+kCXHsRsF
        A1JdSCjzcL6VJAn9l+4JM7LsUKfGfdfFmyQebP7/BLnef6tQ9L2fpNjwd/54HWS1uIrTE1YSdZxqR
        UeQM43Ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgmK4-00038A-59; Thu, 04 Jun 2020 09:38:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F38CA30008D;
        Thu,  4 Jun 2020 11:38:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E88D920D6E7DD; Thu,  4 Jun 2020 11:38:01 +0200 (CEST)
Date:   Thu, 4 Jun 2020 11:38:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] compiler.h: Move instrumentation_begin()/end() into new
 <linux/instrumentation.h> header
Message-ID: <20200604093801.GC2587@hirez.programming.kicks-ass.net>
References: <20200601130806.GA746506@gmail.com>
 <CAHk-=wgmXOFyiu6jZ8Dj8OAU7c0T0q-6RLygKC2tMiNfL7MQjQ@mail.gmail.com>
 <20200604071921.GA1361070@gmail.com>
 <20200604081928.GA570386@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604081928.GA570386@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:19:28AM +0200, Ingo Molnar wrote:
> The tested v2 version of the patch also needed the include in 
> asm-generic/bug.h (see the fix attached below), because for 
> completeness the generic version was annotated as well - even though 
> only x86 has objtool support for now.

x86/asm/bug.h includes asm-generic/bug.h.

x86 uses the generic bug infrastructure.
