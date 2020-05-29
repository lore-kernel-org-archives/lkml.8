Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70116C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419FC2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lv8wSlZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgE2I1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2I1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:27:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8826CC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:27:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so2324306wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t01eFYsLCYMUh71LfaSG8m5mrKtEOYGphARGk4VMCAM=;
        b=lv8wSlZ8RZbxv4EzSVhJKApyfdZ7Nh+/HRU+HHipFV78X0WwbyHNrNXRpz5EH6B++t
         rgJH+656w6SCghD6FzHoThJhcaKOWNhRqehRcfLXOpyK2tmqPh2k37fl4zItPgWxHR6N
         piQdqFalxkZGloVvY+akhG3uA4wIgZG+sEEJxkvdq3lx4GWKTQVx/YElTXAd+pc7fcj7
         2X0SbguFhGiISftlDNtIiEhs0/mRtCXYhbj5Q70tyKk4QRInsa7g21CCaYLVj9F6dmlt
         MfhCS7wbwjGBXDsuWfmvEjf9JqOlT6Wrew4ZO9MXzO9qSevqXxKkIShfSp6XlKninQCI
         Cvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t01eFYsLCYMUh71LfaSG8m5mrKtEOYGphARGk4VMCAM=;
        b=DpuaRzRYohxQmpJqONFCSRLxuLGnYaUoxm1f56cWB0bGfriWhUH9Mo9p+CwYwP/Fbq
         OOXJOX16pKQs0TCgYOR4Jx52GqTX27CD9Bb/r9PD7HZ9pIF3oB/kNr0xqD8TSIP3Xr0k
         wBbliypIawoKonARbUel7ZY2dbLdRPScRWV0u2AH4JHTMGbaKQF1MceKbOQrjN7vc102
         J6Q03YkXpkUT5JdS8zYWK8xI/PneRMTI6ld9P40a2wR0cCQ2cRUV6xk4ipfRv4whuaz9
         upZFPMCdNxR333d7ZEwgirvUvPMmbg7VG7D/Wu+HWQpfsowa5IQvFZ1Jj7QP83GamR+Y
         mt1w==
X-Gm-Message-State: AOAM531RhTj1c1emlIwsnvV5qmS4pKfbyasg+tGKzGsCGNdPrJRtOqIH
        55wnt0awq54sAsnZi4zycJ7vkA==
X-Google-Smtp-Source: ABdhPJwQnfgPwNSZqbr6uVN9JRnU1eAWiaVFQT25mMZwuifAllPHXfm/vwdnHnTsmyOQBsz/JoesdA==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr7741464wmj.118.1590740819317;
        Fri, 29 May 2020 01:26:59 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-214-184.w2-15.abo.wanadoo.fr. [2.15.60.184])
        by smtp.gmail.com with ESMTPSA id o20sm9208618wra.29.2020.05.29.01.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:26:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] net: ethernet: mtk-star-emac: remove unused variable
Date:   Fri, 29 May 2020 10:26:48 +0200
Message-Id: <20200529082648.19677-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The desc pointer is set but not used. Remove it.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 8596ca0e60eb..7df35872c107 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -746,15 +746,12 @@ mtk_star_ring_free_skbs(struct mtk_star_priv *priv, struct mtk_star_ring *ring,
 					   struct mtk_star_ring_desc_data *))
 {
 	struct mtk_star_ring_desc_data desc_data;
-	struct mtk_star_ring_desc *desc;
 	int i;
 
 	for (i = 0; i < MTK_STAR_RING_NUM_DESCS; i++) {
 		if (!ring->dma_addrs[i])
 			continue;
 
-		desc = &ring->descs[i];
-
 		desc_data.dma_addr = ring->dma_addrs[i];
 		desc_data.skb = ring->skbs[i];
 
-- 
2.26.1

