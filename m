Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19761C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA93A22AAA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752634;
	bh=D3i3S5j44fiC1IDgMasI5b1YhvYLYdQs/3us46NgZYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fZKXdPpMAGOqt5ER09MHu+I/QI4hKEnsTOgjsQcDRHjOlKAfehFGxNEu3dhAcCI3h
	 pliFV3b8MlGXp4UgIwC7kWeFcPFHyHwi4Sbm4a8qI/Gbvx1nSJnww7pbyFnaL7kU6J
	 DndXQYkxYrhLmCFMU9PVk1sO1kqZ3IO0XxzLjyLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgGNSud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbgGNSua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:50:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29DC6207F5;
        Tue, 14 Jul 2020 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752630;
        bh=D3i3S5j44fiC1IDgMasI5b1YhvYLYdQs/3us46NgZYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcCNyMwTfWaBfTPywkMNL0J6cVP0j4qSKIgUTPAsqDcUpDLTSALW2/GK9EolBk9hj
         tWcQol13ZMTPZHaHvDXR3xkdTZ8SB89MvuK6OTdyN2EAWx0RbJzVTVOUY0UAeKUHEN
         0hH+UGd0OH+DGkc5jT5Ddkr5IaplcUQzeFmBOzU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Edich <andre.edich@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 052/109] smsc95xx: avoid memory leak in smsc95xx_bind
Date:   Tue, 14 Jul 2020 20:43:55 +0200
Message-Id: <20200714184108.011739687@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Edich <andre.edich@microchip.com>

[ Upstream commit 3ed58f96a70b85ef646d5427258f677f1395b62f ]

In a case where the ID_REV register read is failed, the memory for a
private data structure has to be freed before returning error from the
function smsc95xx_bind.

Fixes: bbd9f9ee69242 ("smsc95xx: add wol support for more frame types")
Signed-off-by: Andre Edich <andre.edich@microchip.com>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc95xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index eb404bb74e18e..bb4ccbda031ab 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1293,7 +1293,8 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	/* detect device revision as different features may be available */
 	ret = smsc95xx_read_reg(dev, ID_REV, &val);
 	if (ret < 0)
-		return ret;
+		goto free_pdata;
+
 	val >>= 16;
 	pdata->chip_id = val;
 	pdata->mdix_ctrl = get_mdix_status(dev->net);
-- 
2.25.1



