Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29908C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038B620674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Vdd2eqWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404332AbgHQTmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbgHQPYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:24:32 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0E4C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:24:32 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b2so7939602qvp.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ouSI1fmyjCntwkXvcneKy2HMb4z/YqQB4UaucGM5G0Y=;
        b=Vdd2eqWvFrDEP81j55aAGX78kvn3o7e5PdhKBfLbtGXSxnZXEFS6rNF/rNyAuLbiId
         XAIjZxMjdkeI2BHrQgpKtsu4A99B1E2wWYMOiQAEcV45tNhN+AmeunsfqNljum1qmsGp
         FYfBdcuJnRnf02FgwuoTFernXAY68L33k3cu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ouSI1fmyjCntwkXvcneKy2HMb4z/YqQB4UaucGM5G0Y=;
        b=MESwOO/E5Ugrpf013uffEkgzpuQfX94AhYVlxJ9vsLL9Mp6L30JHfUotIznVBqK4K4
         v5WtTD41jeBCbrpVVyVEecfXCL9DaAdY2kDjOnxbvTvQiM/uIBZTYwvqc3AnpDCQG6Zh
         blPvqEaCnSvpaX60lRxVLI/clFvvNHNssABBTQA0tK5V56q2IP2xoXAnSO0DlIUQgs2i
         Rf1MrdpfW4uPnWN13S7S4MtOr9qx282L7mwRMuP3L2GOUiap2tuP1SGt0Nt+gO8J3qNN
         PFuBJ1yW6urEMAfjWgf3Mp972eIhN/KmW0RLm5oOPVV0ghuM1EplkXe8v6ghZakSgssw
         Pukw==
X-Gm-Message-State: AOAM532vDrvF4RZoPgiK2qqo9FWhS7i/YJAzlt6uMN9pXiaQc/MfLAZk
        hW3H1p1em6DIeQuyd7UlTXKV1cweQuJvucDIOAI=
X-Google-Smtp-Source: ABdhPJyyv2xXWPrLIBu7N4Y0+Z1a5cPzlfs3fyYI6SBL3A/7lcjOwOjhex5two4mD3qVApuTRMZIiQ==
X-Received: by 2002:ad4:5742:: with SMTP id q2mr15301837qvx.83.1597677870937;
        Mon, 17 Aug 2020 08:24:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:47cc])
        by smtp.gmail.com with ESMTPSA id g11sm17602002qke.128.2020.08.17.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:24:30 -0700 (PDT)
Date:   Mon, 17 Aug 2020 16:24:29 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: [PATCH 1/2] x86: Prevent userspace MSR access from dominating the
 console
Message-ID: <8ebda3f90bca583f12969892e0f0e97166c4d492.1597677395.git.chris@chrisdown.name>
References: <cover.1597677395.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597677395.git.chris@chrisdown.name>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applications which manipulate MSRs from userspace often do so
infrequently, and all at once. As such, the default printk ratelimit
architecture supplied by pr_err_ratelimited doesn't do enough to prevent
kmsg becoming completely overwhelmed with their messages and pushing
other salient information out of the circular buffer. In one case, I saw
over 80% of kmsg being filled with these messages, and the default kmsg
buffer being completely filled less than 5 minutes after boot(!).

This change makes things much less aggressive, while still achieving the
original goal of fiter_write(). Operators will still get warnings that
MSRs are being manipulated from userspace, but they won't have other
also potentially useful messages pushed out of the kmsg buffer.

Of course, one can boot with `allow_writes=1` to avoid these messages at
all, but that then has the downfall that one doesn't get _any_
notification at all about these problems in the first place, and so is
much less likely to forget to fix it. One might rather it was less
binary: it was still logged, just less often, so that application
developers _do_ have the incentive to improve their current methods,
without us having to push other useful stuff out of the kmsg buffer.

This one example isn't the point, of course: I'm sure there are plenty
of other non-ideal-but-pragmatic cases where people are writing to MSRs
from userspace right now, and it will take time for those people to find
other solutions.

Overall, this patch keeps the intent of the original patch, while
mitigating its sometimes heavy effects on kmsg composition.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 arch/x86/kernel/msr.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 49dcfb85e773..3babb0e58b0e 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -80,18 +80,27 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 
 static int filter_write(u32 reg)
 {
+	/*
+	 * Banging MSRs usually happens all at once, and can easily saturate
+	 * kmsg. Only allow 1 MSR message every 30 seconds.
+	 *
+	 * We could be smarter here and do it per-MSR, or whatever, but it would
+	 * certainly be more complex, and this is enough at least to stop
+	 * completely saturating the ring buffer.
+	 */
+	static DEFINE_RATELIMIT_STATE(fw_rs, 30 * HZ, 1);
+
 	switch (allow_writes) {
 	case MSR_WRITES_ON:  return 0;
 	case MSR_WRITES_OFF: return -EPERM;
 	default: break;
 	}
 
-	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
+	if (!__ratelimit(&fw_rs) || reg == MSR_IA32_ENERGY_PERF_BIAS)
 		return 0;
 
-	pr_err_ratelimited("Write to unrecognized MSR 0x%x by %s\n"
-			   "Please report to x86@kernel.org\n",
-			   reg, current->comm);
+	pr_err("Write to unrecognized MSR 0x%x by %s\n"
+	       "Please report to x86@kernel.org\n", reg, current->comm);
 
 	return 0;
 }
-- 
2.28.0

