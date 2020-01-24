Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F460C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FB9214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865638;
	bh=279oGcJbuzVbl/xJigH8sVCw7ku+tcbjqXmu/BoCc5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mrJM/DPwEvKO8JLdXIwUi/uPB51oo6pJDGUSz9kUCCwN5SCax+9+NyGRhTXDoDDsK
	 U8YWwtYRqEn/oFRL2ZqFG42hmHv9x1Ay9Kk5Z9h7T2bE98uEUGzmC1iwQcyvhKYsiO
	 dEncow8d3Uka4GE8Bd/TJ+cnRiS0QTNqt+iKCS0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404664AbgAXLd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404148AbgAXLdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:33:54 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09EF021556;
        Fri, 24 Jan 2020 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865634;
        bh=279oGcJbuzVbl/xJigH8sVCw7ku+tcbjqXmu/BoCc5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVB0hVBKF1orvNCKV17N0PMmTa6ewfkWHbjY8BcKM3t4/b6+5Lt4yAy9yyr3G4kPa
         kXgjoLr2KtYLP5HTlEv1CmZqu4P6n2Yw8gw1Gi4g54/LetA8bI2YCPgu4H+slVK7OM
         JeuMDVqLoY8FxEW17maKpC54Ccze1HKDyRQGaqIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 579/639] net: socionext: Fix a signedness bug in ave_probe()
Date:   Fri, 24 Jan 2020 10:32:29 +0100
Message-Id: <20200124093202.004711161@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7f9e88e6ef8c971f2c638b5ff7044c59b5d0f58d ]

The "phy_mode" variable is an enum and in this context GCC treats it as
an unsigned int so the error handling is never triggered.

Fixes: 4c270b55a5af ("net: ethernet: socionext: add AVE ethernet driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/socionext/sni_ave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 09d25b87cf7c0..c309accc6797e 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1575,7 +1575,7 @@ static int ave_probe(struct platform_device *pdev)
 
 	np = dev->of_node;
 	phy_mode = of_get_phy_mode(np);
-	if (phy_mode < 0) {
+	if ((int)phy_mode < 0) {
 		dev_err(dev, "phy-mode not found\n");
 		return -EINVAL;
 	}
-- 
2.20.1



