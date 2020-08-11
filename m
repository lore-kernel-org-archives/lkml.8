Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0461EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE96E2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160623;
	bh=BZsvxQhFWHjHKjGBpV9DB4Hq7hIqw+rVezzgOfPD/R4=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=G2mWNsOCidYQclRnyZULI1PlqTaJHJ0UN71KLrc4cfKQH9ft9Q1aInZ0tbch/PCei
	 SMIb9yrhvWIB1cDeJEqpFKiCMUZmR/s/jA8G4baKR+7se4u+JiV6W1XUgnP6nzjcgH
	 dc4y6ixtQZui5jKpTKzwHfSlvBo5kgGI3bfCm4DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgHKPnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbgHKPmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 394002083B;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160523;
        bh=BZsvxQhFWHjHKjGBpV9DB4Hq7hIqw+rVezzgOfPD/R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ysw/bZmWIfuI0DBDjupq+UHFqI+l2DQjiNlDc/TPJnCE4WsIsfyy6Teeb6BhYdCeW
         NGQcrSZnJykcENVD1im4qqjrYeFn/foNrj8mdeWUCVNe9KKO3M79+bhbz7VvxcB+oq
         6VdEjsuuaKnmHYQtHqUb2O8FxREAXVYhVhdsFSws=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bmO-Ao; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/33] mfd, regulator: get rid of unused code at HiSilicon SPMI PMIC
Date:   Tue, 11 Aug 2020 17:41:30 +0200
Message-Id: <c8ffb2144274b6f9807667455b705ecd6338ac0e.1597160086.git.mchehab+huawei@kernel.org>
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

There are some checks there which could make sense for
downstream builds, but doesn't make much sense for
upstream ones. They came from the official Hikey970 tree
from Linaro, but even there, the commented-out code is not
set via other Kconfig vars.

So, let's just get rid of that. If needed later, this
patch can be (partially?) reversed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/hisi_pmic_spmi.c            |  63 --------
 drivers/regulator/hisi_regulator_spmi.c | 196 +-----------------------
 include/linux/mfd/hisi_pmic.h           |  42 -----
 3 files changed, 8 insertions(+), 293 deletions(-)

diff --git a/drivers/mfd/hisi_pmic_spmi.c b/drivers/mfd/hisi_pmic_spmi.c
index 6bb0bc4b203b..809381eb6043 100644
--- a/drivers/mfd/hisi_pmic_spmi.c
+++ b/drivers/mfd/hisi_pmic_spmi.c
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
diff --git a/drivers/regulator/hisi_regulator_spmi.c b/drivers/regulator/hisi_regulator_spmi.c
index 941bfe32bf5b..7bc0ae27b110 100644
--- a/drivers/regulator/hisi_regulator_spmi.c
+++ b/drivers/regulator/hisi_regulator_spmi.c
@@ -34,19 +34,10 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/version.h>
-#ifdef CONFIG_HISI_PMIC_DEBUG
-#include <linux/debugfs.h>
-#endif
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/spmi.h>
 
-#if 1
-#define BRAND_DEBUG(args...) pr_debug(args);
-#else
-#define BRAND_DEBUG(args...)
-#endif
-
 struct hisi_regulator_register_info {
 	u32 ctrl_reg;
 	u32 enable_mask;
@@ -110,7 +101,7 @@ static int hisi_regulator_is_enabled(struct regulator_dev *dev)
 	struct hisi_pmic *pmic = rdev_to_pmic(dev);
 
 	reg_val = hisi_pmic_read(pmic, sreg->register_info.ctrl_reg);
-	BRAND_DEBUG("<[%s]: ctrl_reg=0x%x,enable_state=%d>\n", __func__, sreg->register_info.ctrl_reg,\
+	pr_debug("<[%s]: ctrl_reg=0x%x,enable_state=%d>\n", __func__, sreg->register_info.ctrl_reg,\
 			(reg_val & sreg->register_info.enable_mask));
 
 	return ((reg_val & sreg->register_info.enable_mask) != 0);
@@ -124,7 +115,7 @@ static int hisi_regulator_enable(struct regulator_dev *dev)
 	/* keep a distance of off_on_delay from last time disabled */
 	ensured_time_after(sreg->last_off_time, sreg->off_on_delay);
 
-	BRAND_DEBUG("<[%s]: off_on_delay=%dus>\n", __func__, sreg->off_on_delay);
+	pr_debug("<[%s]: off_on_delay=%dus>\n", __func__, sreg->off_on_delay);
 
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&enable_mutex);
@@ -134,7 +125,7 @@ static int hisi_regulator_enable(struct regulator_dev *dev)
 	hisi_pmic_rmw(pmic, sreg->register_info.ctrl_reg,
 				sreg->register_info.enable_mask,
 				sreg->register_info.enable_mask);
-	BRAND_DEBUG("<[%s]: ctrl_reg=0x%x,enable_mask=0x%x>\n", __func__, sreg->register_info.ctrl_reg,\
+	pr_debug("<[%s]: ctrl_reg=0x%x,enable_mask=0x%x>\n", __func__, sreg->register_info.ctrl_reg,\
 			sreg->register_info.enable_mask);
 
 	do_gettimeofday(&last_enabled);
@@ -165,7 +156,7 @@ static int hisi_regulator_get_voltage(struct regulator_dev *dev)
 
 	/* get voltage selector */
 	reg_val = hisi_pmic_read(pmic, sreg->register_info.vset_reg);
-	BRAND_DEBUG("<[%s]: vset_reg=0x%x>\n", __func__, sreg->register_info.vset_reg);
+	pr_debug("<[%s]: vset_reg=0x%x>\n", __func__, sreg->register_info.vset_reg);
 
 	selector = (reg_val & sreg->register_info.vset_mask) >>
 				(ffs(sreg->register_info.vset_mask) - 1);
@@ -198,7 +189,7 @@ static int hisi_regulator_set_voltage(struct regulator_dev *dev,
 		sreg->register_info.vset_mask,
 		vsel << (ffs(sreg->register_info.vset_mask) - 1));
 
-	BRAND_DEBUG("<[%s]: vset_reg=0x%x, vset_mask=0x%x, value=0x%x>\n", __func__,\
+	pr_debug("<[%s]: vset_reg=0x%x, vset_mask=0x%x, value=0x%x>\n", __func__,\
 			sreg->register_info.vset_reg,\
 			sreg->register_info.vset_mask,\
 			vsel << (ffs(sreg->register_info.vset_mask) - 1)\
@@ -214,7 +205,7 @@ static unsigned int hisi_regulator_get_mode(struct regulator_dev *dev)
 	u32 reg_val;
 
 	reg_val = hisi_pmic_read(pmic, sreg->register_info.ctrl_reg);
-	BRAND_DEBUG("<[%s]: reg_val=%d, ctrl_reg=0x%x, eco_mode_mask=0x%x>\n", __func__, reg_val,\
+	pr_debug("<[%s]: reg_val=%d, ctrl_reg=0x%x, eco_mode_mask=0x%x>\n", __func__, reg_val,\
 			sreg->register_info.ctrl_reg,\
 			sreg->register_info.eco_mode_mask\
 		   );
@@ -248,7 +239,7 @@ static int hisi_regulator_set_mode(struct regulator_dev *dev,
 		sreg->register_info.eco_mode_mask,
 		eco_mode << (ffs(sreg->register_info.eco_mode_mask) - 1));
 
-	BRAND_DEBUG("<[%s]: ctrl_reg=0x%x, eco_mode_mask=0x%x, value=0x%x>\n", __func__,\
+	pr_debug("<[%s]: ctrl_reg=0x%x, eco_mode_mask=0x%x, value=0x%x>\n", __func__,\
 			sreg->register_info.ctrl_reg,\
 			sreg->register_info.eco_mode_mask,\
 			eco_mode << (ffs(sreg->register_info.eco_mode_mask) - 1)\
@@ -403,147 +394,6 @@ static struct of_device_id of_hisi_regulator_match_tbl[] = {
 	{ /* end */ }
 };
 
-#ifdef CONFIG_HISI_PMIC_DEBUG
-extern void get_current_regulator_dev(struct seq_file *s);
-extern void set_regulator_state(char *ldo_name, int value);
-extern void get_regulator_state(char *ldo_name);
-extern int set_regulator_voltage(char *ldo_name, unsigned int vol_value);
-
-u32 pmu_atoi(char *s)
-{
-	char *p = s;
-	char c;
-	u64 ret = 0;
-	if (s == NULL)
-		return 0;
-	while ((c = *p++) != '\0') {
-		if ('0' <= c && c <= '9') {
-			ret *= 10;
-			ret += (u64)((unsigned char)c - '0');
-			if (ret > U32_MAX)
-				return 0;
-		} else {
-			break;
-		}
-	}
-	return (u32)ret;
-}
-static int dbg_hisi_regulator_show(struct seq_file *s, void *data)
-{
-	seq_printf(s, "\n\r");
-	seq_printf(s, "%-13s %-15s %-15s %-15s %-15s\n\r",
-			"LDO_NAME", "ON/OFF", "Use_count", "Open_count", "Always_on");
-	seq_printf(s, "-----------------------------------------"
-			"-----------------------------------------------\n\r");
-	get_current_regulator_dev(s);
-	return 0;
-}
-
-static int dbg_hisi_regulator_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dbg_hisi_regulator_show, inode->i_private);
-}
-
-static const struct file_operations debug_regulator_state_fops = {
-	.open		= dbg_hisi_regulator_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int dbg_control_regulator_show(struct seq_file *s, void *data)
-{
-	printk("                                                                             \n\r \
-		---------------------------------------------------------------------------------\n\r \
-		|usage:                                                                         |\n\r \
-		|	S = state	R = read	V = voltage                                         |\n\r \
-		|	set ldo state and voltage                                                   |\n\r \
-		|	get ldo state and current voltage                                           |\n\r \
-		|example:                                                                       |\n\r \
-		|	echo S ldo16 0   > control_regulator	:disable ldo16                      |\n\r \
-		|	echo S ldo16 1   > control_regulator	:enable ldo16                       |\n\r \
-		|	echo R ldo16     > control_regulator	:get ldo16 state and voltage        |\n\r \
-		|	echo V ldo16 xxx > control_regulator	:set ldo16 voltage                  |\n\r \
-		---------------------------------------------------------------------------------\n\r");
-	return 0;
-}
-static ssize_t dbg_control_regulator_set_value(struct file *filp, const char __user *buffer,
-	size_t count, loff_t *ppos)
-{
-	char tmp[128] = {0};
-	char ptr[128] = {0};
-	char *vol = NULL;
-	char num = 0;
-	unsigned int i;
-	int next_flag = 1;
-
-	if (count >= 128) {
-		pr_info("error! buffer size big than internal buffer\n");
-		return -EFAULT;
-	}
-
-	if (copy_from_user(tmp, buffer, count)) {
-		pr_info("error!\n");
-		return -EFAULT;
-	}
-
-	if (tmp[0] == 'R' || tmp[0] == 'r') {
-		for (i = 2; i < (count - 1); i++) {
-			ptr[i - 2] = tmp[i];
-		}
-		ptr[i - 2] = '\0';
-		get_regulator_state(ptr);
-	} else if (tmp[0] == 'S' || tmp[0] == 's') {
-		for (i = 2; i < (count - 1); i++) {
-			if (tmp[i] == ' ') {
-				next_flag = 0;
-				ptr[i - 2] = '\0';
-				continue;
-			}
-			if (next_flag) {
-				ptr[i - 2] = tmp[i];
-			} else {
-				num = tmp[i] - 48;
-			}
-		}
-		set_regulator_state(ptr, num);
-	} else if (tmp[0] == 'V' || tmp[0] == 'v') {
-		for (i = 2; i < (count - 1); i++) {
-			if (tmp[i] == ' ') {
-				next_flag = 0;
-				ptr[i - 2] = '\0';
-				continue;
-			}
-			if (next_flag) {
-				ptr[i - 2] = tmp[i];
-			} else {
-				vol = &tmp[i];
-				break;
-			}
-		}
-		set_regulator_voltage(ptr, pmu_atoi(vol));
-	}
-
-	*ppos += count;
-
-	return count;
-}
-
-static int dbg_control_regulator_open(struct inode *inode, struct file *file)
-{
-	file->private_data = inode->i_private;
-	return single_open(file, dbg_control_regulator_show, &inode->i_private);
-}
-
-static const struct file_operations set_control_regulator_fops = {
-	.open		= dbg_control_regulator_open,
-	.read		= seq_read,
-	.write		= dbg_control_regulator_set_value,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-#endif
-
 static int hisi_regulator_probe(struct spmi_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -556,10 +406,6 @@ static int hisi_regulator_probe(struct spmi_device *pdev)
 	const struct of_device_id *match;
 	struct regulation_constraints *constraint;
 	const char *supplyname = NULL;
-#ifdef CONFIG_HISI_PMIC_DEBUG
-	struct dentry *d;
-	static int debugfs_flag;
-#endif
 	unsigned int temp_modes;
 
 	const struct hisi_regulator *template = NULL;
@@ -572,11 +418,7 @@ static int hisi_regulator_probe(struct spmi_device *pdev)
 	}
 
 	template = match->data;
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(3, 13, 0))
 	initdata = of_get_regulator_init_data(dev, np, NULL);
-#else
-	initdata = of_get_regulator_init_data(dev, np);
-#endif
 	if (NULL == initdata) {
 		pr_err("get regulator init data error !\n");
 		return -EINVAL;
@@ -636,32 +478,10 @@ static int hisi_regulator_probe(struct spmi_device *pdev)
 		goto hisi_probe_end;
 	}
 
-	BRAND_DEBUG("[%s]:valid_modes_mask[0x%x], valid_ops_mask[0x%x]\n", rdesc->name,\
+	pr_debug("[%s]:valid_modes_mask[0x%x], valid_ops_mask[0x%x]\n", rdesc->name,\
 			constraint->valid_modes_mask, constraint->valid_ops_mask);
 
 	dev_set_drvdata(dev, rdev);
-#ifdef CONFIG_HISI_PMIC_DEBUG
-	if (debugfs_flag == 0) {
-		d = debugfs_create_dir("hisi_regulator_debugfs", NULL);
-		if (!d) {
-			dev_err(dev, "failed to create hisi regulator debugfs dir !\n");
-			ret = -ENOMEM;
-			goto hisi_probe_fail;
-		}
-		(void) debugfs_create_file("regulator_state", S_IRUSR,
-						d, NULL, &debug_regulator_state_fops);
-
-		(void) debugfs_create_file("control_regulator", S_IRUSR,
-						d, NULL, &set_control_regulator_fops);
-		debugfs_flag = 1;
-	}
-#endif
-
-#ifdef CONFIG_HISI_PMIC_DEBUG
-hisi_probe_fail:
-	if (ret)
-		regulator_unregister(rdev);
-#endif
 hisi_probe_end:
 	if (ret)
 		kfree(sreg);
diff --git a/include/linux/mfd/hisi_pmic.h b/include/linux/mfd/hisi_pmic.h
index 939b36f617c1..5be9b4d3f207 100644
--- a/include/linux/mfd/hisi_pmic.h
+++ b/include/linux/mfd/hisi_pmic.h
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

