Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DDEC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFCD22BEB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752839;
	bh=EiZ93p2usv/LoFYCN6aaZNeVxDqwVAnsSNJ+CTiv9dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PIgzl/74ZGMEkHBSImVQP8srmLLuXvJ2eP0kFXyBBvH6rmqsFenwEWPiluT+tCmmE
	 RX4oXE4WFKLbpaDDISLKKBURa+usrof7gKmld4ydC/SOcOWqelFUH+GSQk62y1Xz3q
	 CF0yuVETnmnDALMFPmj1hBLMx3eDRa1UpyNcjUrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgGNSx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730113AbgGNSxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:53:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 441E922BEF;
        Tue, 14 Jul 2020 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752833;
        bh=EiZ93p2usv/LoFYCN6aaZNeVxDqwVAnsSNJ+CTiv9dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVGmkVNEAgSqIhyZ1k+tfB1oVLzgAGD9RIRe6ARsThHTZn9UHoYvYveOVulsO9SVP
         OPdqkTVWdRIBvItYgS4uZ767adazzFvnQJaTFC/61P5nhHGr+BJobHmV6lh1J0iyu+
         T3+yyPruZ1jkenLgoERe3e5cBzlsJlB6z+2jZ7qA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 018/166] spi: spidev: fix a race between spidev_release and spidev_remove
Date:   Tue, 14 Jul 2020 20:43:03 +0200
Message-Id: <20200714184116.766310701@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 80dd1025b9530..82e6481fdf950 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -786,13 +786,13 @@ static int spidev_remove(struct spi_device *spi)
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



