Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EBFC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24A6206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBnAI1h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgDHPqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:46:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgDHPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8xYNN+wKtG+ahrHZwD0DDVsv1W5vGn54JqpHjXfqqyc=; b=nBnAI1h5JZbVh0bzFq4v4cBe1E
        eIgpfCksH2tE5emWi5BJLjf1URk3Kox/T/E/sYKMeqoEJ8JepKnBMQ0aX/QdwTEx9R1cqYS69TWkB
        RoRqN93eTJH3BbjmOQiGJBnsDC6CwQ8W+WoP2+YxvXvl/RBajpmA1kACL8mZ3fhR9wFxXgEzh5zxI
        oAifATzDlzeQesklCrGRf4LdPNxO6NJPieHLQ1FLGa/F//IVqxxZTImx13HGABvcnYFzJbdfbDdaM
        oVRBaiDEI3m55gKCnTeYQMLAm6tkVtRufL9bvWARR9/ZHVWNSmYl+kyUdoe1CT9r+4YUPj6DW6i/b
        WJHEZlJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCtu-0006ad-Fi; Wed, 08 Apr 2020 15:46:02 +0000
Date:   Wed, 8 Apr 2020 08:46:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kenny@panix.com, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200408154602.GA24869@infradead.org>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200408092726.7c2bda01@gandalf.local.home>
 <20200408154419.GP20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408154419.GP20730@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:44:19PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 08, 2020 at 09:27:26AM -0400, Steven Rostedt wrote:
> > On Tue, 07 Apr 2020 13:02:40 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > +		if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
> > > +			pr_err("Module writes to CRn or DRn, please use the proper accessors: %s\n", mod->name);
> > > +			return -ENOEXEC;
> > > +		}
> > > +
> > 
> > Something like this should be done for all modules, not just out of tree
> > modules.
> 
> I'm all for it; but people were worried scanning all modules was too
> expensive (I don't really believe it is, module loading just can't be a
> hot-path). Also, in-tree modules are audited a lot more than out of tree
> magic voodoo crap.

Scanning all modules seems safer.  While we're at it - can be move the
kvm bits using VMX to be always in the core kernel and just forbid
modules from using those instructions entirely?
