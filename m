Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA0C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82B420873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgCKICP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:02:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbgCKICP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:02:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFFCCB07B;
        Wed, 11 Mar 2020 08:02:13 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drivers/base/cpu: Simplify s*nprintf() usages
Date:   Wed, 11 Mar 2020 09:02:07 +0100
Message-Id: <20200311080207.12046-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311080207.12046-1-tiwai@suse.de>
References: <20200311080207.12046-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the simpler sprintf() instead of snprintf() or scnprintf() in a
single-shot sysfs output callbacks where you are very sure that it
won't go over PAGE_SIZE buffer limit.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/cpu.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 67aaa052c7a2..df19c002d747 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -231,8 +231,7 @@ static struct cpu_attr cpu_attrs[] = {
 static ssize_t print_cpus_kernel_max(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	int n = snprintf(buf, PAGE_SIZE-2, "%d\n", NR_CPUS - 1);
-	return n;
+	return sprintf(buf, "%d\n", NR_CPUS - 1);
 }
 static DEVICE_ATTR(kernel_max, 0444, print_cpus_kernel_max, NULL);
 
@@ -272,7 +271,7 @@ static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
 static ssize_t print_cpus_isolated(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0, len = PAGE_SIZE-2;
+	int n;
 	cpumask_var_t isolated;
 
 	if (!alloc_cpumask_var(&isolated, GFP_KERNEL))
@@ -280,7 +279,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 
 	cpumask_andnot(isolated, cpu_possible_mask,
 		       housekeeping_cpumask(HK_FLAG_DOMAIN));
-	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(isolated));
+	n = sprintf(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
 
@@ -292,11 +291,7 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0, len = PAGE_SIZE-2;
-
-	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
-
-	return n;
+	return sprintf(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 }
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
-- 
2.16.4

