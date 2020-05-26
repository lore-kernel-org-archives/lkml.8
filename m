Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A26C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F1F208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520163;
	bh=kRGGgjOgo1DcPwnCKmyH1WLigFc+jT/yp6endMImLxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KXpcgORHyTjF13J/S6aA5EOLBO0IUUj9/Q2Y6maaJSK0TOrGceF7MWgPTBA7zx4N4
	 uO0Pb1XbH7kywBn+uTL7YNO7VuctInUbp+vv137bvOqDyTBKZSuy6jYgbg8GfmVW0H
	 j+AxPFYdkr0NKPfOonTmTnvllMQQyqMoPpmVCywE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391852AbgEZTJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391822AbgEZTJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:09:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABCC720873;
        Tue, 26 May 2020 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520144;
        bh=kRGGgjOgo1DcPwnCKmyH1WLigFc+jT/yp6endMImLxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwck1zldvLC/i1rhEvVvIWDTtXzlxGVyWHItuOwYgkAJCq49pvmsY5vBkit7UlOki
         ELHQ8r868wynNhQl/7C1/+gyiISUmsHjqTJVFPm5LZiOoTpmtwfsfXyvwcSVz0nmDK
         cMUzEHQVAsFGp5VlqJSenqLSy69/Zjhvzw5/w7sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 035/111] ftrace/selftest: make unresolved cases cause failure if --fail-unresolved set
Date:   Tue, 26 May 2020 20:52:53 +0200
Message-Id: <20200526183936.169074403@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit b730d668138cb3dd9ce78f8003986d1adae5523a ]

Currently, ftracetest will return 1 (failure) if any unresolved cases
are encountered.  The unresolved status results from modules and
programs not being available, and as such does not indicate any
issues with ftrace itself.  As such, change the behaviour of
ftracetest in line with unsupported cases; if unsupported cases
happen, ftracetest still returns 0 unless --fail-unsupported.  Here
--fail-unresolved is added and the default is to return 0 if
unresolved results occur.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 144308a757b7..19e9236dec5e 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -17,6 +17,7 @@ echo "		-v|--verbose Increase verbosity of test messages"
 echo "		-vv        Alias of -v -v (Show all results in stdout)"
 echo "		-vvv       Alias of -v -v -v (Show all commands immediately)"
 echo "		--fail-unsupported Treat UNSUPPORTED as a failure"
+echo "		--fail-unresolved Treat UNRESOLVED as a failure"
 echo "		-d|--debug Debug mode (trace all shell commands)"
 echo "		-l|--logdir <dir> Save logs on the <dir>"
 echo "		            If <dir> is -, all logs output in console only"
@@ -112,6 +113,10 @@ parse_opts() { # opts
       UNSUPPORTED_RESULT=1
       shift 1
     ;;
+    --fail-unresolved)
+      UNRESOLVED_RESULT=1
+      shift 1
+    ;;
     --logdir|-l)
       LOG_DIR=$2
       shift 2
@@ -176,6 +181,7 @@ KEEP_LOG=0
 DEBUG=0
 VERBOSE=0
 UNSUPPORTED_RESULT=0
+UNRESOLVED_RESULT=0
 STOP_FAILURE=0
 # Parse command-line options
 parse_opts $*
@@ -280,7 +286,7 @@ eval_result() { # sigval
     $UNRESOLVED)
       prlog "	[${color_blue}UNRESOLVED${color_reset}]"
       UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
-      return 1 # this is a kind of bug.. something happened.
+      return $UNRESOLVED_RESULT # depends on use case
     ;;
     $UNTESTED)
       prlog "	[${color_blue}UNTESTED${color_reset}]"
-- 
2.25.1



