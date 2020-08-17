Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE28C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3500920716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693254;
	bh=kbuDP+M988482p05npem60kQat8V2wwECI9KCrdipsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZU5U6diIdQsAsfQM6ii8QimJ3j9sPup4Ol+EO/Yfc3NzZL2S0B5msAUJ1MnznXtL
	 x/cfTWAKwpNh+uey9ET9E3l3FshumXuJ+IuVlFHb1xTF83B6/nucIclA2LiarbbkVn
	 DeFtarzK4EwD7EsTXf7kaYWBgJ4bmbPKUz/d5S3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgHQPZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729273AbgHQPXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:23:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F15E2339D;
        Mon, 17 Aug 2020 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677827;
        bh=kbuDP+M988482p05npem60kQat8V2wwECI9KCrdipsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+l8O1KJxi3KlWf6Y+t1fGXsoZ6bJcbyTuARGXAxqGQf9SPrB6nlvLXb6715veZkr
         Fm6td/brK/EgwCxIkre8HFYcbrMJaA0+YxQyeG0pcdu6i4ZU53yxR3d3iHa3t45Z3T
         7ytta//DrGoEwYAwvnO93SK0Ho3GiNWZB82tv6ck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 092/464] rtw88: 8822ce: add support for device ID 0xc82f
Date:   Mon, 17 Aug 2020 17:10:45 +0200
Message-Id: <20200817143838.196129828@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Ma <aaron.ma@canonical.com>

[ Upstream commit 7d428b1c9ffc9ddcdd64c6955836bbb17a233ef3 ]

New device ID 0xc82f found on Lenovo ThinkCenter.
Tested it with c822 driver, works good.

PCI id:
03:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd.
Device [10ec:c82f]
        Subsystem: Lenovo Device [17aa:c02f]

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200612082745.204400-1-aaron.ma@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
index 7b6bd990651e1..026ac49ce6e3c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
@@ -11,6 +11,10 @@ static const struct pci_device_id rtw_8822ce_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xC822),
 		.driver_data = (kernel_ulong_t)&rtw8822c_hw_spec
 	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xC82F),
+		.driver_data = (kernel_ulong_t)&rtw8822c_hw_spec
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(pci, rtw_8822ce_id_table);
-- 
2.25.1



