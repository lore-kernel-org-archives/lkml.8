Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC400C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBB4221EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gyaeLGZz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EOKHiAaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgIKHEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgIKHCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:02:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA4C061573;
        Fri, 11 Sep 2020 00:02:29 -0700 (PDT)
Date:   Fri, 11 Sep 2020 07:02:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599807747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrGPCWWHuiJjupwNMX8lbIYoM9RCGbxcWDJVBjHnebM=;
        b=gyaeLGZzGiBfJR7cfmtx5iCaXZX7UiDumWSwCAI/wYYEca7Lgz9V1ZknnlDv9zuKQb+5Pb
        jv/LtWCuQksD4vR+Fo/PYVSnEI4IKOc6hnN7OLWUF38jCFCcZmIuE3J0u6CT6iUn3YzIoa
        oxslZz0KW1p3c9wDQvXIm6IEBlwXEE/voJ17dpCkzKccdVeg1MUVKklc7md/BEagLg78Kl
        Zl3HFy3wg+1CK/Fp+GuPo2KDYNXcoiD4UBxPoI351kcZ0MhtY1EzEVXlvMArDC51s9gC+V
        8bo8pnkJkLtfTh+1FRKOA+dzZN43oHpCQpYU0mRnt5Pfp0Gd48tr8ZO34HyRig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599807747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrGPCWWHuiJjupwNMX8lbIYoM9RCGbxcWDJVBjHnebM=;
        b=EOKHiAaC11iEf79jLuTEGitsdq5l+T+Idy4jNv48sgj8YLcrspFyPJlUkmLqFgnRDBVvlr
        EVxrPoXmvL+JkoAw==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Add AMD Fam19h RAPL support
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200908214740.18097-8-kim.phillips@amd.com>
References: <20200908214740.18097-8-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <159980774646.20229.10577640478101769643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a77259bdcb62a2c345914df659a1fbc421269a8b
Gitweb:        https://git.kernel.org/tip/a77259bdcb62a2c345914df659a1fbc421269a8b
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 08 Sep 2020 16:47:40 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:36 +02:00

perf/x86/rapl: Add AMD Fam19h RAPL support

Family 19h RAPL support did not change from Family 17h; extend
the existing Fam17h support to work on Family 19h too.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200908214740.18097-8-kim.phillips@amd.com
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 67b411f..7c0120e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -815,6 +815,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
+	X86_MATCH_VENDOR_FAM(AMD,	0x19,		&model_amd_fam17h),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
