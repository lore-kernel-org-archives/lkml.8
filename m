Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C0C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A79D221ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753924;
	bh=l3HCVOUYRX0UhaSQiRBah5J1WNMVD+e/own6R+sxXq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BUyLIJLPFPXsTExocr58VPtnISI18EKe4ForeeGROBB3oMsoL+wR8kXKmX5xgjbk1
	 59IUunJoS4zKlJVzLVBASHEci592RfSd9m0JvO71MGi1xXIpCxuwYyY13vvY2Z3Fgz
	 p6O1AQT41d6/cj85+16Qu79EuaVFvNDc28zm1JZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgGNSrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729828AbgGNSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:47:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9793622B2D;
        Tue, 14 Jul 2020 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752471;
        bh=l3HCVOUYRX0UhaSQiRBah5J1WNMVD+e/own6R+sxXq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a//p7p9Kngatusd/0uFcYrQalKbJ5BpGm3qXT8XzwmX6qhR07UOkYfEcorx958GOi
         dtt3kcmogDFHsKHCysHIoFYAUkIPaxrmOXbINmRgyI5WJTdjimUyXPTemkkmv3Aje3
         DhFAR7UMQNhu+jyQrLu7pPt7u/eTKmrU9A+tPe6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Li Heng <liheng40@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 27/58] net: cxgb4: fix return error value in t4_prep_fw
Date:   Tue, 14 Jul 2020 20:44:00 +0200
Message-Id: <20200714184057.486322368@linuxfoundation.org>
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

From: Li Heng <liheng40@huawei.com>

[ Upstream commit 8a259e6b73ad8181b0b2ef338b35043433db1075 ]

t4_prep_fw goto bye tag with positive return value when something
bad happened and which can not free resource in adap_init0.
so fix it to return negative value.

Fixes: 16e47624e76b ("cxgb4: Add new scheme to update T4/T5 firmware")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 5934ec9b6a31f..abc2a66754bd0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3499,7 +3499,7 @@ int t4_prep_fw(struct adapter *adap, struct fw_info *fw_info,
 	drv_fw = &fw_info->fw_hdr;
 
 	/* Read the header of the firmware on the card */
-	ret = -t4_read_flash(adap, FLASH_FW_START,
+	ret = t4_read_flash(adap, FLASH_FW_START,
 			    sizeof(*card_fw) / sizeof(uint32_t),
 			    (uint32_t *)card_fw, 1);
 	if (ret == 0) {
@@ -3528,8 +3528,8 @@ int t4_prep_fw(struct adapter *adap, struct fw_info *fw_info,
 		   should_install_fs_fw(adap, card_fw_usable,
 					be32_to_cpu(fs_fw->fw_ver),
 					be32_to_cpu(card_fw->fw_ver))) {
-		ret = -t4_fw_upgrade(adap, adap->mbox, fw_data,
-				     fw_size, 0);
+		ret = t4_fw_upgrade(adap, adap->mbox, fw_data,
+				    fw_size, 0);
 		if (ret != 0) {
 			dev_err(adap->pdev_dev,
 				"failed to install firmware: %d\n", ret);
@@ -3560,7 +3560,7 @@ int t4_prep_fw(struct adapter *adap, struct fw_info *fw_info,
 			FW_HDR_FW_VER_MICRO_G(c), FW_HDR_FW_VER_BUILD_G(c),
 			FW_HDR_FW_VER_MAJOR_G(k), FW_HDR_FW_VER_MINOR_G(k),
 			FW_HDR_FW_VER_MICRO_G(k), FW_HDR_FW_VER_BUILD_G(k));
-		ret = EINVAL;
+		ret = -EINVAL;
 		goto bye;
 	}
 
-- 
2.25.1



