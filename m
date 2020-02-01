Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687B1C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 03:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9D7206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 03:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQjFL00X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgBADzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 22:55:54 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37619 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgBADzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 22:55:54 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so9441065oic.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 19:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpR02gdbkQHjEdxG9SGzf7pEIWQTwMtXqw53xDeIps0=;
        b=VQjFL00X7xtyXkCCDgN3B68jvRIqMEmqrDPxRd5YE3DRN80cjuRwJc+vxnog0d9I5v
         oefItgDUERaDVY/Gd5fT07KrQSGyCfMFvmsVeDqKTlRMu4QC5hyubUOprxRi3O2iZk9S
         v53qnNnUyOyS8RL4KLV+hKJDShcM7+QvFo2HLP4uXwSiTMCgRy8D2WH6g4GTnvEFjn5i
         by/CkmTLDYrhvYjZ9s8vSWSUayYwFsYMnktoKLw6TUHPxil+24ZVVOm8A4US4MkV6VHQ
         XfULhdcSaKINaYs0Qt9Xq7gu1CkXzn/q0rbEaqmknolSfd9wEwSLp6tTknjiPAawKRvF
         g/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpR02gdbkQHjEdxG9SGzf7pEIWQTwMtXqw53xDeIps0=;
        b=WqkI8HH/dLUfOW1ikccQmkJVNXHTFUSOPNot10WYNKd3hZcxSeVv3IFtNcFrqymwlE
         Nw6pF021960mH7hYclzjXUr9SGfTVYGAZDUqU6cmCjJkVGIcxtCa3Uy5+EaGUd/A/84+
         ZkFVr0fk2GAo4nN61rjitgaZah+etAoo/X65bESfIxnM4FRaa1qNUznE0yy6UFU1aV5N
         WOWIWhOP5+y/N3iBKoknKlaWf80FQs9tgJ5GkRJYhx990heSV4z5ErXm8wDAfo2Sa0la
         /fhKk2HoBZmiQ77SeRlz3rAeNe8wwRk5TJnS85IDFTBC5gcyuAh2cgzn5Y/WiRg0HooG
         muIw==
X-Gm-Message-State: APjAAAWR4LqY7Mpxabshq/TeiqoIo8UxFKQi/CFea9ksbyRrU4GDKp5/
        MeZ3CA8xoxon70lTjQsOvqUBIUxy+YufWA9SOae0TQ==
X-Google-Smtp-Source: APXvYqxjgAjU3MBV4JGRRnsokOeDc9RuSZPhvl788mDb/V6Q+vKxvqq99N+lRsnjuxpaGJX4PklmpwXXNaKnby1DZuc=
X-Received: by 2002:aca:1b17:: with SMTP id b23mr6844579oib.95.1580529351343;
 Fri, 31 Jan 2020 19:55:51 -0800 (PST)
MIME-Version: 1.0
References: <CADVnQy=Z0YRPY_0bxBpsZvECgamigESNKx6_-meNW5-6_N4kww@mail.gmail.com>
 <20200131221755.3874-1-sj38.park@gmail.com>
In-Reply-To: <20200131221755.3874-1-sj38.park@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 31 Jan 2020 22:55:34 -0500
Message-ID: <CADVnQy=oFmmG-Z9QMafWLcALOBgohADgwScn2r+7CGFNAw5jvw@mail.gmail.com>
Subject: Re: Re: [PATCH 2/3] tcp: Reduce SYN resend delay if a suspicous ACK
 is received
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, sjpark@amazon.com,
        Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, shuah@kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, aams@amazon.com,
        SeongJae Park <sjpark@amazon.de>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 5:18 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Fri, 31 Jan 2020 17:11:35 -0500 Neal Cardwell <ncardwell@google.com> wrote:
>
> > On Fri, Jan 31, 2020 at 1:12 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > >
> > >
> > >
> > > On 1/31/20 7:10 AM, Neal Cardwell wrote:
> > > > On Fri, Jan 31, 2020 at 7:25 AM <sjpark@amazon.com> wrote:
> > > >>
> > > >> From: SeongJae Park <sjpark@amazon.de>
> > > >>
> > > >> When closing a connection, the two acks that required to change closing
> > > >> socket's status to FIN_WAIT_2 and then TIME_WAIT could be processed in
> > > >> reverse order.  This is possible in RSS disabled environments such as a
> > > >> connection inside a host.
> [...]
> >
> > I looked into fixing this, but my quick reading of the Linux
> > tcp_rcv_state_process() code is that it should behave correctly and
> > that a connection in FIN_WAIT_1 that receives a FIN/ACK should move to
> > TIME_WAIT.
> >
> > SeongJae, do you happen to have a tcpdump trace of the problematic
> > sequence where the "process A" ends up in FIN_WAIT_2 when it should be
> > in TIME_WAIT?
>
> Hi Neal,
>
>
> Yes, I have.  You can get it from the previous discussion for this patchset
> (https://lore.kernel.org/bpf/20200129171403.3926-1-sjpark@amazon.com/).  As it
> also has a reproducer program and how I got the tcpdump trace, I believe you
> could get your own trace, too.  If you have any question or need help, feel
> free to let me know. :)

Great. Thank you for the pointer.

I had one quick question: in the message:
  https://lore.kernel.org/bpf/20200129171403.3926-1-sjpark@amazon.com/
... it showed a trace with the client sending a RST/ACK, but this
email thread shows a FIN/ACK. I am curious about the motivation for
the difference?

Anyway, thanks for the report, and thanks to Eric for further clarifying!

neal
