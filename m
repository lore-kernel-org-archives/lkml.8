Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B25C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0125720716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597688456;
	bh=0GBW3XhInIC+3/GduSZ8I9eU0NOvG+GDn7TUMMjMG6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSQR7tFUAhwhPgcX2frxQLpVeLNpw6wKkAW9lCDgmeMF/dW49fEvhManVaYntJAAh
	 hfQKR3ae9wihXlybXgXYYD3vV8YK8/7alwrFhw2wwOb6g8z5pKhtcWPdIjaJQi9xIB
	 UjLYejqaJCFSYMHKRX1mVWwLRe1e18khqRPID1RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390267AbgHQSUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388301AbgHQQE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:04:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB134206FA;
        Mon, 17 Aug 2020 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680265;
        bh=0GBW3XhInIC+3/GduSZ8I9eU0NOvG+GDn7TUMMjMG6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0mxyh6Af36T6/2ZReO80CMi4VZfe9nQjjMPta2z8OSF1b2Xw8iyi8Cl8k5o6mqwM
         8xK2oL+lpABrtfZ3oy/Hpnrud6dZ4XEnn3vSkcodZRyaE1LY2fE9UKHd8qiNrVm0Ih
         v9ZYjixmhM8M63WUyF5zY64OSvZrLh7pVw9iESdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 117/270] staging: vchiq_arm: Add a matching unregister call
Date:   Mon, 17 Aug 2020 17:15:18 +0200
Message-Id: <20200817143801.600249632@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.com>

[ Upstream commit 5d9272e28a9a6117fb63f5f930991304765caa32 ]

All the registered children of vchiq have a corresponding call to
platform_device_unregister except bcm2835_audio. Fix that.

Fixes: 25c7597af20d ("staging: vchiq_arm: Register a platform device for audio")

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Link: https://lore.kernel.org/r/20200629150945.10720-9-nsaenzjulienne@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index af6bf0736b527..eb76cc2cbfd8c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -3257,6 +3257,7 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
+	platform_device_unregister(bcm2835_audio);
 	platform_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	device_destroy(vchiq_class, vchiq_devid);
-- 
2.25.1



