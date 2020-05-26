Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C847CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4733207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cHOx5G+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390056AbgEZT4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389442AbgEZT4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:56:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B07BC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4mg12U4fZfWWKSxX7s1XyiI8EaUXhtofn/a97kc9q8=; b=cHOx5G+kPvNaBLGQnq5ltqXfmT
        uDI/en9u0J07hTA2Hcai4XZGAH2qTK4xBCgVqIy1mjt8CyOgUwBf6/gb/tmPXGUGE5cr24oei4bik
        TQ/Hai5meajkcUqqvWs+TgKxe6KFLzBdchy8wDNr2RX+h28PXTBzxGhjmww0lijnz97l/7THEl6W+
        I6wPFq9S0ZVuy1/hicrYglAqKhrLrfWeYUYxRuvZgG27DAKqqkRv7FwzkbZ1NgCT5a+ust6haO0lO
        9VWhM1DP+gbhKTY1BqnLk0aEezEpf4M5ChGdYB7+ykvsZXUw6TjOIzgqE9igmrrj2COPjf3t6tp8E
        NLPWUWeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdfge-0007NQ-3E; Tue, 26 May 2020 19:56:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C5F5300478;
        Tue, 26 May 2020 21:56:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 218E22BBAA8F8; Tue, 26 May 2020 21:56:30 +0200 (CEST)
Date:   Tue, 26 May 2020 21:56:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Increase MAX_LOCKDEP_ENTRIES by half
Message-ID: <20200526195630.GF325280@hirez.programming.kicks-ass.net>
References: <20200526174349.8312-1-longman@redhat.com>
 <20200526185850.GE991@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526185850.GE991@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:58:50PM -0400, Qian Cai wrote:

> I still don't understand why reading all sysfs files on this system
> could increase that much, but here is the lockdep file after
> running sysfs read to see if you could spot anything obviously,
> 
> https://cailca.github.io/files/lockdep.txt

00000000f011a2a5 OPS:      20 FD:   45 BD:    1 .+.+: kn->active#834

is that somewhere near the number of CPUs you have?

Anyway, there's very long "kn->active#..." chains in there, which seems
to suggest some annotation is all sorts of buggered.
