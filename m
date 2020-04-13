Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC14C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:55:57 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F08A206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F08A206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgDMHz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:55:55 -0400
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B004C008609
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:55:55 -0700 (PDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D0FE71E67694C316AEF;
        Mon, 13 Apr 2020 15:55:53 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 15:55:46 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <ebiederm@xmission.com>,
        <ricardo.neri-calderon@linux.intel.com>, <yanaijie@huawei.com>,
        <Babu.Moger@amd.com>, <bshanks@codeweavers.com>,
        <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] x86/umip: make umip_insns static
Date:   Mon, 13 Apr 2020 16:22:13 +0800
Message-ID: <20200413082213.22934-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

arch/x86/kernel/umip.c:84:12: warning: symbol 'umip_insns' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/x86/kernel/umip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 4d732a444711..8d5cbe1bbb3b 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -81,7 +81,7 @@
 #define	UMIP_INST_SLDT  3       /* 0F 00 /0 */
 #define	UMIP_INST_STR   4       /* 0F 00 /1 */
 
-const char * const umip_insns[5] = {
+static const char * const umip_insns[5] = {
 	[UMIP_INST_SGDT] = "SGDT",
 	[UMIP_INST_SIDT] = "SIDT",
 	[UMIP_INST_SMSW] = "SMSW",
-- 
2.21.1

