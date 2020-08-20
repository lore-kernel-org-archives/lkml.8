Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86248C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F0207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B3Kb6GTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgHTMjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgHTMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:39:13 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F8C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H65NUm+bQ5sPpf/4kMedwil6nQoa7FfLin0/1Ntxdok=; b=B3Kb6GTHEe538ZTHkDlkzt37Lr
        f1lPcYcQjCiup/UNSHgxYSiEeSUTHblkbJNVQqhkHKcEdPIY3qYYNLmg5uXHrEy1YfLaw2EGyr1vk
        Y/0eDt2eSx6ponu2AfnvdEA59zRfS2bpdstl1OPD6dAtfMPJR7zURV+pEhBpuXpjMTeZn2SslEbWW
        yV3tjiL3Oc6y5/KB2YGfm1IFaiEFdx05/sN8FfWK1W60qmu39I+V7P7z5wujuBB5tzf0B0EotSa+M
        lIO44j+NJCeOWdK7R0sJJk8h9kmUb4XxIH1ZNZWUeH9TR4ggRnSKmETFkt0+YThVpXDIhEj6+RK30
        /eO76N+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8jqP-0007W7-F2; Thu, 20 Aug 2020 12:39:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C791305B23;
        Thu, 20 Aug 2020 14:38:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CF942BE72C5B; Thu, 20 Aug 2020 14:38:59 +0200 (CEST)
Date:   Thu, 20 Aug 2020 14:38:59 +0200
From:   peterz@infradead.org
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, tglx@linutronix.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH] lockdep: Do no validate wait context for novalidate class
Message-ID: <20200820123859.GS2674@hirez.programming.kicks-ass.net>
References: <20200629201529.1017485-1-bigeasy@linutronix.de>
 <20200820114036.GQ2674@hirez.programming.kicks-ass.net>
 <20200820114348.giwwlbihjwpl4kxz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820114348.giwwlbihjwpl4kxz@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 01:43:48PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-08-20 13:40:36 [+0200], peterz@infradead.org wrote:
> > Anyway, all 3 users should have the same wait context, so where is the
> > actual problem?
> 
> I have one in RT which is a per-CPU spinlock within local_bh_disable()
> to act as a per-CPU BLK like mainline.

Then can we get to see that code and an explanation for what the problem
is and why it is still correct?

Because as is, this patch isn't needed.
