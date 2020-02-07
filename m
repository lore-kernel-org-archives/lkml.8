Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63129C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1C520720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gp+sYlwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGMdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:33:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgBGMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F2SfjhQs22QFPd1xeRI15B/VRdcmSSr0GH0YnucUn2g=; b=Gp+sYlwAODpNjTJCocTvwpV52l
        Dss3unYROvlVeiN8qdQMuy2mTHBeGVCfGuh5F889JHAsIGlbB8yMBmqicbVbN6cpHwuqafD5+21/g
        IRJ8KgG7ncN8EW1lljjoaMlLTI0ru9fFF9Frtmxxesfj5WSOVfTWIE7MwrhVQESa53X8TayFq8uWC
        63d001cxSBDtEe4B9R44vOQmnoYDQpMxE69XLIdRhuvpoP0SWzR2PkZ2nooQttMrvndWi3ud1V++f
        WF3snyB0i5ZCeC05mS9RNP00OenHxTwyDhLWHg7Iqy0lFkxzqkWgYg1WStAhht1JV6z0K5iQ4vpSc
        FEkv5vFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j02pE-0008Bw-Qz; Fri, 07 Feb 2020 12:33:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28AF330258F;
        Fri,  7 Feb 2020 13:31:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07D922B835767; Fri,  7 Feb 2020 13:33:35 +0100 (CET)
Date:   Fri, 7 Feb 2020 13:33:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>, joe@perches.com,
        sean.j.christopherson@intel.com
Subject: Re: Checkpatch being daft, Was: [PATCH -v2 08/10] m68k,mm: Extend
 table allocator for multiple sizes
Message-ID: <20200207123334.GT14946@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
 <20200131125403.882175409@infradead.org>
 <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
 <20200207113417.GG14914@hirez.programming.kicks-ass.net>
 <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
 <20200207123035.GI14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207123035.GI14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 01:30:35PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 07, 2020 at 01:11:54PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Feb 7, 2020 at 12:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Fri, Feb 07, 2020 at 11:56:40AM +0100, Geert Uytterhoeven wrote:
> 
> > > > WARNING: Missing Signed-off-by: line by nominal patch author 'Peter
> > > > Zijlstra <peterz@infradead.org>'
> > > > (in all patches)
> > > >
> > > > I can fix that (the From?) up while applying.
> > >
> > > I'm not sure where that warning comes from, but if you feel it needs
> > > fixing, sure. I normally only add the (Intel) thing to the SoB. I've so
> > > far never had complaints about that.
> > 
> > Checkpatch doesn't like this.
> 
> Ooh, I see, that's a relatively new warning, pretty daft if you ask me.
> 
> Now I have to rediscover how I went about teaching checkpatch to STFU ;-)
> 
> Joe, should that '$email eq $author' not ignore rfc822 comments? That

Argh, that's me hitting on the wrong 'nominal' in checkpatch.pl, same
difference though.

> is:
> 
> 	Peter Zijlstra <peterz@infradead.org>
> 
> and:
> 
> 	Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> are, in actual fact, the same.
