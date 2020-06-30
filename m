Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD07C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A5C20702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk+hSYy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733143AbgF3LvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:51:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56281 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729580AbgF3LvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593517860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G2YfZH1ESDw+jmzMPbDA3YjibeflgPdo6tDmDkWPdHY=;
        b=fk+hSYy44gDbyqAKr6mBM8Rw4WodxPc1xC/Z4bQMuSRjuZEhnrH0Fpl/dMKBduPsqPhmUN
        7nd80xnFVqSH7V+mwgnRw1IkVlnI3H7GrI1HGxVMSQHHgbd1YqIyTl7A4zDtdoQT/CMT8C
        PGH8TTVxkUKUbm5BouCex3XYxFf9iks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-drGYxaB9Moel-2KMcbLvQg-1; Tue, 30 Jun 2020 07:50:58 -0400
X-MC-Unique: drGYxaB9Moel-2KMcbLvQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FCA719200C1;
        Tue, 30 Jun 2020 11:50:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.229])
        by smtp.corp.redhat.com (Postfix) with SMTP id D0CF05C1C5;
        Tue, 30 Jun 2020 11:50:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Jun 2020 13:50:56 +0200 (CEST)
Date:   Tue, 30 Jun 2020 13:50:53 +0200
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
Message-ID: <20200630115052.GD23871@redhat.com>
References: <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
 <20200626154313.GI4817@hirez.programming.kicks-ass.net>
 <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
 <1593396958.ydiznwsuu8.astroid@bobo.none>
 <20200629140245.GB20323@redhat.com>
 <1593482844.k3rh7s05o8.astroid@bobo.none>
 <20200630061708.GA21263@redhat.com>
 <1593505946.t0nxq8q8kj.astroid@bobo.none>
 <20200630105354.GB23871@redhat.com>
 <20200630113637.GC23871@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630113637.GC23871@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30, Oleg Nesterov wrote:
>
> may be someting like this

or this ...

	for (;;) {
		int intr = 0;

		spin_lock_irq(&q->lock);
		if (signal_pending_state(state, current)) {
			/* see the comment in prepare_to_wait_event() */
			list_del_init(&wait->entry);
			intr = 1;
		} else {
			if (likely(list_empty(&wait->entry))) {
				__add_wait_queue_entry_tail(q, wait);
				SetPageWaiters(page);
			}
			set_current_state(state);
		}
		spin_unlock_irq(&q->lock);

		bit_is_set = test_bit(bit_nr, &page->flags);
		if (behavior == DROP)
			put_page(page);

		if (!bit_is_set) {
			if (behavior != EXCLUSIVE)
				break;
			if (!test_and_set_bit_lock(bit_nr, &page->flags))
				break;
		}

		if (intr) {
			ret = -EINTR;
			break;
		}

		io_schedule();

		if (behavior == DROP) {
			/*
			 * We can no longer safely access page->flags:
			 * even if CONFIG_MEMORY_HOTREMOVE is not enabled,
			 * there is a risk of waiting forever on a page reused
			 * for something that keeps it locked indefinitely.
			 * But best check for -EINTR before breaking.
			 */
			if (signal_pending_state(state, current))
				ret = -EINTR;
			break;
		}
	}

Oleg.

