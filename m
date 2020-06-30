Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E49FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747672073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHFSgG54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbgF3KyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:54:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729377AbgF3KyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593514447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G4bVBTJM9ZL7UUtLFxlQYgchfUUyg3SPUtd0RzryWjg=;
        b=jHFSgG54JlJhX216P53DPjawLlK47a+KoDUw7XLUp/PyUrX9XADCY0d+1Zpq+5o9WyyBSZ
        WBawNhClMt0K1ExsWqSwjJwmdSR+I3dUQQjJKvVU5Pe3D6njTIBzCpbg3wvoa+vrPrauao
        aeFv5qqdxUJJMtbAAW96+ZKuNl274rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-gCD4jmLUMBmpjZctxH1XUA-1; Tue, 30 Jun 2020 06:54:03 -0400
X-MC-Unique: gCD4jmLUMBmpjZctxH1XUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FAC2107ACCA;
        Tue, 30 Jun 2020 10:54:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.229])
        by smtp.corp.redhat.com (Postfix) with SMTP id B0E6D2B472;
        Tue, 30 Jun 2020 10:53:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Jun 2020 12:54:01 +0200 (CEST)
Date:   Tue, 30 Jun 2020 12:53:55 +0200
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
Message-ID: <20200630105354.GB23871@redhat.com>
References: <20200624161142.GA12184@redhat.com>
 <20200624162042.GA12238@redhat.com>
 <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
 <20200626154313.GI4817@hirez.programming.kicks-ass.net>
 <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
 <1593396958.ydiznwsuu8.astroid@bobo.none>
 <20200629140245.GB20323@redhat.com>
 <1593482844.k3rh7s05o8.astroid@bobo.none>
 <20200630061708.GA21263@redhat.com>
 <1593505946.t0nxq8q8kj.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593505946.t0nxq8q8kj.astroid@bobo.none>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30, Nicholas Piggin wrote:
>
> My patch is what actually introduced this ugly
> bit test, but do we even need it at all? If we do then it's
> under-commented, I can't see it wouldn't be racy though. Can we just
> get rid of it entirely?

But then we will need to move io_schedule() down, after test_and_set_bit().
And we will have the same problem with task->state != RUNNING. Plus more
complications with "behavior == DROP".

Oleg.

