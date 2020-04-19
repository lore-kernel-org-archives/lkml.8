Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2626CC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C002075E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xggy72PC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgDSS6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 14:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgDSS6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 14:58:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E9C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=58eelTMq/bLN5j06iA2jKBO2BNattXuFwU1DrQ+JtV4=; b=Xggy72PCBquU81ve6cNPE+KxXh
        QMeo7dl65RflQIUaU99ssIOE3HMWrtkXbdbglE1iNsbVzMAP9OoHiK8Js+/tm+2cNmJzbYOX3m3N3
        bhWBAx0cFuqGeCJwz0G6qHpADspoP1WUY1/n5bwzr0rTqJxxEyMBOP+XY2etbSSadqpMZk9qKw9uH
        C2ZXkEe0h5X6PGhMfnC34tm4B8EbYNVHwdknqtRcU/WBox92C3OJ513dDGK+e6dbRpFmy3trq6Nbt
        vThw/RVRbSjYryv8isCOpCVAkXJXFrnO65BWSgNl9MlyxXiekOZNcn6JnNrslQJbzHVrMJN/RRFm4
        3ehowW+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQF9N-0005Wx-5n; Sun, 19 Apr 2020 18:58:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92D593012D8;
        Sun, 19 Apr 2020 20:58:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 515402B4E18EF; Sun, 19 Apr 2020 20:58:38 +0200 (CEST)
Date:   Sun, 19 Apr 2020 20:58:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 5/7] x86/speculation: Change __FILL_RETURN_BUFFER to
 work with objtool
Message-ID: <20200419185838.GX20696@hirez.programming.kicks-ass.net>
References: <20200416150752.569029800@infradead.org>
 <20200416151025.004441230@infradead.org>
 <20200419165155.4twgzmf6eusk7rv5@treble>
 <20200419165519.wstqpqmvyom4yh3r@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419165519.wstqpqmvyom4yh3r@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 11:55:19AM -0500, Josh Poimboeuf wrote:
> On Sun, Apr 19, 2020 at 11:52:00AM -0500, Josh Poimboeuf wrote:
> > Are we still planning to warn about stack changes inside an alternative?
> > If so then this would still fail...
> > 
> > In this case I think it should be safe, but I'm not sure how we can
> > ensure that will always be the case for other alternatives.
> > 
> > And do the ORC entries actually work for this?  As far as I can tell,
> > they would be associated with the .altinstructions section and not
> > .text, so it wouldn't work.
> 
> My preference would be to move RSB stuffing out-of-line too, like you
> did the retpolines.  Or use static branches.  Then we could add an
> objtool warning to prevent stack changes in alternatives.

I effectively did the static_branch thing, but with an alternative, it's
in the last patch, due to me being a moron and not refreshing the stack
before sending it out.
