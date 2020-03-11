Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F697C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AF1208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgCKHMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:12:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:34092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:12:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1225AF4E;
        Wed, 11 Mar 2020 07:12:05 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/base/cpu: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:12:00 +0100
Message-Id: <20200311071200.4024-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 6265871a4af2..0abcd9d68714 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -231,7 +231,7 @@ static struct cpu_attr cpu_attrs[] = {
 static ssize_t print_cpus_kernel_max(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	int n = snprintf(buf, PAGE_SIZE-2, "%d\n", NR_CPUS - 1);
+	int n = scnprintf(buf, PAGE_SIZE-2, "%d\n", NR_CPUS - 1);
 	return n;
 }
 static DEVICE_ATTR(kernel_max, 0444, print_cpus_kernel_max, NULL);
@@ -258,13 +258,13 @@ static ssize_t print_cpus_offline(struct device *dev,
 			buf[n++] = ',';
 
 		if (nr_cpu_ids == total_cpus-1)
-			n += snprintf(&buf[n], len - n, "%u", nr_cpu_ids);
+			n += scnprintf(&buf[n], len - n, "%u", nr_cpu_ids);
 		else
-			n += snprintf(&buf[n], len - n, "%u-%d",
+			n += scnprintf(&buf[n], len - n, "%u-%d",
 						      nr_cpu_ids, total_cpus-1);
 	}
 
-	n += snprintf(&buf[n], len - n, "\n");
+	n += scnprintf(&buf[n], len - n, "\n");
 	return n;
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
-- 
2.16.4

