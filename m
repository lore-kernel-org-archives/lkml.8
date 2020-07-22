Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34D320787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bAA051jA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgGVItF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgGVItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:49:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F7C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0MdZWsXfOSzrpphaq5yn3/uApZ2HJH5s2c6LnYTQWjI=; b=bAA051jAuLR40JWxrp848gcYzM
        ZB6Vh98+ib5oHuDcldB6ngF2/JX5hS7H5GQ43X+C3NxI3dqO4r/uxkXI2BxwHX3XKYwu65Ez9aY3g
        xVblQT1hnpuOZNZSXDxLrWfs9jx1XfGeqqFQ+wwliWLZsB44Cy/bCc4hiDjeM3kJ4gg3Wg+EpVVP+
        7OLxrneq6vb5gxiFOXhm5k4/R34pxD6pLKeT0NDOt6F3fxT3IJEmXXpUj5RTVH6jVtoXzwGDnTqc9
        bBJu6EBN/TSxP9EuUfKwFNrELuBFPQzsa8RC2aQleD6LFrjDroQpvVw+Bt22AG2b1H0Iy91pPsKOO
        Tc3ioxTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyAQp-0004OW-1K; Wed, 22 Jul 2020 08:48:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7DD403006D0;
        Wed, 22 Jul 2020 10:48:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45D6320140AC8; Wed, 22 Jul 2020 10:48:54 +0200 (CEST)
Date:   Wed, 22 Jul 2020 10:48:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michael Ellerman <michaele@au1.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Nick Piggin <npiggin@au1.ibm.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@linux.ibm.com>,
        Anton Blanchard <anton@au1.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v2 06/10] powerpc/smp: Generalize 2nd sched domain
Message-ID: <20200722084854.GL10769@hirez.programming.kicks-ass.net>
References: <20200721113814.32284-1-srikar@linux.vnet.ibm.com>
 <20200721113814.32284-7-srikar@linux.vnet.ibm.com>
 <20200722074624.GP119549@hirez.programming.kicks-ass.net>
 <20200722081822.GG9290@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722081822.GG9290@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 01:48:22PM +0530, Srikar Dronamraju wrote:
> * peterz@infradead.org <peterz@infradead.org> [2020-07-22 09:46:24]:
> 
> > On Tue, Jul 21, 2020 at 05:08:10PM +0530, Srikar Dronamraju wrote:
> > > Currently "CACHE" domain happens to be the 2nd sched domain as per
> > > powerpc_topology. This domain will collapse if cpumask of l2-cache is
> > > same as SMT domain. However we could generalize this domain such that it
> > > could mean either be a "CACHE" domain or a "BIGCORE" domain.
> > 
> > What's the whole smallcore vs bigcore thing?
> > 
> > Would it make sense to have an actual overview of the various topology
> > layers somewhere? Because I'm getting lost and can't really make sense
> > of the code due to that.
> 
> To quote with an example: using (Power 9)
> 
> Power 9 is an SMT 8 core by design. However this 8 thread core can run as 2
> independent core with threads 0,2,4 and 6 acting like a core, while threads
> 1,3,5,7 acting as another core.  
> 
> The firmware can decide to showcase them as 2 independent small cores or as
> one big core. However the LLC (i.e last level of cache) is shared between
> all the threads of the SMT 8 core. Future power chips, LLC might change, it
> may be expanded to share with another SMT 8 core or it could be made
> specific to SMT 4 core.
> 
> The smt 8 core is also known as fused core/ Big core.
> The smaller smt 4 core is known as small core.
> 
> So on a Power9 Baremetal, the firmware would show up as SMT4 core.
> and we have a CACHE level at SMT 8. CACHE level would be very very similar
> to MC domain in X86.
> 
> Hope this is clear.

Ooh, that thing. I thought P9 was in actual fact an SMT4 hardware part,
but to be compatible with P8 it has this fused option where two cores
act like a single SMT8 part.

The interleaving enumeration is done due to P7 asymmetric cores,
resuting in schedulers having the preference to use the lower threads.

Combined that results in a P9-fused configuration using two independent
full cores when there's only 2 runnable threads.

Which is a subtly different story from yours.

But reading your explanation, it looks like the Linux topology setup
could actually unravel the fused-faux-SMT8 into two independent SMT4
parts, negating that firmware option.

Anyway, a few comments just around there might be helpfull.


Thanks!
