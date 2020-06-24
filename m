Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A96C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D492082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYAgQBAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404431AbgFXQUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:20:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55144 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404629AbgFXQUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593015650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTk+ahRc101i1Z12o02Pn/Lbw1Hcg3yOCLs6DhRxr/k=;
        b=bYAgQBAXJ8FbWl+QKei0wVhxoRd2tiCS2RFZFu06As/KB6g6A5IyzqBvDG3wexqjoEvP4A
        SrZTFmonBuRHZAiUlfDOiOJ8NHMgnNl8vHzU3SA+fHMlwkPtcLHq+F4BJkri5wEzh7xbum
        GQxUsq/DOHYqtJ2P2kgOCmTRLVIGT+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-ThY8T8cUPayxc8t_ALuOXw-1; Wed, 24 Jun 2020 12:20:48 -0400
X-MC-Unique: ThY8T8cUPayxc8t_ALuOXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C68A61005512;
        Wed, 24 Jun 2020 16:20:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.207])
        by smtp.corp.redhat.com (Postfix) with SMTP id A74A619D61;
        Wed, 24 Jun 2020 16:20:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Jun 2020 18:20:45 +0200 (CEST)
Date:   Wed, 24 Jun 2020 18:20:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
Message-ID: <20200624162042.GA12238@redhat.com>
References: <20200624161142.GA12184@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624161142.GA12184@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24, Oleg Nesterov wrote:
> Suppose that 2 threads T1 and T2 call __lock_page_killable() and sleep in
> wait_on_page_bit_common() -> io_schedule().
>
> T1 is killed, it does test_and_set_bit_lock() but the page is still locked.
>
> unlock_page() calls __wake_up_common(nr_exclusive = 1), this wakes T1 up.
> T2 is not woken.

Ah, please ignore me, sorry for noise.

If T1 is killed it is TASK_RUNNING, try_to_wake_up() should return 0.

Oleg.

