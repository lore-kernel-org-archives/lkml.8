Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF8CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6175224653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="egfoudPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgAUKnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:43:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbgAUKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f/Sbte5snp8vFWptEWtDAMlixV4m6d9CvFlccJ4poOk=; b=egfoudPNXA31Bxuon8KtbBTgh
        1R5wwQKVCoGN4P+5QE07asDkPsAy+Wi+tpiWydRhz6RB+zJ9eQOIONJebb8SR4DcPXyqXLeRFHn6d
        eVfxUPc+Lzt2s5RwgyM5eSilannu0YNWz9cImfiFtfpY27VoL19JbGXO6f/3IgkxAJq/XnN+Nt+s0
        ujtgc8Anm2mlxNzgdjRA8GEqUu9oill6MyXLzaK+OXdT7PxWRmVtlkfkoF3Q0ScQxH/FqhlnM352f
        QS+1BHZE5GUPNjGdOx0gEIwgJn+IqH8t4oXTU51RUBCBbP2dxs9XqsMA3v4XwiqJ8OMW5C6qfazN+
        lzJuHMKXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itqzj-0004bn-26; Tue, 21 Jan 2020 10:42:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1BC9305FEA;
        Tue, 21 Jan 2020 11:41:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D13EE2041FB24; Tue, 21 Jan 2020 11:42:47 +0100 (CET)
Date:   Tue, 21 Jan 2020 11:42:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Message-ID: <20200121104247.GI14914@hirez.programming.kicks-ass.net>
References: <20200114101319.GO3466@techsingularity.net>
 <20200117175631.GC20112@linux.vnet.ibm.com>
 <20200117215853.GS3466@techsingularity.net>
 <20200120080935.GD20112@linux.vnet.ibm.com>
 <20200120083354.GT3466@techsingularity.net>
 <20200120172706.GE20112@linux.vnet.ibm.com>
 <20200120182100.GU3466@techsingularity.net>
 <20200121085501.GF20112@linux.vnet.ibm.com>
 <20200121091148.GV3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121091148.GV3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:11:48AM +0000, Mel Gorman wrote:
> On Tue, Jan 21, 2020 at 02:25:01PM +0530, Srikar Dronamraju wrote:
> > * Mel Gorman <mgorman@techsingularity.net> [2020-01-20 18:21:00]:
> > 
> > > Understood. At the moment, I'm going to assume that the patch has zero
> > > impact on your workload but confirmation that the other test programs
> > > trigger no traces would be appreciated.
> > > 
> > 
> > Yes, I confirm there were no traces when run with other test programs too.
> > 
> 
> Ok, great, thanks for confirming that!
> 
> Peter or Ingo, I think at this point all review comments have been
> addressed. Is there anything else you'd like before picking the patch
> up?

I've already queued it a few days ago, should show up in tip soonish :-)
