Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A048C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5D220771
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgFRX5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgFRX4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:56:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8107D21527;
        Thu, 18 Jun 2020 23:56:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jm4Of-003lTt-Ir; Thu, 18 Jun 2020 19:56:41 -0400
Message-ID: <20200618235641.468268341@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 19:56:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 16/17] tools/bootconfig: Add testcase for show-command and quotes test
References: <20200618235556.451120786@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add testcases for the return value of the command to show
bootconfig in initrd, and double/single quotes selecting.

Link: http://lkml.kernel.org/r/159230247428.65555.2109472942519215104.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/test-bootconfig.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index eff16b77d5eb..3c2ab9e75730 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -55,6 +55,9 @@ echo "Apply command test"
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 new_size=$(stat -c %s $INITRD)
 
+echo "Show command test"
+xpass $BOOTCONF $INITRD
+
 echo "File size check"
 xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 9 + 12)
 
@@ -114,6 +117,13 @@ xpass grep -q "bar" $OUTFILE
 xpass grep -q "baz" $OUTFILE
 xpass grep -q "qux" $OUTFILE
 
+echo "Double/single quotes test"
+echo "key = '\"string\"';" > $TEMPCONF
+$BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $TEMPCONF
+cat $TEMPCONF
+xpass grep \'\"string\"\' $TEMPCONF
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD
-- 
2.26.2


