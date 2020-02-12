Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBFBC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DC3206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aAolVHgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBLPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:53:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34774 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBLPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I78sEJ8+ptaFjhSR0f/UOcUJHo+xxWDSJ6PGpnWy2jA=; b=aAolVHgx06P+LyOsg4e1QFeLQO
        pEH2ZkVZkDAChnLpn2F7UjN+8aAl5G5iLMiQho18nhIs5C3ZGq5tuvYmG8c2I36BjVtN0BGFuK9Et
        kQBtDgqYPw5vx1rbOIxjoq0PBuDYEDZsMfdpHeJTy3SrQUUd+1tJPQzhzVj+jxb+h5iRxhJzukjUb
        79+lHj+yHwA1dGqwDE7Y/Qum1Usy+OHYQsW3WL3F6iWSw/Y1WYShGh5+1yqVog6ZAWn4iYhOrPse0
        i0UE878SuDcL1wrmejG7Bjyts2pD1slBEeq6cn1lV8BCvfP6VXSuRr3870DAD4JsPXtxsHl3Cdr+L
        VZPgbRHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1uK7-0004NF-GR; Wed, 12 Feb 2020 15:53:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E41E300E0C;
        Wed, 12 Feb 2020 16:51:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C3EF203A89A7; Wed, 12 Feb 2020 16:53:09 +0100 (CET)
Date:   Wed, 12 Feb 2020 16:53:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de, Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/7] microblaze: Define SMP safe bit operations
Message-ID: <20200212155309.GA14973@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <6a052c943197ed33db09ad42877e8a2b7dad6b96.1581522136.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a052c943197ed33db09ad42877e8a2b7dad6b96.1581522136.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:42:25PM +0100, Michal Simek wrote:
> From: Stefan Asserhall <stefan.asserhall@xilinx.com>
> 
> For SMP based system there is a need to have proper bit operations.
> Microblaze is using exclusive load and store instructions.
> 
> Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

> +/*
> + * clear_bit doesn't imply a memory barrier
> + */
> +#define smp_mb__before_clear_bit()	smp_mb()
> +#define smp_mb__after_clear_bit()	smp_mb()

These macros no longer exist.

Also, might I draw your attention to:

  include/asm-generic/bitops/atomic.h

This being a ll/sc arch, I'm thinking that if you do your atomic_t
implementation right, the generic atomic bitop code should be near
optimal.
