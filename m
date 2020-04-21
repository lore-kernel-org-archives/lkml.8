Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30AFC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE15206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JsuqJaG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgDURQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbgDURQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:16:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE17C061A41;
        Tue, 21 Apr 2020 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=25trWX6WEnBP45ZCKj9I9u577utZjAybZI5wPJusmTQ=; b=JsuqJaG0t9Ueemdh2TossAsFXC
        Enrc7icqmuLeubDIWEaAT8FC8ETFfjzIlJOEAILBdsTGMbDcu60kY/dRzNlHkaNQNapU/WhlLsI3W
        SXMGRUIjSNAmO/5V8lpbJLl/PP765eLZhsRsTy62aL+ultW7JRjuzfm1AvUK4S6QhqngrKZN+aWyy
        oIbCtOi5vkohLY+qd3CdwTjwSa85Fqb9xkFdAz1xq++dGUb3WLzczuYGzJGRg5cHuWoHRliDDuqwq
        Ls9bYiHbS7DZacH/jygXDL7msouWmqPaKftbzP0qznzzEsDberPVYswJU3L6+GgFpZPNtatL+MhJq
        OSsK/Fkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQwVl-00077n-1R; Tue, 21 Apr 2020 17:16:41 +0000
Date:   Tue, 21 Apr 2020 10:16:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Zhenyu Ye <yezhenyu2@huawei.com>, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiexiangyou@huawei.com, zhangshaokun@hisilicon.com,
        linux-mm@kvack.org, arm@kernel.org, prime.zeng@hisilicon.com,
        kuhn.chenqun@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/6] arm64: Detect the ARMv8.4 TTL feature
Message-ID: <20200421171641.GA25391@infradead.org>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-2-yezhenyu2@huawei.com>
 <20200421165346.GA11171@infradead.org>
 <20200421171328.GW20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421171328.GW20730@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:13:28PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 21, 2020 at 09:53:46AM -0700, Christoph Hellwig wrote:
> > On Fri, Apr 03, 2020 at 05:00:43PM +0800, Zhenyu Ye wrote:
> > > From: Marc Zyngier <maz@kernel.org>
> > > 
> > > In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> > > feature allows TLBs to be issued with a level allowing for quicker
> > > invalidation.
> > 
> > What does "issued with a level" mean?
> 
> What I understood it to be is page-size based on page-table hierarchy.
> Just like we have on x86, 4k, 2m, 1g etc..
> 
> So where x86 INVLPG will tear down any sized page for the address given,
> you can now day, kill me the PMD level translation for @addr.
> 
> Power9 radix also has things like this.

Maybe this needs to be spelled out a little more?  The current commit
log sounds like paper generated by a neural network.
