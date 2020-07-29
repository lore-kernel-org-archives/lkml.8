Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDBC20663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgG2LfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:35:11 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56255 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2LfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:35:10 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N0nOF-1kwod728W5-00wjt6; Wed, 29 Jul 2020 13:35:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mmp: avoid missing prototype warning
Date:   Wed, 29 Jul 2020 13:34:39 +0200
Message-Id: <20200729113456.4072290-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZB+A3F76Zy/nPLsxkoFZDxI4aWKkSGC/60YSpFP6DlGeS6N6XSv
 em/F1tgQsmEufky1Zae1UAuMigBxLTXYNX2QGKNlCHBo9BHBfVCGswKTp7SfcfE89e3AXXn
 ht7KheSD907VjmKiVVfjo61VOWUNEENaX65LulzCb65iNTrlpaVG/nUSuVnt3xrNNneWwTK
 v2/b0hlnMXZgwbiF48OUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ogXTt3n8Ay0=:D2Xfv3HsDUdKgzXOlA/SRi
 UEpoDWp6r3GfMndTBTR6D9rPmgIy8FQayAQFwBF9xofg80EFNHKyZmLdWoQXeVORNZ7dsDc/z
 lF0oqsoJ2e6wNTkMNgO0AVootr7bDMUh6BYTdOrPbM9UtZhd86MVXQ2ycbAEC9uYzdwJq885N
 uqEkYPuQ3EUoonL+elIlVih++pu1/XWkr5IGhiYBrsda6brF+tghi8y9CLzBE9wtiug5hEncl
 XqAbDL1yyrPUxcFDs89c34G1wcH6VKU6UYhKDQ8j62nfcb1V+TTgZgPO9wZKSLDGe5/7MlnZk
 Dy9JNeg9V2wwStV5wAf9U9qtcKK1tUd1+hz15tYyliT8k8S1ulSwA4eQbW7K7mpWxw+uthFs9
 QE02k+BWEMOeNNzKvwIZLrHlkga7t0Ogc5PRNQ8UaQEeceyl47xkOcaFQgMQNMXXpI7gIz7Vk
 MqB5E+ldbExKnI6ZVjbGorZb+IjY5uHsVJqMev4aZj/ljPjPRfpGV0DeFRTjRYk0Z+SkFiEGw
 lO3Wk02YBpVX+PMOufk2W9sbUrMwzdDsyPfeXQxom1m+mJMI0GoF52UngvWAUDaiVTs/LwVju
 5K+rzXaXvYdOpcPZdK7Q8WJ1Hn5IilAchLNkhcKicCAGatvcUU+TW9cGVxAiwkkBuwgJoIcuY
 wsn2qOit7b8n6AqIpFMDelb52d8BPCJTsFV13mxxaQ9Vq7SnlDIJ1deIprW90zKyOtUgUGQbb
 SHPD0+UssnTgEOECUYveqqP6EzuTKuzuuyW/9F0eJbt6StMZ6BqJLZVoXa17BpF0aIzIbgAFD
 /OXMj2uPeNdK/Lfc7rC4wXVQnEuJg2zIlBsycsTdqNR75MioadEwERlsoCcOXyeUcsrfx0o
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot points out two harmless warnings in the
mmp clk drivers:

drivers/clk/mmp/clk-pxa168.c:68:13: warning: no previous prototype for 'pxa168_clk_init' [-Wmissing-prototypes]
drivers/clk/mmp/clk-pxa910.c:66:13: warning: no previous prototype for 'pxa910_clk_init' [-Wmissing-prototypes]

Fix these by including corresponding header file.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/mmp/clk-pxa168.c | 1 +
 drivers/clk/mmp/clk-pxa910.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/mmp/clk-pxa168.c b/drivers/clk/mmp/clk-pxa168.c
index 8e2551ab8462..b351039cac09 100644
--- a/drivers/clk/mmp/clk-pxa168.c
+++ b/drivers/clk/mmp/clk-pxa168.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk/mmp.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
diff --git a/drivers/clk/mmp/clk-pxa910.c b/drivers/clk/mmp/clk-pxa910.c
index 7a7965141918..f254ceff3ea7 100644
--- a/drivers/clk/mmp/clk-pxa910.c
+++ b/drivers/clk/mmp/clk-pxa910.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk/mmp.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
-- 
2.27.0

