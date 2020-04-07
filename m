Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823E6C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD3F20731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JCfpGm5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgDGNwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:52:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDGNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ialmh1oNZLrhgWKFPrEXktfEmlPtTKu0trjFrs2T2Ck=; b=JCfpGm5ABDoZyrRINyea9As5ry
        6mA0K68m+m9rOR5ykUCFTi9JmTJjYgoXBvdLwk3m9UQxUo7I+I0mByn4sTxWyBThdaJ6mlKQG3poy
        b+42ZWwm4p2jvIW9bnLtf/VwdH9dcAsB9uonIitdwQs8OKJItTjdeiFfIcl48oIw5O6IxXdyV5f3T
        8W9Q5+0Uz+SVW4xH5MAbPosSpbDJsmSlEWeGn2b2/9aHq33ddluQRChFRsuIkLSEtN3gF/0C5sKTt
        AYco4od8uFkhl6IKtm7W9i9yLkIC99rCHcc7TbKSKipUOlSIoorshtw5NRzH15UIs0WJExGL+7Wgy
        WG7Qt90Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLoeD-0003SC-Q4; Tue, 07 Apr 2020 13:52:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A88C83011DD;
        Tue,  7 Apr 2020 15:52:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 933052B953CBE; Tue,  7 Apr 2020 15:52:11 +0200 (CEST)
Date:   Tue, 7 Apr 2020 15:52:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200407135211.GB20730@hirez.programming.kicks-ass.net>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407073142.20659-10-alexandre.chartre@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:31:42AM +0200, Alexandre Chartre wrote:

> -	ANNOTATE_NOSPEC_ALTERNATIVE
>  	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
>  		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
>  		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD

Possibly we can write this like:

	ALTERNATIVE("", "lfence", X86_FEATURE_RETPOLINE_AMD);
	ALTERNATIVE("jmp *\reg", "jmp __x86_retpoline_jmp_\reg", X86_FEATURE_RETPOLINE);

With an out-of-line copy of the retpoline, just like the THUNKs the
compiler uses, except of course, it can't be those, because we actually
want to use the alternative to implement those.

By moving the retpoline magic out-of-line we ensure it has a unique
address and the ORC stuff should work.

I'm just not sure what to do about the RETPOLINE_CALL variant.
