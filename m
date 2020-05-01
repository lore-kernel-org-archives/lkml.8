Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B8EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D84E2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1YXw33IL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgEARQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729951AbgEARQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:16:41 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A858CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/l3zOAnDi9DKZar5oCraWARLMZ5QjkXjzkWoreOxc9w=; b=1YXw33ILwhYlmrposW28v4Rv0r
        v5wS+POxan9edlR9ycvkAop2l5sYxGYv9fHhBzTaMKQAiUiZzEogiz5RG1W69w1Zj6hYlPdTK4lZs
        mkz/4imtgUrqu9EaoRktr9mRc07JazLirJ9kPdZiDmgDsl+zQtaTGO1tlM2VlPqnbTgiK2Rp7JfRU
        IB2fzFQnZzcStJbrSBOrBXVCFJH0hC+jH8xr0hdsYFlEaYtFr5oJD4p95vX/yjTMndthi2dRshUF+
        b+tjLKy2rCzBMYTqSHZbUL1/NtRfj6jg/fFLZG8nVs9kEqED/XCjcGuSU0wykGknfGXr1b5VAHVQb
        zZDhOjtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUZGw-00038H-FF; Fri, 01 May 2020 17:16:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04C18300F28;
        Fri,  1 May 2020 19:16:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD115205E6F0C; Fri,  1 May 2020 19:16:18 +0200 (CEST)
Date:   Fri, 1 May 2020 19:16:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200501171618.GF3762@hirez.programming.kicks-ass.net>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
 <20200501002858.4wuiqqv5o32jcvxf@treble>
 <CAK8P3a3_aC9rJDXta+6D2Oq5RSJgfXaT5-wFU_tM-6x7unbuPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_aC9rJDXta+6D2Oq5RSJgfXaT5-wFU_tM-6x7unbuPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 01:41:30PM +0200, Arnd Bergmann wrote:
> disappears, and it also goes away if I disable inlining that function:

Yes, makes sense. The state objtool tracks is strictly per function.

And I suppose GCC-10 just changed around the inline heuristc a bit and
we got lucky.

> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -1134,7 +1134,7 @@ static int testcase_successes;
>  static int expected_testcase_failures;
>  static int unexpected_testcase_failures;
> 
> -static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
> +static noinline void dotest(void (*testcase_fn)(void), int expected,
> int lockclass_mask)
>  {
>         unsigned long saved_preempt_count = preempt_count();
> 
>     Arnd
