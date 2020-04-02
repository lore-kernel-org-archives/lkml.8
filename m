Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5372C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2BD20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbgDBCqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:46:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbgDBCqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:46:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9C1B6186E5F6EA8223A;
        Thu,  2 Apr 2020 10:46:44 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 10:46:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <lingshan.zhu@intel.com>,
        <xiao.w.wang@intel.com>, <tiwei.bie@intel.com>,
        <yuehaibing@huawei.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] vdpa: remove unused variables 'ifcvf' and 'ifcvf_lm'
Date:   Thu, 2 Apr 2020 10:46:26 +0800
Message-ID: <20200402024626.32944-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200331080259.33056-1-yuehaibing@huawei.com>
References: <20200331080259.33056-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/vdpa/ifcvf/ifcvf_main.c:34:24:
 warning: variable ‘ifcvf’ set but not used [-Wunused-but-set-variable]
drivers/vdpa/ifcvf/ifcvf_base.c:304:31:
 warning: variable ‘ifcvf_lm’ set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v2: rework based on commit a4be40cbcedb ("vdpa: move to drivers/vdpa")
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 2 --
 drivers/vdpa/ifcvf/ifcvf_main.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index b61b06ea26d3..e24371d644b5 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -301,12 +301,10 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u64 num)
 
 static int ifcvf_hw_enable(struct ifcvf_hw *hw)
 {
-	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
 	struct virtio_pci_common_cfg __iomem *cfg;
 	struct ifcvf_adapter *ifcvf;
 	u32 i;
 
-	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
 	ifcvf = vf_to_adapter(hw);
 	cfg = hw->common_cfg;
 	ifc_iowrite16(IFCVF_MSI_CONFIG_OFF, &cfg->msix_config);
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 8d54dc5b08d2..28d9e5de5675 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -31,11 +31,9 @@ static irqreturn_t ifcvf_intr_handler(int irq, void *arg)
 static int ifcvf_start_datapath(void *private)
 {
 	struct ifcvf_hw *vf = ifcvf_private_to_vf(private);
-	struct ifcvf_adapter *ifcvf;
 	u8 status;
 	int ret;
 
-	ifcvf = vf_to_adapter(vf);
 	vf->nr_vring = IFCVF_MAX_QUEUE_PAIRS * 2;
 	ret = ifcvf_start_hw(vf);
 	if (ret < 0) {
-- 
2.17.1


