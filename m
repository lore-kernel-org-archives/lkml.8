Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44FAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54DD2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgEFGr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:47:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727812AbgEFGrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:47:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D592D9CC630AC67649E;
        Wed,  6 May 2020 14:47:19 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 14:47:13 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] x86/platform/uv: Use false for return type bool
Date:   Wed, 6 May 2020 14:53:10 +0800
Message-ID: <1588747990-36348-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

arch/x86/include/asm/uv/uv.h:45:53-54: WARNING: return of 0/1
in function 'is_early_uv_system' with return type bool

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 arch/x86/include/asm/uv/uv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 91e088a..334da92 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -42,7 +42,7 @@ extern const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
 #else	/* X86_UV */
 
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
-static inline bool is_early_uv_system(void)	{ return 0; }
+static inline bool is_early_uv_system(void)	{ return false; }
 static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubbed(int uv)	{ return 0; }
 static inline int is_uv_hubless(int uv) { return 0; }
-- 
2.6.2

