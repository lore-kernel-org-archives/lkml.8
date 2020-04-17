Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EC4C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E96F221E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eBAYepU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgDQM0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728751AbgDQM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:26:17 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l1Lr/Pj4SmJ/DxvUqLYYQm3c2dPrEcOY6tYaIIm0uTM=; b=eBAYepU5Q4RB7VaBgQDiJ9Zlki
        nHejyh786gQtNgBfQXQP6DnGzMIExZXR3Fb898iQVO9mpXhB+TSfh1/WoqhxNhmIKwqwPHku7b0Ky
        enc92EEsNc1rxlZ8OWGRPChCcWFzUuI8God+c1fYY8cxALvUQJx2ECw7GCHoafsXRymlHTxidEO1D
        f068bJS5SXhWGkRzpA4H2s58o7zNKIRKyt6s+fih8jWTYX0ETG0aIYmOvQob8DvUf8drfuV3UWrIM
        yUlfecFfSPNPKLX4PUppu2l6jud3yuA/iP5t3qplcsje2nlOH0+H4uOfC+Uh+fijxklfZs73+jewR
        AjKdb1tQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPQ4A-0007oC-NE; Fri, 17 Apr 2020 12:25:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41124307005;
        Fri, 17 Apr 2020 14:25:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 267302B12162B; Fri, 17 Apr 2020 14:25:53 +0200 (CEST)
Date:   Fri, 17 Apr 2020 14:25:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH v5 02/17] objtool: Better handle IRET
Message-ID: <20200417122553.GD20730@hirez.programming.kicks-ass.net>
References: <20200416114706.625340212@infradead.org>
 <20200416115118.631224674@infradead.org>
 <alpine.LSU.2.21.2004171326230.7737@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004171326230.7737@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 01:29:32PM +0200, Miroslav Benes wrote:
> On Thu, 16 Apr 2020, Peter Zijlstra wrote:

> > +		case INSN_EXCEPTION_RETURN:
> > +			if (handle_insn_ops(insn, &state))
> > +				return 1;
> > +
> > +			/*
> > +			 * This handles x86's sync_core() case, where we use an
> > +			 * IRET to self. All 'normal' IRET instructions are in
> > +			 * STT_NOTYPE entry symbols.
> > +			 */
> > +			if (func)
> > +				break;
> > +
> > +			return 0;
> > +
> >  		case INSN_CONTEXT_SWITCH:
> >  			if (func && (!next_insn || !next_insn->hint)) {
> >  				WARN_FUNC("unsupported instruction in callable function",
> 
> It looks really simple.
> 
> Have you tried Julien's proposal about removing INSN_STACK altogether, 
> move the x86 to arch/x86/ and call handle_insn_ops() unconditionally, or 
> have you just postponed it? As I said, I think it could be better in the 
> long term, but the above looks good for now as well.

If you look at this other set I send yesterday:

  https://lkml.kernel.org/r/20200416150752.569029800@infradead.org

(also, sorry for not adding you to the Cc; also best look at the gitweb
version, the patches I send out are missing a hunk and lacking some
back-merges.. clearly I wasn't having a good day yesterday).

it has this intra_function_calls crud that needs explicit conditional
handle_insn_ops().
