Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AADC35672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 10:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C6E208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 10:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgBVK1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 05:27:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38788 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgBVK1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 05:27:22 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9C0FC2963B4;
        Sat, 22 Feb 2020 10:27:20 +0000 (GMT)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 1/3] i3c: Fix MODALIAS uevents
Date:   Sat, 22 Feb 2020 11:27:09 +0100
Message-Id: <20200222102711.1352006-2-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200222102711.1352006-1-boris.brezillon@collabora.com>
References: <20200222102711.1352006-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file2alias uses %X formatters. Fix typos in the MODALIAS uevent to print
the part and ext IDs in uppercase.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index b56207bbed2b..b6db82862a63 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -267,7 +267,7 @@ static int i3c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 				      devinfo.dcr, manuf);
 
 	return add_uevent_var(env,
-			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04xext%04x",
+			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04Xext%04X",
 			      devinfo.dcr, manuf, part, ext);
 }
 
-- 
2.24.1

