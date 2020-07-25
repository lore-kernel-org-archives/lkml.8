Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1488C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8509C206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpqjVj1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgGYT2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:28:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28250 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726381AbgGYT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595705282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4b8xOE1a+SCo8hP5TdzZ/KYctFwKJKu7PER0hCduYU=;
        b=JpqjVj1NbLi1j2yZoeqWUY6JUrBbiC9KzZU/dZQcTI/91qXn02X7KowlTlnBY5H5H3Fn7n
        hbDFCVXb6PeB7f3+SDR3NVPlLpWGQkncCfjx/nL3N9aA4z4qs77SwuUdZZPgO7NJmy+nKb
        vMkTgEmVaR/dxAV3lEGh3O3rjvItgds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-OtXHO55vMHqSr1UcLHQKag-1; Sat, 25 Jul 2020 15:27:58 -0400
X-MC-Unique: OtXHO55vMHqSr1UcLHQKag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C47C185BDF9;
        Sat, 25 Jul 2020 19:27:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id 111741C4;
        Sat, 25 Jul 2020 19:27:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 25 Jul 2020 21:27:56 +0200 (CEST)
Date:   Sat, 25 Jul 2020 21:27:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200725192753.GA21962@redhat.com>
References: <20200723124749.GA7428@redhat.com>
 <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils>
 <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com>
 <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, to avoid the confusion, let me repeat I think your patch is fine.

I too thought that non-exclusive waiters do not care about the bit state
and thus wake_page_function() can simply wake them all up.

But then I did "git blame", found your commit 3510ca20ece0150 and came to
conclusion there are reasons we should not do this.

On 07/25, Linus Torvalds wrote:
>
> On Sat, Jul 25, 2020 at 3:14 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > In essense, this partly reverts your commit 3510ca20ece0150
> > ("Minor page waitqueue cleanups"). I mean this part:
>
> Well, no. I mean, it keeps the "always add to the fail" behavior.

Ah, sorry for confusion, this doesn't matter. I didn't mean "fairness".

What I tried to say. AFAICS before that commit we had (almost) the same
behaviour you propose now: unlock_page/etc wakes all the non-exclusive
waiters up.

No?

Or I misunderstood your reply? Quite possibly, too late for me...

Oleg.

