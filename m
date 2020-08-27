Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13A6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC86D2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598528801;
	bh=dFaCtuuppbrD9PUodVjJhQzg/FVgaLSvUY9+chkC3vQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JxPpwrQyt4b6Kw35RT2Y6HwaYL/olW36ELB/Umi2GzmlI0o6zpd6juoUdCCJjfDG2
	 yU9s5Rhf+gZ/OMZ0dj8ig0ko1NjUDPvBbXOM/qzfLIg8u8AvL1h+93XwfQsmYhSKFB
	 4ujRPZWcahd5LajBLTvSjw9n5fElumOAN/f/DbuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgH0LqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbgH0LfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:35:24 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE0722B40;
        Thu, 27 Aug 2020 11:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598528124;
        bh=dFaCtuuppbrD9PUodVjJhQzg/FVgaLSvUY9+chkC3vQ=;
        h=From:To:Cc:Subject:Date:From;
        b=0q/xqTUwqCBVTSHCGZC8EQaC9mJL1umNzRZIgiXqZYnwmOgkvSf8URXxItL3vG1PT
         oDgXHagGN6pPrkOP6fj/6UAdmWzpiAx+5gSnp0ZSj2gX4NdZgYEId+/rZYp4fAcS7A
         vRJItWmRmOaRpWDUI+2S6uqAM0L0aYuVNDTDaajg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 00/15] kprobes: Unify kretprobe trampoline handlers
Date:   Thu, 27 Aug 2020 20:35:18 +0900
Message-Id: <159852811819.707944.12798182250041968537.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of the series to unify the kretprobe trampoline handler
implementation across all architectures which are currently kprobes supported.
Previous version is here;

 https://lkml.kernel.org/r/159844957216.510284.17683703701627367133.stgit@devnote2

This series removes the in_nmi() check from pre_kretprobe_handler() since we
can avoid double-lock deadlock from NMI by kprobe_busy_begin/end().
In this version, I also add a patch to use kfree_rcu() for freeing kretprobe
instance objects so that we don't call kfree() in NMI context directly.

The unified generic kretprobe trampoline handler is based on x86 code, which
already support frame-pointer checker. The checker is enabled on arm and arm64
too because I can test it. For other architecutres, currently the checker
is not enabled. If someone wants to enable it, please set the correct
frame pointer to ri->fp and pass it to kretprobe_trampoline_handler() as the
3rd parameter, instead of NULL.

Thank you,

---

Masami Hiramatsu (15):
      kprobes: Add generic kretprobe trampoline handler
      x86/kprobes: Use generic kretprobe trampoline handler
      arm: kprobes: Use generic kretprobe trampoline handler
      arm64: kprobes: Use generic kretprobe trampoline handler
      arc: kprobes: Use generic kretprobe trampoline handler
      csky: kprobes: Use generic kretprobe trampoline handler
      ia64: kprobes: Use generic kretprobe trampoline handler
      mips: kprobes: Use generic kretprobe trampoline handler
      parisc: kprobes: Use generic kretprobe trampoline handler
      powerpc: kprobes: Use generic kretprobe trampoline handler
      s390: kprobes: Use generic kretprobe trampoline handler
      sh: kprobes: Use generic kretprobe trampoline handler
      sparc: kprobes: Use generic kretprobe trampoline handler
      kprobes: Remove NMI context check
      kprobes: Free kretprobe_instance with rcu callback


 arch/arc/kernel/kprobes.c          |   55 +---------------
 arch/arm/probes/kprobes/core.c     |   79 +----------------------
 arch/arm64/kernel/probes/kprobes.c |   79 +----------------------
 arch/csky/kernel/probes/kprobes.c  |   78 +---------------------
 arch/ia64/kernel/kprobes.c         |   79 +----------------------
 arch/mips/kernel/kprobes.c         |   55 +---------------
 arch/parisc/kernel/kprobes.c       |   78 ++--------------------
 arch/powerpc/kernel/kprobes.c      |   55 +---------------
 arch/s390/kernel/kprobes.c         |   81 +----------------------
 arch/sh/kernel/kprobes.c           |   59 +----------------
 arch/sparc/kernel/kprobes.c        |   52 +--------------
 arch/x86/kernel/kprobes/core.c     |  109 +------------------------------
 include/linux/kprobes.h            |   35 +++++++++-
 kernel/kprobes.c                   |  126 +++++++++++++++++++++++++++++-------
 14 files changed, 182 insertions(+), 838 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
