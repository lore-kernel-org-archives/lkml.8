Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F976C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6170321569
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JKgl+Dnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgBKS4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:56:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49762 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgBKS4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:56:43 -0500
Received: from zn.tnic (p200300EC2F0955008CA74DB1104365B1.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:8ca7:4db1:1043:65b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B7551EC0652;
        Tue, 11 Feb 2020 19:56:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581447402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nOK+N0KXnb9SKqBmQ9OXdHbBnjXAEXpX2Iu1mLlmwpk=;
        b=JKgl+DnpkzjjwEF7usF0LRQCdth/gWKH/XavQVdTm+qc0nkFww5iXy/GYIa1p/I0U/Wp78
        xjtnEBh5aO+sIrS6+1peHmBwX+cBcN8+B9UivWagv2ETogMS6oD/5rcn+k10epxrIZkTo7
        WaGAo4Dj4fkMyenypDahJ7kz1Q3oU9A=
Date:   Tue, 11 Feb 2020 19:56:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] x86/fpu/xstate: Fix last_good_offset in
 setup_xstate_features()
Message-ID: <20200211185635.GJ32279@zn.tnic>
References: <20200109211452.27369-1-yu-cheng.yu@intel.com>
 <20200109211452.27369-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109211452.27369-2-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:14:50PM -0800, Yu-cheng Yu wrote:
> The function setup_xstate_features() uses CPUID to find each xfeature's
> standard-format offset and size.  Since XSAVES always uses the compacted
> format, supervisor xstates are *NEVER* in the standard-format and their
> offsets are left as -1's.  However, they are still being tracked as
> last_good_offset.
> 
> Fix it by tracking only user xstate offsets.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

How about cleaning it up some more, while at it?

---
From c12e13dcd814023a903399ec5ac2e7082d664b8b Mon Sep 17 00:00:00 2001
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 9 Jan 2020 13:14:50 -0800
Subject: [PATCH] x86/fpu/xstate: Fix last_good_offset in
 setup_xstate_features()

The function setup_xstate_features() uses CPUID to find each xfeature's
standard-format offset and size.  Since XSAVES always uses the compacted
format, supervisor xstates are *NEVER* in the standard-format and their
offsets are left as -1's.  However, they are still being tracked as
last_good_offset.

Fix it by tracking only user xstate offsets.

 [ bp: Use xfeature_is_supervisor() and save an indentation level. Drop
   now unused xfeature_is_user(). ]

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200109211452.27369-2-yu-cheng.yu@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a1806598aaa4..fe67cabfb4a1 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -120,11 +120,6 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
-static bool xfeature_is_user(int xfeature_nr)
-{
-	return !xfeature_is_supervisor(xfeature_nr);
-}
-
 /*
  * When executing XSAVEOPT (or other optimized XSAVE instructions), if
  * a processor implementation detects that an FPU state component is still
@@ -265,21 +260,25 @@ static void __init setup_xstate_features(void)
 
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
 
+		xstate_sizes[i] = eax;
+
 		/*
-		 * If an xfeature is supervisor state, the offset
-		 * in EBX is invalid. We leave it to -1.
+		 * If an xfeature is supervisor state, the offset in EBX is
+		 * invalid, leave it to -1.
 		 */
-		if (xfeature_is_user(i))
-			xstate_offsets[i] = ebx;
+		if (xfeature_is_supervisor(i))
+			continue;
+
+		xstate_offsets[i] = ebx;
 
-		xstate_sizes[i] = eax;
 		/*
-		 * In our xstate size checks, we assume that the
-		 * highest-numbered xstate feature has the
-		 * highest offset in the buffer.  Ensure it does.
+		 * In our xstate size checks, we assume that the highest-numbered
+		 * xstate feature has the highest offset in the buffer.  Ensure
+		 * it does.
 		 */
 		WARN_ONCE(last_good_offset > xstate_offsets[i],
-			"x86/fpu: misordered xstate at %d\n", last_good_offset);
+			  "x86/fpu: misordered xstate at %d\n", last_good_offset);
+
 		last_good_offset = xstate_offsets[i];
 	}
 }
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
