Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54FCC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1F622B2A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752491;
	bh=PUzhsn+22+EvfCIBitcmkj0en3/RTkXCU0CbLGQCvug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hqBao10edCMxgmGjE1izTsukTRL9Pkfvz3ayEtrAsfMnXdF43XJ0rlxZGsscrp1SS
	 XKX9lfsl1xnmQ0zGZtL0z2FLzfsPaCs89zagyGZFMwurTGaC2gIKV+EgR4Sb/zqzlB
	 OGb22agV3GFdipwH7H017PJt2Cov1TZ6SJuILxOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgGNSsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729884AbgGNSsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:48:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B336122B2A;
        Tue, 14 Jul 2020 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752484;
        bh=PUzhsn+22+EvfCIBitcmkj0en3/RTkXCU0CbLGQCvug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIel8p4ULTdbUfqIs2kdf4JKmpXo78gbbsrQPFL20uyxciG7FDly2aCsp0zNguuds
         oKAfHV7cn2+LatfY6j1gxvxUfW200aaAThVa6DpBQ5tNtN22h4IWRXu321fP4a7Nuf
         r54tv01vi5Yte5BAjmIz+JhObBeuyyQGzFY3ryPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Edich <andre.edich@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/58] smsc95xx: avoid memory leak in smsc95xx_bind
Date:   Tue, 14 Jul 2020 20:44:02 +0200
Message-Id: <20200714184057.582907294@linuxfoundation.org>
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
index 145ee4a02a8a5..4f29010e1aeff 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1307,7 +1307,8 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
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



