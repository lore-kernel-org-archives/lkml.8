Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C7C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F2F2137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbgIHTKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:10:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731209AbgIHQFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:05:25 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7A12E37C5177444BBF63;
        Tue,  8 Sep 2020 22:06:12 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 22:06:12 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <inaky.perez-gonzalez@intel.com>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-wimax@intel.com>
Subject: [PATCH net-next] net: wimax: i2400m: fix 'msg_skb' kernel-doc warning in i2400m_msg_to_dev()
Date:   Tue, 8 Sep 2020 22:03:33 +0800
Message-ID: <20200908140333.24434-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

drivers/net/wimax/i2400m/control.c:709: warning: Excess function parameter 'msg_skb' description in 'i2400m_msg_to_dev'

This parameter is not in use. Remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/wimax/i2400m/control.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wimax/i2400m/control.c b/drivers/net/wimax/i2400m/control.c
index 9afed3b133d3..8df98757d901 100644
--- a/drivers/net/wimax/i2400m/control.c
+++ b/drivers/net/wimax/i2400m/control.c
@@ -656,8 +656,6 @@ void i2400m_msg_to_dev_cancel_wait(struct i2400m *i2400m, int code)
  *
  * @i2400m: device descriptor
  *
- * @msg_skb: an skb  *
- *
  * @buf: pointer to the buffer containing the message to be sent; it
  *           has to start with a &struct i2400M_l3l4_hdr and then
  *           followed by the payload. Once this function returns, the
-- 
2.17.1

