Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51714C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09558206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YL/XZaPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390855AbgDCPq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:46:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgDCPq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jumPZeY2/s1i3k4de+rl5jCcLuzdcZov7AWLXx3FDSY=; b=YL/XZaPn6ibQbSO45trkFn4k4b
        KQAHKRXBwXSwkr9Oa1oh4p10NBFp1XMl3TTyPxH9Vb7n5e0zpffrw0MDgFS7jGf5dr9AMZjID3XXL
        jSAxOytsZxCEU3QoMPMbXF60FTRV0+hmezAEozQ8w1mKezNfR4Spqt540nL+dRzvl/yeUusoYvm2i
        v0tNp6a5kwKq+gQQliBmMAhycxhZJZsPubGkyot/8z9O0kjO26+ZeDTUJaSiYru67mRohoX9Jc84M
        PcHDedxY33W+qVhNpUcjkPij0lCPyZqQ94Y1cQN3UjChHx7FoKET/OQi9H/6rPMMiRTPyfn1S+dWL
        I/ntTCDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKOWU-0002tW-Nk; Fri, 03 Apr 2020 15:46:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 598C73010BC;
        Fri,  3 Apr 2020 17:46:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AD512B12426C; Fri,  3 Apr 2020 17:46:20 +0200 (CEST)
Date:   Fri, 3 Apr 2020 17:46:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200403154620.GS20730@hirez.programming.kicks-ass.net>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403151757.lhhia7pzqptvlqz5@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
> Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
> work here?

Yes, it would.
