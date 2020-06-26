Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C48C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8663420775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mt9ekr0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgFZOzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFZOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:55:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5011FC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:55:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so9782109wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HR4bEOxs7v9kCssDbScsWg1pJoSGN7JebNfZuKn5wuo=;
        b=Mt9ekr0ofSNl/CmAF2rA2LbmjOQBfb9ws/Pnfxn+BB5oVzuL8VW1Yu181JEl6/RtZh
         PYK0XUBI+FrHNLDlLfUfPZV3AbnIxwMi0m+JdqjIsT3JFSvga2Tc7PDdIjPklKxxuzuI
         6VY1XWXMIiVLlID7Qdg9drCZcEf+z54TxT7h+st9tTeQ7lzB6z1nf+UWXWutfNx+aWrH
         p6JOpyivN5SvkBnWPSEGq29iXARyLim8Yww7eP+uE7Hirrowhsr65kfasi1I+ztawaaG
         zHovhC88tQD+EGr0RooWpilSFr4ZmqEmtSXUQOQk715ytwkH/LDKbBnetby8lnhRzrS3
         DTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HR4bEOxs7v9kCssDbScsWg1pJoSGN7JebNfZuKn5wuo=;
        b=oBEn/mEE79OlVRZsnoYjZyoT7vp+naohmzSjUqMshd4GKPfLCvU5D2sbVip2yOjagM
         mDcAypBMBPQZp3PQ69woDDt2EeWyM5vCow0iQFJGiW+LUe1Rk3RENTDT5ZinjDhvq1qT
         M9avC0hQ+N/OixRGSx8Ac02w5qa4fsZBzHXwKscV9NzlxneORqr9fIcqFvRzarAMwQTE
         wXlt/+Op1IeoRYtCmsw44UqCwhfFAu+BLnKCqxxzNdxuPZXcXQPS55f9BNYkQ4Mu2KIv
         lm1f1PvyaEE5b4ovRnRwABkHl7ML45q/YetgYVLzWhytR7BUnm5ZgFGsHmGvvqC9+unR
         9onA==
X-Gm-Message-State: AOAM531VbXsjX/LrY02QtQ6frYduIYjEIXDiZSrgd9JIMYIbYFa2ssw6
        2kwj+2Hp0mQCNcK6mJMVZETQSA==
X-Google-Smtp-Source: ABdhPJz18vi8NywzCOBzXPEd4bC5AhA1zgXAV5rZwuNNwHhP4b2oVhim5+ynEc3xCY2m2H0V4NdKAg==
X-Received: by 2002:adf:f08b:: with SMTP id n11mr4127634wro.312.1593183300019;
        Fri, 26 Jun 2020 07:55:00 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u186sm18273745wmu.10.2020.06.26.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 07:54:59 -0700 (PDT)
Date:   Fri, 26 Jun 2020 15:54:57 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [GIT PULL] kgdb changes for v5.8-rc3
Message-ID: <20200626145457.5weza5ow3hrm7kum@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.8-rc3

for you to fetch changes up to 440ab9e10e2e6e5fd677473ee6f9e3af0f6904d6:

  kgdb: Avoid suspicious RCU usage warning (2020-06-26 15:41:40 +0100)

----------------------------------------------------------------
kgdb patches for 5.8-rc3

The main change here is a fix for a number of unsafe interactions
between kdb and the console system. The fixes are specific to kdb (pure
kgdb debugging does not use the console system at all). On systems with
an NMI then kdb, if it is enabled, must get messages to the user despite
potentially running from some "difficult" calling contexts. These fixes
avoid using the console system where we have been provided an
alternative (safer) way to interact with the user and, if using the
console system in unavoidable, use oops_in_progress for deadlock
avoidance. These fixes also ensure kdb honours the console enable flag.

Also included is a fix that wraps kgdb trap handling in an RCU read lock
to avoids triggering diagnostic warnings. This is a wide lock scope but
this is OK because kgdb is a stop-the-world debugger. When we stop the
world we put all the CPUs into holding pens and this inhibits RCU update
anyway.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Douglas Anderson (1):
      kgdb: Avoid suspicious RCU usage warning

Sumit Garg (4):
      kdb: Re-factor kdb_printf() message write code
      kdb: Check status of console prior to invoking handlers
      kdb: Make kdb_printf() console handling more robust
      kdb: Switch to use safer dbg_io_ops over console APIs

 drivers/tty/serial/kgdb_nmi.c |  2 +-
 drivers/tty/serial/kgdboc.c   | 32 +++++++++----------
 drivers/usb/early/ehci-dbgp.c |  3 +-
 include/linux/kgdb.h          |  5 ++-
 kernel/debug/debug_core.c     |  4 +++
 kernel/debug/kdb/kdb_io.c     | 72 ++++++++++++++++++++++++++-----------------
 6 files changed, 68 insertions(+), 50 deletions(-)
