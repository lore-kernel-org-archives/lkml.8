Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32071C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F6120733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eazSKk8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBJKvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:51:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJKvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+OP0+x74Pg3wl2JQ1mjPvfRRIiV2JvruLobHctgyt7c=; b=eazSKk8sVmnF3MoWfazTXORMK6
        wZ74w2+TOGtFz3f2+omjmCu4TTpzab1IPKQwUdUXjHz+EEXM7XbKsJYMqgdQ/6MzGqwOrY1NQSvkD
        1g/SZwJrjixL9NQ/qxY3I/jHWCbYAmb2zaKe/UIHD8gTh9L37xlKKCy6jjs/iGQjntf4rCqp0HTzd
        HouH6T7Q50n9oHSjbyd7Vn4ZECrdjnWSQmVti7D8RSQkWOdfjREZHvJWHipJyMzVAZG3Y8rBlKUkS
        tgcKSuPtZpv1/iUFeK+U8hlzu0YTmh2OB5r9ZsBzsSrbrtliUf1Th8Hyx/WrSPvvseSictpL7iE5O
        XFQcbHHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j16ev-0001gL-U3; Mon, 10 Feb 2020 10:51:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76FFD300446;
        Mon, 10 Feb 2020 11:49:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFD252097750B; Mon, 10 Feb 2020 11:51:17 +0100 (CET)
Date:   Mon, 10 Feb 2020 11:51:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <20200210105117.GE14879@hirez.programming.kicks-ass.net>
References: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
 <B413445A-F1F0-4FB7-AA9F-C5FF4CEFF5F5@amacapital.net>
 <20200207092423.GC14914@hirez.programming.kicks-ass.net>
 <202002091742.7B1E6BF19@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202002091742.7B1E6BF19@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2020 at 05:43:40PM -0800, Kees Cook wrote:
> On Fri, Feb 07, 2020 at 10:24:23AM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 06, 2020 at 12:02:36PM -0800, Andy Lutomirski wrote:
> > > Also, in the shiny new era of
> > > Intel-CPUs-can’t-handle-Jcc-spanning-a-cacheline, function alignment
> > > may actually matter.
> > 
> > *groan*, indeed. I just went and looked that up. I missed this one in
> > all the other fuss :/
> > 
> > So per:
> > 
> >   https://www.intel.com/content/dam/support/us/en/documents/processors/mitigations-jump-conditional-code-erratum.pdf
> > 
> > the toolchain mitigations only work if the offset in the ifetch window
> > (32 bytes) is preserved. Which seems to suggest we ought to align all
> > functions to 32byte before randomizing it, otherwise we're almost
> > guaranteed to change this offset by the act of randomizing.
> 
> Wheee! This sounds like in needs to be fixed generally, yes? (And I see
> "FUNCTION_ALIGN" macro is currently 16 bytes...

It depends a bit on how it all works I suppose (I'm not too clear on the
details).

Suppose the linker appends translation units at (at least) 32 bytes
alignment, but the function alignment inside the translation unit is
smaller, then it could still work, because the assembler (which is going
to insert NOPs to avoid instructions being in the 'wrong' place) can
still know the offset.

If the linker is going to be fancy (say LTO) and move code around inside
sections/translation units, then this goes out the window obviously.

The same with this fine-grained-randomization, if the section alignment
is smaller than 32 bytes, the offset is going to change and the
mitigation will be nullified.

I'll leave it to others to figure out the exact details. But afaict it
should be possible to have fine-grained-randomization and preserve the
workaround in the end.
