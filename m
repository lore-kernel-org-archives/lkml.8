Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC83C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48572207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592302480;
	bh=YOsC4LLGB0qwQzuEjdsQ/IgIA0Osqe8PuO5b9rII9tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q6VSzQ3nsSuo7r063zVB5L7+TyN4JQhqy2ZOtwXbVE5FjqsLBk+M5Dr3//7SpZBzs
	 5GwEhphjnllArkt5yB647rWecQU6/w0GgT8rwnIj0OzETOf32Mixwyo1ewylDlixbS
	 OM8XGICXHDvA0gyz097Gc2QpC4Is4O+Y5mIj5xgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgFPKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgFPKOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:14:37 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858DA20707;
        Tue, 16 Jun 2020 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592302477;
        bh=YOsC4LLGB0qwQzuEjdsQ/IgIA0Osqe8PuO5b9rII9tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvKObokm5xIinxRS7usU65KocXREG2e2lIlqcG+2/JeDwfdnMMzgaNKbVKqzOavT5
         tw0aMOIsPhBMVMPOYye/HQ4j1Mxb6OSQZfuQcr0C44sNGdlaeWkE9IlG9ssmDA6REw
         EsJ00ldYt3SjOHlLbkNl+ITOwpu8YRAoI/MwS97g=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] tools/bootconfig: Add testcase for show-command and quotes test
Date:   Tue, 16 Jun 2020 19:14:34 +0900
Message-Id: <159230247428.65555.2109472942519215104.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159230243779.65555.11413773790099102781.stgit@devnote2>
References: <159230243779.65555.11413773790099102781.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add testcases for the return value of the command to show
bootconfig in initrd, and double/single quotes selecting.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
   - Update patch description.
---
 tools/bootconfig/test-bootconfig.sh |   10 ++++++++++
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

