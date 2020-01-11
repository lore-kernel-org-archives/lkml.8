Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BF7C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0789B20882
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738218;
	bh=GmOtnR2Eu61QLEuSN3v9F9H3Vw8HY9Qr0TfA7waih40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RuXmHoMdBgJNZXssqZZDUtXF/NhwYBoX5XJVFMqXJPFBTHoiKfMfFyvuXp92xJaJx
	 TCBb4WyzezaQV2v/tZ1PVV36mI5LwZ/h05hIWNDZeHRremxNYmZfOZxpjipn+/rI2/
	 bOCBeGI8y3RhbLKHIOX0684HwuFfwTlMjGdxsd5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgAKKXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgAKKXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:23:33 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C65D2082E;
        Sat, 11 Jan 2020 10:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738213;
        bh=GmOtnR2Eu61QLEuSN3v9F9H3Vw8HY9Qr0TfA7waih40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofXzKlbBcNRi2mKhAQdVZntCE33P0IUMqmY5u5xinkfTPOah49BhROe8mTT79XHGW
         t11uD/fUm3nYIrSDXyVcmULleVam7GBoKd6H/Kh07G2KDRhclHMw65LmvGezGKB0f7
         /X0x4YZqIYLfRK0wqewjp7tlFmxeXtwsXnKzN+C0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 034/165] selftests/ftrace: Fix to check the existence of set_ftrace_filter
Date:   Sat, 11 Jan 2020 10:49:13 +0100
Message-Id: <20200111094924.024835197@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit fd1baf6ca2ea3550ea47f2bb0bdcf34ec764a779 ]

If we run ftracetest on the kernel with CONFIG_DYNAMIC_FTRACE=n,
there is no set_ftrace_filter and all test cases are failed, because
reset_ftrace_filter() returns an error.
Let's check whether set_ftrace_filter exists in reset_ftrace_filter()
and clean up only set_ftrace_notrace in initialize_ftrace().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 86986c4bba54..5d4550591ff9 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -46,6 +46,9 @@ reset_events_filter() { # reset all current setting filters
 }
 
 reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
+    if [ ! -f set_ftrace_filter ]; then
+      return 0
+    fi
     echo > set_ftrace_filter
     grep -v '^#' set_ftrace_filter | while read t; do
 	tr=`echo $t | cut -d: -f2`
@@ -93,7 +96,7 @@ initialize_ftrace() { # Reset ftrace to initial-state
     disable_events
     [ -f set_event_pid ] && echo > set_event_pid
     [ -f set_ftrace_pid ] && echo > set_ftrace_pid
-    [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
+    [ -f set_ftrace_notrace ] && echo > set_ftrace_notrace
     [ -f set_graph_function ] && echo | tee set_graph_*
     [ -f stack_trace_filter ] && echo > stack_trace_filter
     [ -f kprobe_events ] && echo > kprobe_events
-- 
2.20.1



