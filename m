Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A79C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78F422B2E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752410;
	bh=0PE/ZEegeyQ50KVBzDMMsCfxPGXZ/ksQVk9m47noOKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lF2DlaTQ45FKFDLTbu0tovV6ajnmqP/r/lApt89j/CpfdmoM8KsTeHXr8CuAollzh
	 98mv0K4dc3ObreYYagYvk9olR8wMBFcoHYnWCzBeLGfFRfkopmDzyePv/WWpJpWo66
	 La/Lkkfkn68ag6TJEmpJOnR8KikyonXsHPPFflOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgGNSqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbgGNSqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:46:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E77A222E9;
        Tue, 14 Jul 2020 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752405;
        bh=0PE/ZEegeyQ50KVBzDMMsCfxPGXZ/ksQVk9m47noOKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYyZDXu7ae1cZi4JHSoRHmuwKF2uw57VkA1kDtbM4WFUOwh9b8UoSD1bLxxq20+ZC
         nhHta3CT2o8197rg4DxwYXiwlCJNq3+QYgWROT351iSISfzFdrwqhastLbBXXuMyHZ
         1qJWFT6N/i9H9h6ebTHdd1zhmFoNcxZO5z/hQS5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/58] gpu: host1x: Detach driver on unregister
Date:   Tue, 14 Jul 2020 20:43:42 +0200
Message-Id: <20200714184056.599981424@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184056.149119318@linuxfoundation.org>
References: <20200714184056.149119318@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit d9a0a05bf8c76e6dc79230669a8b5d685b168c30 ]

Currently when a host1x device driver is unregistered, it is not
detached from the host1x controller, which means that the device
will stay around and when the driver is registered again, it may
bind to the old, stale device rather than the new one that was
created from scratch upon driver registration. This in turn can
cause various weird crashes within the driver core because it is
confronted with a device that was already deleted.

Fix this by detaching the driver from the host1x controller when
it is unregistered. This ensures that the deleted device also is
no longer present in the device list that drivers will bind to.

Reported-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Tested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/bus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 0121fe7a4548d..02f896b50ed07 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -632,8 +632,17 @@ EXPORT_SYMBOL(host1x_driver_register_full);
  */
 void host1x_driver_unregister(struct host1x_driver *driver)
 {
+	struct host1x *host1x;
+
 	driver_unregister(&driver->driver);
 
+	mutex_lock(&devices_lock);
+
+	list_for_each_entry(host1x, &devices, list)
+		host1x_detach_driver(host1x, driver);
+
+	mutex_unlock(&devices_lock);
+
 	mutex_lock(&drivers_lock);
 	list_del_init(&driver->list);
 	mutex_unlock(&drivers_lock);
-- 
2.25.1



