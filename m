Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B893C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FB82072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LLbhPh4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437651AbgDNJ1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:27:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437618AbgDNJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cr9JOOUBDCjRlCArHvWzModBxnVzGdWn5ItJ1H7y5Hg=; b=LLbhPh4Zz3ZlfXRKe9rPBB1g5k
        xP2wtD/XZU2zsOZuSQa23C+iga645aODC/uYQIxW1vegtzTb4Zqk7HdkLd8onrrrgx8d8Xcax2Vcn
        iP6URjpmqxkiNkBIbMwrhiLnuqWMSCpuaQO4+5pSRJxNjuJci9aDBob63ubh3aUgF0jQ+IyJQHPtL
        b2AJa+BNauYOaVw3dgRuTrEp8o/5pDctAzhRwwBVrcA8MyNlCr3tR1xVOHRJk2F8NzFJ8H2MykBoN
        XUD/YubbadAGOk/hj5HMVDEMKucah54HR/uchJCXPep+MOuI6RLxaBo5QoYHpDOZe9WtMFr+xetN3
        YAQNXqVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOHps-0003rY-V5; Tue, 14 Apr 2020 09:26:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE805300483;
        Tue, 14 Apr 2020 11:26:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4A3F2BA1C56F; Tue, 14 Apr 2020 11:26:25 +0200 (CEST)
Date:   Tue, 14 Apr 2020 11:26:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next] sched/topology: use true, false for bool variable
Message-ID: <20200414092625.GI20713@hirez.programming.kicks-ass.net>
References: <1586779281-103078-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586779281-103078-1-git-send-email-zou_wei@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 08:01:21PM +0800, Zou Wei wrote:
> Fixes coccicheck warning:
> 
> kernel/sched/topology.c:224:3-22: WARNING: Assignment of 0/1 to bool variable
> kernel/sched/topology.c:226:3-22: WARNING: Assignment of 0/1 to bool variable

Please shoot that script, it's broken crap.
