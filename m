Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCAAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1294E20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648451;
	bh=ZcDE5i42m9j0hSsmtVzmayvub4jxnh7AZrHRgXzHWhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XHLBYs4WtCmDyu+JQTvJaRQQh8belr8fEJjHoKRgKZ0qWWAwXNgMvj+bK4MvJiPXG
	 M1+r10AjHLR2ruviHjDE1Eg3OmHPFDydFJWzpAdBxIRIEK9j6WiNEpaf3iPYwTy45F
	 cMkAyaNq4Rry8BuyjCr9ldlu0QcIn508QEvsvyns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHQHOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgHQHLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:20 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27AC122B49;
        Mon, 17 Aug 2020 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648277;
        bh=ZcDE5i42m9j0hSsmtVzmayvub4jxnh7AZrHRgXzHWhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgCr34ssaqJELt20tAVRPUC1brWnwEUE5zUhim+TsOVnq4j9ThbSqTCAON68jEOAX
         nm50rEG2NQWVlZ1B3Bx+LX9J81dlFu8t0m3bFZdmH+F0V40lanpOQeAxakUp6r7SBd
         R3iWUapTQH/g3JVtuTOpIs4AOSLMte9IlT0g9dzU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIZ-00Bdjm-9Z; Mon, 17 Aug 2020 09:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 12/44] staging: mfd: hi6421-spmi-pmic: get rid of unused code
Date:   Mon, 17 Aug 2020 09:10:31 +0200
Message-Id: <ecbef801f6c32ba0850ad9e5c534a4304807df3b.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some checks there which could make sense for
downstream builds, but doesn't make much sense for
upstream ones. They came from the official Hikey970 tree
from Linaro, but even there, the commented-out code is not
set via other Kconfig vars.

So, let's just get rid of that. If needed later, this
patch can be (partially?) reversed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 63 ---------------------
 include/linux/mfd/hi6421-spmi-pmic.h        | 42 --------------
 2 files changed, 105 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 6bb0bc4b203b..809381eb6043 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -53,10 +53,6 @@
 #define HISI_PMIC_FIRST_GROUP_INT_NUM        2
 
 static struct bit_info g_pmic_vbus = {0};
-#ifndef BIT
-#define BIT(x)		(0x1U << (x))
-#endif
-
 static struct hisi_pmic *g_pmic;
 static unsigned int g_extinterrupt_flag  = 0;
 static struct of_device_id of_hisi_pmic_match_tbl[] = {
@@ -121,65 +117,6 @@ void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val)
 }
 EXPORT_SYMBOL(hisi_pmic_write);
 
-#ifdef CONFIG_HISI_DIEID
-u32 hisi_pmic_read_sub_pmu(u8 sid, int reg)
-{
-	u32 ret;
-	u8 read_value = 0;
-	struct spmi_device *pdev;
-
-	if(strstr(saved_command_line, "androidboot.swtype=factory"))
-	{
-		if (NULL == g_pmic) {
-			pr_err(" g_pmic  is NULL\n");
-			return -1;/*lint !e570 */
-		}
-
-		pdev = to_spmi_device(g_pmic->dev);
-		if (NULL == pdev) {
-			pr_err("%s:pdev get failed!\n", __func__);
-			return -1;/*lint !e570 */
-		}
-
-		ret = spmi_ext_register_readl(pdev->ctrl, sid, reg, (unsigned char*)&read_value, 1);/*lint !e734 !e732 */
-		if (ret) {
-			pr_err("%s:spmi_ext_register_readl failed!\n", __func__);
-			return ret;
-		}
-		return (u32)read_value;
-	}
-	return  0;
-}
-EXPORT_SYMBOL(hisi_pmic_read_sub_pmu);
-
-void hisi_pmic_write_sub_pmu(u8 sid, int reg, u32 val)
-{
-	u32 ret;
-	struct spmi_device *pdev;
-	if(strstr(saved_command_line, "androidboot.swtype=factory"))
-	{
-		if (NULL == g_pmic) {
-			pr_err(" g_pmic  is NULL\n");
-			return;
-		}
-
-		pdev = to_spmi_device(g_pmic->dev);
-		if (NULL == pdev) {
-			pr_err("%s:pdev get failed!\n", __func__);
-			return;
-		}
-
-		ret = spmi_ext_register_writel(pdev->ctrl, sid, reg, (unsigned char*)&val, 1);/*lint !e734 !e732 */
-		if (ret) {
-			pr_err("%s:spmi_ext_register_writel failed!\n", __func__);
-			return ;
-		}
-	}
-
-	return ;
-}
-EXPORT_SYMBOL(hisi_pmic_write_sub_pmu);
-#endif
 
 void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg,
 		     u32 mask, u32 bits)
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index 939b36f617c1..5be9b4d3f207 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -78,7 +78,6 @@ unsigned int get_uv_mntn_status(void);
 void clear_uv_mntn_resered_reg_bit(void);
 void set_uv_mntn_resered_reg_bit(void);
 
-#if defined(CONFIG_HISI_PMIC) || defined(CONFIG_HISI_PMIC_PMU_SPMI)
 /* Register Access Helpers */
 u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg);
 void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val);
@@ -90,11 +89,6 @@ int hisi_pmic_array_read(int addr, char *buff, unsigned int len);
 int hisi_pmic_array_write(int addr, char *buff, unsigned int len);
 extern int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list);
 extern int hisi_pmic_get_vbus_status(void);
-#if defined(CONFIG_HISI_DIEID)
-u32 hisi_pmic_read_sub_pmu(u8 sid ,int reg);
-void hisi_pmic_write_sub_pmu(u8 sid ,int reg, u32 val);
-#endif
-#else
 static inline u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg) { return 0; }
 static inline void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val) {}
 static inline void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits) {}
@@ -107,38 +101,7 @@ static inline int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list) { return
 static inline int hisi_pmic_get_vbus_status(void) { return 1; }
 static inline u32 hisi_pmic_read_sub_pmu(u8 sid ,int reg) { return 0; }
 static inline void hisi_pmic_write_sub_pmu(u8 sid ,int reg, u32 val) {}
-#endif
 
-#ifdef CONFIG_HISI_HI6421V500_PMU
-enum pmic_irq_list {
-	POR_D45MR = 0,
-	VBUS_CONNECT,
-	VBUS_DISCONNECT,
-	ALARMON_R,
-	HOLD_6S,
-	HOLD_1S,
-	POWERKEY_UP,
-	POWERKEY_DOWN,
-	OCP_SCP_R,
-	COUL_R,
-	VSYS_OV,
-	VSYS_UV,
-	VSYS_PWROFF_ABS,
-	VSYS_PWROFF_DEB,
-	THSD_OTMP140,
-	THSD_OTMP125,
-	HRESETN,
-	SIM0_HPD_R = 24,
-	SIM0_HPD_F,
-	SIM0_HPD_H,
-	SIM0_HPD_L,
-	SIM1_HPD_R,
-	SIM1_HPD_F,
-	SIM1_HPD_H,
-	SIM1_HPD_L,
-	PMIC_IRQ_LIST_MAX,
-};
-#else
 enum pmic_irq_list {
 	OTMP = 0,
 	VBUS_CONNECT,
@@ -156,10 +119,5 @@ enum pmic_irq_list {
 	SIM1_HPD_F,
 	PMIC_IRQ_LIST_MAX,
 };
-#endif
-
-#ifdef CONFIG_HISI_SR_DEBUG
-extern void get_ip_regulator_state(void);
-#endif
 #endif		/* __HISI_PMIC_H */
 
-- 
2.26.2

