Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEC12075A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596539890;
	bh=ZsU/hULOry9TKZHhrN5V5H96ZNI/FynZMR3y1cPErGg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xzi4lJkpXlpYzw+mYU+jCi4ZWUkzPXenBBhaW3zEuDryoW7gQndncoj0Q0G0P2wTG
	 ejDNAFC3vVELJ2IYYfReSE2E8IiTBqz8SAUezjvyvwzIS2KNUU0ZBx53At4mYMhj+E
	 B55i+xtU55CMQF7vI1Ho1oJ0ErZjoDW14RnqaIlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgHDLPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgHDLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:11:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3595C06179E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 04:10:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so21467622ejx.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LUO7jo3FUXjnHuSWrvkgDc8ShkHl+xvb4QPdJ+Ew7K0=;
        b=AcB2wWn7nJOnOjtAZI2ty9OqmeFFOZFVL45E7BFhX5SPIcW3VtkOR+qUtzz4cW1Amh
         a8QwSKFo98HF2LF0sNlbAVy68HKFTrQ2m67EV0c9+qGFmSiTp+X72J2K3/PZ7T9ADVbS
         /h1t54J7UrFJ78sNMyRK2sf41gsAwjnh/LarowKZHHL2r1yNHBSBSepCMpdRoU3Buw7s
         5wHJzKz/c8XqDwNrpNa0ALWO8mJ0l50I0j+GfwgroCv6ZN+ChdIhHuon7jV4JoKd+nw+
         R/u6km1Y4NvxUq0QhR2oP3HETsWEjNKfMJX4b430uUzWS8EaQ54sr9/ARxAkqxxa/ek/
         gfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=LUO7jo3FUXjnHuSWrvkgDc8ShkHl+xvb4QPdJ+Ew7K0=;
        b=Fiuar4YifZCTMk7m11qsdAb2bjrcTq4SZEuC3FG/4rXRfx3OhkWTLGXemAOjTihB1/
         dvO5SzMA1vrYhqfgAJXXkoI6ywvFz8GoLu7cew8pynK+BqFK6SYneBRtqTuJ81M4/fei
         V+zUODZgt//OIXw2zvE434qrea6sGIcCIye0QebXDWz1RO9oEHswwYu6ZrAG6g6l7b9k
         waAA0QimsYEL/FShE44fJEmTcTtPSl1NeEUDmHOuAvBNzSa9DiOvLwzwcVCvlJi52r/w
         6BuubUomVdml2tputube5cgybSwT6gPRhaM5D/EfTqNhAHcVMEHJH6s008Ff7PSNlRFc
         XcBQ==
X-Gm-Message-State: AOAM532kLexXKzFQmeDgVf2rxdNFDqF71LqOHYpBxD9ul+2ga+D+rrur
        Twgnl+7QIbpGgtGTg5VeA102oZej
X-Google-Smtp-Source: ABdhPJypG2NYj+Y2lkCfCrM/+c7Uccum1Cy8scFtgpAguQCcT1b4iQkv0UpJkrh5TjBkF/ei0Rld9g==
X-Received: by 2002:a17:907:100f:: with SMTP id ox15mr21862836ejb.125.1596539428528;
        Tue, 04 Aug 2020 04:10:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l7sm16762533edn.45.2020.08.04.04.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 04:10:27 -0700 (PDT)
Date:   Tue, 4 Aug 2020 13:10:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [GIT PULL] sched/fifo changes for v5.9
Message-ID: <20200804111025.GA1556312@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/fifo git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-fifo-2020-08-04

   # HEAD: 4fd5750af02ab7bba7c58a073060cc1da8a69173 sched,tracing: Convert to sched_set_fifo()

This tree adds the sched_set_fifo*() encapsulation APIs to remove
static priority level knowledge from non-scheduler code.

The three APIs for non-scheduler code to set SCHED_FIFO are:

 - sched_set_fifo()
 - sched_set_fifo_low()
 - sched_set_normal()

These are two FIFO priority levels: default (high), and a 'low' priority level,
plus sched_set_normal() to set the policy back to non-SCHED_FIFO.

Since the changes affect a lot of non-scheduler code, we kept this in a separate
tree.

When merging to the latest upstream tree there's a conflict in drivers/spi/spi.c,
which can be resolved via:

	sched_set_fifo(ctlr->kworker_task);

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Peter Zijlstra (24):
      sched: Provide sched_set_fifo()
      sched,bL_switcher: Convert to sched_set_fifo*()
      sched,crypto: Convert to sched_set_fifo*()
      sched,acpi_pad: Convert to sched_set_fifo*()
      sched,drbd: Convert to sched_set_fifo*()
      sched,psci: Convert to sched_set_fifo*()
      sched,msm: Convert to sched_set_fifo*()
      sched,drm/scheduler: Convert to sched_set_fifo*()
      sched,ivtv: Convert to sched_set_fifo*()
      sched,mmc: Convert to sched_set_fifo*()
      sched,spi: Convert to sched_set_fifo*()
      sched,powercap: Convert to sched_set_fifo*()
      sched,ion: Convert to sched_set_normal()
      sched,powerclamp: Convert to sched_set_fifo()
      sched,serial: Convert to sched_set_fifo()
      sched,watchdog: Convert to sched_set_fifo()
      sched,irq: Convert to sched_set_fifo()
      sched,locktorture: Convert to sched_set_fifo()
      sched,rcuperf: Convert to sched_set_fifo_low()
      sched,rcutorture: Convert to sched_set_fifo_low()
      sched,psi: Convert to sched_set_fifo_low()
      sched: Remove sched_setscheduler*() EXPORTs
      sched: Remove sched_set_*() return value
      sched,tracing: Convert to sched_set_fifo()


 arch/arm/common/bL_switcher.c            |  3 +-
 crypto/crypto_engine.c                   |  3 +-
 drivers/acpi/acpi_pad.c                  |  3 +-
 drivers/block/drbd/drbd_receiver.c       |  5 +---
 drivers/firmware/psci/psci_checker.c     | 10 +------
 drivers/gpu/drm/msm/msm_drv.c            | 13 +--------
 drivers/gpu/drm/scheduler/sched_main.c   |  3 +-
 drivers/media/pci/ivtv/ivtv-driver.c     |  4 +--
 drivers/mmc/core/sdio_irq.c              |  3 +-
 drivers/platform/chrome/cros_ec_spi.c    | 11 ++-----
 drivers/powercap/idle_inject.c           |  4 +--
 drivers/spi/spi.c                        |  4 +--
 drivers/staging/android/ion/ion_heap.c   |  4 +--
 drivers/thermal/intel/intel_powerclamp.c |  5 +---
 drivers/tty/serial/sc16is7xx.c           |  3 +-
 drivers/watchdog/watchdog_dev.c          |  3 +-
 include/linux/sched.h                    |  3 ++
 kernel/irq/manage.c                      |  6 +---
 kernel/locking/locktorture.c             | 10 ++-----
 kernel/rcu/rcuperf.c                     |  8 ++---
 kernel/rcu/rcutorture.c                  |  7 +----
 kernel/sched/core.c                      | 50 ++++++++++++++++++++++++++++++--
 kernel/sched/psi.c                       |  5 +---
 kernel/trace/ring_buffer_benchmark.c     | 48 +++++++++++++++---------------
 24 files changed, 98 insertions(+), 120 deletions(-)
