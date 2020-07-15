Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B22C20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594828929;
	bh=CeX0MHTmJsHaAB/QS6BONJpBk2doOHrMWAlokkPu28o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H2i0enXbbRuFbwrID9GzMOaCLs575+1FlRdVDrppD2lfwQP0QMkRxcsoC2Htdl1H/
	 PUsIC5lFA2i6h4ackg5wOrHw8VKyKF8QypHTDcH09RpUpmlYZQny0RqwF+QxagHuBn
	 g6e6ZRs8Yilq5iBFl8ZfzLTqRPe6oaQjwMDFWvE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgGOQBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgGOQAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:00:41 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53555206D5;
        Wed, 15 Jul 2020 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594828841;
        bh=CeX0MHTmJsHaAB/QS6BONJpBk2doOHrMWAlokkPu28o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcW2cUilMfq0VRhyOLmDIS6q/a9gLEqOf5YNsxgDpWJG7OctqnXrYujqMVqxgpXip
         26GLAx2IQ9jfkGpzb/tO4j55Jh7cCK1v6YW68iE6tk2xwD9azHtaY8Cb5OZPuqC/lf
         cvSGtsqinIbMwrQWf9m5/3qO1VFtw0w5bx/AReXU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alistair Delva <adelva@google.com>, mhiramat@kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] tools/bootconfig: Add testcases for value override operator
Date:   Thu, 16 Jul 2020 01:00:38 +0900
Message-Id: <159482883824.126704.2166030493721357163.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159482882056.126704.15508672095852220119.stgit@devnote2>
References: <159482882056.126704.15508672095852220119.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some testcases and examples for value override operator.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/samples/bad-override.bconf  |    3 +++
 tools/bootconfig/samples/bad-override2.bconf |    3 +++
 tools/bootconfig/samples/good-override.bconf |    6 ++++++
 tools/bootconfig/test-bootconfig.sh          |   13 +++++++++++++
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

