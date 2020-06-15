Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D289CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9753E20707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RpLFBYYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbgFOSdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:33:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39078C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9U2E2WaS+S1jCvMfX0bEl4HRXYMqK3fD1PXTOMCvK7c=; b=RpLFBYYHn3X5f7Y7ZqsnVDJzIp
        PURE4HitpvPnNSpC12F4Nn3oddvfL56xMevVqbQ6d4IUimfIn5ftjqjuHnjrxoby+y+x5R6/urd98
        vLSCTnKIwXjl/SVbV6ED6wD8G/YlzLVdUdTY7xDFJfOKu/i7b9QoAcM5l0ADvNvnKZDMHKny7oNR6
        m54WvDGmvUmiIC1RRqmw8nFIJo2//hKH5QBWyM6UHxVVgGU9+bOcA3RNCMs4PGEa3SjAKZVQ8+KW0
        PaaB27evNzfkNalnejdF68fjIxDs9iX9itVI8IVgu9Yy7YcYhh3rXj8Po6dfzwMbabUAbCQ2VhdPI
        HPGlTxWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jktvD-0005ER-Kk; Mon, 15 Jun 2020 18:33:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C42903010C8;
        Mon, 15 Jun 2020 20:33:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF8C8203B815D; Mon, 15 Jun 2020 20:33:25 +0200 (CEST)
Date:   Mon, 15 Jun 2020 20:33:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200615183325.GF2531@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
 <20200615155513.GG2554@hirez.programming.kicks-ass.net>
 <20200615162427.GI2554@hirez.programming.kicks-ass.net>
 <20200615171404.GI2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615171404.GI2723@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:14:04AM -0700, Paul E. McKenney wrote:

> This merge window has been quite the trainwreck, hasn't it?  :-/

Keeps life interesting I suppose..
