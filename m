Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F64BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2141720663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="AQ0PVm5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgFCBNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCBNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:13:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A301C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 18:13:36 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so186902pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 18:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yEU/E/zVcsMNA7MOTATWLrC20i2Z/QyfV6gOSYm084g=;
        b=AQ0PVm5sNefKPxKryme0FM/PUjnc1S6udB9emTmbswOXmgDeWj5o1gEXAunUxOUHNi
         Tlsu/ldzZeEZ6eeo3W5anDbSXlhhBGLhfCf5yNSYbN42c9tQYst+sGZqdHbQUG9KWCYg
         221p8uegLM9t8IBh4T/KjsmbfpzstwiGTYu2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yEU/E/zVcsMNA7MOTATWLrC20i2Z/QyfV6gOSYm084g=;
        b=mVhIWXd53oaKck2DkW2O2p8cTJ8L3pksTviuk9U4fjnwPgla2Aig0J1fECUi0JhgQJ
         mHY+NV8IHchKt2i/hemN0M6P3ZXMng6kDf1gJuNXnnAitoCjHp8KivzVpajL7EmjNe3E
         hk5pF6GsXK1iCLNoPKbMKwMfaJOMeUIfUPbHLQ/+apqZIvbXK9qd/Xg4MrTpm7E0PmxA
         Gvi/6y3lp7OHDF2bzc+vKHHBHYFMrL9S+3OaAXQ3zznhf3patCsQhJwpzDWleAGUXBFY
         aYPXgl+jKH6/4XxKLAT2bm4Tym2kE1vDfsC6elP003ttDNaB3SBQsxKnaP3SeWMMlWWw
         NRhQ==
X-Gm-Message-State: AOAM533ubgVBdLp27O+TKdxQ+oxGEgJLwloL/W9QrvEcXF4zx6BvMi7u
        D89d8wrT0n3HFpigCuaOBjp1kJV6g1FCOQlb
X-Google-Smtp-Source: ABdhPJzPtPE9c9MQBeniQkiDi6w7igULoD6gkrv/Iq6Tb6CDzsbjVqdIC34ET3KFbGQJeH+PbxrgEQ==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr25191514pll.252.1591146815609;
        Tue, 02 Jun 2020 18:13:35 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id a12sm263222pjw.35.2020.06.02.18.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 18:13:34 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 0/4] Add seccomp notifier ioctl that enables adding fds
Date:   Tue,  2 Jun 2020 18:10:40 -0700
Message-Id: <20200603011044.7972-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the capability for seccomp notifier listeners to add file
descriptors in response to a seccomp notification. This is useful for
syscalls in which the previous capabilities were not sufficient. The
current mechanism works well for syscalls that either have side effects
that are system / namespace wide (mount), or that operate on a specific
set of registers (reboot, mknod), and don't require dereferencing pointers.
The problem with derefencing pointers in a supervisor is that it leaves
us vulnerable to TOC-TOU [1] style attacks. For syscalls that had a direct
effect on file descriptors pidfd_getfd was added, allowing for those file
descriptors to be directly operated upon by the supervisor [2].

Unfortunately, this leaves system calls which return file descriptors
out of the picture. These are fairly common syscalls, such as openat,
socket, and perf_event_open that return file descriptors, and have
arguments that are pointers. These require that the supervisor is able to
verify the arguments, make the call on behalf of the process on hand,
and pass back the resulting file descriptor. This is where addfd comes
into play.

There is an additional flag that allows you to "set" an FD, rather than
add it with an arbitrary number. This has dup2 style semantics, and
installs the new file at that file descriptor, and atomically closes
the old one if it existed. This is useful for a particular use case
that we have, in which we want to swap out AF_INET sockets for AF_UNIX,
AF_INET6, and sockets in another namespace when doing "upconversion".

My specific usecase at Netflix is to enable our IPv4-IPv6 transition
mechanism, in which we our namespaces have no real IPv4 reachability,
and when it comes time to do a connect(2), we get a socket from a
namespace with global IPv4 reachability.

In addition, we intend to use it for our servicemesh, and where our
service mesh needs to intercept traffic ingress traffic, the addfd
capability will act as a mechanism to do socket activation.

Addfd is not implemented as a separate syscall, a la pidfd_getfd, as
VFS makes some optimizations in regards to the fdtable, and assumes
that they are not modified by external processes. Although a mechanism
that scheduled something in the context of the task could work, it is
somewhat simpler to do it in the context of the ioctl as we control
the task while in kernel. In addition there are not obvious needs
for this beyond seccomp notifier.

This mechanism leaves a potential issue that if the manager is
interrupted while injecting FDs, the child process will be left with
leaked / dangling FDs. This may lead to undefined behaviour. A
mechanism to work around this is to extend the structure and add a
"rollback" mechanism for FDs to be closed if things fail.

This introduces a new helper -- file_receive, which is responsible
for moving fds across processes. The helper replaces code in
SCM_RIGHTS. In SCM_RIGHTS compat codepath there was a bug that
resulted in this not being set all. This fixes that bug, and should
be cherry-picked into long-term. The file_receive change should
probably go into stable. The file_receive code also replaced the
receive fd logic in pidfd_getfd. This is somewhat contrary to my
original view[5], but I think it is best for the principal of
least surprise to adopt it. This should be cherry-picked into stable.

I tested this on amd64 with the x86-64 and x32 ABIs.

Given there is no testing infrastructure for cgroup v1, I opted to
forgo adding new tests there as it is considered deprecated.

Changes since v2:
 * Introducion of the file_receive helper which hoists out logic to
   manipulate file descriptors outside of seccomp.c to file.c
 * Small fix that manipulated the socket's cgroup even when the
   receive failed
 * seccomp struct layout
Changes since v1:
 * find_notification has been cleaned up slightly, and it replaces a use
   case in send as well.
 * Fixes ref counting rules to get / release references in the ioctl side,
   rather than the seccomp notifier side [3].
 * Removes the optional move flag, and opts into SCM_RIGHTS
 * Rearranges the seccomp_notif_addfd datastructure for greater user
   clarity [4]. In order to avoid unnamed padding it makes size u64,
   which is a little bit of a waste of space.
 * Changes error codes to return ESRCH upon the process going away on
   notification, and EINPROGRESS is the notification is in an unexpected
   state (and added tests for this behaviour)

[1]: https://lore.kernel.org/lkml/20190918084833.9369-2-christian.brauner@ubuntu.com/
[2]: https://lore.kernel.org/lkml/20200107175927.4558-1-sargun@sargun.me/
[3]: https://lore.kernel.org/lkml/20200525000537.GB23230@ZenIV.linux.org.uk/
[4]: https://lore.kernel.org/lkml/20200525135036.vp2nmmx42y7dfznf@wittgenstein/
[5]: https://lore.kernel.org/lkml/20200107175927.4558-1-sargun@sargun.me/

Sargun Dhillon (4):
  fs, net: Standardize on file_receive helper to move fds across
    processes
  pid: Use file_receive helper to copy FDs
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

 fs/file.c                                     |  56 ++++++
 include/linux/file.h                          |   2 +
 include/uapi/linux/seccomp.h                  |  25 +++
 kernel/pid.c                                  |  20 +-
 kernel/seccomp.c                              | 184 +++++++++++++++++-
 net/compat.c                                  |  10 +-
 net/core/scm.c                                |  14 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 183 +++++++++++++++++
 8 files changed, 467 insertions(+), 27 deletions(-)

-- 
2.25.1

