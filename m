Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB7C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FD82070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585085640;
	bh=YSucMrRxtrynGJ/g9tDph2k08nv6kh3kh3Hl7TdUQPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UE7nkJZcDgwPjVYgmEyNG6H2HB9LM9Iek0dochADfgRGj5einAgVe47NwyW9EQbQ5
	 ZIYP45ZngOPo4DVGn84Pc5m4ZkjE6bN2qjBDWQ+4zfsj6OY83Qn0oKRz9D8m04Xh4a
	 2b3Bjyetzwi+k5SkHbWTJWpVM5r1QetNsx8B+oyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgCXVd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgCXVd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:33:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41043206F6;
        Tue, 24 Mar 2020 21:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585085638;
        bh=YSucMrRxtrynGJ/g9tDph2k08nv6kh3kh3Hl7TdUQPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXKz/8wy8p4KltD7XQjmmy52F9817kzLNOiw4klkv30Lpg690Ck3BR5pWPmOXvYTT
         65/iPl6FiQNrWy8nDWzCtOh2lHQ2VCBp4DyOQADo7k+1qlTqsStcT0HN3HVZNR7MfY
         HZQqGk2p5wW29XzFJBh2XzyQ0tSzpezK2TzFy72Q=
Date:   Tue, 24 Mar 2020 21:33:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 03/21] list: Annotate lockless list primitives with
 data_race()
Message-ID: <20200324213352.GB21176@willie-the-truck>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-4-will@kernel.org>
 <CANpmjNPWpkxqZQJJOwmx0oqvzfcxhtqErjCzjRO_y0BQSmre8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPWpkxqZQJJOwmx0oqvzfcxhtqErjCzjRO_y0BQSmre8A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:23:30PM +0100, Marco Elver wrote:
> On Tue, 24 Mar 2020 at 16:37, Will Deacon <will@kernel.org> wrote:
> >
> > Some list predicates can be used locklessly even with the non-RCU list
> > implementations, since they effectively boil down to a test against
> > NULL. For example, checking whether or not a list is empty is safe even
> > in the presence of a concurrent, tearing write to the list head pointer.
> > Similarly, checking whether or not an hlist node has been hashed is safe
> > as well.
> >
> > Annotate these lockless list predicates with data_race() and READ_ONCE()
> > so that KCSAN and the compiler are aware of what's going on. The writer
> > side can then avoid having to use WRITE_ONCE() in the non-RCU
> > implementation.
> >
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Marco Elver <elver@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  include/linux/list.h       | 10 +++++-----
> >  include/linux/list_bl.h    |  5 +++--
> >  include/linux/list_nulls.h |  6 +++---
> >  include/linux/llist.h      |  2 +-
> >  4 files changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/list.h b/include/linux/list.h
> > index 4fed5a0f9b77..4d9f5f9ed1a8 100644
> > --- a/include/linux/list.h
> > +++ b/include/linux/list.h
> > @@ -279,7 +279,7 @@ static inline int list_is_last(const struct list_head *list,
> >   */
> >  static inline int list_empty(const struct list_head *head)
> >  {
> > -       return READ_ONCE(head->next) == head;
> > +       return data_race(READ_ONCE(head->next) == head);
> 
> Double-marking should never be necessary, at least if you want to make
> KCSAN happy. From what I gather there is an unmarked write somewhere,
> correct? In that case, KCSAN will still complain because if it sees a
> race between this read and the other write, then at least one is still
> plain (the write).
> 
> Then, my suggestion would be to mark the write with data_race() and
> just leave this as a READ_ONCE(). Having a data_race() somewhere only
> makes KCSAN stop reporting the race if the paired access is also
> marked (be it with data_race() or _ONCE, etc.).
> 
> Alternatively, if marking the write is impossible, you can surround
> the access with kcsan_disable_current()/kcsan_enable_current(). Or, as
> a last resort, just leaving as-is is fine too, because KCSAN's default
> config (still) has KCSAN_ASSUME_PLAIN_WRITES_ATOMIC selected.

Right, it looks like this is a bit of a smoking gun and we need to decide
on whether list_empty() is actually usable without synchronisation first.
Based on the outcome of that discussion, I'll update this patch accordingly.

The main thing I want to avoid is marking parts of the non-RCU list
implementation with data_race() or {READ,WRITE}_ONCE() because that's a
sure-fire way to hide real bugs.

Cheers,

Will
