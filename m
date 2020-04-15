Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D003DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A019E20936
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UYHl/yOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409914AbgDOM3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409123AbgDOLpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:45:04 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A44C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F0TfwyL8cSoc6EbuwXOEHdNQToqkZSCb0ZeMj1NZt6Y=; b=UYHl/yOv/tYtFT7s05SpGr0Aep
        u9OV4QmhxJFMBHGAUrYs9WCxILLk/xtgHJcKEiySuB8o1WxrsdkSxCkUlcRNr5GGWx08t9HfDCWk5
        FazvGzuDeGDbBm9dQxXRitKQugJmnIvbqyBeh9yADPznN71P4reB7nVPhd7YsxZ8ZM+5CU/TTd+9a
        cPQdthDc1qTYLZkcs0AzpN16uh9nVCkMLrqrRmT3P+i5El3nNFgK6LoChcXovkvOgwHPiIvZxyFon
        AmCPSXDSbgSj+S56//tUTQFMlsaqznAb74qvIAUqxlzznob8LFl3T1w7P5JBLeKbjBWVVIA8Y9f9B
        c7IYsvHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOgTD-0000yb-V3; Wed, 15 Apr 2020 11:44:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A0A8730066E;
        Wed, 15 Apr 2020 13:44:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57FA12038BC5A; Wed, 15 Apr 2020 13:44:41 +0200 (CEST)
Date:   Wed, 15 Apr 2020 13:44:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, mingo@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seqlock: Use while instead of if+goto in
 __read_seqcount_begin
Message-ID: <20200415114441.GG20730@hirez.programming.kicks-ass.net>
References: <20200409134558.90863-1-songmuchun@bytedance.com>
 <20200410115658.GB24814@willie-the-truck>
 <20200414110516.GO20713@hirez.programming.kicks-ass.net>
 <20200414134830.GB28750@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414134830.GB28750@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 02:48:31PM +0100, Will Deacon wrote:
> Oh yeah, good thinking. Didn't spot that one, but it should work well as
> long as smp_cond_load_relaxed() always implies a control dependency (surely
> it has to?)

Well, yeah, but then you know as well as I do that compilers are dodgy
pieces of crap which are out to get you. Still, I too can't see how it
could mess this up.
