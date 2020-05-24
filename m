Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF1FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E42B2076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="GCKHxVz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbgEXXjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbgEXXjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:39:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E65C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:39:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci23so7775548pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dECFMl9BmmZ3+aYimNGMaHnjr31NSpcMrgo0hG57jSE=;
        b=GCKHxVz/fL3BhDuGXbcUgVZYy3X+rDbmzbLHsW3C2IIIU7jKp9zs7WtQyBn9oXgltU
         oHAedSy3n2UqH1/xJkuE9Xxumx8S/hQzW1Yq12yF1MHOD3sW5o2uqgYtoxqTe7wSX61+
         wVj/v/yR/Dho4fLFJnHRiX62/H9onLke6YIWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dECFMl9BmmZ3+aYimNGMaHnjr31NSpcMrgo0hG57jSE=;
        b=RF9YqUM+CbR10UMvcBE3ujfgSDyW5/hj4JDavTjSzWFFE/nRuoiozUsYSpdyvgGOcr
         tbSugb7m6/SjMn20AhQymyXraGFtOqBN1fL3rPtdQGmffYn7rsIQAQdbgd7ZqeahKfH0
         tDgSVzEXHaay2qrD9t36EATW51SJSKwBDqHI5H2Tco9yNuUUWfa4CW/A99cgFO4wytcQ
         GAFq7No8yrdFBYJ5de5ISpSWol+BFiZCajbUPIZghNCpt50tO0FigLCHgmawApz9iFvG
         TZW439WEw5HEuMHJumFBeVus4j2lxyUl2Aq0+milylL96nTQ8eV/R/BFLphXZkD4vD4k
         KaMw==
X-Gm-Message-State: AOAM533HZGlmdTJlx0s8Lu9UkS8BAlthHUHgapoVk/XYbqPWOnQNwyw+
        agcPYIDEbegTuNJSFwEs+0T8HX84nJ5rCnd8
X-Google-Smtp-Source: ABdhPJw5FNIgchuHVTYQM5hwt4Kd+TtTpK1LkOXfqM8KGDJ9jbvBYAllkAWh1t+0VqQBHZxp31QU/A==
X-Received: by 2002:a17:90a:690f:: with SMTP id r15mr18203328pjj.65.1590363585776;
        Sun, 24 May 2020 16:39:45 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b16sm11633177pfi.74.2020.05.24.16.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:39:45 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com
Subject: [PATCH 0/5] Add seccomp notifier ioctl that enables adding fds
Date:   Sun, 24 May 2020 16:39:37 -0700
Message-Id: <20200524233942.8702-1-sargun@sargun.me>
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
the task while in kernel.

There is an additional flag (move) that was added to enable cgroup
v1 controllers (netprio, classid), and moving sockets, as a socket
can only be associated with one cgroup at a time.

[1]: https://lore.kernel.org/lkml/20190918084833.9369-2-christian.brauner@ubuntu.com/
[2]: https://lore.kernel.org/lkml/20200107175927.4558-1-sargun@sargun.me/

Sargun Dhillon (5):
  seccomp: Add find_notification helper
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
  seccomp: Add SECCOMP_ADDFD_FLAG_MOVE flag to add fd ioctl
  selftests/seccomp: Add test for addfd move semantics

 include/uapi/linux/seccomp.h                  |  33 +++
 kernel/seccomp.c                              | 228 +++++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 235 ++++++++++++++++++
 3 files changed, 479 insertions(+), 17 deletions(-)

-- 
2.25.1

