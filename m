Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4BAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174BE207D5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591022539;
	bh=wgdgPuQe/ZbIcgjxoPiBytv1s+ief8lnvsmb9CloUEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hlYNHG3ky0LxG+k0zlQA65jH5a6Vie5kEa91fUoslDHldK7XBL/cMVbKaAxnqePKD
	 G1q4FtGuRVW02sU+yqLHJR7bNhI6anYp2AfMsZkO5lgZ7Tb+mS7L42Br/1Gv8RBT0e
	 1SfopN6uH5XhDseKi6pe9tVAh85IvFUAPIix3hP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFAOmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgFAOmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:42:17 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451ED207BC;
        Mon,  1 Jun 2020 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591022537;
        bh=wgdgPuQe/ZbIcgjxoPiBytv1s+ief8lnvsmb9CloUEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROi8syQQdUzXIgbOGra96XZ7mil1v95cx7PUjY/ba1x3QCIp4nKA4K3StH66voKvc
         /2j1tOxP8fzcLnr116fweacTbfLBK0+AK/bfCcfvQAcKuss7BIrYQ82EWX/Ih+uKvp
         A4VW0d8ewx6G2Kg2RYfsxOD2xlAKzR6/cd/oE9Ls=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/7] selftests/ftrace: Allow ":" in description
Date:   Mon,  1 Jun 2020 23:42:13 +0900
Message-Id: <159102253287.31199.5076697475734185273.stgit@devnote2>
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

Allow ":" in the description line. Currently if there is ":"
in the test description line, the description is cut at that
point, but that was unintended.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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
 

