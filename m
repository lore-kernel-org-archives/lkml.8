Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5252DC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23BA32075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RPS8DTJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgG1Iei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgG1Iei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:34:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC92C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YLFGmCNLBQaHl2LIIeR8RilOiEeM2D0eo7p9uobvY5k=; b=RPS8DTJiqcvjAwWrwkZVHhw+S8
        01UQExPZp2QoIBo4JC1kVZBJKynbsqpx1TyMdw7CZNpZdhOs5hzV7lLEaL0sLpvaeKw3VPtlT4qDo
        iHqbGOgC29uyh5vdarV9Z8QIXFizC7JHfEyxH07kQtiYho0z6oGe3ywvd8d8LlDO1cnCVwBfJRtSy
        49Utmzak4prIX03jxHSuqEzECRn5MYKt3u9liYp860Nnp+jnpu632TrG9cQkAKHvz4P2o1481mDrb
        mSvTzdV3be8ePnWXo3zYtuifSyV2hScb+WGrk+OFl9OyFgU7uX167CvmF+zqHDupO5TqEkreHdnCx
        dDyEjFxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0L4E-00085j-2L; Tue, 28 Jul 2020 08:34:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7806B304D28;
        Tue, 28 Jul 2020 10:34:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64E592BB9F904; Tue, 28 Jul 2020 10:34:29 +0200 (CEST)
Date:   Tue, 28 Jul 2020 10:34:29 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH] objtool,x86: Verify poke_int3_handler() is self contained
Message-ID: <20200728083429.GP119549@hirez.programming.kicks-ass.net>
References: <20200727104050.GH119549@hirez.programming.kicks-ass.net>
 <87eeowbrto.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeowbrto.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:56:03PM +0200, Thomas Gleixner wrote:
> peterz@infradead.org writes:
> > Abuse the SMAP rules to ensure poke_int3_handler() doesn't call out to
> > anything.
> 
> Yuck. Isn't that what noinstr is for or am I missing something?

Well, we don't want poke_int3_handler() to call out to noinstr either.

So noinstr only allows calling noinstr, The above hack only allows it
calling uaccess-safe functions, and the group of functions that is both
noinstr and uaccess-safe is 'small'.

But like I said yesterday, perhaps this wants it own annotation. Then we
can also verify the lack of any dynamic code.

So yes, yuck and a bad idea, ignore this ;-)
