Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FCDC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A1E20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272858;
	bh=jrIDkJCJcAj5Fx5ifyW1/d9XY7z2Jyo3nzdyGhxeQ3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u2S0rQNGM4lDkaZ76E83+SfptLSvpfX/mAKtHXHOLVe+yfet8WfHk1ohVdJjLEDA5
	 dSE8O+Lbw5NHIpEXq2PoO/QR8WoU6JrottR0to4mHm+H4mYbIbyM45O6uOexRZfsvf
	 YDYakMsHhmam3pm0QycOlBXoxgs0fQXyj10Vz9So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbgBUIOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:14:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732732AbgBUIOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:14:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED00A24650;
        Fri, 21 Feb 2020 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272855;
        bh=jrIDkJCJcAj5Fx5ifyW1/d9XY7z2Jyo3nzdyGhxeQ3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InsRJF7yZYOUj/sy7UYn5o/npd47AhHafyTfUqsctCBrp/YiJlKsV9Mq6KyIyu91L
         hvF3eo+/dN6C49CyStbw+LHfBFxG4qllbAtQeXTVGjCDaGTfMwJlY8diDLMi1Hp6uY
         HXB8M3tHFAuf0tkDu05lBWWl4mZdeOlsXY3RfWzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 301/344] iwlegacy: ensure loop counter addr does not wrap and cause an infinite loop
Date:   Fri, 21 Feb 2020 08:41:40 +0100
Message-Id: <20200221072417.234434582@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c2f9a4e4a5abfc84c01b738496b3fd2d471e0b18 ]

The loop counter addr is a u16 where as the upper limit of the loop
is an int. In the unlikely event that the il->cfg->eeprom_size is
greater than 64K then we end up with an infinite loop since addr will
wrap around an never reach upper loop limit. Fix this by making addr
an int.

Addresses-Coverity: ("Infinite loop")
Fixes: be663ab67077 ("iwlwifi: split the drivers for agn and legacy devices 3945/4965")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 73f7bbf742bc6..746749f379964 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -699,7 +699,7 @@ il_eeprom_init(struct il_priv *il)
 	u32 gp = _il_rd(il, CSR_EEPROM_GP);
 	int sz;
 	int ret;
-	u16 addr;
+	int addr;
 
 	/* allocate eeprom */
 	sz = il->cfg->eeprom_size;
-- 
2.20.1



