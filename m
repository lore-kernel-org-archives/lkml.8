Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21ABC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90442076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="huOywNO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDWJX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:23:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84767C03C1AF;
        Thu, 23 Apr 2020 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wSczomJfGQBW2henWhZVVO4Oy56D/opsLQ1kvUxuKsA=; b=huOywNO4EwZNUmQYmCNW9ackGa
        pynSho+JFOEC3v90M9YBjSU3jJeFzck36IXLCPBzoc2K7TipFfroiQADoCilSrhPKTopODTDz+M7G
        hGHmO6eaEUK2+Ea2IZGJQ2/vhg8z/eUsAAcjSrXkAdF1vZqG20wewe+W2L5NCA2oCnIyDB8evUUOu
        1YE1o9ct1xsoIB3Rz9EkcT8+8esQilAWROqEEqcQZTaJwgeR5nRsVbWdxOIyBP8wQ5rFHBRcHlznT
        plfccN/8L5jGy3At/rOypMx/Gf2WQat++ejIzGP3SuRjfOKCe7MgkRZAZzl3XmtqDL4YbhLcfutUz
        PCbSPGDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRY4i-0007WP-DB; Thu, 23 Apr 2020 09:23:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D863530477A;
        Thu, 23 Apr 2020 11:23:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE80E20C02CD2; Thu, 23 Apr 2020 11:23:14 +0200 (CEST)
Date:   Thu, 23 Apr 2020 11:23:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, pbonzini@redhat.com, bigeasy@linutronix.de,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        will@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/5] rcuwait: Introduce prepare_to and finish_rcuwait
Message-ID: <20200423092314.GQ20730@hirez.programming.kicks-ass.net>
References: <20200422040739.18601-1-dave@stgolabs.net>
 <20200422040739.18601-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422040739.18601-4-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:07:37PM -0700, Davidlohr Bueso wrote:

> +static inline void prepare_to_rcuwait(struct rcuwait *w)
> +{
> +	rcu_assign_pointer(w->task, current);
> +}
> +
> +static inline void finish_rcuwait(struct rcuwait *w)
> +{
> +	WRITE_ONCE(w->task, NULL);

I think that wants to be:

	rcu_assign_pointer(w->task, NULL);

There is a special case in rcu_assign_pointer() that looses the barrier,
but it will keep the __rcu sparse people happy. That is w->task is
__rcu, and WRITE_ONCE ignores that etc.. blah.

The alternative is using RCU_INIT_POINTER() I suppose.

> +	__set_current_state(TASK_RUNNING);
> +}
