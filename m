Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD9AC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC1320732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580290600;
	bh=FovxmkSLoGYjwUy09v29L1DQY/bqCUG4JbwqxUa8464=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k32k5bcTzELn9hC1+hk2BqYHYkQMzWljuIvTUKLmhQUHi4RuiPx3NRYNfsar3oYE9
	 Af984cjB+IUy2m/Oyrl7YpzNtT4D35VWrD0CgRkkZZpa5NotTpHDzmAzI3ZWeEUFtS
	 UWmBjYzc1VrNFzYFhbxBiXvVun1h5VTgVKW8cylw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgA2Jgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:36:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2Jgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:36:39 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DB02070E;
        Wed, 29 Jan 2020 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580290598;
        bh=FovxmkSLoGYjwUy09v29L1DQY/bqCUG4JbwqxUa8464=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zR777BlcnntCXVAWuaWcXn4kv1P3mwCuSrBmPhayY0wk3b9KvsUC6Ggt6udIqmV7i
         lGL0t27SK50tob50qBUQ7wwCxieIre8Ohk6AxGIjD158GrkVOxyklTAncZ6jMZm2/3
         GaW0/YHnUUhs/8eZttFByZUvTQNSoAeA+HWN7+ys=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing/boot: Include required headers and sort it alphabetically
Date:   Wed, 29 Jan 2020 18:36:35 +0900
Message-Id: <158029059514.12381.6597832266860248781.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158029058421.12381.6615257646562417558.stgit@devnote2>
References: <158029058421.12381.6615257646562417558.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include some required (but currently indirectly included)
headers and sort it alphabetically.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 2f616cd926b0..5aad41961f03 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -6,9 +6,16 @@
 
 #define pr_fmt(fmt)	"trace_boot: " fmt
 
+#include <linux/bootconfig.h>
+#include <linux/cpumask.h>
 #include <linux/ftrace.h>
 #include <linux/init.h>
-#include <linux/bootconfig.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/trace.h>
+#include <linux/trace_events.h>
 
 #include "trace.h"
 

