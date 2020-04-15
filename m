Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A122C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF39A21734
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OP0JQBSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409075AbgDOLoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897427AbgDOLl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:41:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8549C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lApmsTY3DbCgBeKnA8O+HpWuoSZ/POP3KyPMIcSKnIc=; b=OP0JQBSweEKaYNeyead3UT/x3T
        zovFgpBEpoL30IUAKLbIGXuqEgBNlODw2FVU0zOuJN88psxgfV02p6ymo/A9AcbRvSS7084Z2dY84
        VEOLdWaf5UFbxMoIJQDot09vnCPGq3jeeftAlik9cqZEV+7l85LPkbAwcFTaTqi6LaUzwVQmE3Gxx
        0IvcA8v3f4i/Bgl1TLCf2vJwHq0SJMOjMd2tviPV+U9v3isilv/VhmCiHPvDE94Y6KdLwfGFqkFwV
        maJDRCd6tgEVaFh6Lhsr+KhobWAjpMMAwdh7OIE4LMdPYvSDuacBai9ZGZwfMegf8fGFLTFj6jFXh
        QR09KK9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOgQW-0007ly-LG; Wed, 15 Apr 2020 11:41:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F187A304D2B;
        Wed, 15 Apr 2020 13:41:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9875D2038BC5A; Wed, 15 Apr 2020 13:41:54 +0200 (CEST)
Date:   Wed, 15 Apr 2020 13:41:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Will Deacon <will@kernel.org>, mingo@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] seqlock: Use while instead of if+goto in
 __read_seqcount_begin
Message-ID: <20200415114154.GF20730@hirez.programming.kicks-ass.net>
References: <20200409134558.90863-1-songmuchun@bytedance.com>
 <20200410115658.GB24814@willie-the-truck>
 <20200414110516.GO20713@hirez.programming.kicks-ass.net>
 <CAMZfGtWk+gG7Z2bOy_bq=XnuuSJzic16zpeajhJiiekpJEFrFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWk+gG7Z2bOy_bq=XnuuSJzic16zpeajhJiiekpJEFrFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:01:06PM +0800, Muchun Song wrote:
> On Tue, Apr 14, 2020 at 7:05 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > .... That said,
> > Will, would it make sense to use smp_cond_load_relaxed() here ?
> 
> I have a similar idea. Would it make sense to use smp_cond_load_acquire()
> in raw_read_seqcount_begin()?

Not sure; I did consider it, but that rmb it has seems more natural in
the over-all ordering scheme here. I mean:

	load seqcount		inc seqcount
	rmb			wmb
	// load stuff		// modify stuff
	rmb			wmb
	compare seqcount	inc seqcount

is nice and symmetric, making that upper left rmb an acquire 'works' but
is just weird IMO. And I suppose you can make the lower right wmb a
store-release, which is somewhat better, but then it gets all weird when
you consider things like barrier and latch.

So best to just leave it as is I think.

Those incs do seem to be really wanting a WRITE_ONCE() though.
