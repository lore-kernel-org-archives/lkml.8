Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09745C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A6B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iUOvGwSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBLKLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:11:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLKLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6wtDFTTn/VINQwgBE92J9tTlrm6/IBj2w+Z0dI8Cerg=; b=iUOvGwSqr/z44NkdhqDjLxPXlo
        ODs1P/2wO4hh02/IgKB3lILqACreHQcjat4COg0fCzLoy6Wicbw+BkgohaTVMll5phPzT5d6oPG3+
        zx/u9IBPnABtZtvwvpehCJb0OJbA7A6OaSElbYdSDKKxYaWzgNx7XVC4KCp6gAUik8UpIyW4iQDzs
        nlKZa1HQskC4SKYtFbmLrUxfFrSb6ZzN8OkFJpWGXS2nmxrkGPymxaWc5AGM1moNCZ3oL9wq3jyrx
        Adffxh/5LPCVwPkjbPveQh2YLkMSjpM2Vx+7r9i68wqn5/Y8IjmTRoQAlOEcTA+7uY+Iy9uVxC3t5
        5a4pbgyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1oz8-0001DA-2j; Wed, 12 Feb 2020 10:11:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DB2A306BCF;
        Wed, 12 Feb 2020 11:09:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5560120148940; Wed, 12 Feb 2020 11:11:08 +0100 (CET)
Date:   Wed, 12 Feb 2020 11:11:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: Re: [PATCH] sched: Use kmem_cache_zalloc() instead of
 kmem_cache_alloc() with flag GFP_ZERO.
Message-ID: <20200212101108.GE14914@hirez.programming.kicks-ass.net>
References: <1581501261-5558-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581501261-5558-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:54:21PM +0800, Yi Wang wrote:
> From: Huang Zijiang <huang.zijiang@zte.com.cn>
> 
>  Use kmem_cache_zalloc instead of manually setting kmem_cache_alloc
>  with flag GFP_ZERO since kzalloc sets allocated memory
>  to zero.
> 
>  Change in v2:
>       add indation

Why? Isn't this more or less a whitespace change?
