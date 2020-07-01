Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BD2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2867F207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565838;
	bh=cKbr0JVUbGa1rdBzJUE+pp3lp4Xeb9PtaK1zjeoyBPo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lRujn4P76FpSbrMnil12LBrBzi9N6kKqQe9JyEZ5CuW9hp0Qlm9RtdxCLHRTzFPX/
	 BF/V99X8G9hW02bVOb5nF0GfcKcHDGygG4pxjw5sYSiMa2p3LkWIw0I8f0uRlnzKgn
	 FATYpGq3uBgV/krV/Q273Lk6OZqjuJ80lmUb1cbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgGABKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgGABKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:36 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69D22065D;
        Wed,  1 Jul 2020 01:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565836;
        bh=cKbr0JVUbGa1rdBzJUE+pp3lp4Xeb9PtaK1zjeoyBPo=;
        h=From:To:Cc:Subject:Date:From;
        b=QixgyfsCQp5NEXZo6Kxh8J8/IC44YAiWpcvOVv2yQAcBdFGD20KJNGKDQx9iL2lM9
         AwoCPThXhIPNt+0ny6HOA87tPVOJGTX8wIv+cUaKU5D0NdnY1vAf6S8UE8A2feYodA
         TyqV1WygF0f6AFRESpfPJjcJC0Y9tFegyIdd8AsI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 00/10] timer: Reduce timers softirq (and other optimizations)
Date:   Wed,  1 Jul 2020 03:10:20 +0200
Message-Id: <20200701011030.14324-1-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juri Lelli has reported that threaded IRQs don't go along well with
full dynticks.

The tick never manages to stop due to the following endless loop:

* Timer tick raises timer softirq
* Ksoftirqd wakes up, restarts the tick (2 tasks in the runqueue)
* Timer tick raises timer softirq
* Ksoftirqd wakes up, etc...

The main issue here is that the tick fires the timer tick unconditionally,
whether timers have expired or not. This set is a proposal to lower that.

The 1st patch is actually a bugfix for a theoretical issue that I haven't
observed in practice. But who knows?

Patch 2 is a consolidation.

Patch 3 and 4 are optimizations.

The rest is about timer softirqs.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/softirq

HEAD: d0567dd5546d1f32eca3772a431488f8b0ac26a1

Thanks,
	Frederic
---

Frederic Weisbecker (10):
      timer: Prevent base->clk from moving backward
      timer: Move trigger_dyntick_cpu() to enqueue_timer()
      timer: Simplify LVL_START() and calc_index()
      timer: Optimize _next_timer_interrupt() level iteration
      timers: Always keep track of next expiry
      timer: Reuse next expiry cache after nohz exit
      timer: Expand clk forward logic beyond nohz
      timer: Spare timer softirq until next expiry
      timer: Remove must_forward_clk
      timer: Lower base clock forwarding threshold


 kernel/time/timer.c | 179 +++++++++++++++++++---------------------------------
 1 file changed, 64 insertions(+), 115 deletions(-)
