Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24408C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E178E2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tAUIgGL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgEVQfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:35:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44200 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgEVQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yorX4qD+MAY7UFaM6AiNcUEHYEEJIru/3ydP8+Kx9yI=; b=tAUIgGL/baSjJdIjHLfWRowaxD
        dYNL3guBgj/n3sIzew9mHyCrcUTVm4DIUYpIH+ycSG1Qpw7ZWZhu5kQ08TQdp95Uy97HEElrtIw2b
        QqySyUP4sSBdmR0U4piBy1/cTpCg6j8GDwBdiu03qpOqELZ3e2PF0B2UiqXVf7fu2Eakt/FT9dJ7I
        PpXnFnS7jfwaQeUj7M6DHrxXEhbB/J/IuFO70z12PmUUCN+hd4Bxvhdj0IRGcb8xQK/K0vPlDMug7
        Gnwpn7/+bDV3DAJq1Kr5B8ppkLByuxgw8HuoQ99zvqMSkH/dFd7sq4gyzit8pnrYWFFtFboR3pRus
        C6qk6DcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcAdW-0006DM-Dt; Fri, 22 May 2020 16:35:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC50E306368;
        Fri, 22 May 2020 18:35:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C75A520B5D17E; Fri, 22 May 2020 18:35:04 +0200 (CEST)
Date:   Fri, 22 May 2020 18:35:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     sumit.garg@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, patches@linaro.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 2/2] locking/spinlock/debug: Add checks for kgdb trap
 safety
Message-ID: <20200522163504.GX317569@hirez.programming.kicks-ass.net>
References: <20200522145510.2109799-1-daniel.thompson@linaro.org>
 <20200522145510.2109799-3-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522145510.2109799-3-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 03:55:10PM +0100, Daniel Thompson wrote:
> In general it is not safe to call spin_lock() whilst executing in the
> kgdb trap handler. The trap can be entered from all sorts of execution
> context (NMI, IRQ, irqs disabled, etc) and the kgdb/kdb needs to be
> as resillient as possible.
> 
> Currently it is difficult to spot mistakes in the kgdb/kdb logic
> (especially so for kdb because it uses more kernel features than
> pure-kgdb). Let's provide a means to bring attention to deadlock
> risks in the debug code.

I really dislike this thing. Also, commit:

  f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions")

should be able to trigger here when the kgdb traps are marked as NMI.
x86 will soon have that.
