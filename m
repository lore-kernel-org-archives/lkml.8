Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A405C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1DB206B5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585880;
	bh=7c1BGpJQSitJm8WZfS40hY8FLPji/njUbJyQSgZSof4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VCBtVc1d+3s9eDiVWkdIP21MiW6EN5bsjP1zUoQxMz9JUgQsTUL9TZ9DIwdnI6fOn
	 kMxtQTaRosPZf9Wmyx9H3A1qwoDOg6pwbaYjlRxSKhkIsMGg4QiIanrE0ZBMEtAnCL
	 1+Y0Ux18hBgrhB4AKmZGQ3GybLTOvMgHZbmR+SoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgIHRYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbgIHQSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C1C24843;
        Tue,  8 Sep 2020 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579907;
        bh=7c1BGpJQSitJm8WZfS40hY8FLPji/njUbJyQSgZSof4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OP9wROykNmTwsuuRpM20ymg/XBh6Tsw7ZW3c0CcfH5mIwC/nfeFqBr1qhbhR5WpCf
         HOt3rQv0dTm5Eu6lCERJhzpOmqYJquuSMQDLUmgXgyNlnstSipUPrZT8WxoqukBMaJ
         Bmx/CSwUsDCr1jdU445KFhPiSNGKd2PNhhLpBDwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 042/129] bnxt_en: Dont query FW when netif_running() is false.
Date:   Tue,  8 Sep 2020 17:24:43 +0200
Message-Id: <20200908152231.779287458@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

[ Upstream commit c1c2d77408022a398a1a7c51cf20488c922629de ]

In rare conditions like two stage OS installation, the
ethtool's get_channels function may be called when the
device is in D3 state, leading to uncorrectable PCI error.
Check netif_running() first before making any query to FW
which involves writing to BAR.

Fixes: db4723b3cd2d ("bnxt_en: Check max_tx_scheduler_inputs value from firmware.")
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 1f512e7c3d434..de9b34a255cf1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -769,7 +769,7 @@ static void bnxt_get_channels(struct net_device *dev,
 	int max_tx_sch_inputs;
 
 	/* Get the most up-to-date max_tx_sch_inputs. */
-	if (BNXT_NEW_RM(bp))
+	if (netif_running(dev) && BNXT_NEW_RM(bp))
 		bnxt_hwrm_func_resc_qcaps(bp, false);
 	max_tx_sch_inputs = hw_resc->max_tx_sch_inputs;
 
-- 
2.25.1



