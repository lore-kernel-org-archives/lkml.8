Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA7BC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECA72082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnZtPmTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgAaWLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:11:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43072 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAaWLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:11:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so8059927oth.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 14:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUtHl3dHVrCGChHJNZz7f2YCmBuydJiAM0b18mQZtvE=;
        b=FnZtPmTyFfflSLT9ix9U7l7Vj5iAxGPg3HBrILk6HczJIYDrF+Md+5uvL5vskeKMNh
         KLJaeZzxn3bmCOeARi+yfni1PSa6xXvwsqcGg8ecxx78m2AoMiKclqLwj2A2iMNXlX2m
         SKVm9XOytZVDUDz7XfRPS3DcoHi/0csh4YPhNTOgLFSTq5x+ITwOQhAXXX5WZZDhBhGr
         cI9bQeEK3oroUJvX+u5LCLP6rMJwov5aWLITMiqbQFXYMbZiONEC9WXSIYxPSpOg2018
         t266ngesJIRxy09r++8k7Rf7Nq+BBI4jnntHyeor9luWLP9auf5V8fKBG5tcovZE+pWy
         nDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUtHl3dHVrCGChHJNZz7f2YCmBuydJiAM0b18mQZtvE=;
        b=hnhX0y5YlbJmKMNKMc3O5FWWqsq2zu7AnM6jS4QbiOHqdJEO28Qq7+ImhtrteROIKN
         NfOmfmnW3Jddzq8weoTMam2DQ0Lt9Z20xnfaAJ0/CyNLmQb/9Am6I67f6YWmkocdVfiV
         9gQGi7x8YGRuE4GPqTZhmR4tNhkCcoSola9FV1JNDlLXuWa91T+DCnrRoopZJqLHkpWR
         PlENKHUjE1Qlli6xZIUW3ZGK3TlFLZIL5gyhoBk5L5WCQLay3io5kwkSmP/3XDLvufWg
         ZDke9wh8LGWIR8QGcWy1e4XBBvuaq/SP1UuBLlh7TOffHJPW3rZxGII/onWOrgF1jSiw
         072A==
X-Gm-Message-State: APjAAAWw2k2Bk354ivp9Ik2WByfD4niLvg60lIqKbjWeVcvIyuJ6eXEs
        KXjr9k5a34YV2EqEuz70IwcwiwDa7ogdZ17sY68izw==
X-Google-Smtp-Source: APXvYqxCHqTZlB1Qipe0jkHRe9ADzTppHbzjeQja0KvVRfyddr2gvbtzAIkqqWEM3zRJnGZ79ZP/BT50aR69S2Wtt9k=
X-Received: by 2002:a9d:7b51:: with SMTP id f17mr9025707oto.302.1580508711413;
 Fri, 31 Jan 2020 14:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20200131122421.23286-1-sjpark@amazon.com> <20200131122421.23286-3-sjpark@amazon.com>
 <CADVnQyk9xevY0kA9Sm9S9MOBNvcuiY+7YGBtGuoue+r+eizyOA@mail.gmail.com> <dd146bac-4e8a-4119-2d2b-ce6bf2daf7ce@gmail.com>
In-Reply-To: <dd146bac-4e8a-4119-2d2b-ce6bf2daf7ce@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 31 Jan 2020 17:11:35 -0500
Message-ID: <CADVnQy=Z0YRPY_0bxBpsZvECgamigESNKx6_-meNW5-6_N4kww@mail.gmail.com>
Subject: Re: [PATCH 2/3] tcp: Reduce SYN resend delay if a suspicous ACK is received
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     sjpark@amazon.com, Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, shuah@kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, sj38.park@gmail.com,
        aams@amazon.com, SeongJae Park <sjpark@amazon.de>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 1:12 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 1/31/20 7:10 AM, Neal Cardwell wrote:
> > On Fri, Jan 31, 2020 at 7:25 AM <sjpark@amazon.com> wrote:
> >>
> >> From: SeongJae Park <sjpark@amazon.de>
> >>
> >> When closing a connection, the two acks that required to change closing
> >> socket's status to FIN_WAIT_2 and then TIME_WAIT could be processed in
> >> reverse order.  This is possible in RSS disabled environments such as a
> >> connection inside a host.
> >>
> >> For example, expected state transitions and required packets for the
> >> disconnection will be similar to below flow.
> >>
> >>          00 (Process A)                         (Process B)
> >>          01 ESTABLISHED                         ESTABLISHED
> >>          02 close()
> >>          03 FIN_WAIT_1
> >>          04             ---FIN-->
> >>          05                                     CLOSE_WAIT
> >>          06             <--ACK---
> >>          07 FIN_WAIT_2
> >>          08             <--FIN/ACK---
> >>          09 TIME_WAIT
> >>          10             ---ACK-->
> >>          11                                     LAST_ACK
> >>          12 CLOSED                              CLOSED
> >
> > AFAICT this sequence is not quite what would happen, and that it would
> > be different starting in line 8, and would unfold as follows:
> >
> >           08                                     close()
> >           09                                     LAST_ACK
> >           10             <--FIN/ACK---
> >           11 TIME_WAIT
> >           12             ---ACK-->
> >           13 CLOSED                              CLOSED
> >
> >
> >> The acks in lines 6 and 8 are the acks.  If the line 8 packet is
> >> processed before the line 6 packet, it will be just ignored as it is not
> >> a expected packet,
> >
> > AFAICT that is where the bug starts.
> >
> > AFAICT, from first principles, when process A receives the FIN/ACK it
> > should move to TIME_WAIT even if it has not received a preceding ACK.
> > That's because ACKs are cumulative. So receiving a later cumulative
> > ACK conveys all the information in the previous ACKs.
> >
> > Also, consider the de facto standard state transition diagram from
> > "TCP/IP Illustrated, Volume 2: The Implementation", by Wright and
> > Stevens, e.g.:
> >
> >   https://courses.cs.washington.edu/courses/cse461/19sp/lectures/TCPIP_State_Transition_Diagram.pdf
> >
> > This first-principles analysis agrees with the Wright/Stevens diagram,
> > which says that a connection in FIN_WAIT_1 that receives a FIN/ACK
> > should move to TIME_WAIT.
> >
> > This seems like a faster and more robust solution than installing
> > special timers.
> >
> > Thoughts?
>
>
> This is orthogonal I think.
>
> No matter how hard we fix the other side, we should improve the active side.
>
> Since we send a RST, sending the SYN a few ms after the RST seems way better
> than waiting 1 second as if we received no packet at all.
>
> Receiving this ACK tells us something about networking health, no need
> to be very cautious about the next attempt.

Yes, all good points. Thanks!

> Of course, if you have a fix for the passive side, that would be nice to review !

I looked into fixing this, but my quick reading of the Linux
tcp_rcv_state_process() code is that it should behave correctly and
that a connection in FIN_WAIT_1 that receives a FIN/ACK should move to
TIME_WAIT.

SeongJae, do you happen to have a tcpdump trace of the problematic
sequence where the "process A" ends up in FIN_WAIT_2 when it should be
in TIME_WAIT?

If I have time I will try to construct a packetdrill case to verify
the behavior in this case.

thanks,
neal

>
>
>
