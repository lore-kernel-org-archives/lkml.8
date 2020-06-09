Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8327D20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgFIQjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:39:10 -0400
Received: from smtp.asem.it ([151.1.184.197]:62825 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgFIQjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:39:09 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000307121.MSG 
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 18:39:07 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Jun
 2020 18:39:05 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 9 Jun 2020 18:39:05 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] tools: testing: ftrace: trigger: fix spelling mistake
Date:   Tue, 9 Jun 2020 18:38:53 +0200
Message-ID: <20200609163853.1602-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090203.5EDFBB2A.0025,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo: "tigger" --> "trigger"

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc   | 2 +-
 .../selftests/ftrace/test.d/trigger/trigger-stacktrace.tc       | 2 +-
 .../ftrace/test.d/trigger/trigger-trace-marker-hist.tc          | 2 +-
 .../ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
index 177e8d4c4744..bf6374e1f6ae 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
@@ -23,7 +23,7 @@ if [ ! -f events/sched/sched_process_fork/hist ]; then
     exit_unsupported
 fi
 
-echo "Test histogram basic tigger"
+echo "Test histogram basic trigger"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
 for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
index 398c05c4d2a7..6248e6b40704 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
@@ -23,7 +23,7 @@ if [ -z "$FEATURE" ]; then
     exit_unsupported
 fi
 
-echo "Test stacktrace tigger"
+echo "Test stacktrace trigger"
 echo 0 > trace
 echo 0 > options/stacktrace
 echo 'stacktrace' > events/sched/sched_process_fork/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
index ab6bedb25736..01fdfd50b4be 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
@@ -28,7 +28,7 @@ if [ ! -f events/ftrace/print/hist ]; then
     exit_unsupported
 fi
 
-echo "Test histogram trace_marker tigger"
+echo "Test histogram trace_marker trigger"
 
 echo 'hist:keys=common_pid' > events/ftrace/print/trigger
 for i in `seq 1 10` ; do echo "hello" > trace_marker; done
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
index df246e505af7..a7fef298e476 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
@@ -46,7 +46,7 @@ test_trace() {
     done
 }
 
-echo "Test snapshot trace_marker tigger"
+echo "Test snapshot trace_marker trigger"
 
 echo 'snapshot' > events/ftrace/print/trigger
 
-- 
2.17.1

