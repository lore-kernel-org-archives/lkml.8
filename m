Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77841C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A720709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4ygIp4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCTRVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:21:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30791 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgCTRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584724882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3lO8xM6OlK/LHQ3bNXjTnXYxe2vLqR+wSw8ysIohFJs=;
        b=i4ygIp4RcAR3x2GLfTTu3eh5DsJUiB9QfaZRpwTvj2Ew5ObDXX09TLLt5RHLgLV0ExLIhg
        nn/Vv5NFrS6RV2EVXzt6lLQP3KY3SpeNGOggdJI4kxPmto3yTGYNvVt1TpgO4v0OpE9RJo
        LojgoSeOaPQWQCTPHLhhC3fT+xR5w1c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-T6d3-98QObmcRngEg1Qslw-1; Fri, 20 Mar 2020 13:21:20 -0400
X-MC-Unique: T6d3-98QObmcRngEg1Qslw-1
Received: by mail-wm1-f70.google.com with SMTP id y1so520842wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 10:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lO8xM6OlK/LHQ3bNXjTnXYxe2vLqR+wSw8ysIohFJs=;
        b=J1UZsZwKTp8P+VA7u7ELFqcRXtv2lIPBU1RghIbHp8Cs5lJHHCciCFZZ7ozejr0ZX2
         yhCwj6M3T5B0Z8VQjCpiqcZWDxbL7ZBK9H4HvqmQ4yDhCPOgVGUEvdPah/Tx8/u6+SHP
         JT2+/j1jvfRsX4Pd6eBzZlW5i5ox9jrUO4rgLcuD+Gcw2KgIqjffzAEgXFB3F2xygcKk
         cLftN+RJM6JCnhR5XJfbPalOEaMnIWF/yZq7VqVyoi1bHhc6AJLJG7Dw1ScA9VGL9zVX
         epox5Fz3hE0sp28YSiBDoKWlyQ+YkR3u7IeKoqAn25BaBr+LPr5VaPKInjpl+VBEO0zR
         dNtw==
X-Gm-Message-State: ANhLgQ1Yes0gjg1eOaElp3UMICX+URkf2DiHSkkYdw7w0C/0s8hLHoDg
        vri6Ylva+rBzfVkrInYUT7iWAjjYNkeI6htY+9TkwqJknbSwbS2p92/8ItC+8pc6PopnXScDa3j
        4BWWzo+fPGAwbt8JsR4WdmhstsVN1cQLdgCthw1Um
X-Received: by 2002:a05:6000:1626:: with SMTP id v6mr11006920wrb.251.1584724877792;
        Fri, 20 Mar 2020 10:21:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuHW/Jr1xuHq7U7U/4NYnNtmu4Ks/y1elJ8BKO+zpUWhlFAx47B4nBlx3pAaU5INeC61joH1HmjoRcJcWF8oDg=
X-Received: by 2002:a05:6000:1626:: with SMTP id v6mr11006880wrb.251.1584724877563;
 Fri, 20 Mar 2020 10:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200309203625.GU3818@techsingularity.net> <20200312095432.GW3818@techsingularity.net>
 <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net> <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
In-Reply-To: <20200320163843.GD3818@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 20 Mar 2020 18:21:06 +0100
Message-ID: <CAE4VaGB0o95Vv7DX78pcTJFNSPxV+EJbQOCmF13DhVRRM5wa_w@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When the initial spreading was prevented, it was for pipelines mainly --
> even basic shell scripts. In that case it was observed that a shell would
> fork/exec two tasks connected via pipe that started on separate nodes and
> had allocated remote data before being pulled close. The processes were
> typically too short lived for NUMA balancing to fix it up by exec time
> the information on where the fork happened was lost.  See 2c83362734da
> ("sched/fair: Consider SD_NUMA when selecting the most idle group to
> schedule on"). Now the logic has probably been partially broken since
> because of how SD_NUMA is now treated but the concern about spreading
> wide prematurely remains.

I understand. It's a hard one - let's keep an eye on it. We will
continue to test the upstream kernels and we will have some discussion
internally. Let's see if anybody has some idea how to treat these
special cases.

Enjoy the weekend!
Jirka


On Fri, Mar 20, 2020 at 5:38 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Mar 20, 2020 at 04:30:08PM +0100, Jirka Hladky wrote:
> > >
> > > MPI or OMP and what is a low thread count? For MPI at least, I saw a 0.4%
> > > gain on an 4-node machine for bt_C and a 3.88% regression on 8-nodes. I
> > > think it must be OMP you are using because I found I had to disable UA
> > > for MPI at some point in the past for reasons I no longer remember.
> >
> >
> > Yes, it's indeed OMP.  With low threads count, I mean up to 2x number of
> > NUMA nodes (8 threads on 4 NUMA node servers, 16 threads on 8 NUMA node
> > servers).
> >
>
> Ok, so we know it's within the imbalance threshold where a NUMA node can
> be left idle.
>
> > One possibility would be to spread wide always at clone time and assume
> > > wake_affine will pull related tasks but it's fragile because it breaks
> > > if the cloned task execs and then allocates memory from a remote node
> > > only to migrate to a local node immediately.
> >
> >
> > I think the only way to find out how it performs is to test it. If you
> > could prepare a patch like that, I'm more than happy to give it a try!
> >
>
> When the initial spreading was prevented, it was for pipelines mainly --
> even basic shell scripts. In that case it was observed that a shell would
> fork/exec two tasks connected via pipe that started on separate nodes and
> had allocated remote data before being pulled close. The processes were
> typically too short lived for NUMA balancing to fix it up by exec time
> the information on where the fork happened was lost.  See 2c83362734da
> ("sched/fair: Consider SD_NUMA when selecting the most idle group to
> schedule on"). Now the logic has probably been partially broken since
> because of how SD_NUMA is now treated but the concern about spreading
> wide prematurely remains.
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka

