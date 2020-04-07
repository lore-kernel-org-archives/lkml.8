Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF63C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0D4206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CiWM3lvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgDGR1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:27:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDGR1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4bpQMLgWqSgsPCS9NLdaFYcf5ljNZI9OXQ8zzPQkveA=; b=CiWM3lvKoUr9dhAvXi+rH+w06i
        aA2zSE9oEGBzdjbLE60jP8u4rNkgJWXSJMLDDQH/Qlh1v57yDYKtSJ7TuP3YaLfX6jvoBQWCQb2BH
        WKTASsWY7F1uS87rLWV2Jt2cVOrl2OkxLKq7bn7JbgIHmOnuyTwPEuFJpMkQzlFEEp6Bi+ADMf6aV
        i6NqKJelG5csifXKdF9ljlAweLt1qO7fz8SkD7hPJ/WcwoiFMZpl5NW5jrEiflSG0TkP8QfOtqPZE
        6Rx1jTh2illfMZkT23+Mf60OMtZS2GbN95Qqb0wsu96TzQSGoUlr/43NT5lwhIxnvkl0buJZmgRmz
        y7rww37g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLs0i-0005y3-PV; Tue, 07 Apr 2020 17:27:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DF093011DD;
        Tue,  7 Apr 2020 19:27:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CCD32B0A1247; Tue,  7 Apr 2020 19:27:39 +0200 (CEST)
Date:   Tue, 7 Apr 2020 19:27:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200407172739.GI20730@hirez.programming.kicks-ass.net>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
 <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
 <20200407162838.5hlh6oom4oa45ugt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407162838.5hlh6oom4oa45ugt@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:28:38AM -0500, Josh Poimboeuf wrote:
> Again, we should warn on stack changes inside alternatives, and then
> look at converting RSB and retpolines to use static branches so they
> have deterministic stacks.

I don't think we need static brancher, we should just out-of-line the
whole thing.

Let me sort this CFI error Thomas is getting and then I'll attempt a
patch along the lines I outlined in earlier emails.
