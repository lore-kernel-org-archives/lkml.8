Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5A0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D39820835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591975433;
	bh=F7Sl8iF2HTDHLNCSmKnG6INFrp4GW1T2ClUzszWv0Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FNEsJlthkpIgt0rSpmnQa7ni/cjWoG1PSQbxySbRf8MEQi63X6UGZzCcZDHDSbk0T
	 YT+Mcs6mvyAyxKbp2JmH7Pj5pKe1uMWz0wWYh7PbPTrcYLYWPYDZV5VBsWCHFFNTby
	 Ks9dxQxb6cU1Ir8czKw+t+Gh4QsE9/2pTEYNOL6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFLPXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgFLPXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:23:48 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A856D208A7;
        Fri, 12 Jun 2020 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591975427;
        bh=F7Sl8iF2HTDHLNCSmKnG6INFrp4GW1T2ClUzszWv0Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBfj/db/kfzFyhv298soYPbeeGayEf/yp4Z+U2fS5JXrr/TzpGLoih2B0ni0x3Lm4
         9MChV0JKHvMu1OqB2z+5dLCKEa5vcEc5sIOWNHJ22j+D5e6kF9E5VLfkgyWASBG3Vn
         k12p3sXB4phjAjGvoh4UNl+buZD6KZ81GnirL44g=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] tools/bootconfig: Add testcase for show-command and quotes test
Date:   Sat, 13 Jun 2020 00:23:44 +0900
Message-Id: <159197542404.80267.8469678731615218528.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159197538852.80267.10091816844311950396.stgit@devnote2>
References: <159197538852.80267.10091816844311950396.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add testcases for applied bootconfig showing command
and double/single quotes issues.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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

