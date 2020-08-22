Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE326C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1E520738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pFwR+asa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RKV/nEQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHVJmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgHVJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:42:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E815DC061574;
        Sat, 22 Aug 2020 02:42:45 -0700 (PDT)
Date:   Sat, 22 Aug 2020 09:42:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598089363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDsFybpPUXbZXVMfDvacBaXxuYysdSQJwkUhgaqfUYE=;
        b=pFwR+asaezwUrEMTWoGXDbqK2Ybm4x5AS3Pb1i3/24S7c1WaYOzQElbFRmlJaSnaq1fcSg
        TLSXcvWydQd4cLxR+IYxgaaDaQXqGcNM4iE7lU6zjaq6ubyeMhinP35aOABb/hQON0t5u9
        s5jc0cai8e6XazTDHMsmaOXdoH7nG08hxl/PY4TglWtnhGHgyVM+wqy383yTDSYxtQZtG0
        ac9dC8hyukIl6Kvd3LYvnYtfEy+6yTG3fD9V74k2K2kThRHEpzxjoD4HyqmAfC2LUHMKmC
        rk4I4H6dx5vhzW1OQUbreAb7QavczHacPQ9xa0hO7IwNB9qKr2hPgIbRQj/8LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598089363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDsFybpPUXbZXVMfDvacBaXxuYysdSQJwkUhgaqfUYE=;
        b=RKV/nEQrfbd9ANGbXAjvQt6a32vP3s1XaxgnyYFU0QDE2fV6AsGiClz+NlzuJ4xEH6pw4a
        07ValapZ3DeWx2Dg==
From:   "tip-bot2 for Chris Down" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/msr: Prevent userspace MSR access from dominating
 the console
Cc:     Chris Down <chris@chrisdown.name>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C563994ef132ce6cffd28fc659254ca37d032b5ef=2E15980?=
 =?utf-8?q?11595=2Egit=2Echris=40chrisdown=2Ename=3E?=
References: =?utf-8?q?=3C563994ef132ce6cffd28fc659254ca37d032b5ef=2E159801?=
 =?utf-8?q?1595=2Egit=2Echris=40chrisdown=2Ename=3E?=
MIME-Version: 1.0
Message-ID: <159808936271.3192.6556644745779470917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     1f35c9c0ce3888405fc813afedaff79de433cf27
Gitweb:        https://git.kernel.org/tip/1f35c9c0ce3888405fc813afedaff79de433cf27
Author:        Chris Down <chris@chrisdown.name>
AuthorDate:    Fri, 21 Aug 2020 13:10:24 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 22 Aug 2020 11:27:40 +02:00

x86/msr: Prevent userspace MSR access from dominating the console

Applications which manipulate MSRs from userspace often do so
infrequently, and all at once. As such, the default printk ratelimit
architecture supplied by pr_err_ratelimited() doesn't do enough to prevent
kmsg becoming completely overwhelmed with their messages and pushing
other salient information out of the circular buffer.

In one case, I saw over 80% of kmsg being filled with these messages,
and the default kmsg buffer being completely filled less than 5 minutes
after boot(!).

Make things much less aggressive, while still achieving the original
goal of fiter_write(). Operators will still get warnings that MSRs are
being manipulated from userspace, but they won't have other also
potentially useful messages pushed out of the kmsg buffer.

Of course, one can boot with `allow_writes=1` to avoid these messages at
all, but that then has the downfall that one doesn't get _any_
notification at all about these problems in the first place, and so is
much less likely to forget to fix it.

One might rather it was less binary: it was still logged, just less
often, so that application developers _do_ have the incentive to improve
their current methods, without the kernel having to push other useful
stuff out of the kmsg buffer.

This one example isn't the point, of course: I'm sure there are plenty
of other non-ideal-but-pragmatic cases where people are writing to MSRs
from userspace right now, and it will take time for those people to find
other solutions.

Overall, keep the intent of the original patch, while mitigating its
sometimes heavy effects on kmsg composition.

 [ bp: Massage a bit. ]

Signed-off-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/563994ef132ce6cffd28fc659254ca37d032b5ef.1598011595.git.chris@chrisdown.name
---
 arch/x86/kernel/msr.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 49dcfb8..b03001d 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -80,18 +80,30 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 
 static int filter_write(u32 reg)
 {
+	/*
+	 * MSRs writes usually happen all at once, and can easily saturate kmsg.
+	 * Only allow one message every 30 seconds.
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
