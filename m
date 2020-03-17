Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B96C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4560C20674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgCQIoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:44:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44242 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgCQIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:44:06 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jE7pG-0006pt-Ix; Tue, 17 Mar 2020 08:43:50 +0000
Date:   Tue, 17 Mar 2020 09:43:49 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: clone3: allow creation of time namespace with offset
Message-ID: <20200317084349.fkmpj4tpdmsv6trj@wittgenstein>
References: <20200317083043.226593-1-areber@redhat.com>
 <20200317084154.m2u76jqj5f47mxqc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317084154.m2u76jqj5f47mxqc@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 09:41:55AM +0100, Christian Brauner wrote:
> On Tue, Mar 17, 2020 at 09:30:40AM +0100, Adrian Reber wrote:
> > This is an attempt to add time namespace support to clone3(). I am not
> > really sure which way clone3() should handle time namespaces. The time
> > namespace through /proc cannot be used with clone3() because the offsets
> > for the time namespace need to be written before a process has been
> > created in that time namespace. This means it is necessary to somehow
> > tell clone3() the offsets for the clocks.
> > 
> > The time namespace offers the possibility to set offsets for
> > CLOCK_MONOTONIC and CLOCK_BOOTTIME. My first approach was to extend
> > 'struct clone_args` with '__aligned_u64 monotonic_offset' and
> > '__aligned_u64 boottime_offset'. The problem with this approach was that
> > it was not possible to set nanoseconds for the clocks in the time
> > namespace.
> > 
> > One of the motivations for clone3() with CLONE_NEWTIME was to enable
> > CRIU to restore a process in a time namespace with the corresponding
> > offsets. And although the nanosecond value can probably never be
> > restored to the same value it had during checkpointing, because the
> > clock keeps on running between CRIU pausing all processes and CRIU
> > actually reading the value of the clocks, the nanosecond value is still
> > necessary for CRIU to not restore a process where the clock jumps back
> > due to CRIU restoring it with a nanonsecond value that is too small.
> > 
> > Requiring nanoseconds as well as seconds for two clocks during clone3()
> > means that it would require 4 additional members to 'struct clone_args':
> > 
> >         __aligned_u64 tls;
> >         __aligned_u64 set_tid;
> >         __aligned_u64 set_tid_size;
> > +       __aligned_u64 boottime_offset_seconds;
> > +       __aligned_u64 boottime_offset_nanoseconds;
> > +       __aligned_u64 monotonic_offset_seconds;
> > +       __aligned_u64 monotonic_offset_nanoseconds;
> >  };
> > 
> > To avoid four additional members to 'struct clone_args' this patchset
> > uses another approach:
> > 
> >         __aligned_u64 tls;
> >         __aligned_u64 set_tid;
> >         __aligned_u64 set_tid_size;
> > +       __aligned_u64 timens_offset;
> > +       __aligned_u64 timens_offset_size;
> 
> Hm, so for set_tid we did set_tid and set_tid_size which makes sense
> because set_tid wasn't actually a struct. But I'm not a fan of
> establishing a pattern whereby we always have to grow two member, the
> object and it's size; at least when we're adding a struct.
> So at a first glance here are two possible ideas:
> - Don't add a size argument and assume that struct timens_offset won't
>   grow. I'm not sure how likely it is it will grow.
> - Make the size the first member of struct timens_offset the size of the
>   struct. (See examples for this pattern in the sched syscalls.)

Oh, and I should point out right way that I consider this material for
the v5.8 merge window. It's too late in this cycle to land this with any
confidence in v5.7. Just so there's no disappointment. :) The good news
is that this leaves us with ample time to figure this out.

Christian
