Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A307AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5FF2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P1d9yaHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgG2IvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG2IvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:51:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C04C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DLxbvqQNNWHcBtqjBcnu6J4A9IgQ+HtwVQj1fioMep8=; b=P1d9yaHYNdtqVsMPimvRVVysuo
        nQi2vCDa5Ayv0w0UUx4hnSFmaqDrYlOQUJg9zGSmwAJTrKuYXB+yVJXyToQyl/LfUFdvQubKBt9IP
        nOba77EfbI2d2HBAIfJfwK6BzyrUBFPogC1eOXXQKKfhmdfU7ICunBNcldQeXnhBwHDXQJG/bwpES
        ZvqU2+9a64xWnCxVa0BkDHY3hkPQLRjiDZuH52t8CMVnXnhRPtEO1pkBDsO3Qc0y3kQPTlPO3MrbL
        CUj4Kgxrn1QzWyIbbwsej2nJ8yyFmSRZPmJjoNuMl2vhI8rDB5xv97CJMP2W0z5EjpxfRWjDhbXwW
        ObKEKOTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0hng-0001oW-FU; Wed, 29 Jul 2020 08:51:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 02226304D28;
        Wed, 29 Jul 2020 10:50:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE9AF2BD93BFD; Wed, 29 Jul 2020 10:50:57 +0200 (CEST)
Date:   Wed, 29 Jul 2020 10:50:57 +0200
From:   peterz@infradead.org
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729085057.GZ119549@hirez.programming.kicks-ass.net>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729030232.GE5583@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729030232.GE5583@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 08:02:32PM -0700, Sean Christopherson wrote:
> Maybe it's just me, but it'd be nice to break this into multiple patches
> so that the SLD refactoring is separate from the introduction of BLD.  As
> is, I find it hard to review as I can't easily distinguish refactoring from
> new functionality.

This. Absolutely 100% this. It's like Fenghua has never send a patch
before..
