Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8CFC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4EF24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCIUYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgCIUYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:24:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977C324671;
        Mon,  9 Mar 2020 20:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jBOxH-00340v-HS; Mon, 09 Mar 2020 16:24:51 -0400
Message-Id: <20200309202451.415031054@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 09 Mar 2020 16:22:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-linus][PATCH 2/4] ktest: Make default build option oldconfig not randconfig
References: <20200309202231.580868511@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

For the last time, I screwed up my ktest config file, and the build went
into the default "randconfig", blowing away the .config that I had set up.
The reason for the default randconfig was because when this was first
written, I wanted to do a bunch of randconfigs. But as time progressed,
ktest isn't about randconfig anymore, and because randconfig destroys the
config in the build directory, it's a dangerous default to have. Use
oldconfig as the default.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 2 +-
 tools/testing/ktest/sample.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 220d04f958a6..6a605ba75dd6 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -30,7 +30,7 @@ my %default = (
     "EMAIL_WHEN_STARTED"	=> 0,
     "NUM_TESTS"			=> 1,
     "TEST_TYPE"			=> "build",
-    "BUILD_TYPE"		=> "randconfig",
+    "BUILD_TYPE"		=> "oldconfig",
     "MAKE_CMD"			=> "make",
     "CLOSE_CONSOLE_SIGNAL"	=> "INT",
     "TIMEOUT"			=> 120,
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 10af34819642..27666b8007ed 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -505,7 +505,7 @@
 #TEST = ssh user@machine /root/run_test
 
 # The build type is any make config type or special command
-#  (default randconfig)
+#  (default oldconfig)
 #   nobuild - skip the clean and build step
 #   useconfig:/path/to/config - use the given config and run
 #              oldconfig on it.
-- 
2.25.0


