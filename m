Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9506C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABAB2067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z73iZVfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgFBQYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:24:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A77C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 09:24:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so4039080wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=P3vrqBjfNDKKP3siR3IdQS6VJvnh0OXHMzs3D2xqe0w=;
        b=z73iZVfSZYY/WgssTyrE6Ezcl2qWjFLtDe4XUeViTmVBt5yERXXR4lRdjSYLIIaYNe
         HPu5gSHq7QjAP5NkHo0GhgCe4tg2NU4nVcpDMqTlmmr1x61ih3FlpshyL7DZa4reB4EJ
         dh5RmHPNMeTo8nEZWUY/SA7W1AzlP5c1VpyM0p/7G5DVCQttz3kO/pKqZ+pijCBpSm6x
         Bt+ueJOT/5vaFmxl1X1dYTdvyAovPmg5tPaW2xENSkcNviDK+zCGmidmiSctulCEaA/Z
         VzgqNrp6JBDfpUWb/Oue3dYNXxf8XEat8VqjLgk39PQLHeMYOU7lgUicmPpCkEEGc4dG
         0tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=P3vrqBjfNDKKP3siR3IdQS6VJvnh0OXHMzs3D2xqe0w=;
        b=V19fnPVEim3NxV5z9lkm8FkdeUjcCVtq6JBcvFWImrzMd6VhDbu0SIIRBQypgzCst0
         RzupWj/24ky35OfOxeBVzUUqHcLDSkHbAd73OkzUeKJZFx479P+aUAcxsUfJH0S85lt7
         05hPhlKcDOFG+t8o+8VcAuLPq8Tkzdr50CoyP5+FU0+lmwLlcvfw+0OluYI7gdKgL87B
         cmesuWrGlBoletswS2JdOcfXZydhkIIY661WmHkLStYnhkX5UuNizv/18IysoT/57Oje
         6raCGYR/+VBoTO0mFutIDgEG5nkDofmsw88DHWThDOmqP9Tb14pOq/P+LD2OGolWj/K3
         K+FA==
X-Gm-Message-State: AOAM533p3G+eIRB4AnL+lQr4xy6q0nVDd/PYu5ZowfPL3d4YRGhRBy9+
        qOHFI51TktrqZkjrz26cNhDXEQ==
X-Google-Smtp-Source: ABdhPJw9tDCs0OnKFet3+yd24gVnj2DKcyW4E7K2Y95YEGo32HkGcyPJ7qslhLeLegUaEVGEprGtjA==
X-Received: by 2002:a5d:6cc1:: with SMTP id c1mr28065505wrc.144.1591115082518;
        Tue, 02 Jun 2020 09:24:42 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a1sm291919wmj.29.2020.06.02.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 09:24:41 -0700 (PDT)
Date:   Tue, 2 Jun 2020 17:24:40 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Wei Li <liwei391@huawei.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Yan <yanaijie@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL] kgdb changes for v5.8-rc1
Message-ID: <20200602162440.l235arjoue5zwzi2@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.8-rc1

for you to fetch changes up to c893de12e1ef17b581eb2cf8fc9018ec0cbd07df:

  kdb: Remove the misfeature 'KDBFLAGS' (2020-06-02 15:15:46 +0100)

----------------------------------------------------------------
kgdb patches for 5.8-rc1

By far the biggest change in this cycle are the changes that allow much
earlier debug of systems that are hooked up via UART by taking advantage
of the earlycon framework to implement the kgdb I/O hooks before handing
over to the regular polling I/O drivers once they are available. When
discussing Doug's work we also found and fixed an broken
raw_smp_processor_id() sequence in in_dbg_master().

Also included are a collection of much smaller fixes and tweaks: a
couple of tweaks to ged rid of doc gen or coccicheck warnings, future
proof some internal calculations that made implicit power-of-2
assumptions and eliminate some rather weird handling of magic
environment variables in kdb.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      kgdb: Drop malformed kernel doc comment

Daniel Thompson (2):
      kgdb: Fix spurious true from in_dbg_master()
      serial: kgdboc: Allow earlycon initialization to be deferred

Douglas Anderson (13):
      kgdb: Disable WARN_CONSOLE_UNLOCKED for all kgdb
      Revert "kgdboc: disable the console lock when in kgdb"
      kgdboc: Use a platform device to handle tty drivers showing up late
      kgdb: Delay "kgdbwait" to dbg_late_init() by default
      kgdb: Prevent infinite recursive entries to the debugger
      kgdboc: Remove useless #ifdef CONFIG_KGDB_SERIAL_CONSOLE in kgdboc
      kgdboc: Add kgdboc_earlycon to support early kgdb using boot consoles
      kgdboc: Disable all the early code when kgdboc is a module
      kgdb: Don't call the deinit under spinlock
      Documentation: kgdboc: Document new kgdboc_earlycon parameter
      serial: qcom_geni_serial: Support kgdboc_earlycon
      serial: 8250_early: Support kgdboc_earlycon
      kdb: Cleanup math with KDB_CMD_HISTORY_COUNT

Jason Yan (1):
      kgdb: Return true in kgdb_nmi_poll_knock()

Sumit Garg (1):
      serial: amba-pl011: Support kgdboc_earlycon

Wei Li (1):
      kdb: Remove the misfeature 'KDBFLAGS'

 Documentation/admin-guide/kernel-parameters.txt |  20 ++
 Documentation/dev-tools/kgdb.rst                |  24 ++
 arch/x86/Kconfig                                |   1 +
 drivers/tty/serial/8250/8250_early.c            |  23 ++
 drivers/tty/serial/amba-pl011.c                 |  32 +++
 drivers/tty/serial/kgdboc.c                     | 318 +++++++++++++++++++++---
 drivers/tty/serial/qcom_geni_serial.c           |  32 +++
 include/linux/kdb.h                             |   2 +-
 include/linux/kgdb.h                            |   8 +-
 kernel/debug/debug_core.c                       |  57 +++--
 kernel/debug/kdb/kdb_main.c                     |  11 +-
 lib/Kconfig.kgdb                                |  18 ++
 12 files changed, 490 insertions(+), 56 deletions(-)
