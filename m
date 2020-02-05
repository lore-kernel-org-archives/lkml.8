Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD430C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1AC21927
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580910628;
	bh=QMEM7LrTjtYYyKCLDA10l3Iqwiugmnkr2d0PEwMb9CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IGznJhLIdoVbogemPSWw/BXOUGHkKCFuKZ4LUClzXT/HpTXnR42feSJr3QoGxJX/c
	 3Ofw06uh/eZm2ybDaDRWWwH9Xdq6urFXgCblohQMGNhFWSEItkwttAL/rOW9ByMYYo
	 6VlR/V+K32uV28HrQm17ayAQtjpXmNv799+qP6kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgBENu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgBENu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:50:27 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1CE217F4;
        Wed,  5 Feb 2020 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580910627;
        bh=QMEM7LrTjtYYyKCLDA10l3Iqwiugmnkr2d0PEwMb9CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xtjg9QYwl7BsXISBKqogIcN8pJTrMXWxIDTgeQYsEohoouDcDNUTnyn3Ekmvsvexm
         dZMnke8oYVx7JE0tjM9fhb0yFHCPUmfAr70XZZDShX+/Hrlj//oACJgsICtphDHMyT
         EOyQtr/xYc3DNoP0iZsP9ytbk0irz2IqVO/97RfI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/4] bootconfig: Show the number of nodes on boot message
Date:   Wed,  5 Feb 2020 22:50:23 +0900
Message-Id: <158091062297.27924.9051634676068550285.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158091058484.27924.11216788166827115442.stgit@devnote2>
References: <158091058484.27924.11216788166827115442.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the number of bootconfig nodes on boot message.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2de2f9f7aab9..491f1cdb3105 100644
--- a/init/main.c
+++ b/init/main.c
@@ -342,6 +342,7 @@ static void __init setup_boot_config(const char *cmdline)
 	char *data, *copy;
 	const char *p;
 	u32 *hdr;
+	int ret;
 
 	p = strstr(cmdline, "bootconfig");
 	if (!p || (p != cmdline && !isspace(*(p-1))) ||
@@ -379,10 +380,11 @@ static void __init setup_boot_config(const char *cmdline)
 	memcpy(copy, data, size);
 	copy[size] = '\0';
 
-	if (xbc_init(copy) < 0)
+	ret = xbc_init(copy);
+	if (ret < 0)
 		pr_err("Failed to parse bootconfig\n");
 	else {
-		pr_info("Load bootconfig: %d bytes\n", size);
+		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */

