Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBA0C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28CA206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255693;
	bh=rEJ6H4/AJvOgw2t1KU/iZXtjapKGf5UoV2N8eG7umdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L3G8vcYYkAX+rVAWqoSV+sAfi5b6cU22Sr/nI0RTIy/hlf6XZSq8zwNh2kJEW+sQU
	 oCljhTcNiWpkbWv0+t0VE9qCv/Xed0jjsWdWm3G0UGU6kijjd025tkPyJagDtoNQYI
	 ITj/95GhZDgcPqQexUVXqJMdMZL48x2bwW0UDH4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgD3NwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbgD3Nv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:51:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42AFE208DB;
        Thu, 30 Apr 2020 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254718;
        bh=rEJ6H4/AJvOgw2t1KU/iZXtjapKGf5UoV2N8eG7umdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9y5IkW3I4fOBjLT6kQfJJ8CDH95QTRWuvwPeIx6/WS1oO9StvIdXOKp94rT+892A
         gxRpDMyrR+CtKbDQ7gqOlx6j2hCcpejrquzAZAfz9FA/7njWqwJma8Pl4JjyF2cRFV
         7rYo7Z8Mp5vHzEjEhYpbVqx+RpkDtL92LMpEVOQM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 66/79] ftrace: Fix memory leak caused by not freeing entry in unregister_ftrace_direct()
Date:   Thu, 30 Apr 2020 09:50:30 -0400
Message-Id: <20200430135043.19851-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit 353da87921a5ec654e7e9024e083f099f1b33c97 ]

kmemleak reported the following:

unreferenced object 0xffff90d47127a920 (size 32):
  comm "modprobe", pid 1766, jiffies 4294792031 (age 162.568s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 22 01 00 00 00 00 ad de  ........".......
    00 78 12 a7 ff ff ff ff 00 00 b6 c0 ff ff ff ff  .x..............
  backtrace:
    [<00000000bb79e72e>] register_ftrace_direct+0xcb/0x3a0
    [<00000000295e4f79>] do_one_initcall+0x72/0x340
    [<00000000873ead18>] do_init_module+0x5a/0x220
    [<00000000974d9de5>] load_module+0x2235/0x2550
    [<0000000059c3d6ce>] __do_sys_finit_module+0xc0/0x120
    [<000000005a8611b4>] do_syscall_64+0x60/0x230
    [<00000000a0cdc49e>] entry_SYSCALL_64_after_hwframe+0x49/0xb3

The entry used to save the direct descriptor needs to be freed
when unregistering.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fd81c7de77a70..63089c70adbb6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5155,6 +5155,7 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 			list_del_rcu(&direct->next);
 			synchronize_rcu_tasks();
 			kfree(direct);
+			kfree(entry);
 			ftrace_direct_func_count--;
 		}
 	}
-- 
2.20.1

