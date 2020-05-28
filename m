Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF312C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86952084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgE1GtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgE1GtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:49:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FA4C08C5C3;
        Wed, 27 May 2020 23:49:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeCLe-0008As-54; Thu, 28 May 2020 08:49:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D1EC31C0051;
        Thu, 28 May 2020 08:49:01 +0200 (CEST)
Date:   Thu, 28 May 2020 06:49:01 -0000
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Flip logic on default events visibility
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527224659.206129-4-eranian@google.com>
References: <20200527224659.206129-4-eranian@google.com>
MIME-Version: 1.0
Message-ID: <159064854169.17951.15029107929974938885.tip-bot2@tip-bot2>
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

Commit-ID:     2a3e3f73a23b4ff2c0065d3a42edc18ad94b7851
Gitweb:        https://git.kernel.org/tip/2a3e3f73a23b4ff2c0065d3a42edc18ad94b7851
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 27 May 2020 15:46:57 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 07:58:55 +02:00

perf/x86/rapl: Flip logic on default events visibility

This patch modifies the default visibility of the attribute_group
for each RAPL event. By default if the grp.is_visible field is NULL,
sysfs considers that it must display the attribute group.
If the field is not NULL (callback function), then the return value
of the callback determines the visibility (0 = not visible). The RAPL
attribute groups had the field set to NULL, meaning that unless they
failed the probing from perf_msr_probe(), they would be visible. We want
to avoid having to specify attribute groups that are not supported by the HW
in the rapl_msrs[] array, they don't have an MSR address to begin with.

Therefore, we intialize the visible field of all RAPL attribute groups
to a callback that returns 0. If the RAPL msr goes through probing
and succeeds the is_visible field will be set back to NULL (visible).
If the probing fails the field is set to a callback that return 0 (not visible).

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200527224659.206129-4-eranian@google.com
---
 arch/x86/events/rapl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f29935e..8d17af4 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -460,9 +460,16 @@ static struct attribute *rapl_events_cores[] = {
 	NULL,
 };
 
+static umode_t
+rapl_not_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return 0;
+}
+
 static struct attribute_group rapl_events_cores_group = {
 	.name  = "events",
 	.attrs = rapl_events_cores,
+	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_pkg[] = {
@@ -475,6 +482,7 @@ static struct attribute *rapl_events_pkg[] = {
 static struct attribute_group rapl_events_pkg_group = {
 	.name  = "events",
 	.attrs = rapl_events_pkg,
+	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_ram[] = {
@@ -487,6 +495,7 @@ static struct attribute *rapl_events_ram[] = {
 static struct attribute_group rapl_events_ram_group = {
 	.name  = "events",
 	.attrs = rapl_events_ram,
+	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_gpu[] = {
@@ -499,6 +508,7 @@ static struct attribute *rapl_events_gpu[] = {
 static struct attribute_group rapl_events_gpu_group = {
 	.name  = "events",
 	.attrs = rapl_events_gpu,
+	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_psys[] = {
@@ -511,6 +521,7 @@ static struct attribute *rapl_events_psys[] = {
 static struct attribute_group rapl_events_psys_group = {
 	.name  = "events",
 	.attrs = rapl_events_psys,
+	.is_visible = rapl_not_visible,
 };
 
 static bool test_msr(int idx, void *data)
