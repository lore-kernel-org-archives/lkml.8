Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7ABC433E4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35ECA206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJU+sunK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgGFURc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0973FC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:17:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so9195671plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vf4k4Ca2nC/UfmU2LxKOu9rGFn+24YTVR8SOW5pJDec=;
        b=mJU+sunK9zmAyi94aCrQaVMEcNI9fn4lmtE75ZhOryFRcI5/2/Y3okHuI5wzVQTZ0F
         SbtV5x1CJaMOcfiR79RFgYVBA8loddfYiYJUib7+F+erFyU6Xrgp+o/GLSxwl1owwifi
         Oh6VXWDp5quFpNnUiennE/lwBZqWhCr3rnQnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vf4k4Ca2nC/UfmU2LxKOu9rGFn+24YTVR8SOW5pJDec=;
        b=hY/2gQYRnVixk6pmU+8sfXNmhcXEEcTj3/UJnXOC47m8dXyXex4SlA0IY+4KSMKDMi
         ZD1hQyBCvjyIajIMm8/XRe3H/NVTvtQltTWdnSgE/EiscMl1fEJjyCv2kjnm05BJIWf3
         S8h7AZjFdd54q+A9E6IuNXKZtALbETy92HtzsFoY7wbuZfvBGA50czK0X0ADHmtnziLR
         n3R8O7VsA9hB9uyqDBNRIlHAanlVmK9R5qpg7nI0mlsN9t52KrUPcBqZVQfHZ6ualtDB
         MpCJNBq4Y8C6txit1dSipLPk93N+TjjP9qJdlQhR4PVbFsf+QtoTooXWvo4E7pSbR9b+
         oniQ==
X-Gm-Message-State: AOAM533JQvBNybiXYDmGoLQU3CeCB7rE8dsjWfoZII4tx2PevXMLSm9h
        sDgoGTUWMipYB3YnNGgvhBFGyQ==
X-Google-Smtp-Source: ABdhPJzOvQDeykz31VBtkhS2Id0OhcoG/jXjb7a9fQnSucy63QTtpHAuZEVpfeWypZ6tk3Q+EfIw3w==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr42813271plo.270.1594066648526;
        Mon, 06 Jul 2020 13:17:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm291257pjb.34.2020.07.06.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 0/7] Add seccomp notifier ioctl that enables adding fds
Date:   Mon,  6 Jul 2020 13:17:13 -0700
Message-Id: <20200706201720.3482959-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

v6:
- fix missing fput()
- API name change: s/fd_install_received/receive_fd/
v5: https://lore.kernel.org/lkml/20200617220327.3731559-1-keescook@chromium.org/

This continues the thread-merge between [1] and [2]. tl;dr: add a way for
a seccomp user_notif process manager to inject files into the managed
process in order to handle emulation of various fd-returning syscalls
across security boundaries. Containers folks and Chrome are in need
of the feature, and investigating this solution uncovered (and fixed)
implementation issues with existing file sending routines.

I intend to carry this in the for-next/seccomp tree, unless someone
has objections. :) Please review and test!

-Kees

[1] https://lore.kernel.org/lkml/20200603011044.7972-1-sargun@sargun.me/
[2] https://lore.kernel.org/lkml/20200610045214.1175600-1-keescook@chromium.org/


Kees Cook (5):
  net/scm: Regularize compat handling of scm_detach_fds()
  fs: Move __scm_install_fd() to __receive_fd()
  fs: Add receive_fd() wrapper for __receive_fd()
  pidfd: Replace open-coded partial receive_fd()
  fs: Expand __receive_fd() to accept existing fd

Sargun Dhillon (2):
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

 fs/file.c                                     |  67 +++++
 include/linux/file.h                          |  19 ++
 include/linux/net.h                           |   9 +
 include/uapi/linux/seccomp.h                  |  22 ++
 kernel/pid.c                                  |  13 +-
 kernel/seccomp.c                              | 172 ++++++++++++-
 net/compat.c                                  |  55 ++---
 net/core/scm.c                                |  50 +---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 229 ++++++++++++++++++
 9 files changed, 554 insertions(+), 82 deletions(-)

-- 
2.25.1

