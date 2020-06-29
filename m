Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD345C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8F320874
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460158;
	bh=v+crxahijm911DuNDyKvGSVyfJ4WlY+YO/iBkJxHw24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MOahfhW76OTo2NBnF7POoKehgS+n8bZ0eU29b5Jgv8RG7ZS6NELC6zewpQrQG48Hv
	 msOsKSWMkhwBOg5NlSHYyee8f8gFYwpQLWx2zCZ8XrMmOXCFiCZ/GvGJmJ0+MzaXgt
	 WbkezBiCUbMXMgHGuZr6vGwbvmAna0FIz31L65Fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbgF2TtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387762AbgF2Tki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F91248C6;
        Mon, 29 Jun 2020 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444420;
        bh=v+crxahijm911DuNDyKvGSVyfJ4WlY+YO/iBkJxHw24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pt2WxAj2THw+feiWj9bgNm4KSO82GVklT7lW+zAMEFDYEsOmimOxLF5UpoNhp78Tu
         z78vaQgnWAFTH/sXRkRKwawEDjp8nEEkkrVcnsimnmCo0VXqCFFQBeJBDlH++lUWzC
         L7nlQDonYR1RJqwJf9gJY9CzD+8ng2fAobcSKtdc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Lobakin <alobakin@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 098/178] net: qede: fix use-after-free on recovery and AER handling
Date:   Mon, 29 Jun 2020 11:24:03 -0400
Message-Id: <20200629152523.2494198-99-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@marvell.com>

[ Upstream commit ec6c80590bde6b5dfa4970fffa3572f1acd313ca ]

Set edev->cdev pointer to NULL after calling remove() callback to avoid
using of already freed object.

Fixes: ccc67ef50b90 ("qede: Error recovery process")
Signed-off-by: Alexander Lobakin <alobakin@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 361a1d759b0b5..2c3d654c84543 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -1247,6 +1247,7 @@ static void __qede_remove(struct pci_dev *pdev, enum qede_remove_mode mode)
 	if (system_state == SYSTEM_POWER_OFF)
 		return;
 	qed_ops->common->remove(cdev);
+	edev->cdev = NULL;
 
 	/* Since this can happen out-of-sync with other flows,
 	 * don't release the netdevice until after slowpath stop
-- 
2.25.1

