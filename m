Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A88C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572D92073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRadJU/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404601AbgFXQn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:43:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24745 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404017AbgFXQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593017007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4iPSMGB25Bj2G0S058u+Dz0Mpvqx1zj5oFOceaGBnDM=;
        b=HRadJU/RfCUCH8aNWZ0g8tWpx+BrxHSv8tqipUaOiJ3PsHUnHY0yw17KC38TOmaQHI981w
        FmR65xhmqHw1IU0VH9DF8E3NgDIGvPObYZvahVeQ4dDv1AIR5v/YdDsSTe8tUdhl3PApCA
        oADJvTm48wzSyAffwR5zq0/Cucz5lQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-eLgneqeHORqTerA3U3RDTw-1; Wed, 24 Jun 2020 12:43:25 -0400
X-MC-Unique: eLgneqeHORqTerA3U3RDTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06FB61005512;
        Wed, 24 Jun 2020 16:43:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.207])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D1025D9DC;
        Wed, 24 Jun 2020 16:43:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Jun 2020 18:43:23 +0200 (CEST)
Date:   Wed, 24 Jun 2020 18:43:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
Message-ID: <20200624164319.GA12203@redhat.com>
References: <20200624161142.GA12184@redhat.com>
 <CAHk-=wjqnKdrjZx0kO+f1vyFQFcb-HZsbHFw6_jAeuQmNsTsbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjqnKdrjZx0kO+f1vyFQFcb-HZsbHFw6_jAeuQmNsTsbQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24, Linus Torvalds wrote:
>
> That said, I'm not entirely happy with your patch.

Neither me,

> The real problem, I feel, is that
>
>                 if (likely(bit_is_set))
>                         io_schedule();
>
> anti-pattern. Without that, we wouldn't have the bug.
>
> Normally, we'd be TASK_RUNNING in this sequence, but because we might
> skip io_schedule(), we can still be in a "sleeping" state here and be
> "woken up" between that bit setting and the signal check.

Ah.

And now it _seems_ to me that even if io_schedule() is called
try_to_wake_up() can "falsely" succed if signal_pending_state() is true,
even if __schedule() won't block in this case.

But I am sure I missed something else. I spent to much time reading the
random code paths today, I'll return tomorrow.

Oleg.

