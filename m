Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC9CC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B08220720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3KWd1Th3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGLhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:37:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48114 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGLhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HT7HIET4pKgxi85PM/tNjjPcKQ1lsduKg8X9m6fkLf4=; b=3KWd1Th3RtQuLNo9N/qjEa3pyZ
        FaUzB4y3Pe92uMOwRH1YMgr6yNgCNUk9PHbOTZe3qKuJZrhVegRQulslXcmcCkMt2y7bbstU9ZrFa
        A/19jDjuoQBx6f6ge90e2Vx+BYBNuK5HzQPCrRdh9H+r7Kx4jXoXuqM4fzTBILRRhjaGYEOtiYmvl
        xLwD5uSJlKB7zrKKXmd9RTsX0o2QynWVv0MLZJqMxbzyiDWOCxZlYXnUQ0vdqWmBaA9cqVWr/+jZ3
        Nv3I1V6Ncm7Nzj9HucCCvRcxdH2gzFGL2+oJ0iDrK1AlPsEQPBCyCcS0QZw99kCi4JkJzrsddVnup
        jthD2KFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j01wi-0007Du-5S; Fri, 07 Feb 2020 11:37:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C8C130066E;
        Fri,  7 Feb 2020 12:35:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB48A2B834C29; Fri,  7 Feb 2020 12:37:14 +0100 (CET)
Date:   Fri, 7 Feb 2020 12:37:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH -v2 09/10] m68k,mm: Fully initialize the page-table
 allocator
Message-ID: <20200207113714.GH14914@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
 <20200131125403.938797587@infradead.org>
 <CAMuHMdUxwz4X+SYCCWCMNAw2nNTMUXWPWrxJ+X9mYC_tirvN=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUxwz4X+SYCCWCMNAw2nNTMUXWPWrxJ+X9mYC_tirvN=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 11:58:42AM +0100, Geert Uytterhoeven wrote:
> Hoi Peter,
> 
> Thanks for your patch!
> 
> On Fri, Jan 31, 2020 at 1:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > Also iterate the PMD tables to populate the PTE table allocator. This
> > also fully replaces the previous zero_pgtable hack.
> 
> As no code is being removed in this patch, does this mean this case was
> broken since "[PATCH 06/10] m68k,mm: Improve kernel_page_table()"?

'broken' is not the right word, less optimal might qualify.

What this code does it add all the pages from the early kernel allocator
to the regular allocator, such that any left over fragments might be
used.


