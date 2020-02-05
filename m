Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67366C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C622218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580910600;
	bh=VVmc7CELiyFpI5nP8dsFtoRReZ3/i4l0fZ0NTR+BefI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fJOKw2J6dpqiJVlKCeDe15jdilqzKP5NWv77T3aHshAoOs0f3c9nzb4B+ElaU/k2H
	 SmfKFoXVa2Lm4jBZ/8sx6w6ISO4Wg5oZhpOsw3Mymb21KA7NtEv0IubSQi1aES731n
	 uJ9K9cBavEt9fM6oYMRuz/S8wl5AuIrSWYtdRy4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgBENt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgBENt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:49:59 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C54217F4;
        Wed,  5 Feb 2020 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580910598;
        bh=VVmc7CELiyFpI5nP8dsFtoRReZ3/i4l0fZ0NTR+BefI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8V8JxfeB9J5Nmdm1+E4z9zY/t6xnkc8s4Nbz8GH23dg5Cu6jIOiBJD38L74qNf4Z
         ukYXyUEQ5hb/JjeKNckKWHp0sWMhoPNnxz6oU6qltuAbQCCD/wGn96hPtANkHMcv4j
         CCZasq/SzZh30HpqbUjDLm+7OMuX1DS8+BBM0Vgk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/4] bootconfig: Use bootconfig instead of boot config
Date:   Wed,  5 Feb 2020 22:49:54 +0900
Message-Id: <158091059459.27924.14414336187441539879.stgit@devnote2>
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

Use "bootconfig" (1 word) instead of "boot config" (2 words)
in the boot message.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index f174a59d3903..2de2f9f7aab9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -372,7 +372,7 @@ static void __init setup_boot_config(const char *cmdline)
 
 	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
 	if (!copy) {
-		pr_err("Failed to allocate memory for boot config\n");
+		pr_err("Failed to allocate memory for bootconfig\n");
 		return;
 	}
 
@@ -380,9 +380,9 @@ static void __init setup_boot_config(const char *cmdline)
 	copy[size] = '\0';
 
 	if (xbc_init(copy) < 0)
-		pr_err("Failed to parse boot config\n");
+		pr_err("Failed to parse bootconfig\n");
 	else {
-		pr_info("Load boot config: %d bytes\n", size);
+		pr_info("Load bootconfig: %d bytes\n", size);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */

