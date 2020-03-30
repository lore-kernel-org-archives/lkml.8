Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F7C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5920714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pOBEKVJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgC3JtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:49:17 -0400
Received: from m12-16.163.com ([220.181.12.16]:34974 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgC3JtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SeQld
        okjjHJIvAaKZfMt5XF+uZtumxTB+zmHBvirpZM=; b=pOBEKVJ1ZuJNrpDb1zAKA
        +B1Uyu4iFaebAt/GLkMyo6SPKi246FcHTIctoVXobLLwXIY3sgeUDB34Ky/2E61t
        GWTEXw19UBfrI/kf+PkH55dwQpIWbgZpPQ8GCnNz/zNUjfk0crzMUy6iYJ3jQ1C7
        Cwz6N6bfSUEBz45UlZpRGY=
Received: from localhost.localdomain (unknown [125.82.11.174])
        by smtp12 (Coremail) with SMTP id EMCowABHZ7e0v4FeUMNJAg--.29599S4;
        Mon, 30 Mar 2020 17:45:27 +0800 (CST)
From:   Hu Haowen <xianfengting221@163.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     josef@toxicpanda.com, tglx@linutronix.de, maennich@google.com,
        xiubli@redhat.com, jeyu@kernel.org, kw@linux.com,
        chris@chris-wilson.co.uk, xianfengting221@163.com, wqu@suse.com,
        yamada.masahiro@socionext.com, stfrench@microsoft.com,
        airlied@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: mic: correct a typo
Date:   Mon, 30 Mar 2020 17:45:19 +0800
Message-Id: <20200330094519.17299-1-xianfengting221@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowABHZ7e0v4FeUMNJAg--.29599S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4rCw1UXFW7tw47JF48tFb_yoW3trc_C3
        ykXF4Iqr4jkF1xK39rJr4fur9xKa1UuF95uF13tF4fG3y7uw1DXrWqyr17A345Za4vvFWk
        GrykZ340yw15tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRtxhJUUUUU==
X-Originating-IP: [125.82.11.174]
X-CM-SenderInfo: h0ld0wxhqj3xtqjsjii6rwjhhfrp/1tbiWwz2AFSImCfQcwAAsh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word "Dont" is incorrect and should be replaced with "Don't".

Signed-off-by: Hu Haowen <xianfengting221@163.com>
---
 drivers/misc/mic/scif/scif_nodeqp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/scif/scif_nodeqp.c b/drivers/misc/mic/scif/scif_nodeqp.c
index fcd999f50d14..ea084626fe11 100644
--- a/drivers/misc/mic/scif/scif_nodeqp.c
+++ b/drivers/misc/mic/scif/scif_nodeqp.c
@@ -660,7 +660,7 @@ int scif_nodeqp_send(struct scif_dev *scifdev, struct scifmsg *msg)
 	struct device *spdev = NULL;
 
 	if (msg->uop > SCIF_EXIT_ACK) {
-		/* Dont send messages once the exit flow has begun */
+		/* Don't send messages once the exit flow has begun */
 		if (OP_IDLE != scifdev->exit)
 			return -ENODEV;
 		spdev = scif_get_peer_dev(scifdev);
-- 
2.20.1


