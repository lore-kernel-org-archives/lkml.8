Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCFDC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A10520757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341124;
	bh=oxOL24FU0cXDlE8Pssg/a1Kx/+IYd0kIxLiLr1oVbFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QosRy9z1wujJSroHD/Y/AqclTO0xDUZitN1pOQ4LqFBLyTL8bxP/og4zHfsjmCRWa
	 13hb1/ak9URs//eDIhXJ/sto7rLuwZvt13B4VOC5prZmjzNPKDlSq5ya70iAE5alrR
	 7368P6SkEeIfv8aI98NPP+dQFUBpRqvxTLkaU44s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgEANiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbgEANhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:37:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B079424956;
        Fri,  1 May 2020 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340275;
        bh=oxOL24FU0cXDlE8Pssg/a1Kx/+IYd0kIxLiLr1oVbFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgdPXbrnlEcQZ7Zdlxg2fjtyQbhPPYoBN77PCimwAJENYjNala+4rCXtKvv++VlrS
         G4M52huUXzKwpFzDVCeJpBl1FL1SGFSVSQoR3LhqWGeSPXO2byvbBd3pm8fJVqfyaX
         6/HgjpslBtvb5dtiM9wEUo7gEq4wpBJxjrHTGlL0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: [PATCH 2/3] selftests/ftrace: Pick only the first kprobe event to test
Date:   Fri,  1 May 2020 22:37:51 +0900
Message-Id: <158834027133.28357.11196486193798517250.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158834025077.28357.15141584656220094821.stgit@devnote2>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the kprobe/kprobe_args_type.tc reads out all event logs
from the trace buffer, the test can fail if there is another
fork event happens.
Use head command to pick only the first kprobe event from
the trace buffer to test the argument types.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 1bcb67dcae26..81490ecaaa92 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -38,7 +38,7 @@ for width in 64 32 16 8; do
   echo 0 > events/kprobes/testprobe/enable
 
   : "Confirm the arguments is recorded in given types correctly"
-  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
+  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
   check_types $ARGS $width
 
   : "Clear event for next loop"

