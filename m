Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8380FC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E58214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRx8f9Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgA0OMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:12:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37581 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbgA0OMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:12:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so7434300qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 06:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdwXXXel1XGOUzw7AXNSSDoNStSQRAMF5BvyR1eddmU=;
        b=dRx8f9Bosa8XXmijmamvYG9PqF6tYhC1luD+qTVYqRqoxyfZsvTZ+N4UVz6EYlJcs6
         Y/7YGArBVWizdsHYOc2k6r0y+ad8AuyHcp2m33nMVsNHrMYMTGdKuLofHVsWRv9SVwcM
         J6oS0lOcI4ZjkR2Mj0dzN+SxkhxwbcqW+xI1klX0bJjR773NkO7Cz5hM9Xi21cSTpjJi
         aHJlwjgbl9/3rlvkmsz8RA10vRdJ3hR+Fdpdkt5+RvFZQ5WWcE3jTwMWgXn9Zzfhi9N3
         j4lntM1QGSi2vB0l1f9dFYwNBbp5imhcnmTjn6HTWDRhJwJq0V/aJhyLRahQLrkAHLog
         H5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdwXXXel1XGOUzw7AXNSSDoNStSQRAMF5BvyR1eddmU=;
        b=GGJRUKG8Q/Ihe7l6c4D2TlFO0RDqtJJNIfgP4KfG+uJZ/5Wv+TXSbaDchNytVDpD/o
         DkuUpP8kGdjDTti9wnkX9trfXtcH4IPC/zRNR7QMCpSHnm/DTZZJrfGGA2ZZ0c9/OAxE
         hkuz88bBz4to33JMneDAa2qvXJUk+NRLiLxFFecMz8j0ctqazGi689RHOCZp3n5ZHdna
         9o90rkfFretmqjW0mLEAGOoJ9T7ynVfpkj0QYVfPAqSWwonJ0HZJcAcmhtKndiBX37qy
         OHSPxY0fyl+a8WDjzIpxJ/De3egd2vhY4vsi4gbWAG6uCbT9bCv2eJ7cLSzm8BMD1kE5
         q7wA==
X-Gm-Message-State: APjAAAUC+HIXXQis5+A3yELNuAQLxMVdiIHCeUhuU4UzCYikTbfDuIru
        f94uUBJXe2ycYJwBUL4tx2digbzRfO1Dxj3/bp6uzw==
X-Google-Smtp-Source: APXvYqzMVk2Qq5thta7u0NWTHDV/Nnn+rnyOZpY6wUCd/mzsoaD0vkxiFkXzt/ecRITrrpbCzdAReJ6hrl3ETyG0IqM=
X-Received: by 2002:ac8:7159:: with SMTP id h25mr15701524qtp.380.1580134338727;
 Mon, 27 Jan 2020 06:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20191112012724.250792-1-dima@arista.com> <20191112012724.250792-4-dima@arista.com>
In-Reply-To: <20191112012724.250792-4-dima@arista.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Jan 2020 15:12:07 +0100
Message-ID: <CACT4Y+b70bRRS2XD3yxhBoy4E-LFy_K3wMrjeuPmiEvaPe_c2Q@mail.gmail.com>
Subject: Re: [PATCHv8 03/34] ns: Introduce Time Namespace
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 2:30 AM Dmitry Safonov <dima@arista.com> wrote:
>
> From: Andrei Vagin <avagin@openvz.org>
>
> Time Namespace isolates clock values.
>
> The kernel provides access to several clocks CLOCK_REALTIME,
> CLOCK_MONOTONIC, CLOCK_BOOTTIME, etc.
>
> CLOCK_REALTIME
>       System-wide clock that measures real (i.e., wall-clock) time.
>
> CLOCK_MONOTONIC
>       Clock that cannot be set and represents monotonic time since
>       some unspecified starting point.
>
> CLOCK_BOOTTIME
>       Identical to CLOCK_MONOTONIC, except it also includes any time
>       that the system is suspended.
>
> For many users, the time namespace means the ability to changes date and
> time in a container (CLOCK_REALTIME).
>
> But in a context of the checkpoint/restore functionality, monotonic and
> bootime clocks become interesting. Both clocks are monotonic with
> unspecified staring points. These clocks are widely used to measure time
> slices and set timers. After restoring or migrating processes, we have to
> guarantee that they never go backward. In an ideal case, the behavior of
> these clocks should be the same as for a case when a whole system is
> suspended. All this means that we need to be able to set CLOCK_MONOTONIC
> and CLOCK_BOOTTIME clocks, what can be done by adding per-namespace
> offsets for clocks.
>
> A time namespace is similar to a pid namespace in a way how it is
> created: unshare(CLONE_NEWTIME) system call creates a new time namespace,
> but doesn't set it to the current process. Then all children of
> the process will be born in the new time namespace, or a process can
> use the setns() system call to join a namespace.
>
> This scheme allows setting clock offsets for a namespace, before any
> processes appear in it.
>
> All available clone flags have been used, so CLONE_NEWTIME uses the
> highest bit of CSIGNAL. It means that we can use it with the unshare()
> system call only. Rith now, this works for us, because time namespace
> offsets can be set only when a new time namespace is not populated. In a
> future, we will have the clone3() system call [1] which will allow to use
> the CSIGNAL mask for clone flags.
>
> [1]: httmps://lkml.kernel.org/r/20190604160944.4058-1-christian@brauner.io
>
> Link: https://criu.org/Time_namespace
> Link: https://lists.openvz.org/pipermail/criu/2018-June/041504.html
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> Co-developed-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  MAINTAINERS                    |   2 +
>  fs/proc/namespaces.c           |   4 +
>  include/linux/nsproxy.h        |   2 +
>  include/linux/proc_ns.h        |   3 +
>  include/linux/time_namespace.h |  66 ++++++++++
>  include/linux/user_namespace.h |   1 +
>  include/uapi/linux/sched.h     |   6 +
>  init/Kconfig                   |   7 ++
>  kernel/fork.c                  |  16 ++-
>  kernel/nsproxy.c               |  41 +++++--
>  kernel/time/Makefile           |   1 +
>  kernel/time/namespace.c        | 217 +++++++++++++++++++++++++++++++++
>  12 files changed, 356 insertions(+), 10 deletions(-)
>  create mode 100644 include/linux/time_namespace.h
>  create mode 100644 kernel/time/namespace.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f7f8cdbc471..037abc28c414 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13172,6 +13172,8 @@ T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>  S:     Maintained
>  F:     fs/timerfd.c
>  F:     include/linux/timer*
> +F:     include/linux/time_namespace.h
> +F:     kernel/time_namespace.c

Is it supposed to be kernel/time/namespace.c?
