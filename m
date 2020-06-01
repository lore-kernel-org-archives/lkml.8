Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B4520738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591018354;
	bh=PC5kgSrsHcVFlGVkUp3VT5gdPx9bihUEUVKfwDXySTY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FiaUtVdK6Cw334E9n3PwJRZfehVSDdYK9diFnTn3A5lE3tmjsPejLU3u40Ph2tSye
	 fRWDJZx2zsQVH3PTHChmkhVNvNR44pmNnwyI9Ih1cfsJXgItkU4Y2jW5cX+Xk1AtPj
	 S0CMBKsA7NhEL+dxoIpBvP4pCMO+NXgo2btVe5Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFANcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgFANcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:32:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 06:32:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f5so11389608wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YF/qa1S8ksjKBALZwxQsWUkfLKi1FTMMBFWwbwhNM9I=;
        b=VdwPLktNMAqdx+hForuRssNRAQaTFwKC5wpi7Mt/LXmpWXKPA1gTvu1PTpqYrjrrUy
         SuwPg+xXQfrc4xDTclQ+22FOFxYFpjaxOC96AcrczNayqrlDTrcW1U3EHW0jBQIN7/nM
         xOzGxfOTuTVC57uNHds+tNNuorMsAoKyOCZ0hJZJ7FY2cGjP9zN1WfeFThoOy4SYWRon
         tp08laPwFxrjCMEGk1cnQKvEMwTJsQerFfNs+GaexZ11iXM0Ee14AxP7FMmiZsDXtyac
         HoH65P625thzROQBHEUEJ+/ZjPGLHTjYSmLXLBoUYZw5VXgq1f0n0ryoM7yXSa7/Q+6I
         HFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=YF/qa1S8ksjKBALZwxQsWUkfLKi1FTMMBFWwbwhNM9I=;
        b=Uuy4CogbD90FkzPp5pCj1IcGZov6TgjVE5PVhztfAzEAPlR5zXZYl04d7KsmvBxJtA
         1IdbWMbyNJClVcDDHz0mGfo8kXRBwVpPydiuZK7zE8f6JOgZLuudqCs/OHGtnH3F98Tl
         ZigZ8tuoV3LGTjoy09Awif1KnALRN834G6J2+hpG/85SSxCt2+Rpkt5SF6Uq9ML2/QXZ
         i+DDrlil5PFaWnaC3bpjOHdyxP0kLL/ZUu7OaPi48yKhtJq2jROr4rHpu01Xp6OzBsLS
         ly9xtkLbXtrrJ4l1Gxydzu7nXCExQQK2gUIXd5wUOrfUjflOXKiLo+eI6lwqiJd3wa5M
         +nTg==
X-Gm-Message-State: AOAM5333fYlohBPp5lAa6Yghn69xhT0O6+89E/0RMV9oZuyGwi/JSGJv
        ysTXhUnm36yfdGABGUzTkhg=
X-Google-Smtp-Source: ABdhPJxg9fqeZ07PhCHWbSbrEdKybbah6Lt8q9Sx7rn7eB90J5x3a+yqEm2CLqXteOXygxaIlVRTTw==
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr13760606wmj.159.1591018351073;
        Mon, 01 Jun 2020 06:32:31 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b8sm21951082wrs.36.2020.06.01.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:32:30 -0700 (PDT)
Date:   Mon, 1 Jun 2020 15:32:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.8
Message-ID: <20200601133228.GA834929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-06-01

   # HEAD: 19f545b6e07f753c4dc639c2f0ab52345733b6a8 zram: Use local lock to protect per-CPU data

The biggest change to core locking facilities in this cycle is the introduction
of local_lock_t - this primitive comes from the -rt project and identifies
CPU-local locking dependencies normally handled opaquely beind preempt_disable()
or local_irq_save/disable() critical sections.

The generated code on mainline kernels doesn't change as a result, but still there
are benefits: improved debugging and better documentation of data structure
accesses.

The new local_lock_t primitives are introduced and then utilized in a couple of
kernel subsystems. No change in functionality is intended.

There's also other smaller changes and cleanups.

 Thanks,

	Ingo

------------------>
Alex Shi (1):
      locking/rtmutex: Remove unused rt_mutex_cmpxchg_relaxed()

Gustavo A. R. Silva (1):
      locking/lockdep: Replace zero-length array with flexible-array

Ingo Molnar (1):
      mm/swap: Use local_lock for protection

Julia Cartwright (1):
      squashfs: Make use of local lock in multi_cpu decompressor

Mike Galbraith (2):
      connector/cn_proc: Protect send_msg() with a local lock
      zram: Use local lock to protect per-CPU data

Sebastian Andrzej Siewior (2):
      radix-tree: Use local_lock for protection
      zram: Allocate struct zcomp_strm as per-CPU memory

Thomas Gleixner (1):
      locking: Introduce local_lock()


 Documentation/locking/locktypes.rst     | 215 ++++++++++++++++++++++++++++++--
 drivers/block/zram/zcomp.c              |  44 +++----
 drivers/block/zram/zcomp.h              |   5 +-
 drivers/connector/cn_proc.c             |  21 ++--
 fs/squashfs/decompressor_multi_percpu.c |  21 ++--
 include/linux/idr.h                     |   2 +-
 include/linux/local_lock.h              |  54 ++++++++
 include/linux/local_lock_internal.h     |  90 +++++++++++++
 include/linux/radix-tree.h              |  11 +-
 include/linux/swap.h                    |   1 +
 kernel/locking/lockdep.c                |   2 +-
 kernel/locking/rtmutex.c                |   2 -
 lib/radix-tree.c                        |  20 ++-
 mm/compaction.c                         |   6 +-
 mm/swap.c                               | 118 ++++++++++++------
 15 files changed, 502 insertions(+), 110 deletions(-)
 create mode 100644 include/linux/local_lock.h
 create mode 100644 include/linux/local_lock_internal.h
