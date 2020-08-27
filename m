Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D869FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B536820825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fp3jGDPe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMsSb1Pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgH0Hyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:54:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgH0Hyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:33 -0400
Date:   Thu, 27 Aug 2020 07:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mTmvlE5zdtLocGp68LdVg1HRKyqOz2s6aWOVET36LjE=;
        b=fp3jGDPeoh8tGcd0+3xWUGnd3M8IZBNgknszw2HbaDWXUs9IPEI0NDnzrAFDpOAlUg7Py8
        DEU/wlmb56t5vxTlS1f4smt4zRI6zhGRKJAqex+1DkNB4t467sLYLpW+FOdzYpYu4pgGv8
        QXUbyyw0EEat0qBBBJTu3VtfxzOS8n1a3TlV+VBlJQQX6mXeX+hgbFvDUPyoh0Qj4Lug/7
        8q7ycqDhKBQY5qwYoPSDv7KAmCtSn88M8SQE4gEXH7REHT8fOqdn6uQKDgUdX5Jy3naW6O
        Hsx3WKmFnjmucIuoUGJsCnshvIpCFZX9EwBUYPwSp9DcynRAXMdCvwWYpF2Gbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mTmvlE5zdtLocGp68LdVg1HRKyqOz2s6aWOVET36LjE=;
        b=DMsSb1PiJffJm2A599B2fGxH2SgWS2h264W5OjCuJoP+JfGd+1/y7XodfGeO2QIJcOl4Vc
        cPbzWNhe5tfdpNCg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Move sd_flag_debug out of
 linux/sched/topology.h
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200825133216.9163-1-valentin.schneider@arm.com>
References: <20200825133216.9163-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159851487090.20229.14835640470330793284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8fca9494d4b4d6b57b1398cd473feb308df656db
Gitweb:        https://git.kernel.org/tip/8fca9494d4b4d6b57b1398cd473feb308df656db
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 25 Aug 2020 14:32:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:59 +02:00

sched/topology: Move sd_flag_debug out of linux/sched/topology.h

Defining an array in a header imported all over the place clearly is a daft
idea, that still didn't stop me from doing it.

Leave a declaration of sd_flag_debug in topology.h and move its definition
to sched/debug.c.

Fixes: b6e862f38672 ("sched/topology: Define and assign sched_domain flag metadata")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200825133216.9163-1-valentin.schneider@arm.com
---
 include/linux/sched/topology.h |  9 ++++-----
 kernel/sched/debug.c           |  6 ++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2d59ca7..b9b0dab 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -33,14 +33,13 @@ static const unsigned int SD_DEGENERATE_GROUPS_MASK =
 #undef SD_FLAG
 
 #ifdef CONFIG_SCHED_DEBUG
-#define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
-static const struct {
+
+struct sd_flag_debug {
 	unsigned int meta_flags;
 	char *name;
-} sd_flag_debug[] = {
-#include <linux/sched/sd_flags.h>
 };
-#undef SD_FLAG
+extern const struct sd_flag_debug sd_flag_debug[];
+
 #endif
 
 #ifdef CONFIG_SCHED_SMT
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0655524..0d7896d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -245,6 +245,12 @@ set_table_entry(struct ctl_table *entry,
 	entry->proc_handler = proc_handler;
 }
 
+#define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
+const struct sd_flag_debug sd_flag_debug[] = {
+#include <linux/sched/sd_flags.h>
+};
+#undef SD_FLAG
+
 static int sd_ctl_doflags(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
