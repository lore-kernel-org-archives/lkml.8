Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A88206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j78Bd4eP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgFDNQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgFDNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:16:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799E0C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WVE3qPA0O7uuxoPXLbzFwIQgphyDorNlT9Drp/WwwVs=; b=j78Bd4eP3yPf0Ni1GgjgVPR16M
        AImmiR1clxiLOn+NvhhkDmiqtFvr7PBLojAEIgPB5+Ta/Di8k4nw9cyVpbd6ZZ8e7udIWTAxvWbEV
        apVPK16HpQEqZWXgu5E3o7+7NBVWyAjfPYGtgFMPj4a2doCST1fnX67QIS8yMzMEgPnk0HJkSsCfj
        4FkA0qwn4XsNitVXHyTbvAVyiHXk519tC8h0DsxIwOKjnSDAujn2cyss+4oc69mz0wmZlpKjMuX0a
        T0Ty1ioYFdMUDUt6/6u3h23LTkcL1byH8KiwSg3cA/Eipg83cm0YtgGSbpto/kYrtsb4b7SV71sWM
        /57wLE1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgpjR-0006y4-SH; Thu, 04 Jun 2020 13:16:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE200301ABC;
        Thu,  4 Jun 2020 15:16:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9855020086132; Thu,  4 Jun 2020 15:16:27 +0200 (CEST)
Date:   Thu, 4 Jun 2020 15:16:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jim Somerville <Jim.Somerville@windriver.com>
Subject: Re: [PATCH 0/2] sched/isolation: Isolate unbound kthreads
Message-ID: <20200604131627.GC4117@hirez.programming.kicks-ass.net>
References: <20200527142909.23372-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527142909.23372-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 04:29:07PM +0200, Frederic Weisbecker wrote:
> Kthreads are harder to affine and isolate than user tasks. They can't
> be placed inside cgroups/cpusets and the affinity for any newly
> created kthread is always overriden from the inherited kthreadd's
> affinity to system wide. Take that into account for nohz_full.
> 

Thanks!
