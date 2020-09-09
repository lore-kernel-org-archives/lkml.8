Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55EDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B02A2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670649;
	bh=ogv/C8I6ZojbyuAx2d/UMxnsYt0XhYHd4Mzwe1oJCto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sz5rA8BYgeO3qXboqxFdwyomJk/Rlr+2+qwsuL68Rk545aZv+AxEeUBOGora+dxfp
	 /DKF9OBHTqEop1hFuvqUAn5DegSgeMZutussmsh1CTYuCK8g7VCZ1kGH8zGvvF91aV
	 P7Exd/ZOPWiXVYK+lfVGIM5gtuX3KY1fXXtFnAQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgIIQ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3129D21D93;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=ogv/C8I6ZojbyuAx2d/UMxnsYt0XhYHd4Mzwe1oJCto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZ8bZ+V2YUlsrOuS2rMRtfdNhZLNDBKrZIdoRzjXHNWly1ip2GNc6TVRIxc9gToVt
         FVh1C5Qej5HLmbs5Ek0bAhvb/hvYOr4nLTOX9StbWQh31pHslKLWSx5yDwMjPlA4Dj
         pGpHKOsKV0Dbk0wfcHn2OrWucqg9Fusz5zxW6L5s=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWl-5X; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/30] docs: trace: fix the location of kprobes.rst
Date:   Wed,  9 Sep 2020 16:10:37 +0200
Message-Id: <a6d4c62e19ab1510789418a3a5ad42980cd7ae3a.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was moved out of staging.

Fixes: 2165b82fde82 ("docs: Move kprobes.rst from staging/ to trace/")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/trace/kprobetrace.rst | 2 +-
 samples/kprobes/kprobe_example.c    | 2 +-
 samples/kprobes/kretprobe_example.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index c1709165c553..10850a9e9af3 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -40,7 +40,7 @@ Synopsis of kprobe_events
  MEMADDR	: Address where the probe is inserted.
  MAXACTIVE	: Maximum number of instances of the specified function that
 		  can be probed simultaneously, or 0 for the default value
-		  as defined in Documentation/staging/kprobes.rst section 1.3.1.
+		  as defined in Documentation/trace/kprobes.rst section 1.3.1.
 
  FETCHARGS	: Arguments. Each probe can have up to 128 args.
   %REG		: Fetch register REG
diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index a02f53836ee1..365905cb24b1 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -5,7 +5,7 @@
  * stack trace and selected registers when kernel_clone() is called.
  *
  * For more information on theory of operation of kprobes, see
- * Documentation/staging/kprobes.rst
+ * Documentation/trace/kprobes.rst
  *
  * You will see the trace data in /var/log/messages and on the console
  * whenever kernel_clone() is invoked to create a new process.
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 0c40f7236989..5dc1bf3baa98 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -11,7 +11,7 @@
  * If no func_name is specified, kernel_clone is instrumented
  *
  * For more information on theory of operation of kretprobes, see
- * Documentation/staging/kprobes.rst
+ * Documentation/trace/kprobes.rst
  *
  * Build and insert the kernel module as done in the kprobe example.
  * You will see the trace data in /var/log/messages and on the console
-- 
2.26.2

