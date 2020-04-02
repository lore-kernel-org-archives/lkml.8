Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B09206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585834838;
	bh=rz2+GteyJrzbWIPIj35ZivysRJ4T6eGUOUcXNkw/XKc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=F4ALi8KLXr/FMANWgFbWzL8GODO/h6HLn0oUw8dB+YSHuR3L6iu+dz4AM5YbrlrXS
	 rSkQLKcUHBCg+VVQ9jV2uEN2jR4WzUIyqX3Ku4Ez7YUUvZKPbx+8hxidn/FPcTkNnN
	 uPe0akZ1jjNG52FUrFQXfY7vLTMVu4BJCxZO5Uvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbgDBNkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388520AbgDBNkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:40:36 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B4CE206E9;
        Thu,  2 Apr 2020 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585834836;
        bh=rz2+GteyJrzbWIPIj35ZivysRJ4T6eGUOUcXNkw/XKc=;
        h=From:To:Cc:Subject:Date:From;
        b=WUK84Bm1qyWj0G0JCDsJUZTQUGWeqjHPYKQJttXvs5jSOdaGVsTS5QZwtNiwal+c+
         ihtlHePAYSmhj6ITA0BjXYyZQIHXUi3enGykmDPA3nXrq6pUGSIBRy4BIoloj0LIJl
         8CkQfMPjD4kTRcRNBBntbqbLCtTRI5zvS3ukxQHk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: [PATCH -tip V5 0/4] kprobes: Fixes mutex, rcu-list warnings and cleanups
Date:   Thu,  2 Apr 2020 22:40:31 +0900
Message-Id: <158583483116.26060.10517933482238348979.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 5th version of the series for kprobes.
I just updated the series on the latest tip/master branch and
add Fixes and Cc tag to [3/4].

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
