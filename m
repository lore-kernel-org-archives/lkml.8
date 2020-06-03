Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51486C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF9B206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAtYsywu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgFCVZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgFCVZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:25:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8ABC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 14:25:45 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id g3so3995225ilq.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UKCexyhQfEqiQwn6LItOK+f7hxdrRXG3JuxUmP0RMzA=;
        b=PAtYsywuCtGCUcb7eh99y4OJxaqoJZMEIJZhYsV6aE2Oo3TuYav/MH71dwe5fLzwCu
         +jmDtogAD/J/mPHzDLtJDjZsNCkqLhAM/qEQwY83KXXPh/Ct7CIfdbR7XTA+Xingdykq
         Ypm1rffzZ1qy2WR9TOq825SZDVgfw3JaRN3KE/W074B6RwOjA4Mpi5E1nbk+3/o54Cz9
         o5WdCQR6mEoCzd0pJj2C6i+tg5EEc3GZfzPVRY7xRN7QNS23JCNyXPKx+cY1sgz5HZyP
         X4Txe4igE6YOF4zRay7dfg9CBXxdETiFC+ofFYxFqH0+KuprQAWS0NKA9EQeZrHYn2Lu
         uQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UKCexyhQfEqiQwn6LItOK+f7hxdrRXG3JuxUmP0RMzA=;
        b=USXR8RHHTfPBj4UJUNUye/xnKBejcMMjWzhcrVGPraQ4sqhSQBA4Y8C5/nY09W5wYV
         4vejlxkG/03aegDgLmj7pjljlEMAZZB364UyoxFy4M+0dkxXJKnAIbGwT/auxG+IGuYc
         /94z8vCsqbSOm5xA8HI5L9ZMpl2oa7qx7vaKbJ18HMXnZ9ECdRiGzpRaYOcj95L7Bifk
         psHMxXCFGI7pTbXc7aiwH4BwQF7/OIn4jfA6CBy2PreXH4YZ/UiQ2ydGmm1oP90/ZsDs
         LZMsxu/eV8C2nRAzeUUUVFJMUMb94f0fUNdOH6jVwBbWlpLkFzPqPwNv9fmg3O/aQrGm
         Zi0g==
X-Gm-Message-State: AOAM533MHiHtDBjbxzIdNR/+kgs/9CDRVe9xIplMAsyqRXf+/owJWIVS
        3XmfNruwWvG7eVLMmOIN8PLqxwxqRtEUEeHDPOKKHg==
X-Google-Smtp-Source: ABdhPJwavyQGUVk8AkhIGopYvWUIN6AoXhP8EkzVXxxeYpXOtBD7ukU8I8Q91irsao3ZLEzD2qCdHbLmThlTVGkqrhA=
X-Received: by 2002:a92:cf52:: with SMTP id c18mr1403501ilr.142.1591219544184;
 Wed, 03 Jun 2020 14:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011044.7972-1-sargun@sargun.me>
In-Reply-To: <20200603011044.7972-1-sargun@sargun.me>
From:   Robert Sesek <rsesek@google.com>
Date:   Wed, 3 Jun 2020 17:25:32 -0400
Message-ID: <CAJChOddWmeQiWSuYKYjGtK5WNbdidMHy9Td81zV=jwz_a-x-2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add seccomp notifier ioctl that enables adding fds
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for working on this, Sargun! I'll briefly interrupt the code
review to explain why this is an important enhancement for our
application. I=E2=80=99m posting this message on behalf of the Chromium pro=
ject,
which powers Google Chrome and several other open-source browsers (Edge,
Brave, Yandex Browser, etc.).

Chromium uses Seccomp-BPF to reduce the kernel attack surface available
to our child processes. These processes directly parse and manipulate
untrustworthy data downloaded from the Internet, an inherently risky
activity. We rely on Seccomp-BPF (along with other sandboxing
technologies) to help limit the potential damage to a system in the
event that the process is compromised.

One major blocking issue for us is filesystem-related syscalls. Our
default sandbox policy does not permit any filesystem access. Certain
child processes are permitted to access files on an explicit allow-list,
which we enforce by using SECCOMP_RET_TRAP on openat() (and other
syscalls that take a pathname), the signal handler for which forwards
the request to an unsandboxed broker process, and then passes the
resulting FD back via an SCM_RIGHTS message. However, this doesn=E2=80=99t =
work
if signals are disabled when the child process performs the system call.
Significantly, glibc is beginning to disable signals around entire
library functions. So, we are investigating the SECCOMP_RET_USER_NOTIF
facilities to replace our current signals-based mechanism.

The issue is that there is currently no good way to pass an FD from the
tracer back to the tracee when using SECCOMP_RET_USER_NOTIF, even though
this is a normal task for a system call implementation.

So, we need to switch to SECCOMP_RET_USER_NOTIF before glibc
incompatibilities invisibly break our Linux users. We are very eager to
see the addfd ioctl merged, since it would allow us to implement our file
brokering sandbox.

Regards,
Robert Sesek
Chromium Platform Security Team


On Tue, Jun 2, 2020 at 9:13 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This adds the capability for seccomp notifier listeners to add file
> descriptors in response to a seccomp notification. This is useful for
> syscalls in which the previous capabilities were not sufficient. The
> current mechanism works well for syscalls that either have side effects
> that are system / namespace wide (mount), or that operate on a specific
> set of registers (reboot, mknod), and don't require dereferencing pointer=
s.
> The problem with derefencing pointers in a supervisor is that it leaves
> us vulnerable to TOC-TOU [1] style attacks. For syscalls that had a direc=
t
> effect on file descriptors pidfd_getfd was added, allowing for those file
> descriptors to be directly operated upon by the supervisor [2].
>
> Unfortunately, this leaves system calls which return file descriptors
> out of the picture. These are fairly common syscalls, such as openat,
> socket, and perf_event_open that return file descriptors, and have
> arguments that are pointers. These require that the supervisor is able to
> verify the arguments, make the call on behalf of the process on hand,
> and pass back the resulting file descriptor. This is where addfd comes
> into play.
>
> There is an additional flag that allows you to "set" an FD, rather than
> add it with an arbitrary number. This has dup2 style semantics, and
> installs the new file at that file descriptor, and atomically closes
> the old one if it existed. This is useful for a particular use case
> that we have, in which we want to swap out AF_INET sockets for AF_UNIX,
> AF_INET6, and sockets in another namespace when doing "upconversion".
>
> My specific usecase at Netflix is to enable our IPv4-IPv6 transition
> mechanism, in which we our namespaces have no real IPv4 reachability,
> and when it comes time to do a connect(2), we get a socket from a
> namespace with global IPv4 reachability.
>
> In addition, we intend to use it for our servicemesh, and where our
> service mesh needs to intercept traffic ingress traffic, the addfd
> capability will act as a mechanism to do socket activation.
>
> Addfd is not implemented as a separate syscall, a la pidfd_getfd, as
> VFS makes some optimizations in regards to the fdtable, and assumes
> that they are not modified by external processes. Although a mechanism
> that scheduled something in the context of the task could work, it is
> somewhat simpler to do it in the context of the ioctl as we control
> the task while in kernel. In addition there are not obvious needs
> for this beyond seccomp notifier.
>
> This mechanism leaves a potential issue that if the manager is
> interrupted while injecting FDs, the child process will be left with
> leaked / dangling FDs. This may lead to undefined behaviour. A
> mechanism to work around this is to extend the structure and add a
> "rollback" mechanism for FDs to be closed if things fail.
>
> This introduces a new helper -- file_receive, which is responsible
> for moving fds across processes. The helper replaces code in
> SCM_RIGHTS. In SCM_RIGHTS compat codepath there was a bug that
> resulted in this not being set all. This fixes that bug, and should
> be cherry-picked into long-term. The file_receive change should
> probably go into stable. The file_receive code also replaced the
> receive fd logic in pidfd_getfd. This is somewhat contrary to my
> original view[5], but I think it is best for the principal of
> least surprise to adopt it. This should be cherry-picked into stable.
>
> I tested this on amd64 with the x86-64 and x32 ABIs.
>
> Given there is no testing infrastructure for cgroup v1, I opted to
> forgo adding new tests there as it is considered deprecated.
>
> Changes since v2:
>  * Introducion of the file_receive helper which hoists out logic to
>    manipulate file descriptors outside of seccomp.c to file.c
>  * Small fix that manipulated the socket's cgroup even when the
>    receive failed
>  * seccomp struct layout
> Changes since v1:
>  * find_notification has been cleaned up slightly, and it replaces a use
>    case in send as well.
>  * Fixes ref counting rules to get / release references in the ioctl side=
,
>    rather than the seccomp notifier side [3].
>  * Removes the optional move flag, and opts into SCM_RIGHTS
>  * Rearranges the seccomp_notif_addfd datastructure for greater user
>    clarity [4]. In order to avoid unnamed padding it makes size u64,
>    which is a little bit of a waste of space.
>  * Changes error codes to return ESRCH upon the process going away on
>    notification, and EINPROGRESS is the notification is in an unexpected
>    state (and added tests for this behaviour)
>
> [1]: https://lore.kernel.org/lkml/20190918084833.9369-2-christian.brauner=
@ubuntu.com/
> [2]: https://lore.kernel.org/lkml/20200107175927.4558-1-sargun@sargun.me/
> [3]: https://lore.kernel.org/lkml/20200525000537.GB23230@ZenIV.linux.org.=
uk/
> [4]: https://lore.kernel.org/lkml/20200525135036.vp2nmmx42y7dfznf@wittgen=
stein/
> [5]: https://lore.kernel.org/lkml/20200107175927.4558-1-sargun@sargun.me/
>
> Sargun Dhillon (4):
>   fs, net: Standardize on file_receive helper to move fds across
>     processes
>   pid: Use file_receive helper to copy FDs
>   seccomp: Introduce addfd ioctl to seccomp user notifier
>   selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
>
>  fs/file.c                                     |  56 ++++++
>  include/linux/file.h                          |   2 +
>  include/uapi/linux/seccomp.h                  |  25 +++
>  kernel/pid.c                                  |  20 +-
>  kernel/seccomp.c                              | 184 +++++++++++++++++-
>  net/compat.c                                  |  10 +-
>  net/core/scm.c                                |  14 +-
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 183 +++++++++++++++++
>  8 files changed, 467 insertions(+), 27 deletions(-)
>
> --
> 2.25.1
>
