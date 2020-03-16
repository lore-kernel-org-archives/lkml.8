Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A8FC10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2230E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326374;
	bh=r2X6fsZEwcykOYrQSgZiDy/C07x8LDvGB1GD/s6K1Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vfd5qVowfBJJ94TcIeF7IL5g7ZnJoxUmgFThMCczJDdmf016YuTZ5LmYSFRX4+PNp
	 dShp8ZgBoIXIMX6yuo2S6QAuEEZwYIbO9I2ZGjphdz1kd42U7gdU3gSCgQpKkancWc
	 hdx+qZznM0xBO/TRUStsMlySocAoXqlkIfOxFK88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgCPCe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgCPCeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:34:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0361120724;
        Mon, 16 Mar 2020 02:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326058;
        bh=r2X6fsZEwcykOYrQSgZiDy/C07x8LDvGB1GD/s6K1Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/MsMuz2Hd6nQRuJ5AHvgZ3WPsjv5KO2fW0qmkWBHTP0KKziPegz77WDKpBmQoova
         mPRHO5Fw1/PVjj2m8kQ2ygOygp8sMBcOJKSylLANJ57cRbBp3JRzyyLMnAgkngM8xD
         KVYBSLhu1i76uuYv7v4FB2iTJ8FqS1IKuVmn25g4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 06/35] phy: ti: gmii-sel: do not fail in case of gmii
Date:   Sun, 15 Mar 2020 22:33:42 -0400
Message-Id: <20200316023411.1263-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023411.1263-1-sashal@kernel.org>
References: <20200316023411.1263-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 58aa7729310db04ffcc022c98002dd8fcb486c58 ]

The "gmii" PHY interface mode is supported on TI AM335x/437x/5xx SoCs, so
don't fail if it's selected.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-gmii-sel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index e998e9cd8d1f8..1c536fc03c83c 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -80,6 +80,7 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 		break;
 
 	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_GMII:
 		gmii_sel_mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
 
-- 
2.20.1

