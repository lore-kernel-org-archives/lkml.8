Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3FCC7657C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6376124656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814264;
	bh=5GAH1D31Jg6YN2y96DofgQKtwEufW/I2MEgvZT31F00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iHHB3kPEp8+3ur4N+nYDULw3D+RTLo3eu/v05qnRU37bhM4vylQYf+jEQn4Y5CjGi
	 rdh6aJfIsbzNM29wvz+DhkW3YezbvskmLD5gXcM6m14ijTpsAZKtV+i0pbZHkKCHOn
	 19tqaUhoYLWlCPElzwngqa6bvfLXXGnUYSTGNU8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbgB0Ohn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732100AbgB0N5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:57:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5159420578;
        Thu, 27 Feb 2020 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811837;
        bh=5GAH1D31Jg6YN2y96DofgQKtwEufW/I2MEgvZT31F00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sggfbATRrt21Mu0L2Mx8gV8vhqgLqH0qUIbYV5IBkuUQAPV/k8nqt/JHvU9XPKz8j
         8Wf17ddDCf5v5VbLT1sMR98IUv1AH1VLcVlGJEOYP9VYPQ3PHt4kCPODOWLiiRLj7a
         kkQUyEttD2pQGvalbwmElwpNigG6J3vNJGds7hAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Simon Schwartz <kern.simon@theschwartz.xyz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 113/237] driver core: platform: Prevent resouce overflow from causing infinite loops
Date:   Thu, 27 Feb 2020 14:35:27 +0100
Message-Id: <20200227132305.185283867@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
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
index f1105de0d9fed..e3d40c41c33b0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -28,6 +28,7 @@
 #include <linux/limits.h>
 #include <linux/property.h>
 #include <linux/kmemleak.h>
+#include <linux/types.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -68,7 +69,7 @@ void __weak arch_setup_pdev_archdata(struct platform_device *pdev)
 struct resource *platform_get_resource(struct platform_device *dev,
 				       unsigned int type, unsigned int num)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < dev->num_resources; i++) {
 		struct resource *r = &dev->resource[i];
@@ -163,7 +164,7 @@ struct resource *platform_get_resource_byname(struct platform_device *dev,
 					      unsigned int type,
 					      const char *name)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < dev->num_resources; i++) {
 		struct resource *r = &dev->resource[i];
@@ -360,7 +361,8 @@ EXPORT_SYMBOL_GPL(platform_device_add_properties);
  */
 int platform_device_add(struct platform_device *pdev)
 {
-	int i, ret;
+	u32 i;
+	int ret;
 
 	if (!pdev)
 		return -EINVAL;
@@ -447,7 +449,7 @@ EXPORT_SYMBOL_GPL(platform_device_add);
  */
 void platform_device_del(struct platform_device *pdev)
 {
-	int i;
+	u32 i;
 
 	if (pdev) {
 		device_remove_properties(&pdev->dev);
-- 
2.20.1



