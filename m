Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA3FC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB4B20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k+wMIaNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgCLQXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:23:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgCLQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wb4fqVdDnVKErzukzgqoKLXhz0PGblbxOaSJG7sUXMw=; b=k+wMIaNJTeFrYQTySdzhY3DeuU
        FiYJf4lOckMfJsfbRv1sk0u8pabaYsJXyl0TPxXoiCjBV4kPBY3FRx97E3cGjVBuK0Sb70cvgYDHe
        rr1LHJ0mzUYX9F7k1eD1th6PejMjiJmKAObmbbvPPOzCYRhrkVn+P8gvrdQp2degnjHJUpY1aOpAU
        D+i9FzvuTWtqmyBeC3jZvL5DN3QPINfxNqHqB0yr9KgbHFs4fwpEPK7A2ZKjSiw6SPWyaQXlOXbhi
        2HbbuMBmfUqVE5LA3ALQon6EUNpVN5Hiifm7Hl6QuJXauWwmTD9Lx+evpuPCpTYbXc9BgJAqLTMi7
        JyznVGpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCQcV-0007VM-Mc; Thu, 12 Mar 2020 16:23:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A043F30015A;
        Thu, 12 Mar 2020 17:23:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C22C2B9A6AF2; Thu, 12 Mar 2020 17:23:37 +0100 (CET)
Date:   Thu, 12 Mar 2020 17:23:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC][PATCH 00/16] objtool: vmlinux.o and noinstr validation
Message-ID: <20200312162337.GU12561@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312134107.700205216@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:07PM +0100, Peter Zijlstra wrote:
> Hi all,
> 
> These patches extend objtool to be able to run on vmlinux.o and validate
> Thomas's proposed noinstr annotation:
> 
>   https://lkml.kernel.org/r/20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org
> 
>  "That's why we want the sections and the annotation. If something calls
>   out of a noinstr section into a regular text section and the call is not
>   annotated at the call site, then objtool can complain and tell you. What
>   Peter and I came up with looks like this:
> 
>   noinstr foo()
> 	do_protected(); <- Safe because in the noinstr section
> 	instr_begin();  <- Marks the begin of a safe region, ignored
> 			   by objtool
> 	do_stuff();     <- All good
> 	instr_end();    <- End of the safe region. objtool starts
> 			   looking again
> 	do_other_stuff();  <- Unsafe because do_other_stuff() is
> 			      not protected
> 
>   and:
> 
>   noinstr do_protected()
> 	bar();          <- objtool will complain here
>   "
> 
> It should be accompanied by something like the below; which you'll find in a
> series by Thomas.
> 

So one of the problem i've ran into while playing with this and Thomas'
patches is that it is 'difficult' to deal with indirect function calls.

objtool basically gives up instantly.

I know smatch has passes were it looks for function pointer assignments
and carries that forward into it's callchain generation. Doing something
like that for objtool is going to be 'fun'...

For now I've got limited success dodging a few instances with
__always_inline (which then results in the compiler resolving the
indirection).
