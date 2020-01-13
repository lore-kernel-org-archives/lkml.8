Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F824C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599BA20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iDXLgDDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAMP7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:59:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35298 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgAMP7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/pevCa93KHqfbMoDCpY5wsv4jaMKrRibMGIqXRPVA6E=; b=iDXLgDDvIoj9wg5DltxvLrdR4
        Eupi3SdBufVUgd1ffaogni2b203DcAZ0wTsFDfrijEf4+59yeq/1yVe9ZKiRNI+WXHeJVbInj4F2I
        lEXcox2nGBWH0gB1PPxmZEVlNDKqmgRk0zNaGRAeD0Fb3N48ZgqfNOye0aRF5AzKzt30b3+s5YTn4
        yGuQ5fbNq9O+WovLYNEWlCOenZcg2baXz+tqI8If/ic07fGuvaoZf1VbSGvBzcdv+hjacruyw4nhh
        0lggbRIeQ/f/b1L0UcbGx/VJJ2W6htYHi34yZS3LlMV9oCJUMKKG6ybaa5gb5Fb9dJp2h7gNpVID1
        hJD/Q/2sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir27r-0000E9-So; Mon, 13 Jan 2020 15:59:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E5403042BC;
        Mon, 13 Jan 2020 16:57:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9938920427392; Mon, 13 Jan 2020 16:59:34 +0100 (CET)
Date:   Mon, 13 Jan 2020 16:59:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200113155934.GZ2844@hirez.programming.kicks-ass.net>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216151517.7060-5-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:15:15AM -0500, Waiman Long wrote:
> An internal nfsd test that ran for more than an hour could cause the
> following message to be displayed.
> 
>   [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

I'm guessing the pertinent detail you forget to mention here is that
that test re-loads the nfs modules lots of times?
