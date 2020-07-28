Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DDEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BD920672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgG1CZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:25:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726613AbgG1CZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:25:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D888E5288AA1947D5F2C;
        Tue, 28 Jul 2020 10:25:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 10:25:06 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sparc: use for_each_child_of_node() macro
Date:   Tue, 28 Jul 2020 10:28:17 +0800
Message-ID: <20200728022817.87957-1-miaoqinglang@huawei.com>
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

Use for_each_child_of_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 arch/sparc/kernel/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 5d45b6d76..9c2b720bf 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -552,9 +552,8 @@ static void pci_of_scan_bus(struct pci_pbm_info *pbm,
 		pci_info(bus, "scan_bus[%pOF] bus no %d\n",
 			 node, bus->number);
 
-	child = NULL;
 	prev_devfn = -1;
-	while ((child = of_get_next_child(node, child)) != NULL) {
+	for_each_child_of_node(node, child) {
 		if (ofpci_verbose)
 			pci_info(bus, "  * %pOF\n", child);
 		reg = of_get_property(child, "reg", &reglen);
-- 
2.25.1

