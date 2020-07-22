Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4FCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA04D20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CEqxqaNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgGVHqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVHqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:46:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B6C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UtSNhIf2wpJr1Xu6wPJnrBrzTE5gyQVve7CwYw8dNtc=; b=CEqxqaNLXFqUG0/lq8sCbUl+px
        +zsCBZ4wSYjVTZHgYdhKLg3OX0lReiMHBKKpiKdNHddVDCRuFcaH09IDFHyDMEnoZJD0F35A1VWjM
        zgQ517U0gTMd5TwWkv0RPleM/CJ67f7CaDg6F6HaVzN7MuEE4ookPkJSTqF4ysA25IKDXIn+2M8S1
        gDBI70R+Z46A7RgPkPCQtzv1JQnEpRIepHSHWDfQksWAPaJoEU6US7/V7+yeAa9CrDm22fppWKgty
        Y8eOau7gL12wqclb70XhVVWF6gDTvm3EcdveQr/IojyxQtnWhI0l+U5htoxoZAlxpB7fhRHrCP5nv
        1nxbSJnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jy9SN-0003eB-MZ; Wed, 22 Jul 2020 07:46:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C57B303A02;
        Wed, 22 Jul 2020 09:46:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE71B29A6A87E; Wed, 22 Jul 2020 09:46:24 +0200 (CEST)
Date:   Wed, 22 Jul 2020 09:46:24 +0200
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
Message-ID: <20200722074624.GP119549@hirez.programming.kicks-ass.net>
References: <20200721113814.32284-1-srikar@linux.vnet.ibm.com>
 <20200721113814.32284-7-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721113814.32284-7-srikar@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:08:10PM +0530, Srikar Dronamraju wrote:
> Currently "CACHE" domain happens to be the 2nd sched domain as per
> powerpc_topology. This domain will collapse if cpumask of l2-cache is
> same as SMT domain. However we could generalize this domain such that it
> could mean either be a "CACHE" domain or a "BIGCORE" domain.

What's the whole smallcore vs bigcore thing?

Would it make sense to have an actual overview of the various topology
layers somewhere? Because I'm getting lost and can't really make sense
of the code due to that.
