Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34194C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066B8206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kr6LBu9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEHQRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEHQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:17:34 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA97C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5y/BvaMmbxGJRPJfxDgGRJxiwkrlSQ5491HGTO/jgms=; b=Kr6LBu9iTpvHpDPUjDXKaZFFkv
        UCgSqF42hXyZiTPU0P0GnOGrcO7Ts+I9xg1ZYi/t2TF9MGEVIC0IGzUEhQ43Mcazm2a66A/hgL7V3
        VQhpc6KaN/VnnctbYujd6ygEmmBTLyzQeEx8ue4rMjY19A3TqpszLg6dLkiK027WFKlvI1Tw1wPI0
        CF57sNH0cLDRdEBRXB4MCMhkrRQQdcn8R0pRefSpgYZ5vD0ITinv2H2qR0aKVbvH7o/7EoPzQaH7H
        nOQCWJqvweVejsTdMDhXiOLFU+etlLu7NtCRkUvfmyJ6TP6ZgsLR3VkrSN9Wvdyfq1MBWP/5EHIr6
        FtvQLVSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX5gP-0000ES-Um; Fri, 08 May 2020 16:17:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF605306108;
        Fri,  8 May 2020 18:17:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5BE8236D7E53; Fri,  8 May 2020 18:17:01 +0200 (CEST)
Date:   Fri, 8 May 2020 18:17:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200508161701.GD3344@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <20200506172455.ho5em2mtzn7qqfjl@treble>
 <20200508152730.GB3344@hirez.programming.kicks-ass.net>
 <20200508154704.6njw5wfsain7p3ev@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508154704.6njw5wfsain7p3ev@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 10:47:04AM -0500, Josh Poimboeuf wrote:

> And if you're calling it
> 
>   DEFINE_STATIC_CALL_NULL
> 
> then it seems like
> 
>   ARCH_DEFINE_STATIC_CALL_NULL
> 
> would be the logical name rather than RETTRAMP?

But that looses the TRAMP, and ARCH_DEFINE_STATIC_CALL_NULL_TRAMP so
damn long, then again, it's only 2 chars more than what I have now,
sure, lets do it.

> Still not crazy about static_cond_call(), though I think at least
> changing it to static_call_cond() would be better for namespacing
> reasons.

Done.
