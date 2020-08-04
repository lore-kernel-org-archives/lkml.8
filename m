Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EDBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD75020842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fFSpiFi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHDWpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHDWpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:45:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UveKBYDbIZyIjh6ZPjOv5UQRCvtyfkU8x2EftZkViyE=; b=fFSpiFi/AMgkfAVlAg1gz8Lovv
        wknbgJJDGNkFpBxfe0qi+Ue73w6sgRM7wQaROnxaNYjc+aWAYlFcyrH07uLsKeMGuxhu9giRlAnyz
        aTVv6J41koFtbUaMem8UHjzBa0hJQeQQmpEy2So1FXEK8WiBx7n2wL7m+FCpn5kTFiTLr166/s1mG
        oF6c8p7cbV3KllUCY0toiT8PYBe66OAbufWPr9nVF16CUmVL8mYK9qada0Z3fMorh20eafrP0Gpdr
        1r1lS9WNOg6cCuLQ0XJkMWT40x1ZBVY1UsnLGyKglE66JM73d6Ruviw3Er7hFtvL4zHSXxYg4VoSP
        07JwMXGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k35gm-0004rW-MJ; Tue, 04 Aug 2020 22:45:44 +0000
Date:   Tue, 4 Aug 2020 23:45:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC] saturate check_*_overflow() output?
Message-ID: <20200804224544.GK23808@casper.infradead.org>
References: <202008031118.36756FAD04@keescook>
 <f177a821-74a3-e868-81d3-55accfb5b161@rasmusvillemoes.dk>
 <202008041137.02D231B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008041137.02D231B@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 12:23:03PM -0700, Kees Cook wrote:
> > What we might do, to deal with the "caller fails to check the result",
> > is to add a
> > 
> > static inline bool __must_check must_check_overflow(bool b) { return
> > unlikely(b); }
> > 
> > and wrap all the final "did it overflow" results in that one - perhaps
> > also for the __builtin_* cases, I don't know if those are automatically
> > equipped with that attribute. [I also don't know if gcc propagates
> > likely/unlikely out to the caller, but it shouldn't hurt to have it
> > there and might improve code gen if it does.]
> 
> (What is the formal name for the ({ ...; return_value; }) C construct?)

'Statement Exprs'.

A compound statement enclosed in parentheses may appear as an expression
in GNU C.  This allows you to use loops, switches, and local variables
within an expression.

