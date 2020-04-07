Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E114BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42FB20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iqjhmh94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDGQlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:41:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgDGQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RA09IMm6IufQ7k2rknWhIbMWA7PHLNfk/QX/AiA8EGg=; b=Iqjhmh94wAOMY41anwB1Ld2+xf
        0fuSWYvJuvoH2U6rFY8BCCT8sC+Q60Q6AZ8Wi+g0EA9vBTCpW4+gFMSdLcMTW03es0JTpsq8MfooW
        J5e9ipOoEp6x+5zeb1r+nLsgz6WHtMJ5C5rrSEhA86nx0P8IquIYv8ZyBCBEphQb/FH6VnYI0P/yY
        nFMqBPfb4frRZpLPDKZCgFuvU0MJP5z8mxmsByoXqfOJjRh2aQWz+yWtQ+HhMMGAsXYG8dGwfBDhe
        8B2snWeYKUE68pPt88MHlm9V8Innlih+pYtT5WR4gT87W6Qt3+hbPYk/VXKfz2aldjHcEZ+URVNAw
        8Zy89vKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLrIH-00005Z-MV; Tue, 07 Apr 2020 16:41:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1AEC3011DD;
        Tue,  7 Apr 2020 18:41:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B348F2B0A1250; Tue,  7 Apr 2020 18:41:43 +0200 (CEST)
Date:   Tue, 7 Apr 2020 18:41:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200407164143.GG20730@hirez.programming.kicks-ass.net>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
 <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 06:18:51PM +0200, Alexandre Chartre wrote:
> 
> On 4/7/20 4:32 PM, Alexandre Chartre wrote:
> > 
> > On 4/7/20 3:34 PM, Josh Poimboeuf wrote:
> > > On Tue, Apr 07, 2020 at 03:28:37PM +0200, Peter Zijlstra wrote:
> > > > Josh, we should probably have objtool verify it doesn't emit ORC entries
> > > > in alternative ranges.
> > > 
> > > Agreed, it might be as simple as checking for insn->alt_group in the
> > > INSN_STACK check or in update_insn_state().
> > > 
> > 
> > We could do that only for the "objtool orc generate" command. That way
> > "objtool check" would still check the alternative, but "objtool orc generate"
> > will just use the first half of the alternative (like it does today with
> > ANNOTATE_NOSPEC_ALTERNATIVE). We can even keep all ANNOTATE_NOSPEC_ALTERNATIVE
> > but only use them for "objtool orc generate".
> > 
> 
> I have checked and objtool doesn't emit ORC entries for alternative:
> decode_instructions() doesn't mark such section with sec->text = true
> so create_orc_sections() doesn't emit corresponding ORC entries.
> 
> So I think we can remove the ANNOTATE_NOSPEC_ALTERNATIVE directives,
> this will allow objtool to check the instructions but it still won't
> emit ORC entries (same behavior as today). In the future, if ORC
> eventually supports alternative we will be ready to have objtool emit
> ORC entries.

I mean, we should make it warn for the case where you remove
ANNOTATE_NOSPEC and it would like to generate ORC.

Also, what's the point of having objtool grok this code and then not
doing anything with it?
