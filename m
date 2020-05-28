Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912F6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1C52075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2hjQjRWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbgE1O6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37342 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403773AbgE1O6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XfDBa6L5beYtY9Mm6rzbZ08MMV6LAgrWZgziccfPExk=; b=2hjQjRWxqtCnbGeD8fBkZSGqOy
        HJNJVsY4UHmFTBSAiHibHn+yESXpMZIHT8lrOtHuXQeqa9IqGo0948KIWACXK+La1VlTKioEj4ThK
        MPw11b4tERh9bXYPPXs3vMD4BQhE49MYn3g+nZfYBY5806qkTRW/CJdd4QSeT/MIIkgqVNkemYNQ5
        TRfqk9DTiRz41a9cjBq+nxS8hlvISxtENsvmD4tr8vhdMRigKJITZzK8varrK6BlSaaZMNf2hQ/3o
        aueutvbdJDWsrqcED1JGLETAHBAW6iZ/uX4fafsdxIP9Y68nzp5mBWN6QJQeAoz7IZLMgNnCDPSMT
        DnBXLzjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeJwS-00037f-Sp; Thu, 28 May 2020 14:55:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7270F301205;
        Thu, 28 May 2020 16:55:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 555032B9FB566; Thu, 28 May 2020 16:55:30 +0200 (CEST)
Date:   Thu, 28 May 2020 16:55:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] kasan: move kasan_report() into report.c
Message-ID: <20200528145530.GG706495@hirez.programming.kicks-ass.net>
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
 <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
 <20200528134913.GA1810@lca.pw>
 <20200528143341.ntxtnq4rw5ypu3k5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528143341.ntxtnq4rw5ypu3k5@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:33:41AM -0500, Josh Poimboeuf wrote:
> On Thu, May 28, 2020 at 09:49:13AM -0400, Qian Cai wrote:
> > On Tue, May 12, 2020 at 05:33:20PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> > > The kasan_report() functions belongs to report.c, as it's a common
> > > functions that does error reporting.
> > > 
> > > Reported-by: Leon Romanovsky <leon@kernel.org>
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > 
> > Today's linux-next produced this with Clang 11.
> > 
> > mm/kasan/report.o: warning: objtool: kasan_report()+0x8a: call to __stack_chk_fail() with UACCESS enabled
> > 
> > kasan_report at mm/kasan/report.c:536
> 
> Peter, this was also reported with GCC about a month ago.  Should we add
> __stack_chk_fail() to the uaccess safe list?

It calls panic(), which I suppose is pretty safe, it kills the entire
machine dead :-)

Ok.
