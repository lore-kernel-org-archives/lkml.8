Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23FAC55197
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B974320776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587730997;
	bh=ceW0OqFGo72zLt1whwqpejHCUYYDHQ7+Wh8tXwZTroQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=koZhXa6FCNA4b208Z2y7gy0mYG1Ll/jTs+7a/KrQUvnsdSaF3VktmwgMAn1dkdFpy
	 EbRFM5frokz/BmjLWBiwVR2MiyclcgITswjgt0yw8KISiTls5r+vFRTL9jMpH4zq0E
	 8pBObXLkMFCFrluGVxKiEV/mVKqdGwQ8ufPzkaTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgDXMXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgDXMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:23:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237B120776;
        Fri, 24 Apr 2020 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587730989;
        bh=ceW0OqFGo72zLt1whwqpejHCUYYDHQ7+Wh8tXwZTroQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVV34W9+VoaPTsC432s6y9IWKgRnIJrvYGv9+c8gY0+QipsdfbMBZkETYyyjy8oHb
         CsjwjpaW0RlZLhMV6DXbi7gX3TOY2kpmYBqDox0CGzGt96hb2AyNDtVs7dYzPIMKKa
         8I79Fna9nXixhz5vM232zW2dfHdMTAPY2WbPtM+4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 28/38] i2c: remove i2c_new_probed_device API
Date:   Fri, 24 Apr 2020 08:22:26 -0400
Message-Id: <20200424122237.9831-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122237.9831-1-sashal@kernel.org>
References: <20200424122237.9831-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 3c1d1613be80c2e17f1ddf672df1d8a8caebfd0d ]

All in-tree users have been converted to the new i2c_new_scanned_device
function, so remove this deprecated one.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 13 -------------
 include/linux/i2c.h         |  6 ------
 2 files changed, 19 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index cefad08819420..4bfb15ac71f1c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2269,19 +2269,6 @@ i2c_new_scanned_device(struct i2c_adapter *adap,
 }
 EXPORT_SYMBOL_GPL(i2c_new_scanned_device);
 
-struct i2c_client *
-i2c_new_probed_device(struct i2c_adapter *adap,
-		      struct i2c_board_info *info,
-		      unsigned short const *addr_list,
-		      int (*probe)(struct i2c_adapter *adap, unsigned short addr))
-{
-	struct i2c_client *client;
-
-	client = i2c_new_scanned_device(adap, info, addr_list, probe);
-	return IS_ERR(client) ? NULL : client;
-}
-EXPORT_SYMBOL_GPL(i2c_new_probed_device);
-
 struct i2c_adapter *i2c_get_adapter(int nr)
 {
 	struct i2c_adapter *adapter;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f6b942150631b..a32f3297d4226 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -453,12 +453,6 @@ i2c_new_scanned_device(struct i2c_adapter *adap,
 		       unsigned short const *addr_list,
 		       int (*probe)(struct i2c_adapter *adap, unsigned short addr));
 
-struct i2c_client *
-i2c_new_probed_device(struct i2c_adapter *adap,
-		       struct i2c_board_info *info,
-		       unsigned short const *addr_list,
-		       int (*probe)(struct i2c_adapter *adap, unsigned short addr));
-
 /* Common custom probe functions */
 int i2c_probe_func_quick_read(struct i2c_adapter *adap, unsigned short addr);
 
-- 
2.20.1

