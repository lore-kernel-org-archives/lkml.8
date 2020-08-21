Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B2B2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Kbsdc36n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgHUMLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgHUMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:10:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D357DC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:10:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p4so1132322qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MqJf9BD8aaQfpI0wiUHYQ/V/4yXxXPs1nR1uZGZhmOE=;
        b=Kbsdc36nsGvNLo4WHfy+UEIDEIi4wbk8mi23rdJ1C6/6fW+RC2PAgTHB01sYvLi6hV
         MCgqZDm9iXRQe5TGjlGP/t2cKMg0+3RdtqOE5RfwO0jAxH7NUyo0A4IRwzrUDsGc0wh7
         cgpSgSdes0KLCEueusDEBi3V4o1EI5imIrmfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MqJf9BD8aaQfpI0wiUHYQ/V/4yXxXPs1nR1uZGZhmOE=;
        b=tCUQenaUIAC54Xs1GuAiQHcKJCbXlNYSfh0OP5VEi3+C98y5F3KXYLZPmxjz85qh7W
         +/1Sw/eMZfnnzcrpqPr6BOO/9/ayfXySncwGPg8iWSzWvqfkwUcTz3RYVwowlMOq5R5A
         zsEHb6TQaHx27X3D1gpX5fa08OVsbdBT219MUGwCm/pxC0qm8LUZWDHs5jHsluMpzG8V
         81Q2lX/dF+87oOh+pXMOR59b/C8u4zCqw7CDqoDwzbvOJ6AvnZL3K9J5frWH7B8JCQrC
         2lGqyYhRbVO0osoMVALvzQJ3XEHCl+bhmkVOR9LP5dizfi1kd0wJWS37RUanPyfbaP/c
         CMkQ==
X-Gm-Message-State: AOAM531ks2tzGf0L8/YQo6wC9aGq/H6W9yGVrb2KJ07raNMVkavkH49J
        GbGBLKl2qhk22Lrz6D1nWfrxw/WtTVNe0fJN
X-Google-Smtp-Source: ABdhPJyMEfrPufYaVJkMXEpNV8ZXeid8fOeYKYYmslk6zxLCkyL8PhaywyXDziSO84F1oQqFln39aA==
X-Received: by 2002:a37:6741:: with SMTP id b62mr2431690qkc.217.1598011826696;
        Fri, 21 Aug 2020 05:10:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:23fc])
        by smtp.gmail.com with ESMTPSA id a8sm1809266qth.69.2020.08.21.05.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 05:10:26 -0700 (PDT)
Date:   Fri, 21 Aug 2020 13:10:24 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: [PATCH v2 1/2] x86: Prevent userspace MSR access from dominating the
 console
Message-ID: <563994ef132ce6cffd28fc659254ca37d032b5ef.1598011595.git.chris@chrisdown.name>
References: <cover.1598011595.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598011595.git.chris@chrisdown.name>
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

Make things much less aggressive, while still achieving the original
goal of fiter_write(). Operators will still get warnings that MSRs are
being manipulated from userspace, but they won't have other also
potentially useful messages pushed out of the kmsg buffer.

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

Overall, keep the intent of the original patch, while mitigating its
sometimes heavy effects on kmsg composition.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 arch/x86/kernel/msr.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 49dcfb85e773..eaf375245549 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -80,18 +80,30 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 
 static int filter_write(u32 reg)
 {
+	/*
+	 * MSRs writes usually happen all at once, and can easily saturate kmsg.
+	 * Only allow 1 MSR message every 30 seconds.
+	 *
+	 * It's possible to be smarter here and do it (for example) per-MSR, but
+	 * it would certainly be more complex, and this is enough at least to
+	 * avoid saturating the ring buffer.
+	 */
+	static DEFINE_RATELIMIT_STATE(fw_rs, 30 * HZ, 1);
+
 	switch (allow_writes) {
 	case MSR_WRITES_ON:  return 0;
 	case MSR_WRITES_OFF: return -EPERM;
 	default: break;
 	}
 
+	if (!__ratelimit(&fw_rs))
+		return 0;
+
 	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
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

