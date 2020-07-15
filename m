Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F80BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240F020663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGODMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:12:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726852AbgGODMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:12:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3029CF1C7A3FF46CCD8E;
        Wed, 15 Jul 2020 11:12:14 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 11:12:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <b-liu@ti.com>, <gregkh@linuxfoundation.org>,
        <nishadkamdar@gmail.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] USB: musb: Remove unused inline function
Date:   Wed, 15 Jul 2020 11:12:04 +0800
Message-ID: <20200715031204.17308-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never used, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/musb/musb_host.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 32336571f05c..4804d4d85c15 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -97,7 +97,6 @@ static inline void musb_host_tx(struct musb *musb, u8 epnum)	{}
 static inline void musb_host_rx(struct musb *musb, u8 epnum)	{}
 static inline void musb_root_disconnect(struct musb *musb)	{}
 static inline void musb_host_resume_root_hub(struct musb *musb)	{}
-static inline void musb_host_poll_rh_status(struct musb *musb)	{}
 static inline void musb_host_poke_root_hub(struct musb *musb)	{}
 static inline int musb_port_suspend(struct musb *musb, bool do_suspend)
 {
-- 
2.17.1


