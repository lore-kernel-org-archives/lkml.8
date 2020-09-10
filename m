Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8BAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BED20719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599774672;
	bh=8gKKD/n/aC0dNUujjPiJ2/C+SWzJMIBaw/u5skGiLl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JCsetqXVXvYLha+HrvetyLoBZHWJRALqWKnUz6AFP8sSWyHDm1lOqhljcsenrzYxq
	 95hz5PLQc5AFTACpZr9rx4PVBbh1XdLD6O9+xlbeEieU49fZMXWiGFHmsUH4YYENUC
	 vkPLrWfR1bKYRUQWCydS62ovJup6JdinVeyucNc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgIJVvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbgIJMi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:38:57 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B42520C09;
        Thu, 10 Sep 2020 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741523;
        bh=8gKKD/n/aC0dNUujjPiJ2/C+SWzJMIBaw/u5skGiLl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUNPSnT1Tql0/xtOFjJ7MSDjVl+slyvWyZXsHk/9I9lK/4ErYWKy4LX32IrNNSHAq
         g+9s+Z6bEHZL24J+cO+711tyFLa9SzDdW19YfWZPIITuC/NqBvW985QEqEKXLef7KE
         OFmQR4JHOzpz2lV2GdMwUFKc5gxUFnMoM9AUcaqY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/6] kprobes: Init kprobes in early_initcall
Date:   Thu, 10 Sep 2020 21:38:39 +0900
Message-Id: <159974151897.478751.8342374158615496628.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159974150897.478751.17933810682730471522.stgit@devnote2>
References: <159974150897.478751.17933810682730471522.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init kprobes feature in early_initcall as same as jump_label and
dynamic_debug does, so that we can use kprobes events in earlier
boot stage.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2880cdf37c47..7d1fbdaa7a08 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2528,7 +2528,7 @@ static int __init init_kprobes(void)
 		init_test_probes();
 	return err;
 }
-subsys_initcall(init_kprobes);
+early_initcall(init_kprobes);
 
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,

