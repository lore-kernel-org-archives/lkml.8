Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD3AC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928DC20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="McR/6Lub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbgCPQsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:48:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbgCPQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LLi4rnfdkVXqdOVLhVNnFoS19kOHY+Adb3HPtcUQkPg=; b=McR/6LubocQwK/n57ZLi3g+ZIv
        +EPQw9yt+oOOllYfukakkZxu5pvaJXpRpeuh2jX5zf1x9LESuvzgmh45eSpweorY8qrVe7gzTHu9z
        DmigqOOhUHFO2EH4bg2+D8q3IHTI+Xl+PZrornPmJiEStWraMupSumG15C6MJPwO4Adbhszh40wN9
        ChEbr+qrkRjBzp6rxxEnYR2tFVj9ONviWSXc173Tzhd9/NI3fu0c4VHN7LjY3DMnWVtSGXapdCT3E
        7JFf+w9+gFpxmA5LFVtFPEoYE49ode70e8HNdasV1GR8+ilGzSl0scfOX24Y4PfoGeulbmUWAebnI
        BZQHKyVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDsuj-0003Yt-An; Mon, 16 Mar 2020 16:48:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB9E130138D;
        Mon, 16 Mar 2020 17:48:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 916FA2B4E3C70; Mon, 16 Mar 2020 17:48:27 +0100 (CET)
Date:   Mon, 16 Mar 2020 17:48:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 15/16] objtool: Implement noinstr validation
Message-ID: <20200316164827.GH12521@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312135042.288201372@infradead.org>
 <20200315180320.cgy2ealklbjlx4g7@treble>
 <20200316132419.GF12521@hirez.programming.kicks-ass.net>
 <20200316161904.zouwkwup6vwsmxgp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316161904.zouwkwup6vwsmxgp@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:19:04AM -0500, Josh Poimboeuf wrote:
> On Mon, Mar 16, 2020 at 02:24:19PM +0100, Peter Zijlstra wrote:
> > > And "read_instr_hints" reads as "read_instruction_hints()".
> > > 
> > > Can we come up with a more readable name?  Why not just "notrace"?
> > > 
> > > The trace begin/end annotations could be
> > > 
> > >   trace_allow_begin()
> > >   trace_allow_end()
> > 
> > notrace already exists and we didn't want to confuse things further.
> 
> Um, why would it confuse things to call a section of notrace code
> ".notrace.text"???

Because it is strictly stronger than the notrace attribute is. And we
certainly don't want all that is now marked notrace to end up there.

Our section also very much excludes kprobes and hardware breakpoints for
starters.
