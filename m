Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6DBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2924421532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582320;
	bh=T1TFFnuOR8yP9KXZ3SI9ba8JrUEjNEAKKapF2hBhyM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ahoy94pOlDbbu6b97KHH1lu0eH/hxCgtSKpd928N96NB0ajZ+QOmznF1u32rMa2AF
	 QZHbfd9ajg9LWvSfJT0J7X1yB1byt6LBNtBVaxbMEyF2zOqUUhqrwMI0OoDvQGXLzv
	 +sKrBI/1e7xIxi+jGu9sZ8PCduKepZCO4HFOQ+8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404043AbgFSPT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392579AbgFSPSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:18:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3402186A;
        Fri, 19 Jun 2020 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579884;
        bh=T1TFFnuOR8yP9KXZ3SI9ba8JrUEjNEAKKapF2hBhyM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y5OMZDpJqBz/QCfy+FpqHExHZONVFTZWHcHj+XqffZhcdpoKh8xhZt2mBDX44XeA5
         2u0v/sbdylUZDEMrh7lM8dk4EMxP9fhiixlmprm8O9Z/D3i3RO5VklDiAXY4eQ3vZx
         8QItX1/xe/P/0XEauagDW/KYsy46Z+PeawJgVA/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 040/376] mt76: mt7615: fix aid configuration in mt7615_mcu_wtbl_generic_tlv
Date:   Fri, 19 Jun 2020 16:29:18 +0200
Message-Id: <20200619141712.254706360@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit fdf433121f82766ff508a6f06665d2aca3e258d5 ]

If the vif is running in station mode the aid will be passed by mac80211
using bss_conf.aid. Fix aid configuration in mt7615_mcu_wtbl_generic_tlv

Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 610cfa918c7b..a19fb0cb7794 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -823,8 +823,11 @@ mt7615_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	generic = (struct wtbl_generic *)tlv;
 
 	if (sta) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
+		else
+			generic->partial_aid = cpu_to_le16(sta->aid);
 		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
-		generic->partial_aid = cpu_to_le16(sta->aid);
 		generic->muar_idx = mvif->omac_idx;
 		generic->qos = sta->wme;
 	} else {
-- 
2.25.1



