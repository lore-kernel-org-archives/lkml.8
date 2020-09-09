Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15961C10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F8F21919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgIIIzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:55:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbgIIIy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:54:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CABAE1E26E649B123902;
        Wed,  9 Sep 2020 16:54:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 16:54:45 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <xuwei5@hisilicon.com>,
        <linuxarm@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>,
        <jinying@hisilicon.com>, <zhangyi.ac@huawei.com>,
        <liguozhu@hisilicon.com>, <tangkunshan@huawei.com>,
        <huangdaode@hisilicon.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next] net: iavf: Use the ARRAY_SIZE macro for aq_to_posix
Date:   Wed, 9 Sep 2020 16:51:11 +0800
Message-ID: <1599641471-204919-1-git-send-email-xuwei5@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ARRAY_SIZE macro to calculate the size of an array.
This code was detected with the help of Coccinelle.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
index baf2fe2..eead12c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
@@ -120,7 +120,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
 	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
 		return -EAGAIN;
 
-	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
+	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
-- 
2.8.1

