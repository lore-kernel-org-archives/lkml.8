Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D78B204EA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0FQClfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgFDKBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgFDKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:01:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197D4C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:01:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a45so2079014pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Clstppy/1La57TBLOjLA/wXNlzifwjjs+dcuhmyrmaM=;
        b=f0FQClfiS3taqRiHZVNQQ/xEoxPu/xT7VUjVZA/dUMwVQlw5oQLsBZsrBsVAMuud5z
         omxOeJKgsRb4M/AiakjwNjFdLagSAb1wYJ3PCu7bAcxesHdFl8zamT89hjwwAiNKGIxI
         bC9/cofrq2DuCMPQTgH5g6pU2zuvUPfgsWx8BHdPZW8loHBAuPwPV3VSQrCuTwYy8JAu
         4VprYlBOiCALNM74NEryhPUfk7bs2b0hjMSbTMxnn9xWNRgYG1pn0fUQaorfVp6gm93h
         kv428ayG3bxzjYwF3E5c+O4VQrm9gfwf59WpXgwq6XLuWfu6UO/w5jM8so1FeVs53wXY
         Mkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Clstppy/1La57TBLOjLA/wXNlzifwjjs+dcuhmyrmaM=;
        b=lPhCFUsMwiDrW66XkjBaNs6I9oXQFuJ5Jz9k08qlcMaHwrPZbdR2LzSSYYJjF4HJsR
         YwbUKsapjUSsJGHWfhNLYRllvYQ8Bqg1tof/2f4UpyYaTdOWLAqQNXe5GJSj7zq9PZ9y
         PrVs2/SztkXecZmfeRgd0PHgZJ4yakOdtzfCY7FHayqJNcBLMGzeI0UY1aM4t8PHPFb6
         VsURkH93xORZoT188cWc/PTbZYS8D+z0LhJkdcXWvZ4/H0JdMn1m6sVcnZ9ABvZyuP2T
         pjrWHFf9cY7G9QspPOiwpBV2eNdLSAEmI99b5zzNYXW7tEeXMPe7KhyR2PNSP4abwRGa
         tJTg==
X-Gm-Message-State: AOAM5306SKOpAigt+ElT45MxXbQ2bfL3WzPqyGwEfB0bLoWVxz2i4cLY
        2jZOnnJpFuCOYU3Z5kqls9FjLA==
X-Google-Smtp-Source: ABdhPJzVjymj2KK9Fb597/6EVryJH8miLwm1wthbBL4tfu3R8Prui6WkFEIdRP6KmrRYYgDI9FEmfw==
X-Received: by 2002:a17:90a:5aa4:: with SMTP id n33mr5297644pji.226.1591264899492;
        Thu, 04 Jun 2020 03:01:39 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id np5sm5786992pjb.43.2020.06.04.03.01.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2020 03:01:38 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 0/4] kdb: Improve console handling
Date:   Thu,  4 Jun 2020 15:31:15 +0530
Message-Id: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set is aimed to improve console handling especially when kdb
operates in NMI context.

Brief description of enhancements:
- Add status check for console prior to invoking corresponding handler.
- Fixup to avoid possible deadlock in NMI context due to usage of locks
  in the console handlers.
- Prefer usage of polling I/O driver mode (lockless APIs) over invocation
  of console handlers.

Changes in v6:
- Replace early_con -> kgdboc_earlycon_io_ops.cons.
- Added Petr's review tag on patch #1, #2 and #3.
- Drop Doug's review tag from patch #4 due to early_con changes which I
  think needs a re-review.

Changes in v5:
- Rebased on top of tags/kgdb-5.8-rc1.
- Get rid of kdb_io_write().
- Fixed issue reported by kbuild test robot.
- Remove is_console from kgdboc_earlycon_io_ops as well.
- Misc. comments.
- Added Doug's review tag.

Changes in v4:
- Use dbg_io_ops->write_char() directly instead of passing it as a
  function pointer.
- Use "struct console" rather than "struct tty_driver" for comparison.
- Make commit descriptions and comments more informative.
- Add review tag for patch #2.

Changes in v3:
- Split patch to have separate patch for console status check.
- New patch to re-factor kdb message emit code.
- New patch to prefer polling I/O over console mode.
- Add code comments to describe usage of oops_in_progress.

Changes in v2:
- Use oops_in_progress directly instead of bust_spinlocks().

Sumit Garg (4):
  kdb: Re-factor kdb_printf() message write code
  kdb: Check status of console prior to invoking handlers
  kdb: Make kdb_printf() console handling more robust
  kdb: Switch to use safer dbg_io_ops over console APIs

 drivers/tty/serial/kgdb_nmi.c |  2 +-
 drivers/tty/serial/kgdboc.c   | 32 +++++++++----------
 drivers/usb/early/ehci-dbgp.c |  3 +-
 include/linux/kgdb.h          |  5 ++-
 kernel/debug/kdb/kdb_io.c     | 72 ++++++++++++++++++++++++++-----------------
 5 files changed, 64 insertions(+), 50 deletions(-)

-- 
2.7.4

