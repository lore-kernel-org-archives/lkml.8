Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766F4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52354206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgENRHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:07:11 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:44463 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgENRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:07:10 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 07E1E200008;
        Thu, 14 May 2020 17:07:07 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] of/platform: Avoid compilation warning
Date:   Thu, 14 May 2020 19:07:07 +0200
Message-Id: <20200514170707.24466-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node() helper has its dummy counterpart for when
CONFIG_OF is not enabled. However, it is clearly stated in the kernel
documentation that it "takes a reference to the embedded struct device
which needs to be dropped after use". Which means the of_dev_put()
helper might have to be called afterwards. Unfortunately, there is no
of_dev_put() dummy function if OF_CONFIG is not enabled which seems
odd in this case. The of_dev_put() helper is pretty simple, it just
checks the validity of the single argument and calls put_device() on
it. One can just call put_device() directly to avoid any build issue
but I find much more accurate in this case to create the dummy
helper.

With this helper, a file using of_find_device_by_node() can also call
of_dev_put() without triggering the following:

error: implicit declaration of function ‘of_dev_put’; did you mean ‘of_node_put’? [-Werror=implicit-function-declaration]

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/of_platform.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..84d9e60e517e 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -54,11 +54,13 @@ extern struct platform_device *of_device_alloc(struct device_node *np,
 					 struct device *parent);
 #ifdef CONFIG_OF
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
+extern void of_dev_put(struct platform_device *dev);
 #else
 static inline struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	return NULL;
 }
+static inline void of_dev_put(struct platform_device *dev) { }
 #endif
 
 /* Platform devices and busses creation */
-- 
2.20.1

