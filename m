Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E86C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5EA20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgEEOI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:08:27 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgEEOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:08:26 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLi0U-1jnV5x0VJg-00Hicr; Tue, 05 May 2020 16:08:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: fix psci dependency
Date:   Tue,  5 May 2020 16:08:08 +0200
Message-Id: <20200505140820.536615-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W3ZKT7/xEdvQph+ENgdt276DQIhipBzM1zEEilk/bWx0GepPFIO
 GcCKUY20WGorcrN3lUGfyYYtxNoVT1norbcrpXAabnY0RiXyJBvuN82CPF2xN6e1W6nglnn
 XXgVx2LKaRA/guGF6Fr9lwqMw3W8Z8t8q3G4Nj3mOMtSS2G6IgXAWknMMm2XjyYkY8WgtYS
 0C37fDtYEMYlUhymerr4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jBrtxkNnkQo=:4ekDkZBpYhVJwqwXStAi6h
 Vpm0QUui7svSv16nYvGX1NWw6dTBQT5oP6slCX76vUZSO1MZ174ggaFdA+7MfEIGwW3mEQLtm
 MeHMti57PgTOBk2jW+4vx/j0LM7ns4TlteeUXY+LXuurNGOxbFMEZ+55B4JJp+Eev6dnpfKtA
 Prpzn9/o2UH3+idI1vvSIuzYOf7/B8Om1Twl3jZBuy9rg3V+FuJo3zkZKePBspdeenJDoKNOW
 E373gY7826zOQQeHIq0JS5kwLObgwQs2RrtnuBHYc6r1ci+QPHQ+FwJsBC3Bz2lg1RUZsGJEj
 8U+71yCjUsz0KyBT0w8FHaJmHROnKLnaWreHpjJCAyF/twFFhG40eo8oWB53ybTNHZ64Uy7Xh
 D0pfS3+odsQwmUiVtS8la+Y0m9SFAxHaEz41e8fbVwgCYTuWLj8abYKQMUOXJiFBjSyf09D9L
 421aq2yOUqhm7rQhL5C33sc7UkDmfS3wIItXB6vZwEQIB1Dy2YQxlXZWyczZeNBFAS6XPv8Tw
 9upPkXMBYCb7HKZy31vh416UBFtGFm0cAqt4tFSX8K8gYBFLxFNXNNKHAkauZO712YLMUjpNG
 VD5zvvStPMJJeHQKjeiOqDD1DO+VzP90ZS9RhcLQL/RfSu1aTiX0E9IB+yQIJDCsuGCeDvbdv
 sv0DPsKu6VlGVlVzzfC9L1eKaX1r/yRbnK4k66mX1mHtGWRJJmGdzsOIahP/QpRXtTcy6s75r
 lyi8WgV0Ip6Zu5oXBmiR+FbTE1xUtYUqBe9TA/myfariDW3jWhgLrbQ52SxVmf7pgTI909fwa
 F/r7bDKMwuWQH++/fGUpz7QtXbg2MYic9H9F0y6u3cmbF7kHUU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ARM_PSCI_FW is disabled but CONFIG_HAVE_ARM_SMCCC is enabled,
arm-scmi runs into a link failure:

arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/smc.o: in function `smc_send_message':
smc.c:(.text+0x200): undefined reference to `arm_smccc_1_1_get_conduit'

Use an inline helper to default to version v1.0 in the absence of psci.

Fixes: 1dc6558062da ("firmware: arm_scmi: Add smc/hvc transport")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/arm-smccc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 59494df0f55b..4f7c962856c0 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -95,7 +95,14 @@ enum arm_smccc_conduit {
  *
  * When SMCCCv1.1 is not present, returns SMCCC_CONDUIT_NONE.
  */
+#ifdef CONFIG_ARM_PSCI_FW
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
+#else
+static inline enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
+{
+	return SMCCC_CONDUIT_NONE;
+}
+#endif
 
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
-- 
2.26.0

