Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5454DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B03A207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2B2m/Xbp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFPUB0mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGQWBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgGQWBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:01:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CF9C0619D2;
        Fri, 17 Jul 2020 15:01:22 -0700 (PDT)
Date:   Fri, 17 Jul 2020 22:01:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595023280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADj7MrohMwhkatX22R/az7BKuLBC4fiYbn+qHZYeYGo=;
        b=2B2m/XbpylnJJjH3jsuO9MLkNw07O+gsWJ96bk/ntQOb5FPQ+GE627edxHT0F4ZMbN/2kw
        HGroE1J675OdOkDnPAeKCLjhrNHI4fonNLOvEUllQWVgA5i80kF33jth8a6GmqBRdS9hIH
        2AuFZriBi26i2U4oT3LclY67qS1IgwcV5d/lC9ACSFzSVk/SHvs1+JUUKtQuREEnYuVKWb
        bdxkaiQYaVZa1WDAL0bia+bh6hGXs53J0X9CJg9h3GJgEHneqx4x5lfwmNcPLoyar7jsn7
        KkG3BZ1ByYHFu91PFtQw+7US282HIsQy4XCJdRiFaoPqOqbZV28Ny/GtU1veXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595023280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADj7MrohMwhkatX22R/az7BKuLBC4fiYbn+qHZYeYGo=;
        b=uFPUB0mXKc72VDiKPuKY5Ue1lX+ttkl+HlkPFc4bjm/g/zXhMoDkNUoiCYL1u7Xh9uZAf8
        Gaqb+xrii26GadDw==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove unused or redundant includes
Cc:     andrealmeid@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200702202843.520764-4-andrealmeid@collabora.com>
References: <20200702202843.520764-4-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <159502328018.4006.15584217266927515101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     38aa3c15b3a422e117a1f687a6dbcb5afd92cfc2
Gitweb:        https://git.kernel.org/tip/38aa3c15b3a422e117a1f687a6dbcb5afd9=
2cfc2
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 02 Jul 2020 17:28:42 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 23:58:50 +02:00

futex: Remove unused or redundant includes

Since 82af7aca ("Removal of FUTEX_FD"), some includes related to file
operations aren't needed anymore. More investigation around the includes
showed that a lot of includes aren't required for compilation, possible
due to redundant includes. Simplify the code by removing unused
includes.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200702202843.520764-4-andrealmeid@collabora=
.com

---
 kernel/futex.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 362fbca..697835a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -31,31 +31,13 @@
  *  "The futexes are also cursed."
  *  "But they come in a choice of three flavours!"
  */
-#include <linux/compat.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fs.h>
-#include <linux/file.h>
 #include <linux/jhash.h>
-#include <linux/init.h>
-#include <linux/futex.h>
-#include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
-#include <linux/signal.h>
-#include <linux/export.h>
-#include <linux/magic.h>
-#include <linux/pid.h>
-#include <linux/nsproxy.h>
-#include <linux/ptrace.h>
-#include <linux/sched/rt.h>
-#include <linux/sched/wake_q.h>
-#include <linux/sched/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
-#include <linux/refcount.h>
=20
 #include <asm/futex.h>
=20
