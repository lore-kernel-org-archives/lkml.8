Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC94DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E51207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825092;
	bh=mLNNcdMEzcijcd6WQUrQiMn6mZLH+CN0WL25fCbmqLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kyEevqRaA6ZsTS848UXZe1k2A7mW54dktPkIiT8JMRkGarHuLFN1NXq0WIaDwxCQR
	 BiVBgEog6I8FKVbKNLokFtEz1vpnb1YhW6hw03b6QVzaUVkofhC8gWhKbi5eJDvcwW
	 1xPLElHEIxah8JDZBDHEZx1yOEvO5oXyySjzqh8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbgERSEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732814AbgERSEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:04:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8983620826;
        Mon, 18 May 2020 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825078;
        bh=mLNNcdMEzcijcd6WQUrQiMn6mZLH+CN0WL25fCbmqLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLu21Yuh411wPRrNEg+Trok+URExLsNDofeVHgOJXURSlp7fqkzjU4CME+NlqQHcF
         6ZgR2ML7UQGLAoL+WWbiQSQR6y0csPp85uHmf31ffo72rRX6Wqs1hFGPBkqiPL8uQY
         zaJ9cXe8IYYwMkuYlFIPmiZ1D6Gao8S2DvimbevI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 118/194] s390/ism: fix error return code in ism_probe()
Date:   Mon, 18 May 2020 19:36:48 +0200
Message-Id: <20200518173541.485451607@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 29b74cb75e3572d83708745e81e24d37837415f9 ]

Fix to return negative error code -ENOMEM from the smcd_alloc_dev()
error handling case instead of 0, as done elsewhere in this function.

Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/ism_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 4fc2056bd2272..e615dc240150b 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -521,8 +521,10 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ism->smcd = smcd_alloc_dev(&pdev->dev, dev_name(&pdev->dev), &ism_ops,
 				   ISM_NR_DMBS);
-	if (!ism->smcd)
+	if (!ism->smcd) {
+		ret = -ENOMEM;
 		goto err_resource;
+	}
 
 	ism->smcd->priv = ism;
 	ret = ism_dev_init(ism);
-- 
2.20.1



