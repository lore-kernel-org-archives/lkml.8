Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD8C35242
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 01:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F025A2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 01:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdrE55xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAZB6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 20:58:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46260 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgAZB6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 20:58:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id x14so4613874ljd.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 17:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIfL/cJCzNWvLIipJX4iPUcP2Js+zrphpdXyW0xzwSw=;
        b=UdrE55xEvTNev5zrYEtR3f8tW3HAKw6Db5nfR2TQ4Q6bjf6z5CYi3/1LdCL8CzV1C+
         RzouEEDwaPbzn+0Atzdiim8UcKTDypaNQFYhAcuz60QLvK+ykNCvVlPZ10PlYUl/By7G
         ZQMWXRMW4fclA87jgfucL0scpDIGFUDG83n9uFIfG0g6RGtHL/tNveiwmbzJF1cyDFrJ
         ZKx0qnlAxb1nIn4RfOG7tOJlQ27Ty/hWwZhk7rW7hj9RdiFu56bUTEM5U4s8IlD7Wemv
         pONgJbxpv1TZ5CBcVYJ81Zpunc3riFTu1j+5VB6Z6aIsSulzlQfTuom8QPxXy05llS8E
         V4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIfL/cJCzNWvLIipJX4iPUcP2Js+zrphpdXyW0xzwSw=;
        b=BhU430CQKYYvppbVQU9i2rXb5xLU0EJEK5ICKZpY6TBXH8OTsTGgDLZNmfnofD1SrU
         /MWPzXgwqkB2So+SM/0WnzhwbFFvYUZvtcpnjja4ieKUt7Zl0OOo89wEOytr9HgGWnhe
         rCke7mnE1+rjRWOajCIdAL0rDHR+Ypt6LSCJVz0KOxxCqF/rsLJr+AkQpYl9sco8FkHZ
         KyC+c9aKQdboeb1Af0bWqMETTta7LO1BnHUAJqX3Xp9+eQ5HWl1Z0cpn3GhtHj146Nrk
         wftSwZMs8a9s7Uu47PH4mYPenGyc+WIUSyFcAqPUlltIpVIQs7rDGyI/Hp9C4HdrroSX
         BGLw==
X-Gm-Message-State: APjAAAXVRVLgKu7/cey1HsAwuvn+i8F6VWm0lCq82a80Xyh99O4H98md
        pPTYRpr0r95qZfyydaCZOnWezmkO5HiKmC2/VhXAMw==
X-Google-Smtp-Source: APXvYqxFMd6pxcgrWFRhWI+L7uUeLKJ1rNxrfoADDl5K+6rdgzxWCvh2VEWVZQCNsEYjOZcDWxr/xwN2zc3mAVXs5vA=
X-Received: by 2002:a2e:7009:: with SMTP id l9mr6119810ljc.96.1580003894105;
 Sat, 25 Jan 2020 17:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20200115035920.54451-1-alex.kogan@oracle.com> <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com> <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
In-Reply-To: <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
From:   Lihao Liang <lihaoliang@google.com>
Date:   Sun, 26 Jan 2020 01:58:02 +0000
Message-ID: <CAC4j=Y--5UQR7Oc5n+sxAwLxd_PKi0Eb-7aiZjDTUW0FTJy8Tw@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 12:32 AM Lihao Liang <lihaoliang@google.com> wrote:
>
> Hi Alex and Waiman,
>
> Thanks a lot for your swift response and clarification.
>
> On Wed, Jan 22, 2020 at 7:30 PM Alex Kogan <alex.kogan@oracle.com> wrote:
> >
> > Hi, Lihao.
> >
> > > On Jan 22, 2020, at 6:45 AM, Lihao Liang <lihaoliang@google.com> wrote:
> > >
> > > Hi Alex,
> > >
> > > On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> wrote:
> > >>
> > >> Summary
> > >> -------
> > >>
> > >> Lock throughput can be increased by handing a lock to a waiter on the
> > >> same NUMA node as the lock holder, provided care is taken to avoid
> > >> starvation of waiters on other NUMA nodes. This patch introduces CNA
> > >> (compact NUMA-aware lock) as the slow path for qspinlock. It is
> > >> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
> > >>
> > >
> > > Thanks for your patches. The experimental results look promising!
> > >
> > > I understand that the new CNA qspinlock uses randomization to achieve
> > > long-term fairness, and provides the numa_spinlock_threshold parameter
> > > for users to tune.
> > This has been the case in the first versions of the series, but is not true anymore.
> > That is, the long-term fairness is achieved deterministically (and you are correct
> > that it is done through the numa_spinlock_threshold parameter).
> >
> > > As Linux runs extremely diverse workloads, it is not
> > > clear how randomization affects its fairness, and how users with
> > > different requirements are supposed to tune this parameter.
> > >
> > > To this end, Will and I consider it beneficial to be able to answer the
> > > following question:
> > >
> > > With different values of numa_spinlock_threshold and
> > > SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
> > > sockets have to wait to acquire the lock?
> > The SHUFFLE_REDUCTION_PROB_ARG parameter is intended for performance
> > optimization only, and *does not* affect the long-term fairness (or, at the
> > very least, does not make it any worse). As Longman correctly pointed out in
> > his response to this email, the shuffle reduction optimization is relevant only
> > when the secondary queue is empty. In that case, CNA hands-off the lock
> > exactly as MCS does, i.e., in the FIFO order. Note that when the secondary
> > queue is not empty, we do not call probably().
> >
> > > This is particularly relevant
> > > in high contention situations when new threads keep arriving on the same
> > > socket as the lock holder.
> > In this case, the lock will stay on the same NUMA node/socket for
> > 2^numa_spinlock_threshold times, which is the worst case scenario if we
> > consider the long-term fairness. And if we have multiple nodes, it will take
> > up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
> > lock transitions until any given thread will acquire the lock
> > (assuming 2^numa_spinlock_threshold > nr_cpus_per_node).
> >
>
> You're right that the latest version of the patch handles long-term fairness
> deterministically.
>
> As I understand it, the n-th thread in the main queue is guaranteed to
> acquire the lock after N lock handovers, where N is bounded by
>
> n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
>
> I'm not sure what role the variable nr_cpus_per_node plays in your analysis.
>
> Do I miss anything?
>

If I understand correctly, there are two phases in the algorithm:

MCS phase: when the secondary queue is empty, as explained in your emails,
the algorithm hands the lock to threads in the main queue in an FIFO order.
When probably(SHUFFLE_REDUCTION_PROB_ARG) returns false (with default
probability 1%), if the algorithm finds the first thread running on the same
socket as the lock holder in cna_scan_main_queue(), it enters the following
CNA phase.

CNA phase: when the secondary queue is not empty, the algorithm keeps
handing the lock to threads in the main queue that run on the same socket as
the lock holder. When 2^numa_spinlock_threshold is reached, it splices
the secondary queue to the front of the main queue. And we are back to the
MCS phase above.

For the n-th thread T in the main queue, the MCS phase handles threads that
arrived in the main queue before T. In high contention situations, the CNA
phase handles two kinds of threads:

1. Threads ahead of T that run on the same socket as the lock holder when
a transition from the MCS to CNA phase was made. Assume there are m such
threads.

2. Threads that keep arriving on the same socket as the lock holder. There
are at most 2^numa_spinlock_threshold of them.

Then the number of lock handovers in the CNA phase is max(m,
2^numa_spinlock_threshold). So the total number of lock handovers before T
acquires the lock is at most

n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)

Please let me know if I misunderstand anything.

Many thanks,
Lihao.
