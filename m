Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEA7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA87206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kaDOvEDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgDCSUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:20:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56482 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgDCSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2dKDGpqijVtdLIYlA6wF/IukuIi+37yb9HKFfYMStlk=; b=kaDOvEDtAAkWAJWmPA6o4gjBww
        6Vk4be/+t5ebFQlnfvZHv2zf6EcgEIRlBVTltimFDRQdrzQQ1YCEi7ZnXNghZWK9yJJq5OCJlCNn7
        JyeeZ2x11KE8QP1kNrkqpH1WIF2HAFaS3OsSq3cru48n+F8YKcKWIa5b6zLcZ9ulK0IjgH/Mt0F4R
        i/om2K+qIV+cXchQ+TGsGjMNtvRaoqiU0PkaHQOhyBUuD00lToTZwNBCZKbWcVuLeB6A+JvmXKwSN
        CxFzfStAYzYj3yVGgG2EQFTa3V5x0cSWiPMCrujwN2v9IiuD8WtQuHVHhvbIMg1qXdGw6fYt/xfwx
        CUtOJKEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKQvI-000502-2I; Fri, 03 Apr 2020 18:20:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88E5C3056DE;
        Fri,  3 Apr 2020 20:20:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F8A82B1255EA; Fri,  3 Apr 2020 20:20:05 +0200 (CEST)
Date:   Fri, 3 Apr 2020 20:20:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH 5/7] x86/speculation: Annotate intra-function calls
Message-ID: <20200403182005.GC20730@hirez.programming.kicks-ass.net>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-6-alexandre.chartre@oracle.com>
 <20200403160538.qwu237amhanr6pyi@treble>
 <20200403161607.jxz6duaz7dud22wf@treble>
 <2c615bae-6002-80b7-493d-b24ec48f69c9@oracle.com>
 <20200403171836.GB20730@hirez.programming.kicks-ass.net>
 <20200403172408.odvcsymwlyx6ises@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403172408.odvcsymwlyx6ises@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 12:24:08PM -0500, Josh Poimboeuf wrote:
> On Fri, Apr 03, 2020 at 07:18:36PM +0200, Peter Zijlstra wrote:
> > What we need in this case though is only a different stack layout inside
> > the alternative, and that is doable.
> 
> I'm not sure what you mean... any stack changes within the alternative
> have to match exactly the stack changes at the same offsets of the
> original code because ORC doesn't know the difference between the two.

I mean that the ORC entries on either side of the alternative have to be
invariant wrt the specific alternative chosen, but that -- provded you
whip up that ORC alternative stuff -- stack layout inside of an
alternative could possibly be different.
