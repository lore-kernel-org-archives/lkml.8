Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB20BC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C70248BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R3l62Bv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgDFPjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:39:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgDFPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mxSwDQedmKVmfPXA425qbplhX+5HMsLQ63GXQLeSu9Q=; b=R3l62Bv5nxTACfVHr6B2NmsGoN
        1NEdK3b3VFySdKHFGT06A3IL3rEwJdx9lWYbqg5VzEWdKwW1bOw1fNB8Ju5sIgKRoYM5WsNokc/qJ
        ByJ2FYIy3eRTOQQSv4u4Zd4G/G451m2nOfh2JQ9MjK+jrHDCJ0bliJ5GXraPkuf0geXIO1aeE5pQw
        icVlUx5Fe1gTzwCtxVYI4aMrCvCmLP2dTEQBteKUiQwTBFLUScRKx2IrRbmV6mr6WXsJfA1VYZuf3
        MlO8oeCTxLQvTKB36HhTGPzdk0mAk1WzXf4XRU/j7sy2u3cPPzxWPYwU7ukDX9lrHfX/9vSXdR8ub
        aqKITC3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLTq2-0002dc-Dc; Mon, 06 Apr 2020 15:39:02 +0000
Date:   Mon, 6 Apr 2020 08:39:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware
 (out-of-tree) module enables VMX
Message-ID: <20200406153902.GA9939@infradead.org>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200406125010.GA29306@infradead.org>
 <20200406140403.GL20730@hirez.programming.kicks-ass.net>
 <20200406152411.GA25652@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406152411.GA25652@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:24:11AM -0700, Christoph Hellwig wrote:
> > and this
> > removes __get_vm_area() and with the ability to custom ranges. It also
> > removes map_vm_area() and replaces it with map_vm_area_nx() which kills
> > adding executable maps.

Also there seems to be various other ways to create exectuable mappings,
pretty much everything in vmalloc.c that gets a pgprot_t..
