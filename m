Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31075C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E7C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590589757;
	bh=p8Tj4T6e9pm5BQbrEyV7XK+iFSEGbui3AwBFj4blceg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FebAZoaZyKt0MiRFzoVopihevD2flL0Ka7GPdBIcVRqfNnIDpbm8PZQH6psfI+J7R
	 +FqHwdHoCSY2IH9vYOu2ijz8VsYdfp3W/XHwNFolLq61AkQJDhhC8WjQk8MW46AdEf
	 YL0Fww5IAjdfEi6gOqh0VZqCfKDNeanzYTrv9t7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbgE0O3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389189AbgE0O3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:29:16 -0400
Received: from lenoir.home (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B3C2084C;
        Wed, 27 May 2020 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590589755;
        bh=p8Tj4T6e9pm5BQbrEyV7XK+iFSEGbui3AwBFj4blceg=;
        h=From:To:Cc:Subject:Date:From;
        b=ux0TYu03syUIz1ubSQgIGXiP5Y370WG2Qcyl9S+/O5ULPYyuzx6YA5CpCUdwNjiDC
         SOX6HltyzHxMIGJPGXEdMItr5cev8fATzx9l0kqXCcGGu5a0eixYoiJSkRfy1PDCtr
         IEcHJftQX09xblvNl41NlQubQDhLyS+uw0MbRiCo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jim Somerville <Jim.Somerville@windriver.com>
Subject: [PATCH 0/2] sched/isolation: Isolate unbound kthreads
Date:   Wed, 27 May 2020 16:29:07 +0200
Message-Id: <20200527142909.23372-1-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kthreads are harder to affine and isolate than user tasks. They can't
be placed inside cgroups/cpusets and the affinity for any newly
created kthread is always overriden from the inherited kthreadd's
affinity to system wide. Take that into account for nohz_full.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	sched/core

HEAD: 774258ad06e832e9fbdcf681225d2c29421a100f

Thanks,
	Frederic
---

Marcelo Tosatti (2):
      kthread: Switch to cpu_possible_mask
      isolcpus: Affine unbound kernel threads to housekeeping cpus


 include/linux/sched/isolation.h | 1 +
 kernel/kthread.c                | 6 ++++--
 kernel/sched/isolation.c        | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)
