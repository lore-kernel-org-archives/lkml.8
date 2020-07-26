Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5B8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9DC206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFXeLsb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGZN5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 09:57:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbgGZN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 09:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595771833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6baPv1PbnRySH8ZZBtT2emXkXeca9+Q0TLzoLgXvgU=;
        b=JFXeLsb44k4hfM8EDy+JwxkZOnQZ+XyNmrFSGO6lqbRPnllVhfB/BQY+u+54LLL2DypMgA
        cVDn8sj3wQEB5yOFMN6pBpObX9kr6bIaVyCvmbYT3tX7QWSnSTWWSNjDCmR4sdqywXeSdp
        PT6ByFX13fqUTr4faEnEwu2n0TVi5aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-46pJdSpAMDq1mY3u6zwuaQ-1; Sun, 26 Jul 2020 09:57:10 -0400
X-MC-Unique: 46pJdSpAMDq1mY3u6zwuaQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42E7C59;
        Sun, 26 Jul 2020 13:57:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.29])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1F4015F1E8;
        Sun, 26 Jul 2020 13:57:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 26 Jul 2020 15:57:08 +0200 (CEST)
Date:   Sun, 26 Jul 2020 15:57:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200726135705.GA14017@redhat.com>
References: <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils>
 <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com>
 <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <20200725192753.GA21962@redhat.com>
 <CAHk-=wgpdbxaWWxOeVeA-eTex6QcSZLK9S2=eSv6KbQdPapfug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgpdbxaWWxOeVeA-eTex6QcSZLK9S2=eSv6KbQdPapfug@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I was greatly confused and tried to confuse you.

Somehow I misunderstood your last version and didn't bother to read it
again until now.

Sorry for noise and thanks for your explanations.

Oleg.


On 07/25, Linus Torvalds wrote:
>
> On Sat, Jul 25, 2020 at 12:28 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > What I tried to say. AFAICS before that commit we had (almost) the same
> > behaviour you propose now: unlock_page/etc wakes all the non-exclusive
> > waiters up.
> >
> > No?
>
> Yes, but no.
>
> We'd wake them _up_ fairly aggressively, but then they'd be caught on
> the bit being set again by the exclusive locker (that we also woke
> up).
>
> So they'd get woken up, and then go to sleep again.
>
> So the new behavior wakes things up more aggressively (but a different
> way), but not by letting them go out of order and early, but simply by
> not going back to sleep again.
>
> So the "wake up more" is very different - now it's about not going to
> sleep again, rather than by ordering the wakeup queue.
>
> We _could_ order the wakeup queue too, and put all non-exclusive
> weiters at the head again. And make it *really* aggressive.
>
> But since one of ourissues has been "latency of walking the wait
> queue", I'm not sure we want that. interspesing any blocking waiters -
> and stopping the waitqueue walking as a result - might be better under
> load.
>
> Wild handwaving. We could try it, but IO think that really would be a
> separate "try this out" patch.
>
> Right now, I think my patch will likely make for _better_ latencies
> for everything.
>
> Lower latency of non-exclusive waiters (because not going back to
> sleep), but also lower latency of walking the wait queue (because
> fewer entries, hopefully, and also less contention due to the "not
> going back to sleep" noise)
>
>            Linus
>

