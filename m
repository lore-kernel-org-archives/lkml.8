Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32AAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A9423119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JlnadfkI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lsyxfT7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgHFRKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbgHFRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:09:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B61C061575;
        Thu,  6 Aug 2020 10:09:55 -0700 (PDT)
Date:   Thu, 06 Aug 2020 17:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pU6Z1LydeuL7IE2EVfz7XpU/ocZPxIBQMRcCgKa0TWw=;
        b=JlnadfkI4fLXQs4u0iU49WpRSiFclx6pBU/mIpMn8sI7D8FO6Xl5vgelFC5BGbcao3IdA0
        kKfvcIsepzvArKb+2dBxGOnG2QInJ3IN+MdNUvn0O7dTlYLp0qiBDsqicwlxUsybY7ilT+
        yU+6InFdvZrER84e2Td7481ElperP4pboVeDh49SnN5AE5lSTXzeydCtmUNxouWgxYpl4N
        wibQY7LMJt+i/riS2Xa8duYMcOZlQuHXwq75c6dbSUA7QLCNkpqe3Sx2Dt/Vu0fNw52kSk
        Yyb9q7+u9Kwtskta8x4sT2n72z5+vv+nUHo5RT3bbYnkyd0ShCR34M2a+BNojQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pU6Z1LydeuL7IE2EVfz7XpU/ocZPxIBQMRcCgKa0TWw=;
        b=lsyxfT7vNA0s5RsyJp6GV+qu3SmnON7HUHxKkbRp1ilzr2Ty8fFxB5Ir2vGjJ3e3z6caKS
        HwBHX0oT7ipUMpDw==
From:   "tip-bot2 for Bhupesh Sharma" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] hw_breakpoint: Remove unused
 __register_perf_hw_breakpoint() declaration
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1594971060-14180-1-git-send-email-bhsharma@redhat.com>
References: <1594971060-14180-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Message-ID: <159673379201.3192.872827889497018459.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b55b3fdce3e554a6bbe8f8ca6a01a892d720e64e
Gitweb:        https://git.kernel.org/tip/b55b3fdce3e554a6bbe8f8ca6a01a892d720e64e
Author:        Bhupesh Sharma <bhsharma@redhat.com>
AuthorDate:    Fri, 17 Jul 2020 13:01:00 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 17:54:04 +02:00

hw_breakpoint: Remove unused __register_perf_hw_breakpoint() declaration

Commit:

  b326e9560a28 ("hw-breakpoints: Use overflow handler instead of the event callback")

removed __register_perf_hw_breakpoint() function usage and replaced it
with register_perf_hw_breakpoint() function.

Remove the left-over unused __register_perf_hw_breakpoint() declaration
from <linux/hw_breakpoint.h> as well.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/1594971060-14180-1-git-send-email-bhsharma@redhat.com
---
 include/linux/hw_breakpoint.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index d7d4250..78dd703 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -72,7 +72,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    void *context);
 
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
-extern int __register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
 
@@ -119,8 +118,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    void *context)		{ return NULL; }
 static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
-static inline int
-__register_perf_hw_breakpoint(struct perf_event *bp) 	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
 unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)	{ }
