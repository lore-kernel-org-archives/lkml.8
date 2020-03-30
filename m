Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DECC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D511320780
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C/thCUS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgC3EQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:16:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37342 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3EQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 00:16:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so6229417plm.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 21:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XMXWPpzZEtK+F1U4JzVoOBbs1eIUjiNeM4Rwa2h/6a0=;
        b=C/thCUS8EqotHHh3LKyezd37NuhPVGX4T59/xJA9RXpNnqPk7HV9cIl5HxeHMmj4s4
         oyEOBxw1VEOJVQOmZcwxAPYEV0w8pnblQNF9CphWOYElAH/p1M2Clup6FN9ZWc/FWPGm
         G3EwcnnNGp1Ql3fVJCZub/zx3wwBHhASuXgAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XMXWPpzZEtK+F1U4JzVoOBbs1eIUjiNeM4Rwa2h/6a0=;
        b=na+2YfEnA1xjQH8YfJhOmDFU/dcbLUBkkrFPB53EsZj8rDmwk9xaZ5EQ0FWgm2fb+4
         8SE3cNitUWroNeuz6/X/gGow/BfllvJVDhU2rLRZDC9nvzpdu9MIMPNinpm73Ur+caUr
         kglpzap68yBwn+dyIFou8pMKFZDdlLaDrN7SOudq9WuBLkW2SYI7WxhHcOidlosPjqvq
         2jBWY3DWHw+e+G+Xeihl3C/4jKyivkUYdl8BlOdHq2khTVJSOJzlE8WTQ9vSNBKkB+kf
         LXXsl0KTWpBJdYE9JVuy7gfaHfM1W6AxtbmPTvcNL1l7g2ygrqKRLXHymjdR9p17U4pX
         OU2A==
X-Gm-Message-State: ANhLgQ2YCRL9HfDFLfCBNKOYZ34p7ea3SV02+GnIFj/qlD5now3fp/KL
        hTYl8A+PLo35qmy6JFS6KajzVg==
X-Google-Smtp-Source: ADFU+vuf3zc8w1+cSGu7EMmfo3lY9rnX0p8kn34Ufw93E8FI3L14osLNccTIauB3kPQdrv6LF0fDuA==
X-Received: by 2002:a17:90b:3556:: with SMTP id lt22mr13643656pjb.138.1585541769888;
        Sun, 29 Mar 2020 21:16:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x15sm9051229pfq.107.2020.03.29.21.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 21:16:08 -0700 (PDT)
Date:   Sun, 29 Mar 2020 21:16:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Denton <mpdenton@google.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [GIT PULL] seccomp updates for v5.7-rc1
Message-ID: <202003292114.2252CAEF7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these couple of seccomp updates for v5.7-rc1. They're both
mostly bug fixes that I wanted to have sit in linux-next for a while.
That's done now, so here they are for v5.7.

Thanks!

-Kees

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.7-rc1

for you to fetch changes up to 3db81afd99494a33f1c3839103f0429c8f30cb9d:

  seccomp: Add missing compat_ioctl for notify (2020-03-29 21:10:51 -0700)

----------------------------------------------------------------
updates for seccomp

- allow TSYNC and USER_NOTIF together (Tycho Andersen)
- Add missing compat_ioctl for notify (Sven Schnelle)

----------------------------------------------------------------
Sven Schnelle (1):
      seccomp: Add missing compat_ioctl for notify

Tycho Andersen (1):
      seccomp: allow TSYNC and USER_NOTIF together

 include/linux/seccomp.h                       |  3 +-
 include/uapi/linux/seccomp.h                  |  1 +
 kernel/seccomp.c                              | 15 ++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 74 ++++++++++++++++++++++++++-
 4 files changed, 87 insertions(+), 6 deletions(-)

-- 
Kees Cook
