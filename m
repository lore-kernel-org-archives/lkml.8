Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9161EC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F69920728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OdZUh8sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgDXJzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726489AbgDXJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:55:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE3C09B045;
        Fri, 24 Apr 2020 02:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IwKwbSmGjb9mqGGwT2L7N216BXJbyhGPyRcIk5sPmzk=; b=OdZUh8sMRP0YeZhGvBlhTwqXJT
        LDaLsZJ0FzBe9Pxo/xgaYRjnKijrVWJ93E9upc2h9f6t1c+VFb3RdTLv2H94LVOYzqa2cj9pDyvdy
        evh6EBcpJEyYzvuB1jmlfc3pX6wFignIHZlb6RPxOc+/BVMB9+K4fJf7Ul3t5Pp33qexByVhvzjBp
        lDP56zndTyaFOUFoHWFUW7sTe3a70DHaN3tRtBFgYf934OqN0OyohrRTLb/uuCHK2sHr7YErA7i72
        f55XFJdja6DZaqc0nnRGQPVELeO579cjJif4Z1gaarWQryQc+HbutOtf2EMkYl1sB7nzt5i4nyvj/
        w7rancWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRv3Z-0000ox-VI; Fri, 24 Apr 2020 09:55:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F3DF3010C4;
        Fri, 24 Apr 2020 11:55:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C949020325E18; Fri, 24 Apr 2020 11:55:33 +0200 (CEST)
Date:   Fri, 24 Apr 2020 11:55:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, pbonzini@redhat.com, maz@kernel.org,
        bigeasy@linutronix.de, rostedt@goodmis.org,
        torvalds@linux-foundation.org, will@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 4/5] rcuwait: Introduce rcuwait_active()
Message-ID: <20200424095533.GY20730@hirez.programming.kicks-ass.net>
References: <20200424054837.5138-1-dave@stgolabs.net>
 <20200424054837.5138-5-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424054837.5138-5-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 10:48:36PM -0700, Davidlohr Bueso wrote:
> This call is lockless and thus should not be trustedblindly,
> ie: for wakeup purposes, which is already provided correctly
> by rcuwait_wakeup().
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
