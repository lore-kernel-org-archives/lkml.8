Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC7EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13548214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599741846;
	bh=d23ElutQoLsVdLLOs3nz6q2kPUfQWTA4Z/VuhTPRCNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b28wC60FKa9LHkWxdafSaqolHyOhM4v2lgDJkRL5L8TRAS8dXjQWPKqhZer78kWac
	 8QvrAOg5CFxnQz763fY+MKFGOzoaVDbAjXn1QqfnGWP3K2akUhoSzL9uAcITmCtz5t
	 njQDjdpe30KFvmr6F5pGq9pxcdSH/r64iIfoloTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgIJMoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730654AbgIJMkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:40:11 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F9A21D90;
        Thu, 10 Sep 2020 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741570;
        bh=d23ElutQoLsVdLLOs3nz6q2kPUfQWTA4Z/VuhTPRCNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1KeAjvxnrUSt8kuM5CyHb8jFIS0ciUzBq+pN9QmrkxPyIQamcVeUt2Na+NAwNC0R
         CEGxK0Xk+eve9aoen6RUnr7aFcvg+AekAQzd9Abnx4LYOJ4sahiaBTskdJRhjTg8Li
         3wImoC1wjDfQnwAyTleW6ylxmnWBNlLies1iBKho=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6/6] Documentation: tracing: Add the startup timing of boot-time tracing
Date:   Thu, 10 Sep 2020 21:39:27 +0900
Message-Id: <159974156678.478751.10215894815285734481.stgit@devnote2>
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

Add the note about when to start the boot-time tracing.
This will be needed for the people who wants to trace
earlier boot sequence.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/boottime-trace.rst |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index c216f5695ae2..3931b43f902c 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -120,6 +120,20 @@ instance node, but those are also visible from other instances. So please
 take care for event name conflict.
 
 
+When to Start
+=============
+
+All boot-time tracing options starting with ``ftrace`` will be enabled at the
+end of core_initcall. This means you can trace the events from postcore_initcall.
+Most of the subsystems and architecture dependent drivers will be initialized
+after that (arch_initcall or subsys_initcall). Thus, you can trace those with
+boot-time tracing.
+If you want to trace events before core_initcall, you can use the options
+starting with ``kernel``. Some of them will be enabled eariler than the initcall
+processing (for example,. ``kernel.ftrace=function`` and ``kernel.trace_event``
+will start before the initcall.)
+
+
 Examples
 ========
 

