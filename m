Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D039CC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A693F20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272777;
	bh=VE72fj0GrvsmScHPaEP/ZnlRnMn2L0iaATmIuBbj9ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gH/pnKet3f3DPfz/OG0zFbOfbQsbznVadN7y9JAm8y8V16JFeLfIo4BeFVy9nFGAQ
	 /94WhDm2/YUpc80BVH8V8whkv54Kj2sf9qs5Q4YDeVs8wixbm1+wAEj05hHoD5B/xa
	 oXWa34LNoSIeQWpPqhcPSdOniorafzDEa7xXFt+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbgBUIMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732638AbgBUIMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:12:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4DF20722;
        Fri, 21 Feb 2020 08:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272761;
        bh=VE72fj0GrvsmScHPaEP/ZnlRnMn2L0iaATmIuBbj9ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=It7S1HN4aSFx+tY6sepwWI/VH69Eutodm3muinbT/LRodx98RbGGzktvBQLOpHrfV
         dGXZI2NKk3KlaxM5jg6ZZXZ6OLkk2pCpS7PX+hZq9GkV/f6wlkwRrvkIAY/elfX+Y6
         wuBAw5WevWpE77OspUCfAamFrZ7gMgPkhF1QPDIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Simon Schwartz <kern.simon@theschwartz.xyz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 218/344] driver core: platform: Prevent resouce overflow from causing infinite loops
Date:   Fri, 21 Feb 2020 08:40:17 +0100
Message-Id: <20200221072409.005849916@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



