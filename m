Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71656C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B5720776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="YroBNmuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbgFRR0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:26:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55726 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732173AbgFRR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:26:00 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IH2XcT014920;
        Thu, 18 Jun 2020 19:25:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=9JidG9SI0t24FUmVLA0cuOTFSYM8EHYtOdUK2GCQGQo=;
 b=YroBNmuZuxNVyqP6rkpu+5jD9Co2S3KWWRo+cn/EfBpiGn9fs279erCoa7AOd3A12jDG
 yypWkHkxM6/7CtIHmIs5Zg14Yrqej1idio8agYHjut2aEXKbm/gwmKhm1OOqLjw0WXMV
 r8qLQsCUs9boQJdVz0e2lz4oYVOVrf1iKVhv0LiKKA58OFmtzeKjIINd+/N8IOjfR3mg
 R/RkFUSqeuyqSVsyeJUDo/11dRrCqJAMjJjT/q3xnoAfLtfJr5fGyuWb7SdHRajR4C6x
 +7TvTsuydOYY/DY6wmW0FN1FiPUk9EUkDaYY1vCvzYpwDRsSyxDfckRAnUmls0qzYCoy dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31q64ccbrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 19:25:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50B0310002A;
        Thu, 18 Jun 2020 19:25:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36FFC2D6955;
        Thu, 18 Jun 2020 19:25:42 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun 2020 19:25:41
 +0200
From:   <patrice.chotard@st.com>
List-Id: <soc.lore.kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>
CC:     <patrice.chotard@st.com>, Alain Volmat <alain.volmat@st.com>
Subject: [PATCH] Revert "ARM: sti: Implement dummy L2 cache's write_sec"
Date:   Thu, 18 Jun 2020 19:24:56 +0200
Message-ID: <20200618172456.29475-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_14:2020-06-18,2020-06-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This reverts commit 7b8e0188fa717cd9abc4fb52587445b421835c2a.

Initially, STiH410-B2260 was supposed to be secured, that's why
l2c_write_sec was stubbed to avoid secure register access from
non secure world.

But by default, STiH410-B2260 is running in non secure mode,
so L2 cache register accesses are authorized, l2c_write_sec stub
is not needed.

With this patch, L2 cache is configured and performance are enhanced.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Cc: Alain Volmat <alain.volmat@st.com>
---
 arch/arm/mach-sti/board-dt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index dcb98937fcf5..ffecbf29646f 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -20,14 +20,6 @@ static const char *const stih41x_dt_match[] __initconst = {
 	NULL
 };
 
-static void sti_l2_write_sec(unsigned long val, unsigned reg)
-{
-	/*
-	 * We can't write to secure registers as we are in non-secure
-	 * mode, until we have some SMI service available.
-	 */
-}
-
 DT_MACHINE_START(STM, "STi SoC with Flattened Device Tree")
 	.dt_compat	= stih41x_dt_match,
 	.l2c_aux_val	= L2C_AUX_CTRL_SHARED_OVERRIDE |
@@ -36,5 +28,4 @@ DT_MACHINE_START(STM, "STi SoC with Flattened Device Tree")
 			  L2C_AUX_CTRL_WAY_SIZE(4),
 	.l2c_aux_mask	= 0xc0000fff,
 	.smp		= smp_ops(sti_smp_ops),
-	.l2c_write_sec	= sti_l2_write_sec,
 MACHINE_END
-- 
2.17.1

