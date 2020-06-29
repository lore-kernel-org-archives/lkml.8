Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C6B20760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461321;
	bh=IgoOoQmsqfiOHurLj0DNUfAR15Mzza5F5UVSi8vBgl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EvPUZ/7DnqYV7zNn2zWChwhgVwLtytdYoMplRfzGzwTz6A2AZr1Ggr3p8ch/KYtE7
	 zDVFZgUKlnf6PA662hAW+pNnN1ZYhYDy1l7RUF5Sl3ZD/qLT6eyjYg824XyDpB2lCc
	 VQDqXD+qk6oWh94YO4TlQR5b8QRkVHkRkXBZarlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbgF2UI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732929AbgF2TaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0899A2522E;
        Mon, 29 Jun 2020 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444947;
        bh=IgoOoQmsqfiOHurLj0DNUfAR15Mzza5F5UVSi8vBgl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbuQsnZ3YDL5Pc7+jM2Jb7D/NPdzqcLFrSlQ+flPUqe4Z/iYCGmxzBbP/F9VJmq4z
         qICxPMuNY3gFRU71dYhGz/L/W/36GrXeNBywQadt/SzbHYzxLq0vKto0+705qrcQQG
         HkJwROogW8Z9mdB47/ui+wq3j2iRZm8/Bl5W2j80=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 045/131] usb: host: xhci-mtk: avoid runtime suspend when removing hcd
Date:   Mon, 29 Jun 2020 11:33:36 -0400
Message-Id: <20200629153502.2494656-46-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Macpaul Lin <macpaul.lin@mediatek.com>

commit a24d5072e87457a14023ee1dd3fc8b1e76f899ef upstream.

When runtime suspend was enabled, runtime suspend might happen
when xhci is removing hcd. This might cause kernel panic when hcd
has been freed but runtime pm suspend related handle need to
reference it.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200624135949.22611-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-mtk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 60987c787e44f..2c3b31109e168 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -592,6 +592,9 @@ static int xhci_mtk_remove(struct platform_device *dev)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	struct usb_hcd  *shared_hcd = xhci->shared_hcd;
 
+	pm_runtime_put_noidle(&dev->dev);
+	pm_runtime_disable(&dev->dev);
+
 	usb_remove_hcd(shared_hcd);
 	xhci->shared_hcd = NULL;
 	device_init_wakeup(&dev->dev, false);
@@ -602,8 +605,6 @@ static int xhci_mtk_remove(struct platform_device *dev)
 	xhci_mtk_sch_exit(mtk);
 	xhci_mtk_clks_disable(mtk);
 	xhci_mtk_ldos_disable(mtk);
-	pm_runtime_put_sync(&dev->dev);
-	pm_runtime_disable(&dev->dev);
 
 	return 0;
 }
-- 
2.25.1

