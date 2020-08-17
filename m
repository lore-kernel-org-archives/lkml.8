Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC6DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04E62065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692805;
	bh=WtHJlHpN1IoAghHnJrD6JHQcmHdwzjW8VjXo4bId0K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RcBbp74JZIAXvBhVtfhwO64kD3Ygn8xQQYMm87wElr51HTV+VC3vmP+cNYWE6YxEX
	 9qOzw0NBchihWKLDFYIJ/OlFdrVDPZN2oJ1Ue5gsLXRhAH2UQqIMxREm+f0qAZUwyQ
	 qg+XfRu+XnribKa6DQrWJjDSpikT9ET14E5sgVIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgHQTdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbgHQPa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:30:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AFF023440;
        Mon, 17 Aug 2020 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678257;
        bh=WtHJlHpN1IoAghHnJrD6JHQcmHdwzjW8VjXo4bId0K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ab554IHOpmgjA5BR8eExpNISn4gqdmsA8P+NmRnZnz4MRMfjzuG0P5N6BBkq967gQ
         oDz/4Gu4AXl8OC62mqpoAikEhLPrO+n3b4/oimwglUB1eH66GQliNMTTvDjo9ed8YR
         fNAaW0q4otWcNzCbPTO5EnOmOhszLftOCCeQaVQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 271/464] mt76: mt7915: add missing CONFIG_MAC80211_DEBUGFS
Date:   Mon, 17 Aug 2020 17:13:44 +0200
Message-Id: <20200817143846.763111625@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit a6e29d8ecd3d4eea8748d81d7b577083b4a7c441 ]

Add CONFIG_MAC80211_DEBUGFS to fix a reported warning.

Fixes: ec9742a8f38e ("mt76: mt7915: add .sta_add_debugfs support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 5278bee812f1c..7e48f56b5b08e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -384,6 +384,7 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	return 0;
 }
 
+#ifdef CONFIG_MAC80211_DEBUGFS
 /** per-station debugfs **/
 
 /* usage: <tx mode> <ldpc> <stbc> <bw> <gi> <nss> <mcs> */
@@ -461,3 +462,4 @@ void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	debugfs_create_file("fixed_rate", 0600, dir, sta, &fops_fixed_rate);
 	debugfs_create_file("stats", 0400, dir, sta, &fops_sta_stats);
 }
+#endif
-- 
2.25.1



