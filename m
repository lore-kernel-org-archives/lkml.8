Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF5AC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF5D216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340651;
	bh=SAmhZ94kAm6nE8pFR6LQ+iQqbeuid7sTq8jwZcfG5/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WF3k+VwNDVr9KGg/OtzeJP6a8zSwGgdkeJ1Aj8ts6S2VMEZ3mdUWyIKeQWUjr1Sop
	 UeJbZVzmXFMMN9ai0+t0vQSp0QnSpNy3tCryHoDweurPCUxWezjpUrSjgzo/B9cnGz
	 fpUmK5sgJvKzVhMyj7dSl87EguDgF9M+Het/vQvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgEANoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731717AbgEANoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:44:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89FB205C9;
        Fri,  1 May 2020 13:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340647;
        bh=SAmhZ94kAm6nE8pFR6LQ+iQqbeuid7sTq8jwZcfG5/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtXF8czHrqkHqjiVyL76DLhmhdYjUPZB7iSOYmULv4oFIa32IMRqGVXCNoT92T4gq
         QLxAqGZW+NE+o6JVfsoZ1b/P3Yrjb/r5U+1JWwEba0f5twL5IFG3QAso+xGXYQMqoz
         lWcvD/Xrsgi6PN6FNCrX3h/gC3x8y/kFmM9AYWX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 071/106] signal: check sig before setting info in kill_pid_usb_asyncio
Date:   Fri,  1 May 2020 15:23:44 +0200
Message-Id: <20200501131552.648364843@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

[ Upstream commit eaec2b0bd30690575c581eebffae64bfb7f684ac ]

In kill_pid_usb_asyncio, if signal is not valid, we do not need to
set info struct.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/r/f525fd08-1cf7-fb09-d20c-4359145eb940@huawei.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 7938c60e11dd2..9abf962bbde47 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1510,15 +1510,15 @@ int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr,
 	unsigned long flags;
 	int ret = -EINVAL;
 
+	if (!valid_signal(sig))
+		return ret;
+
 	clear_siginfo(&info);
 	info.si_signo = sig;
 	info.si_errno = errno;
 	info.si_code = SI_ASYNCIO;
 	*((sigval_t *)&info.si_pid) = addr;
 
-	if (!valid_signal(sig))
-		return ret;
-
 	rcu_read_lock();
 	p = pid_task(pid, PIDTYPE_PID);
 	if (!p) {
-- 
2.20.1



