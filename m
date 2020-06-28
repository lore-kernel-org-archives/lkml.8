Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1292C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D275520768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgF1A7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 20:59:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbgF1A7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 20:59:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8ECEB9B8377CC198B1C8;
        Sun, 28 Jun 2020 08:59:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 08:58:56 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <sstabellini@kernel.org>, <linux@armlinux.org.uk>,
        <xen-devel@lists.xenproject.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] arm/xen: remove the unused macro GRANT_TABLE_PHYSADDR
Date:   Sun, 28 Jun 2020 08:57:06 +0800
Message-ID: <1593305826-28279-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

arch/arm64/xen/../../arm/xen/enlighten.c:244: warning: macro
"GRANT_TABLE_PHYSADDR" is not used [-Wunused-macros]

It is an isolated macro, and should be removed when its last user
was deleted in the following commit 3cf4095d7446 ("arm/xen: Use
xen_xlate_map_ballooned_pages to setup grant table")

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 arch/arm/xen/enlighten.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index fd4e1ce1..e93145d 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -241,7 +241,6 @@ static int __init fdt_find_hyper_node(unsigned long node, const char *uname,
  * see Documentation/devicetree/bindings/arm/xen.txt for the
  * documentation of the Xen Device Tree format.
  */
-#define GRANT_TABLE_PHYSADDR 0
 void __init xen_early_init(void)
 {
 	of_scan_flat_dt(fdt_find_hyper_node, NULL);
-- 
2.7.4

