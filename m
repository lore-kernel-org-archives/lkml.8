Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AAAC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBEB208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgDQMKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:10:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727824AbgDQMKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:10:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 95E8E8E4E9CB12F4DE12;
        Fri, 17 Apr 2020 20:10:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 20:10:37 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <atish.patra@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3/3] riscv: sbi: Fix undefined reference to sbi_shutdown
Date:   Fri, 17 Apr 2020 20:12:22 +0800
Message-ID: <20200417121222.156422-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417121222.156422-1-wangkefeng.wang@huawei.com>
References: <20200417121222.156422-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no shutdown call in SBI v0.2, only set pm_power_off
when RISCV_SBI_V01 enabled to fix following build error,

riscv64-linux-ld: arch/riscv/kernel/sbi.o: in function `sbi_power_off':
sbi.c:(.text+0xe): undefined reference to `sbi_shutdown

Fixes: efca13989250 ("RISC-V: Introduce a new config for SBI v0.1")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/kernel/sbi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 62b10a16c8d7..f383ef5672b2 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -167,6 +167,11 @@ static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
 
 	return result;
 }
+
+static void sbi_set_power_off(void)
+{
+	pm_power_off = sbi_shutdown;
+}
 #else
 static void __sbi_set_timer_v01(uint64_t stime_value)
 {
@@ -191,6 +196,8 @@ static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
 
 	return 0;
 }
+
+static void sbi_set_power_off(void) {}
 #endif /* CONFIG_RISCV_SBI_V01 */
 
 static void __sbi_set_timer_v02(uint64_t stime_value)
@@ -540,16 +547,12 @@ static inline long sbi_get_firmware_version(void)
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_VERSION);
 }
 
-static void sbi_power_off(void)
-{
-	sbi_shutdown();
-}
 
 int __init sbi_init(void)
 {
 	int ret;
 
-	pm_power_off = sbi_power_off;
+	sbi_set_power_off();
 	ret = sbi_get_spec_version();
 	if (ret > 0)
 		sbi_spec_version = ret;
-- 
2.20.1

