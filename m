Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720AEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4345420768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217994;
	bh=uCDUcXmEwX5SSUfpabvQs8S1gdekkxZT6ihr0BNLMug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jCWDlkLXzBxGARx8lZIXsgWk9DjMt/L40uLEHLv7ugbNYzBNGzbz13usjDc4kS0Kl
	 trw2rnUhGY3lqRs2s+Ye3csduhWHIGtEZ2jitf16jJgfUBwFLqExFlR2ELp0eL2LYC
	 tcV3B63xC/IfnE5GmfNZOqRwrE+PjQUbOloOcTRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgDGAGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgDGACN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:02:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C717220936;
        Tue,  7 Apr 2020 00:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217733;
        bh=uCDUcXmEwX5SSUfpabvQs8S1gdekkxZT6ihr0BNLMug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1aPiuWpipMqYcpFXSjcy/dTlRnq9u4Whg/W3uB1EDSQJK8p/z7pa3wGZl19EhKFRK
         j3T5ovY/GVhp5aaWzeXaGdq6eOYlYn2u348uaXk7eJZIJlqmfl+vJqE1+gJkn8JA0Z
         NVkiTaMWZxo+1mQPyhKlOS//nBMYWzADGit5kDUc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luo bin <luobin9@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 17/32] hinic: fix a bug of waitting for IO stopped
Date:   Mon,  6 Apr 2020 20:01:35 -0400
Message-Id: <20200407000151.16768-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000151.16768-1-sashal@kernel.org>
References: <20200407000151.16768-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>

[ Upstream commit 96758117dc528e6d84bd23d205e8cf7f31eda029 ]

it's unreliable for fw to check whether IO is stopped, so driver
wait for enough time to ensure IO process is done in hw before
freeing resources

Signed-off-by: Luo bin <luobin9@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  | 51 +------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
index 79b3d53f2fbfa..c7c75b772a866 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
@@ -360,50 +360,6 @@ static int wait_for_db_state(struct hinic_hwdev *hwdev)
 	return -EFAULT;
 }
 
-static int wait_for_io_stopped(struct hinic_hwdev *hwdev)
-{
-	struct hinic_cmd_io_status cmd_io_status;
-	struct hinic_hwif *hwif = hwdev->hwif;
-	struct pci_dev *pdev = hwif->pdev;
-	struct hinic_pfhwdev *pfhwdev;
-	unsigned long end;
-	u16 out_size;
-	int err;
-
-	if (!HINIC_IS_PF(hwif) && !HINIC_IS_PPF(hwif)) {
-		dev_err(&pdev->dev, "Unsupported PCI Function type\n");
-		return -EINVAL;
-	}
-
-	pfhwdev = container_of(hwdev, struct hinic_pfhwdev, hwdev);
-
-	cmd_io_status.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
-
-	end = jiffies + msecs_to_jiffies(IO_STATUS_TIMEOUT);
-	do {
-		err = hinic_msg_to_mgmt(&pfhwdev->pf_to_mgmt, HINIC_MOD_COMM,
-					HINIC_COMM_CMD_IO_STATUS_GET,
-					&cmd_io_status, sizeof(cmd_io_status),
-					&cmd_io_status, &out_size,
-					HINIC_MGMT_MSG_SYNC);
-		if ((err) || (out_size != sizeof(cmd_io_status))) {
-			dev_err(&pdev->dev, "Failed to get IO status, ret = %d\n",
-				err);
-			return err;
-		}
-
-		if (cmd_io_status.status == IO_STOPPED) {
-			dev_info(&pdev->dev, "IO stopped\n");
-			return 0;
-		}
-
-		msleep(20);
-	} while (time_before(jiffies, end));
-
-	dev_err(&pdev->dev, "Wait for IO stopped - Timeout\n");
-	return -ETIMEDOUT;
-}
-
 /**
  * clear_io_resource - set the IO resources as not active in the NIC
  * @hwdev: the NIC HW device
@@ -423,11 +379,8 @@ static int clear_io_resources(struct hinic_hwdev *hwdev)
 		return -EINVAL;
 	}
 
-	err = wait_for_io_stopped(hwdev);
-	if (err) {
-		dev_err(&pdev->dev, "IO has not stopped yet\n");
-		return err;
-	}
+	/* sleep 100ms to wait for firmware stopping I/O */
+	msleep(100);
 
 	cmd_clear_io_res.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
 
-- 
2.20.1

