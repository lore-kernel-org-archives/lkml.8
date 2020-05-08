Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3BCC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51C9208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jTat2N4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgEHQ0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEHQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:26:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799DDC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eOXwZu6jGxF28/fjq4ri8nUXwqrvhi607Z+SSxjQJFs=; b=jTat2N4zBBs5R8ZNjqJ51Jzk+n
        nUw7KQs7wHetj7+78AD7fXlyEz4PMoGdSXlr5HuXa24GFMesWyaagH5Wo62q8Xt149nMuCUKGDlL4
        wof7+yDNbtqMhHouGy72z4b8UolWUz+2bC+PijY65DGHkZlFZDvSvhVN9N1g0eaWIbBG2Qj4v03uh
        2AqjxUHCiEZrkuzLwTCjH0atYIru9OoC4AzES6xussgr2ysgiNEaachVqeGj6jwcYU1W1NjmzD6ye
        kk8nSOYH+ZCmw5NefnQZT6wySXX0P841OdxN6WYWCALTY9Z8XjBtA24VFCydapD9JVhsu/xT7PmH3
        v18dOSIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX5p9-0002tG-1v; Fri, 08 May 2020 16:26:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EC9630018B;
        Fri,  8 May 2020 18:26:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F0EB29C8A723; Fri,  8 May 2020 18:26:04 +0200 (CEST)
Date:   Fri, 8 May 2020 18:26:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
Message-ID: <20200508162604.GE3344@hirez.programming.kicks-ass.net>
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
 <CAK8P3a0pY+tu=3hvWTZVwD7nbA7UhaaCGWbBVba0eDuNcpt2Sg@mail.gmail.com>
 <20200508095509.GX5298@hirez.programming.kicks-ass.net>
 <20200508161750.bl5c7wh36gh6gcvp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508161750.bl5c7wh36gh6gcvp@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:17:50AM -0500, Josh Poimboeuf wrote:
> On Fri, May 08, 2020 at 11:55:09AM +0200, Peter Zijlstra wrote:
> > On Fri, May 08, 2020 at 11:27:39AM +0200, Arnd Bergmann wrote:
> > 
> > > Right, makes sense. It would be nice though to have a way of intentionally
> > > turning all objtool warnings into errors. I do my randconfig tests
> > > with '-Werror'
> > > at the moment in order to catch all new warnings, but this does not catch
> > > objtool errors at the moment. For now, this is probably the right thing to do,
> > > as there are a couple of warnings that I have no patches for, but at some point
> > > I would prefer to trap immediately when a new warning pops up.
> > 
> > Completely untested, and I'm 100% unsure of the Makefile change, but
> > something like so, then?
> 
> Mostly looks good, but it only errors out on fatal errors, right?  For
> -Werror (and what Arnd is asking about) should it also return error on
> "warnings > 0"?

Oh, good point. Extra knob or just: if (error && ret) return -1 ?
