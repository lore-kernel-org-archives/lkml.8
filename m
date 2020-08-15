Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F889C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A58F2065C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="VOLisn9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgHOWju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgHOWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:39:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96117C061786
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 15:39:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so6222756pgh.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=9FapJhQoBMtbwij74lQLZNQhsqQ3XULhrJx0z/bufEw=;
        b=VOLisn9lMLSxG5HeCc/GDPJVLhYXcUOkPQvtJVbMdZZ+KN13M7x+BfajJZodhzT5dh
         dx/AzKIqzYCj4dzEbB0aouk8GKslw2RKb9llv2xUmgAYs8V2P2ezXoHpW4lFKkVRh/op
         uZ6qGBWM10hVKVjMOQeH68EFZCrIp+ajGasRZzORZLI/+mskyOmVO06uulOFjyYRlZpf
         f23krKSnAncwQ3xBF809DKKLM6JJ4u1RUIs4KFvnJhiw4FsUcPwFjYmtNqv/M3rWzOUS
         LSPE5f3la1ZOovsXrM/rQTMOR6i0tfQqMTJgOguxcBcWfeaThOwX72lhvoiYndnpYDWz
         8Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=9FapJhQoBMtbwij74lQLZNQhsqQ3XULhrJx0z/bufEw=;
        b=Cmeq8jNuJPhrX5+wQQGPv9UhWhwS+oDgHvC7uW12pI1d5FqDci4odd5TNmhig/EQbf
         6VAGKqa3RkbgJOoSzy+2OmibFUi3749kNNcaThhsM2f1oniSEJYZMdUOp+QYb0UvA8aL
         se6HtXO9BbNzcMcmq0k48fiTtWRXzqpu20zZI4V7Oe2OJpcBPptMSDK6+poFTHIhsGQk
         Ui9487CZdPOd5ngohqxwPzx0eksmrB2qphiJAYBC1cITXQN3twiYJoLqxlA93ks5zR9u
         vBhDVtwhPGwfvz4q9yempR6M9W56Js+b71MyyoTa7lsF087Dl6pDtrdiGpIFgY1NUOrQ
         s38g==
X-Gm-Message-State: AOAM533rEQbJ+gUGDtwzvvvSa1rhSlNSy9btZEDLOnNOl+9P3DPvumjP
        /Oo5DKLT4jB/04Y6R0JFrZpfMCqIE/RjCA==
X-Google-Smtp-Source: ABdhPJzsYbLqVxLqhgxvTWlSgTVE59AvXa+OUOnRWknRroNcbhKvWE8v+384QzHP3wr3psM6BiPCTA==
X-Received: by 2002:a62:90:: with SMTP id 138mr6515631pfa.0.1597531182000;
        Sat, 15 Aug 2020 15:39:42 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s22sm13136870pfh.16.2020.08.15.15.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 15:39:41 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:39:41 -0700 (PDT)
X-Google-Original-Date: Sat, 15 Aug 2020 15:39:35 PDT (-0700)
Subject: [GIT PULL] A RISC-V Fix for 5.9
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-9e581f1d-3696-40ba-8a64-b0910d6c85bb@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-5.9-mw0'
The following changes since commit dbf83817315d9ce93b3e5b1c83a167f537245bd8:

  Merge tag 'riscv-for-linus-5.9-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2020-08-07 10:11:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-mw1

for you to fetch changes up to 76d4467a97bd8c4bb01e810a5129c8f96d7dcbf8:

  riscv: Setup exception vector for nommu platform (2020-08-14 16:28:20 -0700)

----------------------------------------------------------------
A RISC-V Fix for 5.9

I collected a single fix during the merge window: we managed to break the early
trap setup on !MMU, this patch fixes it.

The power keeps going on here so I haven't have a chance to give this the
testing I usually would, but I don't have a Kendryte anyway so I doubt I'd pick
up anything subtle even if I was to test.  The patch seems pretty safe and it's
still early, so I don't see any reason to let it sit around.

It's fairly late so if it misses the merge window that's not a big deal.  I'll
definately have stuff for next week, so I'll just start from whenever this
lands.

----------------------------------------------------------------
Qiu Wenbo (1):
      riscv: Setup exception vector for nommu platform

 arch/riscv/kernel/head.S | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)
