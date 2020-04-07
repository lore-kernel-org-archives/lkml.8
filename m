Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7AFC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7608920771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZZoapT47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDGSOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:14:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48754 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KI8clYhavNExjpTnyuAzjWnFiJ2tpeJN+uus0XHQTjA=; b=ZZoapT47u50iTPkKIzN25A0jLi
        fPzgW9MDVU2fcs5aHyn5+WZ9R1PXnKVIAdUeklxxs1W5IviCKzO6OeLoTJqGKyPiohOxKlSQP0hx+
        6vRS2jDcpo5XsleVDML2xIGc8hFSyRYwN5OZRfbgISYjOnYxzCnlqkfbSmXtXvM+DLpSd3vX1WCqp
        ZdclOA4ptD+Y9De20/ePCZRJULb1r4aqnsqgz8Y30x7I5ZSIQILcw55zePsO1OQav73LgqwgYvZTb
        XWrlcX9EgdokNUMSaE7wRi4psaHvjqtOmhhh46FKyqCACdM31e01pQ/qYuSP6ixgchktz74TTYiNn
        wplao8Mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLsj2-0006wZ-Fl; Tue, 07 Apr 2020 18:13:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8AF643007CD;
        Tue,  7 Apr 2020 20:13:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C9352BA2A486; Tue,  7 Apr 2020 20:13:25 +0200 (CEST)
Date:   Tue, 7 Apr 2020 20:13:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        David.Laight@aculab.com, dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200407181325.GJ20730@hirez.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <202004070958.CB8A3DA71D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004070958.CB8A3DA71D@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 10:01:04AM -0700, Kees Cook wrote:
> On Tue, Apr 07, 2020 at 01:02:40PM +0200, Peter Zijlstra wrote:
> > Since we now have infrastructure to analyze module text, disallow
> > modules that write to CRn and DRn registers.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kernel/module.c |   21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > --- a/arch/x86/kernel/module.c
> > +++ b/arch/x86/kernel/module.c
> > @@ -266,6 +266,22 @@ static bool insn_is_vmx(struct insn *ins
> >  	return false;
> >  }
> >  
> > +static bool insn_is_mov_CRn(struct insn *insn)
> > +{
> > +	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x22)
> > +		return true;
> 
> I always cringe at numeric literals. Would it be overkill to add defines
> for these (and the others that have comments next to them in 3/4)? It
> makes stuff easier to grep, etc. (e.g. we have register names in
> arch/x86/include/asm/asm.h, do we need instruction names somewhere else?
> I assume objtool has a bunch of this too...)

objtool does not, have a peek at tools/objtool/arch/x86/decode.c

I'm not sure what the best way is here, the x86 opcode map is a
disaster. Even the mnemonic doesn't help us here, as that's just MOV :/
