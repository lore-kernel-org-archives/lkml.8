Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A21C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35D22075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgE1OvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:51:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42672 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgE1OvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:51:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EE29D80307C7;
        Thu, 28 May 2020 14:51:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q9qy3OZCWlf6; Thu, 28 May 2020 17:51:00 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Olof Johansson <olof@lixom.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] bus: bt1-axi: Use sysfs_streq instead of strncmp
Date:   Thu, 28 May 2020 17:50:50 +0300
Message-ID: <20200528145050.5203-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200528145050.5203-1-Sergey.Semin@baikalelectronics.ru>
References: <20200528145050.5203-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a ready-to-use method to compare a retrieved from a sysfs node
string with another string. It treats both NUL and newline-then-NUL as
equivalent string terminations. So use it instead of manually truncating
the line length in the strncmp() method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Olof Johansson <olof@lixom.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: soc@kernel.org
---
 drivers/bus/bt1-axi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/bt1-axi.c b/drivers/bus/bt1-axi.c
index c194d9a2bbeb..e7a6744acc7b 100644
--- a/drivers/bus/bt1-axi.c
+++ b/drivers/bus/bt1-axi.c
@@ -220,9 +220,9 @@ static ssize_t inject_error_store(struct device *dev,
 	 * error while unaligned writing - the AXI bus write error handled
 	 * by this driver.
 	 */
-	if (!strncmp(data, "bus", 3))
+	if (sysfs_streq(data, "bus"))
 		readb(axi->qos_regs);
-	else if (!strncmp(data, "unaligned", 9))
+	else if (sysfs_streq(data, "unaligned"))
 		writeb(0, axi->qos_regs);
 	else
 		return -EINVAL;
-- 
2.26.2

