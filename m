Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DB5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1886207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgE1GtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1GtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:49:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7290DC08C5C2;
        Wed, 27 May 2020 23:49:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeCLd-0008AP-MB; Thu, 28 May 2020 08:49:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 59BA91C032F;
        Thu, 28 May 2020 08:49:01 +0200 (CEST)
Date:   Thu, 28 May 2020 06:49:01 -0000
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Make perf_probe_msr() more robust and
 flexible
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527224659.206129-5-eranian@google.com>
References: <20200527224659.206129-5-eranian@google.com>
MIME-Version: 1.0
Message-ID: <159064854124.17951.10750193374892124205.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4c953f879460bf65ea3c119354026b126fe8ee57
Gitweb:        https://git.kernel.org/tip/4c953f879460bf65ea3c119354026b126fe8ee57
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 27 May 2020 15:46:58 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 07:58:55 +02:00

perf/x86/rapl: Make perf_probe_msr() more robust and flexible

This patch modifies perf_probe_msr() by allowing passing of
struct perf_msr array where some entries are not populated, i.e.,
they have either an msr address of 0 or no attribute_group pointer.
This helps with certain call paths, e.g., RAPL.

In case the grp is NULL, the default sysfs visibility rule
applies which is to make the group visible. Without the patch,
you would get a kernel crash with a NULL group.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200527224659.206129-5-eranian@google.com
---
 arch/x86/events/probe.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
index c2ede2f..136a1e8 100644
--- a/arch/x86/events/probe.c
+++ b/arch/x86/events/probe.c
@@ -10,6 +10,11 @@ not_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return 0;
 }
 
+/*
+ * Accepts msr[] array with non populated entries as long as either
+ * msr[i].msr is 0 or msr[i].grp is NULL. Note that the default sysfs
+ * visibility is visible when group->is_visible callback is set.
+ */
 unsigned long
 perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 {
@@ -24,8 +29,16 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 		if (!msr[bit].no_check) {
 			struct attribute_group *grp = msr[bit].grp;
 
+			/* skip entry with no group */
+			if (!grp)
+				continue;
+
 			grp->is_visible = not_visible;
 
+			/* skip unpopulated entry */
+			if (!msr[bit].msr)
+				continue;
+
 			if (msr[bit].test && !msr[bit].test(bit, data))
 				continue;
 			/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
