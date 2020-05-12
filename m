Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED58C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496ED206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vm7xbu1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgELOIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:08:40 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E925CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fzwFqbLGDZkv7zVEdnOkAnrFdnE9KNFZhl2rWunK4uU=; b=Vm7xbu1WPV9rFcmXbY0vufqy69
        VxYkGncfQBanfOlxD+iMe05h1iEOIHmHJF9cLtCJrykt5M1F/MXVel26a7HC/vO8B6/I2vQhsHNoK
        RMT+JpiwO0rtNjNj9i8bLi6HE9nGCsCtk0pwdGrY2IYESesk7ZAhXlfmt4s5rfunKXzPOpyK/M/VB
        8I8WH3FZhXaRRCEkeblPSU2cbznHbj5tQ313Oq7fBypecu8LGm7bKLNCwZC78p43hKndUNMQ2u/EL
        OuvJdveia5YREEuQwHTuqhAzTvf/IRRU0C5W0u/VzK56klr5uE5lF+VozugNNcLx+TyUgMDQFuB+p
        SakVOIVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYVZu-00069L-Fo; Tue, 12 May 2020 14:08:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB2BB304DB2;
        Tue, 12 May 2020 16:08:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E62620962E33; Tue, 12 May 2020 16:08:11 +0200 (CEST)
Date:   Tue, 12 May 2020 16:08:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        sboyd@codeaurora.org, john.stultz@linaro.org
Subject: Re: [PATCH 2/5] arm64: perf: Implement correct cap_user_time
Message-ID: <20200512140811.GK2978@hirez.programming.kicks-ass.net>
References: <20200512124058.833263033@infradead.org>
 <20200512124450.824507755@infradead.org>
 <20200512140301.GC20352@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512140301.GC20352@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:03:01PM +0800, Leo Yan wrote:
> > +	if (userpg->shift == 32) {
> 
> Thanks a lot for the patch set, some typos:
> 
> s/shift/time_shift
> 
> > +		userpg->shift = 31;
> 
> s/shift/time_shift

Blergh.. so much for me not taking the time to dig out the arm64 cross
compiler :/ Sorry about that.
