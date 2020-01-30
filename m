Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19792082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpmvpHVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgA3Njw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:39:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39284 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbgA3Njv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:39:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so3127696oty.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 05:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4H48YtpiLm+taBVkGC08gZKk3HEB7Nrcktl9EzCxbo=;
        b=fpmvpHVJRwNGUKox3FbEv7QUeGtehnoVBpDFYdiVATAqAM2G5s3/rCn29rmIX/hUag
         7ZoiJdy/WbI6C1J2JsP0HzCQCQfBoisD2ocZE0JDPDDkLD7qdTWJFq4LIjLmOcRthVZd
         klwgF6tsX0NGqdCRvReOs3VInFUomaDW8nSBcjUqtAwobvQe9VcetgP9iMrBHXgRo4Y1
         XYp1YRKVgtTBwQN8TWgfmmcRkJ7/emXY4x3E+4mrKikSHusR7bSSMRjF3faPTQU2fkQK
         SuTLimSrW0UkUVUngakgkbprP6I8nYK+r5L8zHsat5kiFrYHTEIGkzeAYEnkoHlC1BAA
         kb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4H48YtpiLm+taBVkGC08gZKk3HEB7Nrcktl9EzCxbo=;
        b=V1FAJoy6SvrqmwJo+C1zKclATggHsRCV3wsVy/fmLmOA35ZElT5wlC7Bh8s9wRV8kk
         jTbrGOKQSrtaEoq/U4xPKL4QCS1pmLz6PhPBHqtJW0mrayLo0UXnbkR5ETSsiet3BgwC
         Ohtu0pjOsUCltw17C/Z5rbfiCocqGUijFL63fwncdb/q40ABPi6gPYh78Qv0QG3grLHw
         4nVusuAfSuptIcXPbRogk4acJAjj2imUH8HUBRnCBfL4XUQh2ZWieqVoMpWIkiRwxM21
         Tj1KI9K0usXO3gXV9KfeB9tw5UsdNfEJe4idZvqhL8iBDD8T9DDjeTih07MuMZpco/bT
         A24w==
X-Gm-Message-State: APjAAAXSgn9CAQ4tInN5+M1ont3OULtKxFRn5KMdG+PF1loy2pQ9O62n
        3gMx/2uHQBMUtFY1po24TCC+pIWjesBeFiGojnUmwQ==
X-Google-Smtp-Source: APXvYqwEN46hySibjKKmLbsfKaAe9m6tuHXXvjKBUUXwRHJIxSXXgFmJNH0SXMfO59TxMs7ONgZRCIXUgixw7Ln95Sc=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr3755637otq.17.1580391590549;
 Thu, 30 Jan 2020 05:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20200122165938.GA16974@willie-the-truck> <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com> <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net> <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
 <20200128165655.GM14914@hirez.programming.kicks-ass.net> <20200129002253.GT2935@paulmck-ThinkPad-P72>
 <CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=cozW5cYkm8h-GTBg@mail.gmail.com> <20200129184024.GT14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200129184024.GT14879@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 30 Jan 2020 14:39:38 +0100
Message-ID: <CANpmjNNZQsatHexXHm4dXvA0na6r9xMgVD5R+-8d7VXEBRi32w@mail.gmail.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, Qian Cai <cai@lca.pw>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 at 19:40, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 29, 2020 at 04:29:43PM +0100, Marco Elver wrote:
>
> > On Tue, 28 Jan 2020 at 17:52, Peter Zijlstra <peterz@infradead.org> wrote:
> > > I'm claiming that in the first case, the only thing that's ever done
> > > with a racy load is comparing against 0, there is no possible bad
> > > outcome ever. While obviously if you let the load escape, or do anything
> > > other than compare against 0, there is.
> >
> > It might sound like a simple rule, but implementing this is anything
> > but simple: This would require changing the compiler,
>
> Right.
>
> > which we said we'd like to avoid as it introduces new problems.
>
> Ah, I missed that brief.
>
> > This particular rule relies on semantic analysis that is beyond what
> > the TSAN instrumentation currently supports. Right now we support GCC
> > and Clang; changing the compiler probably means we'd end up with only
> > one (probably Clang), and many more years before the change has
> > propagated to the majority of used compiler versions. It'd be good if
> > we can do this purely as a change in the kernel's codebase.
>
> *sigh*, I didn't know there was such a resistance to change the tooling.
> That seems very unfortunate :-/

Unfortunately. Just wanted to highlight what to expect if we go down
that path. We can put it on a nice-to-have list, but don't expect or
rely on it to happen soon, given the implications above.

> > Keeping the bigger picture in mind, how frequent is this case, and
> > what are we really trying to accomplish?
>
> It's trying to avoid the RmW pulling the line in exclusive/modified
> state in a loop. The basic C-CAS pattern if you will.
>
> > Is it only to avoid a READ_ONCE? Why is the READ_ONCE bad here? If
> > there is a racing access, why not be explicit about it?
>
> It's probably not terrible to put a READ_ONCE() there; we just need to
> make sure the compiler doesn't do something stupid (it is known to do
> stupid when 'volatile' is present).

Maybe we need to optimize READ_ONCE().

'if (data_race(..))' would also work here and has no cost.

> But the fact remains that it is entirely superfluous, there is no
> possible way the compiler can wreck this.

Agree. Still thinking if there is a way to do it without changing the
compiler, but I can't see it right now. :/

Thanks,
-- Marco
