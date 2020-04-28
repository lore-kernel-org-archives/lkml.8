Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772B8C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D5B20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgD1VhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:37:11 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD1VhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:37:09 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mo7if-1ioQaP0hbP-00phAH; Tue, 28 Apr 2020 23:36:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Rajat Jain <rajatja@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel_pmc_core: avoid unused-function warnings
Date:   Tue, 28 Apr 2020 23:36:38 +0200
Message-Id: <20200428213648.3629501-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nvNU/HDnyd33t01OiWL2I6dmE6u7w9oJnm8AAqtxowJeqKhvQqw
 haXaJX3ywsdYR3AiMt+DPphtMU8g2kfqr6aHeEMyOQZZGE5dPzUqOu2osXRe0uLC3C0VOMz
 HzWqotj1SsW3Y/AvXF/P95eaHSZICk/8ENTuDVyEeSjfaf7YOqvLqao5ml281iy5MyH+Ksq
 BcbAGEs2BAPst60ge+MUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3jBJdqlr6ro=:83ZkR/dO+GI/5JLxYRofra
 PMNHMSM1p4DgHgv6TawQA7/2OIZLJ83xhjBifRvVkYFDYDfOIlwP3V8WQULv8spF7VFEX1YcC
 SQ7hOvblO4759ek641nhlE8yuhyDClhcAsH8Qqys53wd1rOTEAd5XoLn7SBt492N7vgNx9oxR
 gu1mdiYKgviFj9sLkGf+2q1nW3wLTaVOO8z6BFgwS+zIabtvMlDwyk6ReB0GhqiqDO/Uys3EE
 ATNsBLWpPTPcmo1IEWN0gx/lWFJ22WtCWEbn+2oN7VQy4l19rAp9nDdjn8lTcHR30nFKPCPs0
 NyRafXoBqS3FyWYolEC8zDfrusNEbJopW6G+2Xqou2Ja3HF97jaPEULV1IQBtkP8H+OTa8wl7
 h95hNSOy3K8B5YOLPvd3RbP9KU0exb+rMEIDvjycxLQOlnl6JTYo1PLIS6qtqh6Ghn+JQckfB
 btsS6GtDim+atapsQuVLcUVYJMtYz0OKSDpmDkrY4ISYK9Oc6TSbi1yDWAZB1f0FnXcuecZoo
 kxdHtKo1CNWaHTrQKkc0/8axUjW6j5Pgj5C5bqrTzqZDX/xhOd1CEVlZxpFtfPOX/5nUtnRT8
 S4fXSiQHIqYF3QrZ5TiuGxLfK6OEx9LnTWpbW8ulN3zBYxeone9N6hLt20y0py6JeQYHBfLD1
 jS2Z5LbPr/urw7cskvGVDq1wFZ+Kx/HQeD6pg5zof0X4eNgNaXzVKlvltmnhbVAUSkc+Y5OuR
 /jHphW1EPpLm5gw723MqJSMPYtXN7/QHU2zLp5jG/awnoiJJ/6IYTiZJhZqfXjrJtwogCoXRP
 7q90t4JZky2DWlWef3ZSymSG6x4TPKJEL5x81YV6UXtoWEczBE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both CONFIG_DEBUG_FS and CONFIG_PM_SLEEP are disabled, the
functions that got moved out of the #ifdef section now cause
a warning:

drivers/platform/x86/intel_pmc_core.c:654:13: error: 'pmc_core_lpm_display' defined but not used [-Werror=unused-function]
  654 | static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~
drivers/platform/x86/intel_pmc_core.c:617:13: error: 'pmc_core_slps0_display' defined but not used [-Werror=unused-function]
  617 | static void pmc_core_slps0_display(struct pmc_dev *pmcdev, struct device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~

Rather than add even more #ifdefs here, remove them entirely and
let the compiler work it out, it can actually get rid of all the
debugfs calls without problems as long as the struct member is
there.

The two PM functions just need a __maybe_unused annotations to avoid
another warning instead of the #ifdef.

Fixes: aae43c2bcdc1 ("platform/x86: intel_pmc_core: Relocate pmc_core_*_display() to outside of CONFIG_DEBUG_FS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/intel_pmc_core.c | 18 ++----------------
 drivers/platform/x86/intel_pmc_core.h |  2 --
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index a130859ec49e..7c8bdab078cf 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -692,7 +692,6 @@ static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
 	kfree(lpm_regs);
 }
 
-#if IS_ENABLED(CONFIG_DEBUG_FS)
 static bool slps0_dbg_latch;
 
 static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
@@ -1133,15 +1132,6 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 				    &pmc_core_substate_l_sts_regs_fops);
 	}
 }
-#else
-static inline void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
-{
-}
-
-static inline void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
-{
-}
-#endif /* CONFIG_DEBUG_FS */
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&spt_reg_map),
@@ -1260,13 +1250,11 @@ static int pmc_core_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static bool warn_on_s0ix_failures;
 module_param(warn_on_s0ix_failures, bool, 0644);
 MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
 
-static int pmc_core_suspend(struct device *dev)
+static __maybe_unused int pmc_core_suspend(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 
@@ -1318,7 +1306,7 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 	return false;
 }
 
-static int pmc_core_resume(struct device *dev)
+static __maybe_unused int pmc_core_resume(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
@@ -1348,8 +1336,6 @@ static int pmc_core_resume(struct device *dev)
 	return 0;
 }
 
-#endif
-
 static const struct dev_pm_ops pmc_core_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
 };
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 0d50b2402abe..5eae55d80226 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -282,9 +282,7 @@ struct pmc_dev {
 	u32 base_addr;
 	void __iomem *regbase;
 	const struct pmc_reg_map *map;
-#if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbgfs_dir;
-#endif /* CONFIG_DEBUG_FS */
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
-- 
2.26.0

