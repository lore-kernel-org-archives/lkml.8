Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB0BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4509120725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MzITWI/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGKFGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 01:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGKFGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 01:06:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A4CC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 22:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EGgfQnPB8mOuLpGtL0DpbYWr52UzYkXOmj5U47A06X4=; b=MzITWI/9Ru5NUTCE9ms9BPIdS+
        stL2pUzF5jETV2VpNivLxjWcRHUuwHVygKCkubvYAUZ+WyumIGftNrLf2eqa8MZspEN4gdmfp+MdV
        4P+7w+Gdp6Cn/sHFFgl8jEzwfNwN3ylPZ0JvP9FRbJ5BIkRHUgw+IJVw5c6UQxmi1CBUP21JltRZx
        /ya4HxxRlEBq/AnVXfFrMlY+BB6Hg9MLACeR0NvkltuhJt2CCQGCnNh9Oc0JmOzp9A/YSBr28iPwm
        IM5cHXokysQf2wwRJ41/1v7QGtJPpw4m1gnaPSpC2p2pWdZQc5dM2Gbh5OG8Kma31UFonmjdEIZVX
        tRCivrIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ju7iQ-0005pU-GE; Sat, 11 Jul 2020 05:06:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB401300130;
        Sat, 11 Jul 2020 07:06:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1C672B85DD26; Sat, 11 Jul 2020 07:06:18 +0200 (CEST)
Date:   Sat, 11 Jul 2020 07:06:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 14/17] static_call: Handle tail-calls
Message-ID: <20200711050618.GW597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134336.977578032@infradead.org>
 <20200710202319.3c3eec12@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710202319.3c3eec12@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:23:19PM -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2020 15:38:45 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > GCC can turn our static_call(name)(args...) into a tail call, in which
> > case we get a JMP.d32 into the trampoline (which then does a further
> > tail-call).
> > 
> > Teach objtool to recognise and mark these in .static_call_sites and
> > adjust the code patching to deal with this.
> > 
> 
> Hmm, were you able to trigger crashes before this patch?

No, just a bunch of tail-calls that didn't get patched and would still
point to the trampoline.

