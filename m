Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A53C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A572076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160536;
	bh=X2B3az95zRIbyTuwoWaRkhmdAxD6yf8txfb/MxjlF68=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=s+HNmOU6K1+/DwS+a/kRVkubM+icC+3F8IdW/juGyLMXwbhxmXDmSFWV7b9YV9jJ3
	 280rOrL/H50dZrWoO7lyxXQWfAfj5oCEKFxoj5i2yn5nSy4ZgnPKxSy9HzM17oAbHG
	 nH5zIvSrIlk4gdUaPcE0WrU9l6wuTwFq+1TBewTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgHKPmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbgHKPmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53EC5208A9;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160523;
        bh=X2B3az95zRIbyTuwoWaRkhmdAxD6yf8txfb/MxjlF68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiaIF9qg81iQceoIPEb24bd4++OMbiwNja+/Qfm7hDnfc/nWulsvajIBII9YODZHc
         GhUwBmrZRfr4D/5tTyg/qhNcfaJu8GpCTrvTydPOxa/ofsw3BnRSLsErPSJRG2fnfd
         vT9MTxyelzGujxqRIprUpxPoLk5L6JUM4sm57tQU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bmQ-DV; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/33] regulator: hisi_regulator_spmi: port it to upstream
Date:   Tue, 11 Aug 2020 17:41:31 +0200
Message-Id: <8f13ec8a695b4e162a65c48de605b572c2f08133.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was originally written for Kernel 4.9. It needs to
be ported to upstream:

	- Got rid of timeval;
	- Removed a bogus dependency;
	- Did cleanups at the header file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hisi_regulator_spmi.c | 34 ++++---------------------
 include/linux/mfd/hisi_pmic.h           | 26 -------------------
 2 files changed, 5 insertions(+), 55 deletions(-)

diff --git a/drivers/regulator/hisi_regulator_spmi.c b/drivers/regulator/hisi_regulator_spmi.c
index 7bc0ae27b110..904cb64b1dcd 100644
--- a/drivers/regulator/hisi_regulator_spmi.c
+++ b/drivers/regulator/hisi_regulator_spmi.c
@@ -49,7 +49,6 @@ struct hisi_regulator_register_info {
 struct hisi_regulator {
 	const char *name;
 	struct hisi_regulator_register_info register_info;
-	struct timeval last_off_time;
 	u32 off_on_delay;
 	u32 eco_uA;
 	struct regulator_desc rdesc;
@@ -57,8 +56,6 @@ struct hisi_regulator {
 };
 
 static DEFINE_MUTEX(enable_mutex);
-struct timeval last_enabled;
-
 
 static inline struct hisi_pmic *rdev_to_pmic(struct regulator_dev *dev)
 {
@@ -72,27 +69,6 @@ static inline struct hisi_pmic *rdev_to_pmic(struct regulator_dev *dev)
 /* helper function to ensure when it returns it is at least 'delay_us'
  * microseconds after 'since'.
  */
-static void ensured_time_after(struct timeval since, u32 delay_us)
-{
-	struct timeval now;
-	u64 elapsed_ns64, delay_ns64;
-	u32 actual_us32;
-
-	delay_ns64 = delay_us * NSEC_PER_USEC;
-	do_gettimeofday(&now);
-	elapsed_ns64 = timeval_to_ns(&now) - timeval_to_ns(&since);
-	if (delay_ns64 > elapsed_ns64) {
-		actual_us32 = ((u32)(delay_ns64 - elapsed_ns64) /
-							NSEC_PER_USEC);
-		if (actual_us32 >= 1000) {
-			mdelay(actual_us32 / 1000); /*lint !e647 */
-			udelay(actual_us32 % 1000);
-		} else if (actual_us32 > 0) {
-			udelay(actual_us32);
-		}
-	}
-	return;
-}
 
 static int hisi_regulator_is_enabled(struct regulator_dev *dev)
 {
@@ -113,13 +89,16 @@ static int hisi_regulator_enable(struct regulator_dev *dev)
 	struct hisi_pmic *pmic = rdev_to_pmic(dev);
 
 	/* keep a distance of off_on_delay from last time disabled */
-	ensured_time_after(sreg->last_off_time, sreg->off_on_delay);
+	usleep_range(sreg->off_on_delay, sreg->off_on_delay + 1000);
 
 	pr_debug("<[%s]: off_on_delay=%dus>\n", __func__, sreg->off_on_delay);
 
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&enable_mutex);
-	ensured_time_after(last_enabled, HISI_REGS_ENA_PROTECT_TIME);
+	usleep_range(HISI_REGS_ENA_PROTECT_TIME,
+		     HISI_REGS_ENA_PROTECT_TIME + 1000);
+
+
 
 	/* set enable register */
 	hisi_pmic_rmw(pmic, sreg->register_info.ctrl_reg,
@@ -128,7 +107,6 @@ static int hisi_regulator_enable(struct regulator_dev *dev)
 	pr_debug("<[%s]: ctrl_reg=0x%x,enable_mask=0x%x>\n", __func__, sreg->register_info.ctrl_reg,\
 			sreg->register_info.enable_mask);
 
-	do_gettimeofday(&last_enabled);
 	mutex_unlock(&enable_mutex);
 
 	return 0;
@@ -143,8 +121,6 @@ static int hisi_regulator_disable(struct regulator_dev *dev)
 	hisi_pmic_rmw(pmic, sreg->register_info.ctrl_reg,
 				sreg->register_info.enable_mask, 0);
 
-	do_gettimeofday(&sreg->last_off_time);
-
 	return 0;
 }
 
diff --git a/include/linux/mfd/hisi_pmic.h b/include/linux/mfd/hisi_pmic.h
index 5be9b4d3f207..c3f6e59e2b7d 100644
--- a/include/linux/mfd/hisi_pmic.h
+++ b/include/linux/mfd/hisi_pmic.h
@@ -73,34 +73,9 @@ struct hisi_pmic {
 	struct write_lock debug_lock;
 };
 
-/* 0:disable; 1:enable */
-unsigned int get_uv_mntn_status(void);
-void clear_uv_mntn_resered_reg_bit(void);
-void set_uv_mntn_resered_reg_bit(void);
-
-/* Register Access Helpers */
 u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg);
 void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val);
 void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits);
-unsigned int hisi_pmic_reg_read(int addr);
-void hisi_pmic_reg_write(int addr, int val);
-void hisi_pmic_reg_write_lock(int addr, int val);
-int hisi_pmic_array_read(int addr, char *buff, unsigned int len);
-int hisi_pmic_array_write(int addr, char *buff, unsigned int len);
-extern int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list);
-extern int hisi_pmic_get_vbus_status(void);
-static inline u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg) { return 0; }
-static inline void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val) {}
-static inline void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits) {}
-static inline unsigned int hisi_pmic_reg_read(int addr) { return 0; }
-static inline void hisi_pmic_reg_write(int addr, int val) {}
-static inline void hisi_pmic_reg_write_lock(int addr, int val) {}
-static inline int hisi_pmic_array_read(int addr, char *buff, unsigned int len) { return 0; }
-static inline int hisi_pmic_array_write(int addr, char *buff, unsigned int len) { return 0; }
-static inline int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list) { return -1; }
-static inline int hisi_pmic_get_vbus_status(void) { return 1; }
-static inline u32 hisi_pmic_read_sub_pmu(u8 sid ,int reg) { return 0; }
-static inline void hisi_pmic_write_sub_pmu(u8 sid ,int reg, u32 val) {}
 
 enum pmic_irq_list {
 	OTMP = 0,
@@ -120,4 +95,3 @@ enum pmic_irq_list {
 	PMIC_IRQ_LIST_MAX,
 };
 #endif		/* __HISI_PMIC_H */
-
-- 
2.26.2

