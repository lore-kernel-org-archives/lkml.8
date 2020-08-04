Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C116C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0197622CA0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgHDU6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgHDU6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A92522D01;
        Tue,  4 Aug 2020 20:58:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340k-006HH4-CY; Tue, 04 Aug 2020 16:58:14 -0400
Message-ID: <20200804205814.263230363@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:57:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 16/17] tools/bootconfig: Add testcases for value override operator
References: <20200804205743.419135730@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add some testcases and examples for value override operator.

Link: https://lkml.kernel.org/r/159482883824.126704.2166030493721357163.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/samples/bad-override.bconf  |  3 +++
 tools/bootconfig/samples/bad-override2.bconf |  3 +++
 tools/bootconfig/samples/good-override.bconf |  6 ++++++
 tools/bootconfig/test-bootconfig.sh          | 13 +++++++++++++
 4 files changed, 25 insertions(+)
 create mode 100644 tools/bootconfig/samples/bad-override.bconf
 create mode 100644 tools/bootconfig/samples/bad-override2.bconf
 create mode 100644 tools/bootconfig/samples/good-override.bconf

diff --git a/tools/bootconfig/samples/bad-override.bconf b/tools/bootconfig/samples/bad-override.bconf
new file mode 100644
index 000000000000..fde6c561512e
--- /dev/null
+++ b/tools/bootconfig/samples/bad-override.bconf
@@ -0,0 +1,3 @@
+key.subkey = value
+# We can not override pre-defined subkeys with value
+key := value
diff --git a/tools/bootconfig/samples/bad-override2.bconf b/tools/bootconfig/samples/bad-override2.bconf
new file mode 100644
index 000000000000..688587cb023c
--- /dev/null
+++ b/tools/bootconfig/samples/bad-override2.bconf
@@ -0,0 +1,3 @@
+key = value
+# We can not override pre-defined value with subkey
+key.subkey := value
diff --git a/tools/bootconfig/samples/good-override.bconf b/tools/bootconfig/samples/good-override.bconf
new file mode 100644
index 000000000000..7d31d5f8fbd8
--- /dev/null
+++ b/tools/bootconfig/samples/good-override.bconf
@@ -0,0 +1,6 @@
+# Override the value
+key.word = 1,2,4
+key.word := 2,3
+
+# No pre-defined key
+key.new.word := "new"
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 3c2ab9e75730..56284b98d8f0 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -117,6 +117,19 @@ xpass grep -q "bar" $OUTFILE
 xpass grep -q "baz" $OUTFILE
 xpass grep -q "qux" $OUTFILE
 
+echo "Override same-key values"
+cat > $TEMPCONF << EOF
+key = bar, baz
+key := qux
+EOF
+echo > $INITRD
+
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xfail grep -q "bar" $OUTFILE
+xfail grep -q "baz" $OUTFILE
+xpass grep -q "qux" $OUTFILE
+
 echo "Double/single quotes test"
 echo "key = '\"string\"';" > $TEMPCONF
 $BOOTCONF -a $TEMPCONF $INITRD
-- 
2.26.2


