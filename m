Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A29EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F71208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKHrqtqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407213AbgE1UQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407201AbgE1UQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:16:28 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8BDC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:16:26 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id q10so309164qvs.16
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GQWu2f9NZklLdzS60+6PL6niL+TWcaL7F+qGquV9Sfs=;
        b=FKHrqtqa3eX/hMTxYWddZEa9nZwZ+EgoSp0U4z1O+zsruv/JzsOkJxkcT7AwTLQuSm
         DB7/datS6wCAPgguo/zzbtCmiqJS0vH92GN6Bw47Rv7Tg5XnblrXysvgqlU1S4M1VSnX
         pGl3DHxi/TuXF793E99WTgjyfHY3PrgLh04mXcNqPE40Iqww31qL2K6Iqk/Fn6t0pwnN
         y2YQluplGgt51z/TEivFDgPviY2Czk9fgtJd0cw95n3eAG9CJf9jTlXlwS1uoSp9U0SS
         lWUVJkPdHRtbaPedqumv4WF6RqbsBsfaxnORdbtgwK8uW39LrGSYSB5UUTQLrCTUG/C0
         y9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GQWu2f9NZklLdzS60+6PL6niL+TWcaL7F+qGquV9Sfs=;
        b=Fl2LmVdNqNBLyGFX06To3q5QGG36xlzPK81GVW9kd9spfhpig1ursJ+XQo267ZN2DN
         YQmUeLNV8CeE9h8nMUGr0uB7QQKdyGxAP0QfE5UTEs494bJb/1V4arcxtT6gnJS/XZZb
         xsUNwDuhVDlJCJSoloUdEcIjx9e/sneowh47Xhe7IZTTvu/PnPANNZPlapmlt/wG2hsu
         ifgIX6AgLpyEIsFPClDqMDqmn5gr5EdSy44ZhZhe4uJwFOA83WL6u+D+YpwUvB5xILnm
         fFLxQeAd38R/tZn/Yw+Pcr5pKt4UA6J3Sfz4G2bwW/hrusXCaUwswzkHqiYgoUZb3zYy
         W9CA==
X-Gm-Message-State: AOAM530EC/+JTnj56SlXWxzASTNOfGsqMUq+nQyekm74fjcD/B7HGzkW
        oQWcE7EVl5rIUDwJDe/0gWI1+I44rpDB41ad2tG1l3x8MZkZ074WalolHUAzVq07kVBUJcS8o9t
        /IsVwC7Et2P9tjs4oG4mjI+9iCOfxNPxCamqFF6Iw8olK7OqtU4sW13W2cVELmnjxH6f4m4hw
X-Google-Smtp-Source: ABdhPJy9GV4l+facI1wkwZDvgu/LpZCxjhKHu8zuw9pBLwV0bfFJ8JKc356FUr/X1sv4D8mFtNqgQ1GHPF1u
X-Received: by 2002:a05:6214:11f0:: with SMTP id e16mr4834216qvu.37.1590696985936;
 Thu, 28 May 2020 13:16:25 -0700 (PDT)
Date:   Thu, 28 May 2020 13:16:14 -0700
Message-Id: <20200528201614.250182-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] perf/x86/rapl: fix rapl config variable bug
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug introduced by:

commit fd3ae1e1587d6 ("perf/x86/rapl: Move RAPL support to common x86 code")

The Kconfig variable name was wrong. It was missing the CONFIG_ prefix.

Signed-off-by: Stephane Eranian <eraniangoogle.com>

---
 arch/x86/events/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 12c42eba77ec3..9933c0e8e97a9 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= core.o probe.o
-obj-$(PERF_EVENTS_INTEL_RAPL)		+= rapl.o
+obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)	+= rapl.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
-- 
2.27.0.rc2.251.g90737beb825-goog

