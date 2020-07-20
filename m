Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BE7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21FA2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fr2uojTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGTIlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:41:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q7H8FhLFAWwenVaWoaULPDjpconR6IkD92nyts4yKVU=; b=Fr2uojTEhUZfwR7jKyuXuTVajc
        xK+lrm8l8kqREEwn+X9PxXcQqNfWBt+B3cYfNZzqrOvM9ILI7FSw+r9nIu7WwRr9vybDpj/ZXDxKr
        ywRW95Iac4x7Anzm8BGj0D8lRWb+gSw7M2Z/apnwlTp91JbjxGrOlLD/h7TphzFfRWV8N9dy0F0oE
        rvAk/hzgrwQ2c/m31mUIjLlM2bszkbcBTN8Qg8tMGjaL5520sl8hTmOcHpMcMbnRpSdVgMuQEo3yc
        +t9gGZjqo4CyrSjyhkgGoX281Ux3rRT/1Ee8gMyNEdFeGxxQZLn84/W2ogzeSZv0cUhjIT/1VJ8sA
        p8uOmw+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxRMF-0007Kv-5p; Mon, 20 Jul 2020 08:41:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 782453010C8;
        Mon, 20 Jul 2020 10:41:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 444732129EDD8; Mon, 20 Jul 2020 10:41:06 +0200 (CEST)
Date:   Mon, 20 Jul 2020 10:41:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720082657.GC6612@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:26:58AM +0200, Oleg Nesterov wrote:
> Peter,
> 
> Let me add another note. TASK_TRACED/TASK_STOPPED was always protected by
> ->siglock. In particular, ttwu(__TASK_TRACED) must be always called with
> ->siglock held. That is why ptrace_freeze_traced() assumes it can safely
> do s/TASK_TRACED/__TASK_TRACED/ under spin_lock(siglock).
> 
> Can this change race with
> 
> 		if (signal_pending_state(prev->state, prev)) {
> 			prev->state = TASK_RUNNING;
> 		}
> 
> in __schedule() ? Hopefully not, signal-state is protected by siglock too.
> 
> So I think this logic was correct even if it doesn't look nice. But "doesn't
> look nice" is true for the whole ptrace code ;)

*groan*... another bit of obscure magic :-(

let me go try and wake up and figure out how best to deal with this.
