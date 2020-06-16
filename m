Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E6BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10A720756
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FRqFvjr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFPDZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgFPDZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 23:25:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B6C008632
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 20:25:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n9so7775726plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OccJNbyy0FfcO+NA6C7yQdujZ1D/AqAjCekMSJ8aj8A=;
        b=FRqFvjr6OjkLiohv0sT5U1oo9bD6Ib4bxSZIX8h+h7+J/bnqygBr6USH7j+phNr76Q
         F4vUdJeQo9YhtpUAiEDXiUENq7bOLk4RWEw145LTOX3+UBjOPc7vT4BUJ2rMVm0HCN/S
         zrrQ03Wg1ub1uXhOt1dsf8fWKv7xBwMTu70O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OccJNbyy0FfcO+NA6C7yQdujZ1D/AqAjCekMSJ8aj8A=;
        b=kMSo0nomqPLGXedv2QUQLALMyOyQ+ddJ4Pu8Sui/4C1VC+0yLBqnRfZ1JyDlQuzFlu
         UdTOz9P9ViC3t4VbJ1N/kfAlmJrHsuwuAm412XntQKRqnu9oagbEnhuy2HRd5H51PBff
         wgJtKNirb6dWjJid5mfzto5uu7EcIGmnETjzRbPzfqz9jf7DdR4IU7k7yqNpPXaC3p56
         5WYGekIDjuYvvObHor6bLRx6gzu3ElyzNTfZHlNcJDNpO7fmwUhAhAo/2EEFsUfq/5O0
         mw1z4HcXDWL0EXik2TFutV8yM9vj1wbc+c48NlSkPt4yhRMunx8g1yySnlIzsRybC7hx
         5beA==
X-Gm-Message-State: AOAM531HulLRZQcZe1c8KgRXqGgO+eM3nA43UrhrVBfi4aqq3ukVEnBR
        /RV2n5xXIVVewuauDcfzG6MdwQ==
X-Google-Smtp-Source: ABdhPJxgcK/l6xCXdtSwCQ40JJUAiVgLKoo4hOU48ZEP4FhEZChYl9Se2TmOgyhEb/6Mbtv9TOME9g==
X-Received: by 2002:a17:90a:1617:: with SMTP id n23mr730023pja.80.1592277932181;
        Mon, 15 Jun 2020 20:25:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n2sm15740871pfd.125.2020.06.15.20.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 20:25:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
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
Subject: [PATCH v4 00/11] Add seccomp notifier ioctl that enables adding fds
Date:   Mon, 15 Jun 2020 20:25:13 -0700
Message-Id: <20200616032524.460144-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is a bit of thread-merge between [1] and [2]. tl;dr: add a way for
a seccomp user_notif process manager to inject files into the managed
process in order to handle emulation of various fd-returning syscalls
across security boundaries. Containers folks and Chrome are in need
of the feature, and investigating this solution uncovered (and fixed)
implementation issues with existing file sending routines.

I intend to carry this in the seccomp tree, unless someone has objections.
:) Please review and test!

-Kees

[1] https://lore.kernel.org/lkml/20200603011044.7972-1-sargun@sargun.me/
[2] https://lore.kernel.org/lkml/20200610045214.1175600-1-keescook@chromium.org/

Kees Cook (9):
  net/scm: Regularize compat handling of scm_detach_fds()
  fs: Move __scm_install_fd() to __fd_install_received()
  fs: Add fd_install_received() wrapper for __fd_install_received()
  pidfd: Replace open-coded partial fd_install_received()
  fs: Expand __fd_install_received() to accept fd
  selftests/seccomp: Make kcmp() less required
  selftests/seccomp: Rename user_trap_syscall() to user_notif_syscall()
  seccomp: Switch addfd to Extensible Argument ioctl
  seccomp: Fix ioctl number for SECCOMP_IOCTL_NOTIF_ID_VALID

Sargun Dhillon (2):
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

 fs/file.c                                     |  65 ++++
 include/linux/file.h                          |  16 +
 include/uapi/linux/seccomp.h                  |  25 +-
 kernel/pid.c                                  |  11 +-
 kernel/seccomp.c                              | 181 ++++++++-
 net/compat.c                                  |  55 ++-
 net/core/scm.c                                |  50 +--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 350 +++++++++++++++---
 8 files changed, 618 insertions(+), 135 deletions(-)

-- 
2.25.1

