Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E02C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDA021D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753699;
	bh=alMXgitqfudaWLiNgIEZtpaM4OOytV1zOGA/mL7al90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qZgDNeCG+py5aGzbQWhOoK2+NCQbWovYYBwLa1uCnwJLL09KvFSV8ygSOmn6MroV0
	 //IYgCR56nrXnOTq1VLsHHxWF7C5+xMV6KuWEC/C7DsSE+kvFlSyntNe7aa014UG1g
	 oTDkIP80OBRRoWfpoH/OVg6iYYNmPDX6kEVUApLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgGNSub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgGNSu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:50:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C21207F5;
        Tue, 14 Jul 2020 18:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752628;
        bh=alMXgitqfudaWLiNgIEZtpaM4OOytV1zOGA/mL7al90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUYumaajgOP/K/mEu5AuXepFHGT3wUPR4t1mBFbKzIBkwWzSO10ZaN88QhMg2LCKv
         dy75KYRDuNW5Eu40Col1gGOfM7PQIl8wihoRzC4cZU8Sm5TRcgraqHzQZx4/pLa5O/
         zd3ubAGIhxswGC2FdVtRS1KLfDnUM3nVaBVhHMGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 043/109] net: mvneta: fix use of state->speed
Date:   Tue, 14 Jul 2020 20:43:46 +0200
Message-Id: <20200714184107.582661292@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit f2ca673d2cd5df9a76247b670e9ffd4d63682b3f ]

When support for short preambles was added, it incorrectly keyed its
decision off state->speed instead of state->interface.  state->speed
is not guaranteed to be correct for in-band modes, which can lead to
short preambles being unexpectedly disabled.

Fix this by keying off the interface mode, which is the only way that
mvneta can operate at 2.5Gbps.

Fixes: da58a931f248 ("net: mvneta: Add support for 2500Mbps SGMII")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 9799253948281..ffdb7b113f172 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3594,7 +3594,7 @@ static void mvneta_mac_config(struct phylink_config *config, unsigned int mode,
 	/* When at 2.5G, the link partner can send frames with shortened
 	 * preambles.
 	 */
-	if (state->speed == SPEED_2500)
+	if (state->interface == PHY_INTERFACE_MODE_2500BASEX)
 		new_ctrl4 |= MVNETA_GMAC4_SHORT_PREAMBLE_ENABLE;
 
 	if (pp->phy_interface != state->interface) {
-- 
2.25.1



