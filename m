Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD4FC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE24B206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgCQGWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:22:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:53584 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQGWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:22:37 -0400
IronPort-SDR: USMivveEUvBV9VHRnGPzCYDuSyI2oc3JLIxHLcmRpqjQLTsZQFxJzDFx5hOh4sX/rsbDEQnKwx
 xv+L8yZ/OaZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 23:22:37 -0700
IronPort-SDR: zraXoa41tEBgEM1Bf66mcMJuxtFtPWMgqnxA1RZ914NBR4k4Xj/Ox3VPjvgUupNBSKYKBuaLfQ
 Z4Z5ozaLLo/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="445390311"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2020 23:22:35 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 1/6] intel_th: Disallow multi mode on devices where it's broken
Date:   Tue, 17 Mar 2020 08:22:10 +0200
Message-Id: <20200317062215.15598-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317062215.15598-1-alexander.shishkin@linux.intel.com>
References: <20200317062215.15598-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some versions of Intel TH have an issue that prevents the multi mode of
MSU from working correctly, resulting in no trace data and potentially
stuck MSU pipeline.

Disable multi mode on such devices.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/intel_th.h |  2 ++
 drivers/hwtracing/intel_th/msu.c      | 11 +++++++++--
 drivers/hwtracing/intel_th/pci.c      |  8 ++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 6f4f5486fe6d..5fe694708b7a 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -47,11 +47,13 @@ struct intel_th_output {
 /**
  * struct intel_th_drvdata - describes hardware capabilities and quirks
  * @tscu_enable:	device needs SW to enable time stamping unit
+ * @multi_is_broken:	device has multiblock mode is broken
  * @has_mintctl:	device has interrupt control (MINTCTL) register
  * @host_mode_only:	device can only operate in 'host debugger' mode
  */
 struct intel_th_drvdata {
 	unsigned int	tscu_enable        : 1,
+			multi_is_broken    : 1,
 			has_mintctl        : 1,
 			host_mode_only     : 1;
 };
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 8e48c7458aa3..6e118b790d83 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -157,7 +157,8 @@ struct msc {
 	/* config */
 	unsigned int		enabled : 1,
 				wrap	: 1,
-				do_irq	: 1;
+				do_irq	: 1,
+				multi_is_broken : 1;
 	unsigned int		mode;
 	unsigned int		burst_len;
 	unsigned int		index;
@@ -1664,7 +1665,7 @@ static int intel_th_msc_init(struct msc *msc)
 {
 	atomic_set(&msc->user_count, -1);
 
-	msc->mode = MSC_MODE_MULTI;
+	msc->mode = msc->multi_is_broken ? MSC_MODE_SINGLE : MSC_MODE_MULTI;
 	mutex_init(&msc->buf_mutex);
 	INIT_LIST_HEAD(&msc->win_list);
 	INIT_LIST_HEAD(&msc->iter_list);
@@ -1876,6 +1877,9 @@ mode_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	return -EINVAL;
 
 found:
+	if (i == MSC_MODE_MULTI && msc->multi_is_broken)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&msc->buf_mutex);
 	ret = 0;
 
@@ -2082,6 +2086,9 @@ static int intel_th_msc_probe(struct intel_th_device *thdev)
 	if (!res)
 		msc->do_irq = 1;
 
+	if (INTEL_TH_CAP(to_intel_th(thdev), multi_is_broken))
+		msc->multi_is_broken = 1;
+
 	msc->index = thdev->id;
 
 	msc->thdev = thdev;
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index e9d90b53bbc4..ad7e51ebe49e 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -120,6 +120,10 @@ static void intel_th_pci_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+static const struct intel_th_drvdata intel_th_1x_multi_is_broken = {
+	.multi_is_broken	= 1,
+};
+
 static const struct intel_th_drvdata intel_th_2x = {
 	.tscu_enable	= 1,
 	.has_mintctl	= 1,
@@ -152,7 +156,7 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 	{
 		/* Kaby Lake PCH-H */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa2a6),
-		.driver_data = (kernel_ulong_t)0,
+		.driver_data = (kernel_ulong_t)&intel_th_1x_multi_is_broken,
 	},
 	{
 		/* Denverton */
@@ -207,7 +211,7 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 	{
 		/* Comet Lake PCH-V */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa3a6),
-		.driver_data = (kernel_ulong_t)&intel_th_2x,
+		.driver_data = (kernel_ulong_t)&intel_th_1x_multi_is_broken,
 	},
 	{
 		/* Ice Lake NNPI */
-- 
2.25.1

