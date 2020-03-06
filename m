Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7220C3F2D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ABD2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFGmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:42:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgCFGmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:42:02 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43F80B97B73A86E1D99C;
        Fri,  6 Mar 2020 14:42:01 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 14:41:50 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>,
        <dja@axtens.net>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v4 4/6] powerpc/fsl_booke/64: do not clear the BSS for the second pass
Date:   Fri, 6 Mar 2020 14:40:31 +0800
Message-ID: <20200306064033.3398-5-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200306064033.3398-1-yanaijie@huawei.com>
References: <20200306064033.3398-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BSS section has already cleared out in the first pass. No need to
clear it again. This can save some time when booting with KASLR
enabled.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Scott Wood <oss@buserror.net>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/head_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 454129a3c259..9354c292b709 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -913,6 +913,13 @@ start_here_multiplatform:
 	bl      relative_toc
 	tovirt(r2,r2)
 
+	/* Do not clear the BSS for the second pass if randomized */
+	LOAD_REG_ADDR(r3, kernstart_virt_addr)
+	ld	r3,0(r3)
+	LOAD_REG_IMMEDIATE(r4, KERNELBASE)
+	cmpd	r3,r4
+	bne	4f
+
 	/* Clear out the BSS. It may have been done in prom_init,
 	 * already but that's irrelevant since prom_init will soon
 	 * be detached from the kernel completely. Besides, we need
-- 
2.17.2

