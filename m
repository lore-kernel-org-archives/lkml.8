Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1847C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E62207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UtV1sTlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbgDBOEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:04:31 -0400
Received: from m12-14.163.com ([220.181.12.14]:58870 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbgDBOEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vB8A8
        ILNdgZfe8OOTGN8Sb7fekELRPDOFvkYmENO0aY=; b=UtV1sTlHURVujv7oHHexk
        YmiQZrrrxOwlL5KXNSYxbKFR1+MoofMU0ljcaLziv4C5+XFEdnEzZY2frSy76LhM
        VDI6w514bFxH0WTcj7/btBHfEDm2zt4C11j1YilrBMFeaSgZamRx+BS5iPTc1kX1
        CD0WOFRNrI0Bl3UrWJ5O8Y=
Received: from localhost.localdomain (unknown [125.82.11.8])
        by smtp10 (Coremail) with SMTP id DsCowACnU53U8IVefkTICQ--.23777S4;
        Thu, 02 Apr 2020 22:04:05 +0800 (CST)
From:   Hu Haowen <xianfengting221@163.com>
To:     jdelvare@suse.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hu Haowen <xianfengting221@163.com>
Subject: [PATCH] i2c: piix4: remove an empty and redundant comment line
Date:   Thu,  2 Apr 2020 22:03:59 +0800
Message-Id: <20200402140359.22017-1-xianfengting221@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowACnU53U8IVefkTICQ--.23777S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5cTQUUUUU
X-Originating-IP: [125.82.11.8]
X-CM-SenderInfo: h0ld0wxhqj3xtqjsjii6rwjhhfrp/1tbiDxX5AFUMSHNuKAAAsH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This line in the comment is empty and redundant, so removed it.

Signed-off-by: Hu Haowen <xianfengting221@163.com>
---
 drivers/i2c/busses/i2c-piix4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 30ded6422e7b..8bdb1d4abac5 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -2,7 +2,6 @@
 /*
     Copyright (c) 1998 - 2002 Frodo Looijaard <frodol@dds.nl> and
     Philip Edelbrock <phil@netroedge.com>
-
 */
 
 /*
-- 
2.20.1


