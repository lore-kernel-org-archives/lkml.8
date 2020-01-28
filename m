Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6649DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3386021739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221407;
	bh=/188A5AV3dmrQIx72hiPDcmOUbywvXgwVDruUKUM3fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KnEPAtfUZE+Y8sxNumxmuHIH5LdH7Hhhm9/n2WcZDqMeIV3+AufkiwTwqc8DGvCLj
	 wvEMQZbx8wlrAq2x55VELrJ2FRPfAQy2Hpk20HUDSA8yYf4Gx3uxnMkEQ5Z8dSXHuI
	 /rXpWL5WwOqfKAE+QLmeVY2Do4BuCJZ6uTizvRK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbgA1OX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731512AbgA1OXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:23:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CD12071E;
        Tue, 28 Jan 2020 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221400;
        bh=/188A5AV3dmrQIx72hiPDcmOUbywvXgwVDruUKUM3fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaRYo8V+9jxc3zx+y4rS1Sfa45JpK+O+wSUhdrJjpzvBKtjMebqrIlcdfddmy6Ia5
         8WI8whnVGVKPS9oPRQ+/ZSFK+M+OnRinDguZ+XqmMYdOVn8qkoQIng3+5js7d0HfE4
         OzZN9HB+pSjtjvX5Tx/EMZC7yoNCw1TT4U9g+mPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 209/271] net: stmmac: gmac4+: Not all Unicast addresses may be available
Date:   Tue, 28 Jan 2020 15:05:58 +0100
Message-Id: <20200128135908.100101957@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 25683bab09a70542b9f8e3e28f79b3369e56701f ]

Some setups may not have all Unicast addresses filters available. Check
the number of available filters before trying to setup it.

Fixes: 477286b53f55 ("stmmac: add GMAC4 core support")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index f46f2bfc2cc09..4216c0a5eaf5a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -168,7 +168,7 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
 	}
 
 	/* Handle multiple unicast addresses */
-	if (netdev_uc_count(dev) > GMAC_MAX_PERFECT_ADDRESSES) {
+	if (netdev_uc_count(dev) > hw->unicast_filter_entries) {
 		/* Switch to promiscuous mode if more than 128 addrs
 		 * are required
 		 */
-- 
2.20.1



