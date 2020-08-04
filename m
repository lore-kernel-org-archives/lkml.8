Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85270C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5822070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQRDXeVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgHDKsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgHDKq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:46:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 03:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+6Tt80sUg+tg0PdE7s0Kuf5aRtc3dDNucVqs4QUfFJo=; b=YQRDXeVGnrpdvgOV9toahm8icy
        oY5/5JySL/IwyPGKSuJ94/W3EiqpEYNbwAS2+Afrhvcq3qTwJfxbD803u4gx1jxnZ7n0/hlKb6sqJ
        5d1+q5DC0NTdCUs2yIv4/sQQ/VOjPuaN4GqytK6eKOrLx2jtNY1DjgiurB/UcJeD/PxGqsrO1iN0R
        qF43d+qNaJ9uw73bDhLTCXEPiltwEzF2GFgA+ErH8g1/0yQaw3QLrEmQMVABdQSBIpn8nWKz8ieRn
        XxOK8EJOu9X+T6284ZuLrUq2Qx+QIYuXbL8/QJm4CFT+RSOJlYo0K2088DuiVxFABe87+qcezB/9+
        aJk5+WGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2uSz-0001Kt-Dn; Tue, 04 Aug 2020 10:46:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9F94301631;
        Tue,  4 Aug 2020 12:46:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB51A2B94E749; Tue,  4 Aug 2020 12:46:42 +0200 (CEST)
Date:   Tue, 4 Aug 2020 12:46:42 +0200
From:   peterz@infradead.org
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/topology: Override cpu_smt_mask
Message-ID: <20200804104642.GC2657@hirez.programming.kicks-ass.net>
References: <20200804033307.76111-1-srikar@linux.vnet.ibm.com>
 <20200804033307.76111-2-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804033307.76111-2-srikar@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 09:03:07AM +0530, Srikar Dronamraju wrote:
> On Power9 a pair of cores can be presented by the firmware as a big-core
> for backward compatibility reasons, with 4 threads per (small) core and 8
> threads per big-core. cpu_smt_mask() should generally point to the cpu mask
> of the (small)core.
> 
> In order to maintain userspace backward compatibility (with Power8 chips in
> case of Power9) in enterprise Linux systems, the topology_sibling_cpumask
> has to be set to big-core. Hence override the default cpu_smt_mask() to be
> powerpc specific allowing for better scheduling behaviour on Power.

Why does Linux userspace care about this?
