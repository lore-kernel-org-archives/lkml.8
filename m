Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB27C47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86382070B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgELByS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 21:54:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbgELByR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:54:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E8BA2F1F82839A34A387;
        Tue, 12 May 2020 09:54:15 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 12 May 2020 09:54:07 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <cristian.birsan@microchip.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] usb: gadget: udc: atmel: Make some symbols static
Date:   Tue, 12 May 2020 10:00:13 +0800
Message-ID: <1589248813-105323-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

drivers/usb/gadget/udc/atmel_usba_udc.c:188:30: warning: symbol 'queue_dbg_fops' was not declared.
drivers/usb/gadget/udc/atmel_usba_udc.c:196:30: warning: symbol 'regs_dbg_fops' was not declared.

queue_dbg_fops and regs_dbg_fops have only call within atmel_usba_udc.c
They should be static

Fixes: 914a3f3b3754 ("USB: add atmel_usba_udc driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 2220034..b771a85 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -185,7 +185,7 @@ static int regs_dbg_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-const struct file_operations queue_dbg_fops = {
+static const struct file_operations queue_dbg_fops = {
 	.owner		= THIS_MODULE,
 	.open		= queue_dbg_open,
 	.llseek		= no_llseek,
@@ -193,7 +193,7 @@ const struct file_operations queue_dbg_fops = {
 	.release	= queue_dbg_release,
 };
 
-const struct file_operations regs_dbg_fops = {
+static const struct file_operations regs_dbg_fops = {
 	.owner		= THIS_MODULE,
 	.open		= regs_dbg_open,
 	.llseek		= generic_file_llseek,
-- 
2.6.2

