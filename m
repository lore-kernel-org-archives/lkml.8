Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED013C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83682168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701116;
	bh=VE72fj0GrvsmScHPaEP/ZnlRnMn2L0iaATmIuBbj9ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d3TyjttxyPXlrfFrbZtqaEqu5WCYvTUDpY2/B6Lw9Yo9X9HJjSeuit0Bd1Yoef+/R
	 j/31JYBBzy0ag07O7H7Jg3jZpDzvoHTj4Skgqr7VEnoAcbzxi0LHm3lflIIuBqAD0l
	 A4S3Mdrd1Nrnl734Z7SyjvlZxCBW4jlsdpmglhCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391096AbgBNQIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:08:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390267AbgBNQIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:08:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FC092187F;
        Fri, 14 Feb 2020 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696496;
        bh=VE72fj0GrvsmScHPaEP/ZnlRnMn2L0iaATmIuBbj9ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSxk74FNcGKx8bt/3oLWEoUZWjvfW2TVA+54cDfHCPj2yPlrJWxyeFJlhGuRNM9/K
         INo3VOJUBunmF2zPOofVX/J+MifkNxqxcvBxA3s/gICQoNsK2LbpQfVOaNjD06jvo9
         q1BH3G+ZVQlNs1DjAyB/WP5yy2DM7AiJEBEe+ieM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Simon Schwartz <kern.simon@theschwartz.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 301/459] driver core: platform: Prevent resouce overflow from causing infinite loops
Date:   Fri, 14 Feb 2020 10:59:11 -0500
Message-Id: <20200214160149.11681-301-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Schwartz <kern.simon@theschwartz.xyz>

[ Upstream commit 39cc539f90d035a293240c9443af50be55ee81b8 ]

num_resources in the platform_device struct is declared as a u32.  The
for loops that iterate over num_resources use an int as the counter,
which can cause infinite loops on architectures with smaller ints.
Change the loop counters to u32.

Signed-off-by: Simon Schwartz <kern.simon@theschwartz.xyz>
Link: https://lore.kernel.org/r/2201ce63a2a171ffd2ed14e867875316efcf71db.camel@theschwartz.xyz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3c0cd20925b71..ee99b15581290 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -27,6 +27,7 @@
 #include <linux/limits.h>
 #include <linux/property.h>
 #include <linux/kmemleak.h>
+#include <linux/types.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -48,7 +49,7 @@ EXPORT_SYMBOL_GPL(platform_bus);
 struct resource *platform_get_resource(struct platform_device *dev,
 				       unsigned int type, unsigned int num)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < dev->num_resources; i++) {
 		struct resource *r = &dev->resource[i];
@@ -226,7 +227,7 @@ struct resource *platform_get_resource_byname(struct platform_device *dev,
 					      unsigned int type,
 					      const char *name)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < dev->num_resources; i++) {
 		struct resource *r = &dev->resource[i];
@@ -473,7 +474,8 @@ EXPORT_SYMBOL_GPL(platform_device_add_properties);
  */
 int platform_device_add(struct platform_device *pdev)
 {
-	int i, ret;
+	u32 i;
+	int ret;
 
 	if (!pdev)
 		return -EINVAL;
@@ -562,7 +564,7 @@ EXPORT_SYMBOL_GPL(platform_device_add);
  */
 void platform_device_del(struct platform_device *pdev)
 {
-	int i;
+	u32 i;
 
 	if (!IS_ERR_OR_NULL(pdev)) {
 		device_del(&pdev->dev);
-- 
2.20.1

