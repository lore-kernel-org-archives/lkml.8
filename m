Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E593C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B582082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOwoRCDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgBDRVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:21:42 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:36734 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgBDRVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:21:40 -0500
Received: by mail-wr1-f73.google.com with SMTP id t6so7532611wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/EdK19HAv7xXcKBEepm7DrM633ZSHTkUWpJ8Lb/HPBw=;
        b=kOwoRCDox+ZECsE9pHIMr4EtoDXQDF2fOG9dbo51B1gVx4HvOxcJzovUAJmDLZzI34
         bwER33zSb7DyCkTbovvrhcBW1gIL0m47qqTCHv4NSoZ/bezqWs739WfHpLVEflvUPo2s
         TkoMX+fNJvD6n2dVnr9mzFO4hCZOboqDtekopkSxnOtg4sbkYSax8W6S89lTZraabHqU
         YoeX1EjBo/KrHCD6B4cJaROKqYUREBBclEG9ONHuIfbfnpMN2xPUEZLapa4ANI6UiRso
         yKSjKJ+ulMmr2ZsNrLwklRwoeXF7//JutJnaB0o6OB1xtvy7Lw51B3jLHk2fQ1WB6Msk
         xHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/EdK19HAv7xXcKBEepm7DrM633ZSHTkUWpJ8Lb/HPBw=;
        b=MjYxtOWnqcnOV+QGOorgy7d/QJKsjhWFcSSoAgnK53YdGc3S9Vb2khulC9wdp/jycz
         7zEp2PJlnYSX0PllsStkUkth8Tj3FF9/anmCPrFfKdKDNJjKXCmMW17RDC52YtNZz+jZ
         hqfqtEbVumCb38kZs9i4uAfwBuLRYv6zSyN6OaSo8WrEHmDrYBPDxGDttgv5BvTSu8Ax
         ShT3nEql5yh+ZXSkdv3GfnFk40qPkmu74mQ6ayB0TLaiCqg1iMyFaXlHT1GvGsF3fdyT
         kTClXpMcE9JFog7mS2J2/ApovYpZLJbIc3Ge5SCMWtTDlMoPdj6lDC5fdL/fNBmv8wvU
         ntBw==
X-Gm-Message-State: APjAAAV91OCxCDg1FwET/jS4UJv9UsxuTkYhLQfwbM35VsLpDXiEjSNC
        wVfJ/LpCwgGc1fAsqVUHxzuZYjadVA==
X-Google-Smtp-Source: APXvYqzUesV9YnehhpYzBRc3hWKydie834EHQBvyumDCHzHA5mzK80My2hHFPD1lL94EKDQMnxHIw5OzrQ==
X-Received: by 2002:adf:9b87:: with SMTP id d7mr24109403wrc.64.1580836897715;
 Tue, 04 Feb 2020 09:21:37 -0800 (PST)
Date:   Tue,  4 Feb 2020 18:21:12 +0100
In-Reply-To: <20200204172112.234455-1-elver@google.com>
Message-Id: <20200204172112.234455-3-elver@google.com>
Mime-Version: 1.0
References: <20200204172112.234455-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 3/3] kcsan: Cleanup of main KCSAN Kconfig option
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the rules of the 'KCSAN' Kconfig option by:
  1. implicitly selecting 'STACKTRACE' instead of depending on it;
  2. depending on DEBUG_KERNEL, to avoid accidentally turning KCSAN on if
     the kernel is not meant to be a debug kernel;
  3. updating the short and long summaries.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kcsan | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 020ac63e43617..9785bbf9a1d11 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -4,12 +4,15 @@ config HAVE_ARCH_KCSAN
 	bool
 
 menuconfig KCSAN
-	bool "KCSAN: watchpoint-based dynamic data race detector"
-	depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE
+	bool "KCSAN: dynamic data race detector"
+	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
+	select STACKTRACE
 	help
-	  Kernel Concurrency Sanitizer is a dynamic data race detector, which
-	  uses a watchpoint-based sampling approach to detect races. See
-	  <file:Documentation/dev-tools/kcsan.rst> for more details.
+	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic data race
+	  detector, which relies on compile-time instrumentation, and uses a
+	  watchpoint-based sampling approach to detect data races.
+
+	  See <file:Documentation/dev-tools/kcsan.rst> for more details.
 
 if KCSAN
 
-- 
2.25.0.341.g760bfbb309-goog

