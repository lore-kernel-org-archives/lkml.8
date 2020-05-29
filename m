Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E680920723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OJyHQWJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgE2TFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:05:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43564 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2TFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=thn7TMkwb5FVZbIobG9IjrSgpGicxOEnfAegFwtUQ9Q=; b=OJyHQWJ025zNOPknTYZbwW+IcS
        6qmc1yzs5g43hxKLNNudj30TImVKiIVvVB/vUfz87vN8Umc0VR459hh+55Uffdh86hqTxh+Q4csvW
        xEvZKBtS6hSqG4dJTyPy8q2a7ZPya33yiaY5mWarfF+8XwfhQgylaUYH3axPlQiwMxMY99S51hLTT
        gW1/OWLUVBF4ikyzoSWHqnjQhJLq33ZK5QYT9ygTyinoxe2gXVTEXzdjtMBPGBY3XZzCQLLpDfTq+
        nFqGP9kx8s3V70F+EiHN3vMNQE8TUnYA7SOrgSv8ohurUxxY8nOYM/dPbO1AiZ+bgZcH6ahDxszkK
        xxiGkoZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jekGy-0003zK-5w; Fri, 29 May 2020 19:02:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F21530047A;
        Fri, 29 May 2020 21:02:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8B562021AF65; Fri, 29 May 2020 21:02:18 +0200 (CEST)
Date:   Fri, 29 May 2020 21:02:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, daniel.thompson@linaro.org
Subject: Re: [PATCH 1/6] x86/entry: Introduce local_db_{save,restore}()
Message-ID: <20200529190218.GP706495@hirez.programming.kicks-ass.net>
References: <20200528213352.GC4496@worktop.programming.kicks-ass.net>
 <AC94E789-9EC7-4156-955C-841FF7114176@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AC94E789-9EC7-4156-955C-841FF7114176@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:28:33AM -0700, Andy Lutomirski wrote:
> > +static __always_inline unsigned long local_db_save(void)
> > +{
> > +    unsigned long dr7;
> > +
> > +    get_debugreg(&dr7, 7);
> > +    dr7 ^= 0x400;
> 
> Why xor?  This seems extra confusing.

I'll do the normal mask thing ..
