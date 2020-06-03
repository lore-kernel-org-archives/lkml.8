Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E47C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD8D20674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591152015;
	bh=aIJ1a7rvQXz2M63O+DfYAeyjaSsp4HOq1vGHLd4VTPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e84ByxtmuLIvR0KgZY9S0AWnXjZ1vxhC1Qm9OjskFTOdTayGI6agDG3OrPZ6iccg9
	 iKrvSsxAW7yxRf+N+gZ4zDw5GuoitdWW4mVyVBG5BTdwol/9BsKG4pxwjEmavqiMfW
	 gMb+48FW1yZQWbRHdysL3qdUdtaREtX1nPjwzCfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgFCCkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgFCCkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:40:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464CB20738;
        Wed,  3 Jun 2020 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591152013;
        bh=aIJ1a7rvQXz2M63O+DfYAeyjaSsp4HOq1vGHLd4VTPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ev8fPJDOciRVQOgtRqZjkk45SJrKrrJMXCmlu7JPOp62Z79M05/9Fe3G1UmHTtGYQ
         HbSmVDqdWnLvt8qs4f2laUESYiOItOPprMUoaAWPFNujYK2fXFlWH+IJ6gqq3kOw3E
         mwi1wvNU/RoSRjEv2CUG2BnI4T+07Pkt03Gc0ajI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 1/7] selftests/ftrace: Allow ":" in description
Date:   Wed,  3 Jun 2020 11:40:10 +0900
Message-Id: <159115201005.70027.2043111124794279656.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159115200085.70027.6141550347953439240.stgit@devnote2>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow ":" in the description line. Currently if there is ":"
in the test description line, the description is cut at that
point, but that was unintended.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index a4605b5ee66d..d3f6652311ef 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -263,7 +263,7 @@ CASENO=0
 
 testcase() { # testfile
   CASENO=$((CASENO+1))
-  desc=`grep "^#[ \t]*description:" $1 | cut -f2 -d:`
+  desc=`grep "^#[ \t]*description:" $1 | cut -f2- -d:`
   prlog -n "[$CASENO]$INSTANCE$desc"
 }
 

