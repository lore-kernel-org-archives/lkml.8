Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C88C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8418320748
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653436;
	bh=bQdhkyleKNrB/eAmk3MoXZ4uuEJHYABQVPYga/A9WNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQ8kFpf195cKBc9XwENalakkCTxPjmpB3SjWdTffUaWjxNa+N3+sE7ph3Z6NBjQhs
	 CxoOgHhi8PsVSFBEXcHcUUv2WJ6ef/ayLq6v+Mj4Wvm02VGWujieez1lPacKAAT+ZT
	 RUS+gHtWJMEmv3SWmsgztooNJDIiPeHVxEI5FLJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgGBBad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbgGBB05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:26:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5A5820748;
        Thu,  2 Jul 2020 01:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653216;
        bh=bQdhkyleKNrB/eAmk3MoXZ4uuEJHYABQVPYga/A9WNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vr6v19I9LlrkYNvq8VkGr9gi+MIU2GGYmyv4+OxeNOm7M1D5ZTBA5xKZO4AGfntd8
         ANiwXfq46lTIb0Uvc+v1ZMWaZscXKcm6vtA1qzQYlDBjbXODlWgfC7i6LiPMlkFZ1s
         dJq/7Be+RQO7JTxNcpwKLuUFlTov48Qdz6cEganc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/17] spi: spidev: fix a race between spidev_release and spidev_remove
Date:   Wed,  1 Jul 2020 21:26:37 -0400
Message-Id: <20200702012649.2701799-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012649.2701799-1-sashal@kernel.org>
References: <20200702012649.2701799-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@gmail.com>

[ Upstream commit abd42781c3d2155868821f1b947ae45bbc33330d ]

Imagine below scene, spidev is referenced after it's freed.

spidev_release()                spidev_remove()
...
                                spin_lock_irq(&spidev->spi_lock);
                                    spidev->spi = NULL;
                                spin_unlock_irq(&spidev->spi_lock);
mutex_lock(&device_list_lock);
dofree = (spidev->spi == NULL);
if (dofree)
    kfree(spidev);
mutex_unlock(&device_list_lock);
                                mutex_lock(&device_list_lock);
                                list_del(&spidev->device_entry);
                                device_destroy(spidev_class, spidev->devt);
                                clear_bit(MINOR(spidev->devt), minors);
                                if (spidev->users == 0)
                                    kfree(spidev);
                                mutex_unlock(&device_list_lock);

Fix it by resetting spidev->spi in device_list_lock's protection.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Link: https://lore.kernel.org/r/20200618032125.4650-1-zhenzhong.duan@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spidev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 028725573e632..5edf4029a3486 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -782,13 +782,13 @@ static int spidev_remove(struct spi_device *spi)
 {
 	struct spidev_data	*spidev = spi_get_drvdata(spi);
 
+	/* prevent new opens */
+	mutex_lock(&device_list_lock);
 	/* make sure ops on existing fds can abort cleanly */
 	spin_lock_irq(&spidev->spi_lock);
 	spidev->spi = NULL;
 	spin_unlock_irq(&spidev->spi_lock);
 
-	/* prevent new opens */
-	mutex_lock(&device_list_lock);
 	list_del(&spidev->device_entry);
 	device_destroy(spidev_class, spidev->devt);
 	clear_bit(MINOR(spidev->devt), minors);
-- 
2.25.1

