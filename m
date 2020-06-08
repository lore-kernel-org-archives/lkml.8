Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B1AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1118206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662891;
	bh=kRGGgjOgo1DcPwnCKmyH1WLigFc+jT/yp6endMImLxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1gUiw9FzQYwBtgi4/YhXcLYcPSbZOy4EH9W3YSZ+IWFnGegq/Qf+hAY3lpQuxU2QK
	 IHxph5QJAK1wFbfJbRlA8zGb/IUd1KXJdplqm9LtRmthU3rFANGWa5UsBK6BSnnkzL
	 m2djDOVEv/CJbEYtyK9T+y1RhQUvVhvbOkX3yaxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbgFIAev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbgFHXOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A50A215A4;
        Mon,  8 Jun 2020 23:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658073;
        bh=kRGGgjOgo1DcPwnCKmyH1WLigFc+jT/yp6endMImLxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0la07guw795SCBWdnlLyEKkdI2keXQ0xQ0TAGVNKP4k2Qso/fOQmHnvHlDeEsq4Q
         TXQpJRTr+29JxkuwrWC7bVWA41NzGpSBXXyo2kq8KPSdT201gftgUpbtrhn9pwgVa5
         8o989XBXOOFQwnmL/+N27EVsJHFDCz7Xj0YMTamw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 118/606] ftrace/selftest: make unresolved cases cause failure if --fail-unresolved set
Date:   Mon,  8 Jun 2020 19:04:03 -0400
Message-Id: <20200608231211.3363633-118-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

