Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27799C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F323120772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591088908;
	bh=VfQvDWSn/f05Fb8HRvfqUjtKhARLcQsB2AaWUbTXdcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGrDNIruXM6k5qizfdfiyPRiNbKNw6E4NhVM5u0n2ElHB3xJlPS7S6TwJsLj8VKxo
	 GfORN0V4t4RiGbUG+VdbhnvSA5jFcpn9H8EX/Uaf7zfG6FJbdrEsxjBrg9NFABRaUE
	 p+dlSeb2b9iczXHXRA0y84Y/oGZVW22zK1N97VsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFBJI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgFBJI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:08:26 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C322077D;
        Tue,  2 Jun 2020 09:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591088906;
        bh=VfQvDWSn/f05Fb8HRvfqUjtKhARLcQsB2AaWUbTXdcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEy4PvdC9PkpZOABjM1XsvwzSVeeMrGlg2aPnTPQZDeR4uKxHBQU+1WzyMEYCI97s
         /XEmWoyQBC9/oM1l2mGVPG5ukHr/Np/rdy2V1tSxKwmsVPVlDm2oMEpCoMCqS8+l4n
         LVH5SphXZkWCQ5cowFVuh9bf3U2pniMZHmt3WEJA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 2/7] selftests/ftrace: Return unsupported for the unconfigured features
Date:   Tue,  2 Jun 2020 18:08:21 +0900
Message-Id: <159108890177.42416.7636902056809255360.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159108888259.42416.547252366885528860.stgit@devnote2>
References: <159108888259.42416.547252366885528860.stgit@devnote2>
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
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
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
 

