Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2453C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAF7246E2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204088;
	bh=e5BxQUvwtKpoy8dVgoesU1wA5L+9SWslk6w8zeHqf44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DhmWluBT0ldG1Wj5fYr3LKhmCc1M8Mm0Ady0pH4rqAuAGY8HScLvNdkIf096egvT1
	 6FuDMY+0bMn/3g91gP+Cy6AoRkPyukDEdLP1TjlBY6688gSHetMqM0hLuu7baW0i0n
	 iSgOKaFkO+Xpmp1LHn8mYQPY4bLWAS4GL20CB+1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgCCCyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:54:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbgCCCtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:49:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8590324673;
        Tue,  3 Mar 2020 02:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203754;
        bh=e5BxQUvwtKpoy8dVgoesU1wA5L+9SWslk6w8zeHqf44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQkjUsVZX57CGDk88/3P9oY6Nr88wbMA/TZ9gZfr5wXKwo4NCoIF8oVtmIxz5k9wl
         YoRgn5F64sTiQLyAsLpT4HyWeYK5tKW6m/woYpaap5XWHHpnFlNXcWQYUsvrcc7CK5
         uiHl7mYvo3l6Xw/wCMt3qebl6AQGeWH1wg6YZhGA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/32] net: dsa: b53: Ensure the default VID is untagged
Date:   Mon,  2 Mar 2020 21:48:36 -0500
Message-Id: <20200303024851.10054-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024851.10054-1-sashal@kernel.org>
References: <20200303024851.10054-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit d965a5432d4c3e6b9c3d2bc1d4a800013bbf76f6 ]

We need to ensure that the default VID is untagged otherwise the switch
will be sending tagged frames and the results can be problematic. This
is especially true with b53 switches that use VID 0 as their default
VLAN since VID 0 has a special meaning.

Fixes: fea83353177a ("net: dsa: b53: Fix default VLAN ID")
Fixes: 061f6a505ac3 ("net: dsa: Add ndo_vlan_rx_{add, kill}_vid implementation")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 51436e7eae103..ac5d945b934a0 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1165,6 +1165,9 @@ void b53_vlan_add(struct dsa_switch *ds, int port,
 
 		b53_get_vlan_entry(dev, vid, vl);
 
+		if (vid == 0 && vid == b53_default_pvid(dev))
+			untagged = true;
+
 		vl->members |= BIT(port);
 		if (untagged && !dsa_is_cpu_port(ds, port))
 			vl->untag |= BIT(port);
-- 
2.20.1

