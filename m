Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89F1C7C842
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C78206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgD0DYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 23:24:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbgD0DYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:24:31 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CF798AA9AC01DCEB5063;
        Mon, 27 Apr 2020 11:24:29 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 11:24:18 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <wambui.karugax@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 4/7] staging: rtl8723bs: core: remove set but not used 'algthm'
Date:   Mon, 27 Apr 2020 11:23:39 +0800
Message-ID: <20200427032342.27211-5-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427032342.27211-1-yanaijie@huawei.com>
References: <20200427032342.27211-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1087:33: warning: variable
‘algthm’ set but not used [-Wunused-but-set-variable]
  unsigned int seq, len, status, algthm, offset;
                                 ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 8f9da1d49343..5adc3dad8d7c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1084,7 +1084,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 
 unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_frame)
 {
-	unsigned int	seq, len, status, algthm, offset;
+	unsigned int	seq, len, status, offset;
 	unsigned char *p;
 	unsigned int	go2asoc = 0;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -1103,7 +1103,6 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 
 	offset = (GetPrivacy(pframe)) ? 4 : 0;
 
-	algthm	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset));
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
-- 
2.21.1

