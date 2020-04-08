Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33842C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09229206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R0wHbzYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgDHPot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:44:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48108 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgDHPot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ppT9Ykb6WfAeBTRHeKGYVk4EuqKRhEhhBG8VE/vcqL8=; b=R0wHbzYDjjMG6dRZnnupQjheVq
        HvshbrGTRhbE1F8xdaOc3ISQiDGFZhbZcDymD8jQuMvp7L6a+s84/5bhFj5Ecr/A8Qnau+aGL/8Yz
        OdGoLCG+1ZKIgaS6Gdbwr7Gzq2ThReSWafrlRo6LjYkZ58lo4Jx+zcySTD0xnFk1EDxdSO/GrxOzS
        Z3taGGdw95wiGGz/+y8/R8ERQPTvKrTVKBgC/QNnPPYr0tzwgkEmJPeSLWBMongJZdiuUfXFY4VyE
        yuhlE7pankKznwbNYzHEitnQ+b3pc9jI3YVNZ9Gcbd9g3l0AaoF5DpLMgHfc1Q/Y72D5X3b8WPso4
        vxI84hUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCsH-0005kk-Rv; Wed, 08 Apr 2020 15:44:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D186300130;
        Wed,  8 Apr 2020 17:44:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21A8E2BB026FE; Wed,  8 Apr 2020 17:44:19 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:44:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200408154419.GP20730@hirez.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200408092726.7c2bda01@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408092726.7c2bda01@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 09:27:26AM -0400, Steven Rostedt wrote:
> On Tue, 07 Apr 2020 13:02:40 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > +		if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
> > +			pr_err("Module writes to CRn or DRn, please use the proper accessors: %s\n", mod->name);
> > +			return -ENOEXEC;
> > +		}
> > +
> 
> Something like this should be done for all modules, not just out of tree
> modules.

I'm all for it; but people were worried scanning all modules was too
expensive (I don't really believe it is, module loading just can't be a
hot-path). Also, in-tree modules are audited a lot more than out of tree
magic voodoo crap.
