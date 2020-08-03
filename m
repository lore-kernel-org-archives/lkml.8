Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C854EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E7820A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eBgmDeTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgHCTF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:05:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EB9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:05:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so21337107pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=p4O5OJPYD/axZ/eHBgLKdaZ9QSiU10iFPGcu4nVgfY4=;
        b=eBgmDeTcZnx3Hzk2T9iEtnaGKuGPRtorSB/ME1GsH4Dvw86cc7znefgoYch7Cn/GkD
         JrN2tyjIhdJtICADhJfE7cSL4yxiiNEiDCZre05q/yBSXRtMVT8mxm3Y3Yx3Wm3JRCP2
         vPa6Q+H3FSW7AAFzF31i69K+HzvH/9GMM5ThA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=p4O5OJPYD/axZ/eHBgLKdaZ9QSiU10iFPGcu4nVgfY4=;
        b=aiDCHmUmjj0QcJYTkXi46gZDNvxqfnaMoyheSmCJq2/QXxwfQgo8kVCRTpEn0bZ0Uz
         nUFyaa7AeoU1VSvrkkujWrF+rBmRzyjq7w6RL5acZGUMGCYf8sx3FE1r6qD8BVDD/6ls
         jCiTH1iXdIXZxmB9CB8erQxNONE180rX7Aeum6t1iM1On0ZcipWszZCFIQbEO9taAXJi
         M5ogSRpfM9KNmCLWpzlFeUgTe2Qr1pOET536syma8yZsZ/PP9VNLRMQyGM8Lj9uIqSSA
         fQC952C3BpGJqLGIEkfUDOcmrPbRCrHEJn0uQ4YMo/iZl1FcV1AhE6bZxKhahd666NSn
         5KiA==
X-Gm-Message-State: AOAM530qoMPbtmqprU+QeUFtyseEOaRwwQCKGxQEMgYFpGdi9fiOcwiq
        fkAnjRpAtkx8qzWRzinrhaiDxg==
X-Google-Smtp-Source: ABdhPJxO5tfeJIgLQzuS23/y5vC4pRJL476W8p0iqTt7eYzhX0aJ8OLZwjlUCb/Sq620tuR6U+9awQ==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr15934710plz.8.1596481557141;
        Mon, 03 Aug 2020 12:05:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g129sm3918110pfb.33.2020.08.03.12.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:05:56 -0700 (PDT)
Date:   Mon, 3 Aug 2020 12:05:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Romain Perier <romain.perier@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] tasklets updates for v5.9-rc1
Message-ID: <202008031200.7A9BCE5C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these tasklets updates for v5.9-rc1. These are the
infrastructure updates needed to support converting the tasklet API
to something more modern (and hopefully for removal further down the
road). There is a 300-patch series waiting in the wings to get set out
to subsystem maintainers, but these changes need to be present in the
kernel first. Since this has some treewide changes, I carried this series
for -next instead of paining Thomas with it in -tip, but it's got his Ack.
This is similar to the timer_struct modernization from a while back, but
not nearly as messy (I hope). :)

Thanks!

-Kees

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/tasklets-v5.9-rc1

for you to fetch changes up to 12cc923f1ccc1df467e046b02a72c2b3b321b6a2:

  tasklet: Introduce new initialization API (2020-07-30 11:16:01 -0700)

----------------------------------------------------------------
tasklets API update for v5.9-rc1

- Prepare for tasklet API modernization (Romain Perier, Allen Pais, Kees Cook)

----------------------------------------------------------------
Kees Cook (2):
      usb: gadget: udc: Avoid tasklet passing a global
      treewide: Replace DECLARE_TASKLET() with DECLARE_TASKLET_OLD()

Romain Perier (1):
      tasklet: Introduce new initialization API

 drivers/input/keyboard/omap-keypad.c   |  2 +-
 drivers/input/serio/hil_mlc.c          |  2 +-
 drivers/net/wan/farsync.c              |  4 ++--
 drivers/s390/crypto/ap_bus.c           |  2 +-
 drivers/staging/most/dim2/dim2.c       |  2 +-
 drivers/staging/octeon/ethernet-tx.c   |  2 +-
 drivers/tty/vt/keyboard.c              |  2 +-
 drivers/usb/gadget/udc/snps_udc_core.c |  6 ++---
 drivers/usb/host/fhci-sched.c          |  2 +-
 include/linux/interrupt.h              | 41 +++++++++++++++++++++++++++++-----
 kernel/backtracetest.c                 |  2 +-
 kernel/debug/debug_core.c              |  2 +-
 kernel/irq/resend.c                    |  2 +-
 kernel/softirq.c                       | 18 ++++++++++++++-
 net/atm/pppoatm.c                      |  2 +-
 net/iucv/iucv.c                        |  2 +-
 sound/drivers/pcsp/pcsp_lib.c          |  2 +-
 17 files changed, 70 insertions(+), 25 deletions(-)

-- 
Kees Cook
