Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF87C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B129F24653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582707597;
	bh=kvvOZL6viAJypBnm5PyPuhdkoWN8/vGB+eDjK93fGUI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GvngaVq9RpZcyiraAXU15318g+PsAJ9qHUb6v5E+8CoWDnYWHLMBSHjXgCpegLZWO
	 I5QqF/IzADkXw7U7rZBqjFnhRSUklXIJ1Lane8sMH5TPBfVeo3zDtr9ELffKQYhVnf
	 oklKksaJPGqQbttUA2gXulRs0pUElI8ZNm6IfarA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBZI70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgBZI7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:59:25 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0C0420732;
        Wed, 26 Feb 2020 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582707565;
        bh=kvvOZL6viAJypBnm5PyPuhdkoWN8/vGB+eDjK93fGUI=;
        h=From:To:Cc:Subject:Date:From;
        b=l81FXHMZwEMBMNxjfWYHsn/5fHpsOsUTZf4x9FmLWOveHRowRDpDBTmk10QwmS5By
         5Bno+wrRgdA94/Tczqrc0JYkauMwzIb3V+Rm6vTRevszHUAchrKHPU5e/uwG2cOcpr
         T/M9QOf56WZY9IXL+Ce58ZdIAZ/AsQQNtZu1QT/E=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip V4 0/4] kprobes: Fixes and cleanups
Date:   Wed, 26 Feb 2020 17:59:20 +0900
Message-Id: <158270755997.18966.3544449431956918068.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Here is a collection of fixes and cleanups for kprobes, which have
been submitted previously.

Basically, those were not changed but ported on the top of the
latest -tip tree. Just to distinguish it from previous posts,
I tagged v4 (v3 was last post [1]) on this series. In this v4,
I added 2 fixes which were posted with another RFT series [2].

[1] https://lkml.org/lkml/2020/1/14/1460
[2] https://lkml.org/lkml/2020/1/16/571

Thank you,

---

Masami Hiramatsu (4):
      kprobes: Suppress the suspicious RCU warning on kprobes
      kprobes: Use non RCU traversal APIs on kprobe_tables if possible
      kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
      kprobes: Remove redundant arch_disarm_kprobe() call


 kernel/kprobes.c |   37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
