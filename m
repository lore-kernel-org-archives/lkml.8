Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC6FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B3C206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580944;
	bh=+XUa+QkXIWQlTxrFkkvcAbe+hTh14HBih0M5FvU+b+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5xORp13iLWPRifU/QljeLShkJ0Zw+KO4V6N2d+jlkNn2yCuCQuScLt2xvsh8XHeD
	 kgifWkdCIwBOVFQKAMSi8u5iax+MWLGMBqy8GUyvBSgDegzoPb0Vk/+RFLrrYoih4M
	 kXi3BlzCxhQCXfL8dBzr3pN2oVs48YC8C3VDTxAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405027AbgFSPfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404851AbgFSPbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:31:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2011520734;
        Fri, 19 Jun 2020 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580695;
        bh=+XUa+QkXIWQlTxrFkkvcAbe+hTh14HBih0M5FvU+b+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwoNEfvqaYt6hPspsPHDmpwRioGlQVLpwwhE+43OkqBCvK63Rt6mBBZrFLA16b5s0
         EwGV6n+LcNzqauHp8XWfrz9sZUuqKGDUCyBJd4RmzOtm7j0SYCiDgLaLW6CMINSOmz
         zBfc/75UdqnJjnuWmYX3vvY1R7DJNEmuvg/LtdRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Qiushi Wu <wu000273@umn.edu>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.7 317/376] power: supply: core: fix memory leak in HWMON error path
Date:   Fri, 19 Jun 2020 16:33:55 +0200
Message-Id: <20200619141725.337093073@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

commit 1d7a7128a2e9e1f137c99b0a44e94d70a77343e3 upstream.

In function power_supply_add_hwmon_sysfs(), psyhw->props is
allocated by bitmap_zalloc(). But this pointer is not deallocated
when devm_add_action fail,  which lead to a memory leak bug. To fix
this, we replace devm_add_action with devm_add_action_or_reset.

Cc: stable@kernel.org
Fixes: e67d4dfc9ff19 ("power: supply: Add HWMON compatibility layer")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/power_supply_hwmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -304,7 +304,7 @@ int power_supply_add_hwmon_sysfs(struct
 		goto error;
 	}
 
-	ret = devm_add_action(dev, power_supply_hwmon_bitmap_free,
+	ret = devm_add_action_or_reset(dev, power_supply_hwmon_bitmap_free,
 			      psyhw->props);
 	if (ret)
 		goto error;


