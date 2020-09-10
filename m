Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41528C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0D920719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgIJVt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:49:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11773 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730522AbgIJMZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:25:47 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D4A7FAC483107EA50ED7;
        Thu, 10 Sep 2020 20:25:36 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 20:25:26 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alex.williamson@redhat.com>, <cohuck@redhat.com>,
        <kwankhede@nvidia.com>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] vfio: Fix typo of the device_state
Date:   Thu, 10 Sep 2020 20:25:08 +0800
Message-ID: <20200910122508.705-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A typo fix ("_RUNNNG" => "_RUNNING") in comment block of the uapi header.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 include/uapi/linux/vfio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 920470502329..d4bd39e124bf 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -462,7 +462,7 @@ struct vfio_region_gfx_edid {
  * 5. Resumed
  *                  |--------->|
  *
- * 0. Default state of VFIO device is _RUNNNG when the user application starts.
+ * 0. Default state of VFIO device is _RUNNING when the user application starts.
  * 1. During normal shutdown of the user application, the user application may
  *    optionally change the VFIO device state from _RUNNING to _STOP. This
  *    transition is optional. The vendor driver must support this transition but
-- 
2.19.1

