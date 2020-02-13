Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D6BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA0720661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608530;
	bh=m2zuk68W3p50Ha0nrV0cD8BjVNfkJsTE0v3GQloDCnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mRRCq2gLKf3x9pSEycC3fwiNOyd4/6Shv2f0Bs+Um1V/wxOhD/krjbetW0C4f8eni
	 K92cuCF1gxc+QRUQ7nB4IVUYVgoqJSHD2cwDPWZmKxO+sNBx/9sCM/oLJaAD+lLdX8
	 00w97jVViOCoefLnQKgAOgrNt171/imoWStZur1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgBMPmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:42:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387450AbgBMP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:19 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476DC222C2;
        Thu, 13 Feb 2020 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607699;
        bh=m2zuk68W3p50Ha0nrV0cD8BjVNfkJsTE0v3GQloDCnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eD44tvg2hN+eMMnQBBOYrpuCl2xZnQP3DKM6pLNZ9Tx0QnutvErzeyWv5/Ayxx3JV
         I+kUxkRBBCXg4cR7jo52hwsfiTYbsppLipjm02UidnygGQqtnoic1XUSE/GjF8rQkF
         1Ekr0tE0WpppoN26hWWS8oR1znhiMCy8YokvujYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.5 042/120] mt76: mt7615: fix max_nss in mt7615_eeprom_parse_hw_cap
Date:   Thu, 13 Feb 2020 07:20:38 -0800
Message-Id: <20200213151916.014391631@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

commit d08f3010f4a32eec3c8aa771f03a1b342a1472fa upstream.

Fix u8 cast reading max_nss from MT_TOP_STRAP_STA register in
mt7615_eeprom_parse_hw_cap routine

Fixes: acf5457fd99db ("mt76: mt7615: read {tx,rx} mask from eeprom")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -92,8 +92,9 @@ static int mt7615_check_eeprom(struct mt
 
 static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 {
-	u8 val, *eeprom = dev->mt76.eeprom.data;
+	u8 *eeprom = dev->mt76.eeprom.data;
 	u8 tx_mask, rx_mask, max_nss;
+	u32 val;
 
 	val = FIELD_GET(MT_EE_NIC_WIFI_CONF_BAND_SEL,
 			eeprom[MT_EE_WIFI_CONF]);


