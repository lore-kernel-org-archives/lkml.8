Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F3CC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7E220674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vxwCAsrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgBDPmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:42:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBDPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EbEGOeP5qZeH1FznwM60dtjG3y2n99NGAdinrR8oUl8=; b=vxwCAsrt0T14o/pBIENd3rkIHc
        x+EyClFMGMLBdEcQzMvEypMsg0/hydLrBl9j6cIAZ6iUsCvIxjpbtcseX4zhszncH2b85lnkpzpFf
        U8xu9wg1/otQ8LF/EFKj3udS0oJTPjsyifnsEpnLdVqnlOCLYdfquo8xaTNcnKSQh4bsSGhCCr2N7
        sbprhW0EBuU8AUf1YMCGL5kyf8CvKvBE6AonUFjDlUZr00bKZ147awd9iEY99Qzy3DCMo2LyZQohn
        odKFWUAJ77Lxu86Su/+bKsduLfDPt1NexLgiSbJHOEBhMDaobkBL9pMnQX+uH891TgqqnIhO1ryO7
        Q52kE8cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iz0LX-0007cd-4X; Tue, 04 Feb 2020 15:42:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AE4A304C21;
        Tue,  4 Feb 2020 16:40:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F82B2B49E53A; Tue,  4 Feb 2020 16:42:36 +0100 (CET)
Date:   Tue, 4 Feb 2020 16:42:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200204154236.GE14879@hirez.programming.kicks-ass.net>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203164147.17990-7-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 11:41:46AM -0500, Waiman Long wrote:
> +	/*
> +	 * We require a minimum of 2 (u16) entries to encode a freelist
> +	 * 'pointer'.
> +	 */
> +	req = max(req, 2);


Would something simple like the below not avoid that whole 1 entry
'chain' nonsense?

It boots and passes the selftests, so it must be perfect :-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3163,7 +3163,7 @@ static int validate_chain(struct task_st
 	 * (If lookup_chain_cache_add() return with 1 it acquires
 	 * graph_lock for us)
 	 */
-	if (!hlock->trylock && hlock->check &&
+	if (!chain_head && !hlock->trylock && hlock->check &&
 	    lookup_chain_cache_add(curr, hlock, chain_key)) {
 		/*
 		 * Check whether last held lock:
