Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7307AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D1C207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591022549;
	bh=1YExi40xGXdY3c2aLLYLqs5VAs1fWH47llqS3lm3EKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NbkeVglOuf7aiwTYXPHDinCWeNUG+H8UAb336lNQw7gJtAc/LxL/ajZ77Y98pnQEn
	 Lf57r2InZIuFJe1YekwXtbB7ZfQFcj1tB6UwpVWjFzCXUix+zylROwXSTxWxrCk5H0
	 N7Cm7fXmYmJ2sDDeKmJvbBWJ6h0ltO8j1XCxiAC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFAOm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAOm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:42:27 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5874C207D5;
        Mon,  1 Jun 2020 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591022547;
        bh=1YExi40xGXdY3c2aLLYLqs5VAs1fWH47llqS3lm3EKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhfhP22tp7x2yH48ei9oMHyuAwgFVudHJDYz8zVGDZ1aks4R1YMvWhWjI4dOqLYFi
         3l+AtMqJP/VYZQfC65HSnMKsTxCSe2dausPrI13Lo3zF51iUHYqU+4nRg7XAr1/BZz
         3ll09tb/CopT+8+hJDai5OOv1BM7ulCacA7Cu9To=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/7] selftests/ftrace: Return unsupported for the unconfigured features
Date:   Mon,  1 Jun 2020 23:42:23 +0900
Message-Id: <159102254289.31199.15357461818950717703.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159102252279.31199.12855129586058455119.stgit@devnote2>
References: <159102252279.31199.12855129586058455119.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As same as other test cases, return unsupported if kprobe_events
or argument access feature are not found.

There can be a new arch which does not port those features yet,
and an older kernel which doesn't support it.
Those can not enable the features.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/direct/kprobe-direct.tc          |    2 +-
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index 801ecb63e84c..e95b744b23e4 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -10,7 +10,7 @@ fi
 
 if [ ! -f kprobe_events ]; then
 	echo "No kprobe_events file -please build CONFIG_KPROBE_EVENTS"
-	exit_unresolved;
+	exit_unsupported;
 fi
 
 echo "Let the module run a little"
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
index 0f60087583d8..b41471f301ab 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -4,7 +4,7 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-grep -q '\$arg<N>' README || exit_unresolved # depends on arch
+grep -q '\$arg<N>' README || exit_unsupported # depends on arch
 grep -A10 "fetcharg:" README | grep -q 'ustring' || exit_unsupported
 grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
 

