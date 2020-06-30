Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E5DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDFE206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgiynQdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgF3GRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:17:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56597 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725845AbgF3GRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593497837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+RQ+qThaJtacs4jb/OrkWyGDybA1bqNRSM4ltwc1f0=;
        b=hgiynQdP5neWRwjjGg2IDq5JISZSrg4QPPRKnl5cpluxA24gr+H6FyMsXR6Fp8vEfBqc+V
        b4TAVfi47HCgzXnyQ4hcIaa3NsCKz5N5u3HhHSh+1wPPMFa/eceZ2gITSUMydApnfqRHaO
        bXXZXuv7wDRgLnFg27N27lCuijkS9fY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-8Nb0DMCcPDGBs07zBmvtCw-1; Tue, 30 Jun 2020 02:17:15 -0400
X-MC-Unique: 8Nb0DMCcPDGBs07zBmvtCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86695800D5C;
        Tue, 30 Jun 2020 06:17:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id A202B5C290;
        Tue, 30 Jun 2020 06:17:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Jun 2020 08:17:13 +0200 (CEST)
Date:   Tue, 30 Jun 2020 08:17:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
Message-ID: <20200630061708.GA21263@redhat.com>
References: <20200624161142.GA12184@redhat.com>
 <20200624162042.GA12238@redhat.com>
 <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
 <20200626154313.GI4817@hirez.programming.kicks-ass.net>
 <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
 <1593396958.ydiznwsuu8.astroid@bobo.none>
 <20200629140245.GB20323@redhat.com>
 <1593482844.k3rh7s05o8.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593482844.k3rh7s05o8.astroid@bobo.none>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30, Nicholas Piggin wrote:
> Excerpts from Oleg Nesterov's message of June 30, 2020 12:02 am:
> > On 06/29, Nicholas Piggin wrote:
> >>
> >> prepare_to_wait_event() has a pretty good pattern (and comment), I would
> >> favour using that (test the signal when inserting on the waitqueue).
> >>
> >> @@ -1133,6 +1133,15 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
> >>         for (;;) {
> >>                 spin_lock_irq(&q->lock);
> >>
> >> +               if (signal_pending_state(state, current)) {
> >> +                       /* Must not lose an exclusive wake up, see
> >> +                        * prepare_to_wait_event comment */
> >> +                       list_del_init(&wait->entry);
> >> +                       spin_unlock_irq(&q->lock);
> >> +                       ret = -EINTR;
> >
> > Basically this is what my patch in the 1st email does. But note that we can't
> > just set "ret = -EINTR" here, we will need to clear "ret" if test_and_set_bit()
> > below succeeds. That is why I used another "int intr" variable.
>
> You snipped off one more important line of context. No such games are
> required AFAIKS.

		for (;;) {
			spin_lock_irq(&q->lock);
	 
	+               if (signal_pending_state(state, current)) {
	+                       /* Must not lose an exclusive wake up, see
	+                        * prepare_to_wait_event comment */
	+                       list_del_init(&wait->entry);
	+                       spin_unlock_irq(&q->lock);
	+                       ret = -EINTR;
	+                       break;
	+               }


so wait_on_page_bit_common() just returns -EINTR if signal_pending_state() == T.
And this is wrong if "current" was already woken up by unlock_page().

That is why ___wait_event() checks the condition even if prepare_to_wait_event()
returns -EINTR. The comment in prepare_to_wait_event() tries to explain this.

Oleg.

