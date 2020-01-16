Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56082C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF5D214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198337;
	bh=54xeeJt3oi2IZTScEVdGI/xjrie/0xH7YLIooRyhRns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IGu3bTWf6Z7XeseNMKxBlLWyVwKzzCCV0cWKZHUJfnmPzzjS8j/q0t4HAGUmlStEP
	 l8pSAl5vlrL8BlR2vtiADn0LAIzbLJT2PlLZnYEaw54Y8d3aGM0gjGLsSR0Dc2LHVy
	 V/bn2B6K0vAtdFpEunIeg29kBCHncLIkYA9dHa/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393157AbgAPRhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405292AbgAPRhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 932072468C;
        Thu, 16 Jan 2020 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196226;
        bh=54xeeJt3oi2IZTScEVdGI/xjrie/0xH7YLIooRyhRns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ej+07r44qtZRxuQRX0uaM0lmUtfzEe4mhaf4DSi0HrZUkM0sF5UDaTtlsoJDoxXmH
         lcef4UXve2ACrleoUZ1Rgm5lvEI2tfVvywZd9acnM2k57d3XCp/eXKBnGNOfEi79yh
         xg4By5+meeiWcfsYXB0V4eLzQu7Bj/e5x4O/IHeg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 059/251] net: phy: fixed_phy: Fix fixed_phy not checking GPIO
Date:   Thu, 16 Jan 2020 12:33:28 -0500
Message-Id: <20200116173641.22137-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

[ Upstream commit 8f289805616e81f7c1690931aa8a586c76f4fa88 ]

Fix fixed_phy not checking GPIO if no link_update callback
is registered.

In the original version all users registered a link_update
callback so the issue was masked.

Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/fixed_phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index eb5167210681..3ab2eb677a59 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -67,11 +67,11 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 			do {
 				s = read_seqcount_begin(&fp->seqcount);
 				/* Issue callback if user registered it. */
-				if (fp->link_update) {
+				if (fp->link_update)
 					fp->link_update(fp->phydev->attached_dev,
 							&fp->status);
-					fixed_phy_update(fp);
-				}
+				/* Check the GPIO for change in status */
+				fixed_phy_update(fp);
 				state = fp->status;
 			} while (read_seqcount_retry(&fp->seqcount, s));
 
-- 
2.20.1

