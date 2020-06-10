Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF72C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038BF206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GEWMeM91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFJJKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgFJJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:10:06 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52ECC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EmvZOX3XKJAnMLDmrNxCkG2SMZZf7Tnqr5HQzs32oxY=; b=GEWMeM91x9p303KqeEjqbnd3s+
        3U/iW3wsFB5JY6p590i/W+aaw65cZMPUR2DXxWhRp+7VkpAeBthr/loFa81iz9LrWUKXrr/3haZdr
        W7Wz7siV55N0A6D2uOyluQ0CLOHbwkb8G/CXORaSbUMbMgjLwFyyIilox5BB1cjyqAgC/plGd1hzV
        iegSkqlz9Wy8tbSGmsrljCwMzCelgAqsOQLc/0VnRDAjErk5J6LJ8IElmxs90ySdGXXQRndUUWjZn
        DkgcH18OpgM+HaNceKxLKmKjwdvtImH7WYA608AGmo4M9LDMtpq4x3oUX/PjSo3IA9SHT+bxf4lrg
        02idfCig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiwjm-0008Cx-6A; Wed, 10 Jun 2020 09:09:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EEFD430280E;
        Wed, 10 Jun 2020 11:09:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB7342041055D; Wed, 10 Jun 2020 11:09:30 +0200 (CEST)
Date:   Wed, 10 Jun 2020 11:09:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eric Biggers <ebiggers@kernel.org>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200610090930.GE2531@hirez.programming.kicks-ass.net>
References: <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
 <20200605161532.GD1373@sol.localdomain>
 <53318971-561c-b445-0408-530b3d3ba44e@roeck-us.net>
 <20200609202134.GA1105@sol.localdomain>
 <20200609212509.GA239889@roeck-us.net>
 <20200609213829.GA789@sol.localdomain>
 <20200609220601.GD2514@hirez.programming.kicks-ass.net>
 <e8a57823-3c5a-886a-e114-b5e7b2bb4f01@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a57823-3c5a-886a-e114-b5e7b2bb4f01@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 04:03:19PM -0700, Guenter Roeck wrote:
> On 6/9/20 3:06 PM, Peter Zijlstra wrote:
> > On Tue, Jun 09, 2020 at 02:38:29PM -0700, Eric Biggers wrote:
> >> Does the struct actually have to be named?  How about:
> >>
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index c5d96e3e7fff42..14ca25cda19150 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -653,8 +653,14 @@ struct task_struct {
> >>  	unsigned int			ptrace;
> >>  
> >>  #ifdef CONFIG_SMP
> >> -	struct llist_node		wake_entry;
> >> -	unsigned int			wake_entry_type;
> >> +	/*
> >> +	 * wake_entry_type must follow wake_entry, even when
> >> +	 * CONFIG_GCC_PLUGIN_RANDSTRUCT=y.
> >> +	 */
> >> +	struct {
> >> +		struct llist_node	wake_entry;
> >> +		unsigned int		wake_entry_type;
> >> +	};
> >>  	int				on_cpu;
> >>  #ifdef CONFIG_THREAD_INFO_IN_TASK
> >>  	/* Current CPU: */
> >>
> >>
> >> However, it would be preferable to not rely on different structs sharing the
> >> same field order, but rather write proper C code that uses the same struct
> >> everywhere to encapsulate these 2 fields...
> > 
> > https://lkml.kernel.org/r/20200605093704.GB2948@hirez.programming.kicks-ass.net
> > 
> > And I have more patches on top to clean up some of the anonymous union
> > stuff, that that's quite a lot of frobbing.
> > 
> 
> That is why I tried to keep it simple as hackish fixup patch.

Fair enough; I'll try and get the above variant merged to address the
build fail. Then I can chase down Paul's bug and finisht the cleanup.
