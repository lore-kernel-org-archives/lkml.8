Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D505C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0903420809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592589886;
	bh=4BtD3MYD+VZOU9pnwXf8Ajs1DRRHrNXmV37Wuhj/+Gc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tRG/NcR9FN0HSyTpqF2m5wS2rs/PxShbbVDJM0MXYV+yxc3Y77DS95pEiAxndY/xt
	 z0Gi/xcGNOI/hC8FiC9B/JP9KC8E5IyRofU9jwsMqXRBoW/m22mtOxg/Pv8AOFK8zY
	 JTPUUw7gnJ1wJeW9p5DLvqslGU/GZtGRyyDr1Nw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392071AbgFSSEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389671AbgFSSEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:04:44 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B073420DD4;
        Fri, 19 Jun 2020 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592589883;
        bh=4BtD3MYD+VZOU9pnwXf8Ajs1DRRHrNXmV37Wuhj/+Gc=;
        h=Date:From:To:Cc:Subject:From;
        b=UZfGmO8K/btUZpFfszkFst5DdKQp3Z5but4edsWZRZEa649haUjZIo/YfTaIihf9J
         MHr9+242B2LfW5ZQt0C4GlvHuYwNDDu7tyNRlhvSOcIUkM0svtcIKnULrfGL0b200u
         ZoFkVbUk1/ukdB7mdywIyqBa/v5CzlQwfKGRCUVM=
Date:   Fri, 19 Jun 2020 13:10:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] net: dsa: sja1105: Use struct_size() in kzalloc()
Message-ID: <20200619181007.GA32353@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_tas.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_tas.c b/drivers/net/dsa/sja1105/sja1105_tas.c
index 3aa1a8b5f766..31d8acff1f01 100644
--- a/drivers/net/dsa/sja1105/sja1105_tas.c
+++ b/drivers/net/dsa/sja1105/sja1105_tas.c
@@ -475,8 +475,7 @@ bool sja1105_gating_check_conflicts(struct sja1105_private *priv, int port,
 	if (list_empty(&gating_cfg->entries))
 		return false;
 
-	dummy = kzalloc(sizeof(struct tc_taprio_sched_entry) * num_entries +
-			sizeof(struct tc_taprio_qopt_offload), GFP_KERNEL);
+	dummy = kzalloc(struct_size(dummy, entries, num_entries), GFP_KERNEL);
 	if (!dummy) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to allocate memory");
 		return true;
-- 
2.27.0

