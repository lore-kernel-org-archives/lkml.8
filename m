Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C0C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA8720842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737690;
	bh=jnChr6xfx1BLBTep35l10JmYx7icGyU5b8Qk13BPgbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c3cKi65s0KfWB9sH9E74hF1jxRl8siRPNS1JdNaihlXJiocxCYus6YJYxU/7TH00P
	 jffVk/lrhv/D7MA+oIcPcnQLwMYiD5b5vXFnO5tDQ+Zea56Hh+w3vdcW5AL+hdXXJD
	 lQp5VJiPC/mNvE9sNM32HET0025in6z3oH9EsmIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgAKKOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:14:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbgAKKOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:14:44 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3347120673;
        Sat, 11 Jan 2020 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737684;
        bh=jnChr6xfx1BLBTep35l10JmYx7icGyU5b8Qk13BPgbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scIoXYBVbS4WEvwnzDVur67SJ70M1xl5JDYMiHlhPB7f0Y0EdoKxBsuy53mOTmJ+W
         iY559mpFHa0hr1bNjzLhw3fmFNr3Sb1iFXQqwUi6vave1Ai+mozTvowBZm1X6Jw4pU
         /uPtAjGUTLdrEupMD6QzQwxkM6aO3OJ3g29ox+fM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 22/84] selftests/ftrace: Fix multiple kprobe testcase
Date:   Sat, 11 Jan 2020 10:49:59 +0100
Message-Id: <20200111094853.877097419@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 5cc6c8d4a99d0ee4d5466498e258e593df1d3eb6 ]

Fix multiple kprobe event testcase to work it correctly.
There are 2 bugfixes.
 - Since `wc -l FILE` returns not only line number but also
   FILE filename, following "if" statement always failed.
   Fix this bug by replacing it with 'cat FILE | wc -l'
 - Since "while do-done loop" block with pipeline becomes a
   subshell, $N local variable is not update outside of
   the loop.
   Fix this bug by using actual target number (256) instead
   of $N.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/ftrace/test.d/kprobe/multiple_kprobes.tc      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index ce361b9d62cf..da298f191086 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -25,9 +25,9 @@ while read i; do
   test $N -eq 256 && break
 done
 
-L=`wc -l kprobe_events`
-if [ $L -ne $N ]; then
-  echo "The number of kprobes events ($L) is not $N"
+L=`cat kprobe_events | wc -l`
+if [ $L -ne 256 ]; then
+  echo "The number of kprobes events ($L) is not 256"
   exit_fail
 fi
 
-- 
2.20.1



