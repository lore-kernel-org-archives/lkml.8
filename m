Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8408C3B1A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B041E24688
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695387;
	bh=T7uWfjRYwYIvMGHvSLHzXsYWS5MRR42vOXJsYdLx2RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjyxWphQry4reIAf+ok64O88/naZjD8JHUK6h9Qb5PA8CMAvOfdIQf/M0o1CkDWCX
	 BqzGoZImH2ixcJbhN5ZYjs0VBucyyj3UNLXua6BxYVAsImio4eAEiXbz04ZvERSgqF
	 cBkWs8V1KoAt+2CuTwJ2DLjIuLr00D9eZ9lD2kQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgBNPtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbgBNPtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:49:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72E7724650;
        Fri, 14 Feb 2020 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695381;
        bh=T7uWfjRYwYIvMGHvSLHzXsYWS5MRR42vOXJsYdLx2RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wbqn7P1ME16belOwu1JdbKK04L5+aWXCGp5pPL9Pk51xXlRQDQg3YfCxxRSlX5Ods
         OHMwydSJfJ1xdnTcERw2A2laCRl/FEeV6en//61PsZABuxHnbhUpSDbgft5AXos2SK
         srH/TM3U1QBWFgN2g51D8Ii/BTqNTe2yEEz9nktk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 036/542] printk: fix exclusive_console replaying
Date:   Fri, 14 Feb 2020 10:40:28 -0500
Message-Id: <20200214154854.6746-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit def97da136515cb289a14729292c193e0a93bc64 ]

Commit f92b070f2dc8 ("printk: Do not miss new messages when replaying
the log") introduced a new variable @exclusive_console_stop_seq to
store when an exclusive console should stop printing. It should be
set to the @console_seq value at registration. However, @console_seq
is previously set to @syslog_seq so that the exclusive console knows
where to begin. This results in the exclusive console immediately
reactivating all the other consoles and thus repeating the messages
for those consoles.

Set @console_seq after @exclusive_console_stop_seq has stored the
current @console_seq value.

Fixes: f92b070f2dc8 ("printk: Do not miss new messages when replaying the log")
Link: http://lkml.kernel.org/r/20191219115322.31160-1-john.ogness@linutronix.de
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1ef6f75d92f1f..fada22dc4ab6c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2770,8 +2770,6 @@ void register_console(struct console *newcon)
 		 * for us.
 		 */
 		logbuf_lock_irqsave(flags);
-		console_seq = syslog_seq;
-		console_idx = syslog_idx;
 		/*
 		 * We're about to replay the log buffer.  Only do this to the
 		 * just-registered console to avoid excessive message spam to
@@ -2783,6 +2781,8 @@ void register_console(struct console *newcon)
 		 */
 		exclusive_console = newcon;
 		exclusive_console_stop_seq = console_seq;
+		console_seq = syslog_seq;
+		console_idx = syslog_idx;
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
-- 
2.20.1

