Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CE1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFAC2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JYYvv2FH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgE0GL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:11:57 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:53212 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0GL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=tqB8gk4cBM9ljJdG5y
        YuMl1Lq4aOSsx4vGFhMHDPSCM=; b=JYYvv2FHiyXbBl2zRz27cDg1T9B0d67055
        57h1Ealri5jEf+A76U2T3FTGDzM5R3mcT8MVmhvIHMP6F9n0qo12BEsFBbaLAHT+
        0kGX0aKYpXnIWkLGJSfA1mDrah7S63XRhTi6q/GAVJJDmgX300AoyE8h22cZqfNB
        8PH7H4fWY=
Received: from localhost.localdomain (unknown [124.64.17.235])
        by smtp2 (Coremail) with SMTP id GtxpCgB3nwiUBM5e1byuBw--.253S4;
        Wed, 27 May 2020 14:11:37 +0800 (CST)
From:   YuanJunQing <yuanjunqing66@163.com>
To:     tsbogend@alpha.franken.de
Cc:     paulburton@kernel.org, chenhc@lemote.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        liulichao@loongson.cn, YuanJunQing <yuanjunqing66@163.com>
Subject: [PATCH] MIPS: Fix IRQ tracing when call handle_fpe() and handle_msa_fpe()
Date:   Wed, 27 May 2020 14:11:30 +0800
Message-Id: <20200527061130.15618-1-yuanjunqing66@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GtxpCgB3nwiUBM5e1byuBw--.253S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWUurykKF4kZryxur4xXrb_yoWDWrc_Kr
        42v3yUKr15CwnxWr17tw4rW34Ivw4SgF9IyFyvvw1ayr45Wrs0krWvg3WkXwn3Wr4SkFWI
        y398G3Z2kF1xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjwvKUUUUUU==
X-Originating-IP: [124.64.17.235]
X-CM-SenderInfo: h1xd0ypxqtx0rjwwqiywtou0bp/xtbBURoxXFaD7Pj41wAAsI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Register "a1" is unsaved in this function,
 when CONFIG_TRACE_IRQFLAGS is enabled,
 the TRACE_IRQS_OFF macro will call trace_hardirqs_off(),
 and this may change register "a1".
 The changed register "a1" as argument will be send
 to do_fpe() and do_msa_fpe().

Signed-off-by: YuanJunQing <yuanjunqing66@163.com>
---
 arch/mips/kernel/genex.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 8236fb291e3f..a1b966f3578e 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -476,20 +476,20 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.endm
 
 	.macro	__build_clear_fpe
+	CLI
+	TRACE_IRQS_OFF
 	.set	push
 	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
 	.set	mips1
 	SET_HARDFLOAT
 	cfc1	a1, fcr31
 	.set	pop
-	CLI
-	TRACE_IRQS_OFF
 	.endm
 
 	.macro	__build_clear_msa_fpe
-	_cfcmsa	a1, MSA_CSR
 	CLI
 	TRACE_IRQS_OFF
+	_cfcmsa	a1, MSA_CSR
 	.endm
 
 	.macro	__build_clear_ade
-- 
2.17.1

