Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2F4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C7222BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917909;
	bh=V+/Zi4mxR5Rb4HM+/QHOT7Y2fxlm21G4sCP879RSQ0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P96QXZKdT4yy5H47il5TBY3QGv1RXc0+sGtvfg0mJGvvpmHBAsgCgEIFce7e/ZXvQ
	 VGOS0Vbyq40Gr3GuITVbmQJAP2jVqUSR/Z9Cj7oT16Rlt+rs5gsiWOgbB5FJmSb72u
	 Kc4xHYYWhA4eL1s3P62BETZi2kMYXVkEjGuevYsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgHTKFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbgHTKB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:01:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB5122BF3;
        Thu, 20 Aug 2020 10:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917713;
        bh=V+/Zi4mxR5Rb4HM+/QHOT7Y2fxlm21G4sCP879RSQ0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXvmsl015aQa31kW1T55w5D/PJFN1BJJBlfxUYZLcdwXHZTjrjTDCryL+n5qcTWZr
         93t5X5/OOKcC4GzVxl5J4AYaUawHy6nbkBADAASRbSax1o5MUvq9jOWSUUgouzfCBZ
         Dodkev546ixUtpm2A1AItznyWqmBnaqZ2VSAeB9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 129/212] staging: rtl8192u: fix a dubious looking mask before a shift
Date:   Thu, 20 Aug 2020 11:21:42 +0200
Message-Id: <20200820091608.864370010@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c4283950a9a4d3bf4a3f362e406c80ab14f10714 ]

Currently the masking of ret with 0xff and followed by a right shift
of 8 bits always leaves a zero result.  It appears the mask of 0xff
is incorrect and should be 0xff00, but I don't have the hardware to
test this. Fix this to mask the upper 8 bits before shifting.

[ Not tested ]

Addresses-Coverity: ("Operands don't affect result")
Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20200716154720.1710252-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 6ec3790566504..fa4c47c7d2166 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2522,7 +2522,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 				ret = eprom_read(dev, (EEPROM_TxPwIndex_CCK >> 1));
 				if (ret < 0)
 					return ret;
-				priv->EEPROMTxPowerLevelCCK = ((u16)ret & 0xff) >> 8;
+				priv->EEPROMTxPowerLevelCCK = ((u16)ret & 0xff00) >> 8;
 			} else
 				priv->EEPROMTxPowerLevelCCK = 0x10;
 			RT_TRACE(COMP_EPROM, "CCK Tx Power Levl: 0x%02x\n", priv->EEPROMTxPowerLevelCCK);
-- 
2.25.1



