Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB1D2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589388441;
	bh=Y1xc6yfMDKKhaCVovhCrcOXTsV2tl+2a+oxwHn0AtlE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xixgSMHfxWD9kJ3nXEG7SZm5AU/Jfyi3jxM/SyvaqCiK1hmdUUPg50XRQ2BBh72V1
	 SxUtugACSmj/HOc2sUSdDhzm8hBZzio5jvcwlmbZTXzyMBTrhHiznrIcz8aMNAq/GR
	 Qv0v5dYCzdE6ZE2w+HnZrNJ/4WiTHC65hsB0V+KA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389680AbgEMQrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbgEMQrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:20 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9505B205ED;
        Wed, 13 May 2020 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388440;
        bh=Y1xc6yfMDKKhaCVovhCrcOXTsV2tl+2a+oxwHn0AtlE=;
        h=From:To:Cc:Subject:Date:From;
        b=E4QN/tVtaqQeoj3CxYqjx7994UJ+YdlE7YraswVp53ZaXBS384Ou23fy+JgRkMdj0
         gs4uYVmf2SRHrUe043f5vumrU/O4jvHkMvk01td2bEsqviOoihYQyLcoyAgpf0gqak
         GyavIFhSWyAqkHzaeHd4Ze1/yX0faKQlpzB5uKok=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 00/10] rcu: Allow a CPU to leave and reenter NOCB state
Date:   Wed, 13 May 2020 18:47:04 +0200
Message-Id: <20200513164714.22557-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a necessary step toward making nohz_full controllable through
cpuset. Next step should be to allow a CPU to be nocb even if it wasn't
part of the nocb set on boot.

The core design of this set is mostly based on suggestions from Paul
of course.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/nohz

HEAD: 31cb4ee9da4e9cc6314498ff22d83f0d872b1a88

Thanks,
	Frederic
---

Frederic Weisbecker (10):
      rcu: Directly lock rdp->nocb_lock on nocb code entrypoints
      rcu: Use direct rdp->nocb_lock operations on local calls
      rcu: Make locking explicit in do_nocb_deferred_wakeup_common()
      rcu: Implement rcu_segcblist_is_offloaded() config dependent
      rcu: Remove useless conditional nocb unlock
      rcu: Make nocb_cb kthread parkable
      rcu: Temporarily assume that nohz full CPUs might not be NOCB
      rcu: Allow to deactivate nocb on a CPU
      rcu: Allow to re-offload a CPU that used to be nocb
      rcu: Nocb (de)activate through sysfs


 include/linux/rcu_segcblist.h |   2 +
 include/linux/rcupdate.h      |   4 ++
 kernel/cpu.c                  |  23 +++++++
 kernel/rcu/rcu_segcblist.c    |   6 +-
 kernel/rcu/rcu_segcblist.h    |   8 ++-
 kernel/rcu/tree.c             |  24 +++----
 kernel/rcu/tree.h             |   2 +-
 kernel/rcu/tree_plugin.h      | 149 ++++++++++++++++++++++++++++++++++--------
 8 files changed, 172 insertions(+), 46 deletions(-)
