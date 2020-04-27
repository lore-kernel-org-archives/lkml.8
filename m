Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282D2C7C840
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A842084D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgD0DYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 23:24:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726447AbgD0DYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:24:31 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A447A892CAD0EE307B57;
        Mon, 27 Apr 2020 11:24:29 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 11:24:20 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <wambui.karugax@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 7/7] staging: rtl8723bs: core:  remove set but not used 'pframe'
Date:   Mon, 27 Apr 2020 11:23:42 +0800
Message-ID: <20200427032342.27211-8-yanaijie@huawei.com>
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

drivers/staging/rtl8723bs/core/rtw_mlme.c:2920:6: warning: variable
‘pframe’ set but not used [-Wunused-but-set-variable]
  u8 *pframe;
      ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index abf60c92c1ac..e65c5a870b46 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2914,12 +2914,11 @@ void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
 	u8 cap_content[8] = {0};
-	u8 *pframe;
 
 	if (phtpriv->bss_coexist)
 		SET_EXT_CAPABILITY_ELE_BSS_COEXIST(cap_content, 1);
 
-	pframe = rtw_set_ie(out_ie + *pout_len, EID_EXTCapability, 8, cap_content, pout_len);
+	rtw_set_ie(out_ie + *pout_len, EID_EXTCapability, 8, cap_content, pout_len);
 }
 
 inline void rtw_set_to_roam(struct adapter *adapter, u8 to_roam)
-- 
2.21.1

