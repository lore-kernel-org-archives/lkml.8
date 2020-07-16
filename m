Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86743C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5461E2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGPIwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:52:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7861 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgGPIwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:52:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DF40A914ED1DA6CAABC5;
        Thu, 16 Jul 2020 16:52:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:52:20 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: udc: lpc32xx: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 16:56:12 +0800
Message-ID: <20200716085612.10712-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index e79f5f286..3f1c62adc 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -495,7 +495,7 @@ static void proc_ep_show(struct seq_file *s, struct lpc32xx_ep *ep)
 	}
 }
 
-static int proc_udc_show(struct seq_file *s, void *unused)
+static int udc_show(struct seq_file *s, void *unused)
 {
 	struct lpc32xx_udc *udc = s->private;
 	struct lpc32xx_ep *ep;
@@ -524,22 +524,11 @@ static int proc_udc_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int proc_udc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_udc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations proc_ops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_udc_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(udc);
 
 static void create_debug_file(struct lpc32xx_udc *udc)
 {
-	udc->pde = debugfs_create_file(debug_filename, 0, NULL, udc, &proc_ops);
+	udc->pde = debugfs_create_file(debug_filename, 0, NULL, udc, &udc_fops);
 }
 
 static void remove_debug_file(struct lpc32xx_udc *udc)
-- 
2.17.1

