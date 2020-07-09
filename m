Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C40C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9641D2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLdYWtX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgGIS0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGIS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:26:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D55CC08E763
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:26:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so1352012pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ah/xwyUwLDcO5c6QVFl6V0itB29Y6z2+QXTTe1nwKSY=;
        b=LLdYWtX2Ocxzeqrp4lxxrExn+xcyO48LOp5c6ZDWdc234/u9a5SODz90KAgrKxCN8W
         aNWPR4t1ijUoVqeoqb3RQCycFkimFWJYaV/kEuNOn2ZjD0QBAa0ao6eHZCm5TmkfcCgS
         w6JMIfWsigDUAVICaYgQjKNjyQ0WJHCeBLKpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ah/xwyUwLDcO5c6QVFl6V0itB29Y6z2+QXTTe1nwKSY=;
        b=Pc9a5LRZ6l980e47pRNaJb7pIqWh+R59r7Tvfpzpbhcr1sVWiLGwijwiwjwMMmLfPx
         vkvaopMRWLv4GYzh3mM7KDB/QnQrJMTFe8gWdm3hTfUEJPmr74j3owZK6Hz7hrGzPVkB
         rbm6zTIg14EHAxLUBFVP/zU80Cp9BLIaqoaUFcdnOK4xLLQpqsQtyp6QaiUah/gGlpUp
         tI/7AwtQN9OPBK8wSWd5Qu8lA3raspVGB+H+RhZlh5j5yuW7vVAy0+Iku/RdXIMWW9Cf
         5UEc9I/n9Z4MnfTdYYRwy7XcnijKHCrHudEb1neo6TAfxPTepeycFII8dYzn7u7Q2d9S
         Djeg==
X-Gm-Message-State: AOAM533AaU0XNOaIKUB8OFyXqQJ40f3tSdFj07H77kRDeAEAE17Q+YLi
        pa64/ZVJWKURGrbDzAhAg/WjuQ==
X-Google-Smtp-Source: ABdhPJyj3kXdp3Y89vB25U3RAgnxdfxtaz0Z4xZpDPqeUGcsCQaO8cgdoenYnidhHgf9LaZ0+/Sm6A==
X-Received: by 2002:a65:6089:: with SMTP id t9mr56104275pgu.236.1594319209137;
        Thu, 09 Jul 2020 11:26:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n25sm3462318pff.51.2020.07.09.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:26:47 -0700 (PDT)
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
Subject: [PATCH v7 0/9] Add seccomp notifier ioctl that enables adding fds
Date:   Thu,  9 Jul 2020 11:26:33 -0700
Message-Id: <20200709182642.1773477-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

v7:
- break out sock usage counting fixes into more cleanly backportable pieces
- code style cleanups (christian)
- clarify addfd commit log (christian)
- add ..._SIZE_{VER0,LATEST} and BUILD_BUG_ON()s (christian)
- remove undef (christian)
- fix addfd embedded URL reference numbers
v6: https://lore.kernel.org/lkml/20200706201720.3482959-1-keescook@chromium.org/

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


Kees Cook (7):
  net/compat: Add missing sock updates for SCM_RIGHTS
  pidfd: Add missing sock updates for pidfd_getfd()
  net/scm: Regularize compat handling of scm_detach_fds()
  fs: Move __scm_install_fd() to __receive_fd()
  fs: Add receive_fd() wrapper for __receive_fd()
  pidfd: Replace open-coded receive_fd()
  fs: Expand __receive_fd() to accept existing fd

Sargun Dhillon (2):
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

 fs/file.c                                     |  57 +++++
 include/linux/file.h                          |  19 ++
 include/linux/seccomp.h                       |   4 +
 include/net/sock.h                            |   4 +
 include/uapi/linux/seccomp.h                  |  22 ++
 kernel/pid.c                                  |  14 +-
 kernel/seccomp.c                              | 173 ++++++++++++-
 net/compat.c                                  |  55 ++---
 net/core/scm.c                                |  50 +---
 net/core/sock.c                               |  21 ++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 229 ++++++++++++++++++
 11 files changed, 566 insertions(+), 82 deletions(-)

-- 
2.25.1

