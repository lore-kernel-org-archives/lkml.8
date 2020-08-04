Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D320C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A6E22BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgHDMKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:10:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46626 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbgHDL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:57:52 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k2vYo-0003XZ-4h; Tue, 04 Aug 2020 11:56:50 +0000
Date:   Tue, 4 Aug 2020 13:56:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, ebiederm@xmission.com,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] namespaces: Introduce generic refcount
Message-ID: <20200804115649.kzea757e5wwpk4k3@wittgenstein>
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 01:16:10PM +0300, Kirill Tkhai wrote:
> Every namespace type has its own counter. Some of them are
> of refcount_t, some of them are of kref.
> 
> This patchset introduces generic ns_common::count for any
> type of namespaces instead of them.
> 
> ---

I was wondering why that series never made it to me turns out there's
some weird bug in my (neo)mutt where it sometimes marks messages as read
when I'm deleting completely unrelated messages. That has already cost
me a talk slot for an event I really wanted to attend and now it seems
to start costing me patches... I need to figure this out.

Anyway, thanks for sending this. I pulled this into my tree now.

Thanks!
Christian

> 
> Kirill Tkhai (8):
>       ns: Add common refcount into ns_common add use it as counter for net_ns
>       uts: Use generic ns_common::count
>       ipc: Use generic ns_common::count
>       pid: Use generic ns_common::count
>       user: Use generic ns_common::count
>       mnt: Use generic ns_common::count
>       cgroup: Use generic ns_common::count
>       time: Use generic ns_common::count
> 
> 
>  fs/mount.h                     |    3 +--
>  fs/namespace.c                 |    4 ++--
>  include/linux/cgroup.h         |    5 ++---
>  include/linux/ipc_namespace.h  |    3 +--
>  include/linux/ns_common.h      |    3 +++
>  include/linux/pid_namespace.h  |    4 +---
>  include/linux/time_namespace.h |    9 ++++-----
>  include/linux/user_namespace.h |    5 ++---
>  include/linux/utsname.h        |    9 ++++-----
>  include/net/net_namespace.h    |   11 ++++-------
>  init/version.c                 |    2 +-
>  ipc/msgutil.c                  |    2 +-
>  ipc/namespace.c                |    4 ++--
>  kernel/cgroup/cgroup.c         |    2 +-
>  kernel/cgroup/namespace.c      |    2 +-
>  kernel/pid.c                   |    2 +-
>  kernel/pid_namespace.c         |   13 +++----------
>  kernel/time/namespace.c        |    9 +++------
>  kernel/user.c                  |    2 +-
>  kernel/user_namespace.c        |    4 ++--
>  kernel/utsname.c               |    7 ++-----
>  net/core/net-sysfs.c           |    6 +++---
>  net/core/net_namespace.c       |    6 +++---
>  net/ipv4/inet_timewait_sock.c  |    4 ++--
>  net/ipv4/tcp_metrics.c         |    2 +-
>  25 files changed, 51 insertions(+), 72 deletions(-)
> 
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
