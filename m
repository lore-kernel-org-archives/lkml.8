Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68D7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E982076D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SbEXpDhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHRLcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHRL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:28:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF341C061346
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HO5PlampxTqwJn0Jy4EZPXa1kiqA52/6XkjW420QRZU=; b=SbEXpDhDzaNpYq4EJwAosM8+fT
        1s4XoBOeHs95l3T9nLQ3hQXHPt9jWIUQVeFj37JghhvcGtZ//9lurLyP62wi5qhk7GZZIYHjkmo6j
        VjMKFeGQtrbGHLKdEktWN9ouPBJ8mcpPbTbKOXH068kDQigFZao6tOLtjlvL0gsMz5o8ivjPiHZPa
        Bx2yVBwEhxOguQZqo+zXRLkPssoOS/J7VcGhu+vxvYsL0HtSlmAexT0KQC+LETWsmbFKmd+sjmkdM
        Og9JlBaWROQqj7AKgEzz8zXSjt9ah5tv4EAnKnhIzlF7R3+8tN89fGLQqwWNAaLZ/9j/bQ4cc16gL
        42fIcDHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7zmP-0002AM-BK; Tue, 18 Aug 2020 11:27:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99843305E21;
        Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 51F69200D4C35; Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Message-ID: <20200818105102.926463950@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 12:51:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [PATCH v2 00/10] smp: irq_work / smp_call_function rework
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a new version of the irq_work / smp_call_function integration / cleanup.

I'm thinking the first (5?) patches should be ready to go in, all the
dependents (i915, block) landed this merge window.

The rest attempts to 'fix' smp_call_function_single_async() while migrating a
number of performance sensitive users over to a new (fairly crap by
requirements) interface.

But by getting 'rid' of those smp_call_function_single_async() users, we can
'fix' that interface.

I'm still not entirely happy with the end result. Suggestions?



