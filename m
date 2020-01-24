Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514FEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231F52075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864169;
	bh=7nPI0tt7j0JBxlx0n7ebAsqlu3UsN9J6K28FdVhwmn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gkf7Il6tRB83uWnLdBCkmgQBcozkmDPBdLsW2HSqfOn0Jvj3zgw2Z6Gv1HKNHzYT9
	 +ve+DAUAKSfZAsEfHc9lTlkFox/Ahf1+Mm0SVIm4B3BKqXVjpyaQdXIjalfgGkAcH4
	 1L4Sw1fXr+J/PxbvKkdNbmROdqAa/N2K/6F3PaD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgAXLJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbgAXLJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:09:23 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4313220708;
        Fri, 24 Jan 2020 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864162;
        bh=7nPI0tt7j0JBxlx0n7ebAsqlu3UsN9J6K28FdVhwmn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRiryMJAVUlNKzcxh+YafyJStps+3lVb3uvrqhz7tuLHWux1hJMkGDXlF5S2Xx2T7
         0mGbf+bTQm1GOJM3TQ6TgbImavXgDyArqVwa7JA928bUDb5Lfveck2cdL4fCOAniUZ
         EMcri2ZmyTUSF05IkqOtvDCBC2wWXBSVg8KuBbog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Moritz Fischer <mdf@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 176/639] net: phy: fixed_phy: Fix fixed_phy not checking GPIO
Date:   Fri, 24 Jan 2020 10:25:46 +0100
Message-Id: <20200124093109.232533274@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 67b260877f305..59820164502eb 100644
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



