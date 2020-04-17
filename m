Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DD4C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7319122202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wIqsDV+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgDQSYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730407AbgDQSYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:24:06 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D83C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DiAL1Kli1dergiSVAf/Jbou57tH/ONAV2dcLWISgSX8=; b=wIqsDV+NZoQYY2Yw9XkSwGrVu0
        QSTwgsJZ+xsMhm1Gip1qnno44KUegn95yLjAeOEaEjRLg7xW863exJ10cxWUiGfu6MrYtl3N9QeVc
        3UAuCnTzmHkuNvr9fRv4o6d/TM7aWdSJDgIj0Br4syu4sRMqcefxOFdPxAKwIGD3hZ/XTdKiAZKBk
        /+lb783gbdPhSWQ5fCwRF1E9NSF6M46hz1fhFtUrR88VCoVJoYKuKbXcVB3lvO8rqHV+ibkx9drwo
        IpQGBU6Cl+Rvlzig4kwz3rNr4Xi3+JyncGYONAGLrDRIx4YQGj+ht4wtMStnrCZ5sS4OV38vJuDI7
        fGiTXAuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPVeQ-0007ZF-3M; Fri, 17 Apr 2020 18:23:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BC243006E0;
        Fri, 17 Apr 2020 20:23:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BBF72B124A89; Fri, 17 Apr 2020 20:23:39 +0200 (CEST)
Date:   Fri, 17 Apr 2020 20:23:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com
Subject: Re: [PATCH v5 02/17] objtool: Better handle IRET
Message-ID: <20200417182339.GJ20730@hirez.programming.kicks-ass.net>
References: <20200416114706.625340212@infradead.org>
 <20200416115118.631224674@infradead.org>
 <8692ee18-e553-6f90-5291-62d6d57407cd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8692ee18-e553-6f90-5291-62d6d57407cd@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 07:37:32PM +0200, Alexandre Chartre wrote:
> > @@ -2243,6 +2232,20 @@ static int validate_branch(struct objtoo
> >   			break;
> > +		case INSN_EXCEPTION_RETURN:
> > +			if (handle_insn_ops(insn, &state))
> > +				return 1;
> 
> Do we need to update the stack state for normal IRET? This wasn't done before.
> So shouldn't this better be:
> 
>                case INSN_EXCEPTION_RETURN:
>                         if (!func)
>                                 return 0;
> 
>                         if (handle_insn_ops(insn, &state))
>                                 return 1;
> 
>                         break;

Well, I was going to do the unconditional handle_insn_ops(), like
mentioned, but then that intra_function_call thing spoiled it.

It doesn't matter though; STT_NOTYPE doesn't care.

> > +
> > +			/*
> > +			 * This handles x86's sync_core() case, where we use an
> > +			 * IRET to self. All 'normal' IRET instructions are in
> > +			 * STT_NOTYPE entry symbols.
> > +			 */
> > +			if (func)
> > +				break;
> 
> Is it worth checking that func->name is effectively "sync_core"?

It's an inline..
