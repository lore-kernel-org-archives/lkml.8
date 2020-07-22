Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451EAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136872077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qMkOu+zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgGVIyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgGVIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:54:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292EC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Z73rgNzULE5N7bg+bwWraBZnyK5vQPqWDQ36XJiXik=; b=qMkOu+zicovwtaHxhU7/JCNNZA
        anhh7VzJHSzHkfXX8/EeXDtu9RIIG5u4IS5ZaRGdmniEPdQ1c01p30A2Iyf+G5cQXvGX8GWwmrWCw
        6UhCwjdOD0egAM/WhuB2DLDc/yqviqFYqMKFwkNG7iZ7kFYAGDVOpjiW+Cs4ab9z1PDT7r/mgRtEe
        Cd/WmMNeiqEn0tpGwq2x5Y4n6zFlqi03e/nDaGGK14jTpvIwgs736id3Ei+W7t378ptk8F2ERFH2A
        V4Lj1RA9iqNF3s6R9ktGwmZ06VpHEOieNXFNanHIjc7PsmuO13h+9HK7P7MAwyG0OuijwTpw+IoUU
        PuLw3CpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyAVw-0004gu-Cf; Wed, 22 Jul 2020 08:54:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD79A304E03;
        Wed, 22 Jul 2020 10:54:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B221A21A7D50F; Wed, 22 Jul 2020 10:54:11 +0200 (CEST)
Date:   Wed, 22 Jul 2020 10:54:11 +0200
From:   peterz@infradead.org
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
Message-ID: <20200722085411.GI43129@hirez.programming.kicks-ass.net>
References: <20200721113814.32284-1-srikar@linux.vnet.ibm.com>
 <20200721113814.32284-7-srikar@linux.vnet.ibm.com>
 <20200722074624.GP119549@hirez.programming.kicks-ass.net>
 <20200722081822.GG9290@linux.vnet.ibm.com>
 <20200722084854.GL10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722084854.GL10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:48:54AM +0200, Peter Zijlstra wrote:
> But reading your explanation, it looks like the Linux topology setup
> could actually unravel the fused-faux-SMT8 into two independent SMT4
> parts, negating that firmware option.

Ah, it looks like that's exactly what you're doing. Nice!
