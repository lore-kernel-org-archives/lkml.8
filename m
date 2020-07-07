Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BBCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5081520722
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594085588;
	bh=u6fNG2FiXN9ala0D4fABXFTcLSBkJ478pzCy22zTINA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bWc9+7YoY2kslsqz6a6o7OSF3t5qtnH6ga5i1A+qcEESu5mB8psUUJdFaV1BMaPZI
	 mV6+1XGJhVkbwsmAAWwURhpIuqcn+vhtJ05KWQ7YOkbLan3C4v+lpNyQD0zd2M8cBO
	 vNTbwE35xpdD9k9iBkEe8zgzhwdEVcbKr6ft9MRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGGBdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgGGBdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:33:06 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291C5206E6;
        Tue,  7 Jul 2020 01:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594085586;
        bh=u6fNG2FiXN9ala0D4fABXFTcLSBkJ478pzCy22zTINA=;
        h=From:To:Cc:Subject:Date:From;
        b=HF/IICASZBRdz2n/IQazPYMUYW+7qqNlg8pmtCyxRRMvA7cyjITUc93sgP8gdJNdk
         zkxT8S1FxEctwQp7fIneX8yKpNx5CALcYjk2hmGpD/G28f+ZJxmqXFKJj22C+Onnxu
         CV9Q4PRPM081U3fFH/fNgXPYBbN7TlSr0S7lX8iQ=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 0/9] timer: Reduce timers softirq v2
Date:   Tue,  7 Jul 2020 03:32:44 +0200
Message-Id: <20200707013253.26770-1-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No huge change here, just addressed reviews and fixed warnings:

* Reposted patch 1 separately with appropriate "Fixes:" tag and stable Cc'ed:
  https://lore.kernel.org/lkml/20200703010657.2302-1-frederic@kernel.org/

* Fix missing initialization of next_expiry in 4/9 (thanks Juri)

* Dropped "timer: Simplify LVL_START() and calc_index()" and added comments
  to explain current layout instead in 2/9 (thanks Thomas)

* Rewrote changelog of 9/9 (Thanks Thomas)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/softirq-v2

HEAD: 5545d80b7b9bd69ede1c17fda194ac6620e7063f

Thanks,
	Frederic
---

Frederic Weisbecker (9):
      timer: Move trigger_dyntick_cpu() to enqueue_timer()
      timer: Add comments about calc_index() ceiling work
      timer: Optimize _next_timer_interrupt() level iteration
      timers: Always keep track of next expiry
      timer: Reuse next expiry cache after nohz exit
      timer: Expand clk forward logic beyond nohz
      timer: Spare timer softirq until next expiry
      timer: Remove must_forward_clk
      timer: Lower base clock forwarding threshold


 kernel/time/timer.c | 169 ++++++++++++++++++----------------------------------
 1 file changed, 58 insertions(+), 111 deletions(-)
