Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B827C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7416E20708
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sr/jic7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgA2Stp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:49:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgA2Stp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KUyQBoXhEovxNfF4eKqrkEbw0GAhd/ZaP73j2VawXbg=; b=sr/jic7XwIUCAb9Yov3R6yWJE
        fht2fWtsFqeDcJKhtdq/x0dZFk2IYPs7jmVXtwDLbH4Vxq4h/BdnO2mMywRD//nscDUXtfkLLex0u
        rFAN465ynySb1AMEJO6v7LGFzg0klNKhIw4RzCTUMZh1D+LPcPL8bWW4X8LyiDoW04dhqx6tcY09Z
        8JcKEl5IRM4+ZDSUviHof0rjAe7yz2cfWkh66J6k4MhEhQ9tz119EAlqkr798g5iaBN6wXZTjFNZL
        Y6BCwObZx9vnanOuGcIshOpHej8PnQvimGAQXdqEaZPDAWh5i/S7BpumCTqyp3anwvw3BPdNCk713
        nfCEs0qLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwsPB-00028n-UZ; Wed, 29 Jan 2020 18:49:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 178F33035D4;
        Wed, 29 Jan 2020 19:47:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F082D2B7A8620; Wed, 29 Jan 2020 19:49:35 +0100 (CET)
Date:   Wed, 29 Jan 2020 19:49:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200129184935.GU14879@hirez.programming.kicks-ass.net>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net>
 <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
 <20200128165655.GM14914@hirez.programming.kicks-ass.net>
 <20200129002253.GT2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129002253.GT2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 04:22:53PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 28, 2020 at 05:56:55PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 28, 2020 at 12:46:26PM +0100, Marco Elver wrote:
> > 
> > > > Marco, any thought on improving KCSAN for this to reduce the false
> > > > positives?
> > > 
> > > Define 'false positive'.
> > 
> > I'll use it where the code as written is correct while the tool
> > complains about it.
> 
> I could be wrong, but I would guess that Marco is looking for something
> a little less subjective and a little more specific.  ;-)

How is that either? If any valid translation by a compile results in
correct functionality, yet the tool complains, then surely we can speak
of a objective fact.
