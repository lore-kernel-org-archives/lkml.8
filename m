Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA2FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8712B20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgHUNPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:15:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58431 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgHUNP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:15:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k96sz-0004WG-7i; Fri, 21 Aug 2020 13:15:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        wlanfae <wlanfae@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Mike McCormack <mikem@ring3k.org>, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: fix missing failure check on a call to dev_alloc_name
Date:   Fri, 21 Aug 2020 14:15:12 +0100
Message-Id: <20200821131512.348775-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the second call to dev_alloc_name is not checking if this
failed.  Add the check and perform necessary cleanup on an error.

Addresses-Coverity: ("Unchecked return value")
Fixes: 94a799425eee ("rtl8192e: Import new version of driver from realtek")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index fac58eebf263..7b15faeefff2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2489,7 +2489,8 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 	if (dev_alloc_name(dev, ifname) < 0) {
 		RT_TRACE(COMP_INIT,
 			 "Oops: devname already taken! Trying wlan%%d...\n");
-		dev_alloc_name(dev, ifname);
+		if (dev_alloc_name(dev, ifname) < 0)
+			goto err_unmap;
 	}
 
 	RT_TRACE(COMP_INIT, "Driver probe completed1\n");
-- 
2.27.0

