Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F5C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2483B24677
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698781;
	bh=djrylqynmlxVfb1NigsjuAumrzZme2zHlypxM5eLteM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STgIuYtUm7kuP9V6SipCi6VeoUKtdXkdv1MomrLSpXpArNMeCpkOZV6csjYXlmv7/
	 rBzo/yYM3hnZsU1g5KK31FUgDM8QRRj1YMgKTNBPgqxkhIktXRFs1rDIKNhh05rs+u
	 wPip93gMf33yKrQTh75Zz/81Uy5ZMTMUMXKRSrZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394131AbgBNQqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392966AbgBNQVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37118246A6;
        Fri, 14 Feb 2020 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697290;
        bh=djrylqynmlxVfb1NigsjuAumrzZme2zHlypxM5eLteM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnKneg26fiNd4auWY0d39/PVdlc4SrkyKZGIb8jcmCDquB6oLBm0fVOFTqYlGBFz6
         lkiimNJz059n3WiFCrnrHfin50cDuYRjsVNHhc24pm3ZD/tF53tMLjqpoV2PwKMGVM
         LL8SL6bOzSQ7E9S0arCwWT7LLEGs0znISpclwW8s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 006/141] brcmfmac: Fix use after free in brcmf_sdio_readframes()
Date:   Fri, 14 Feb 2020 11:19:06 -0500
Message-Id: <20200214162122.19794-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 216b44000ada87a63891a8214c347e05a4aea8fe ]

The brcmu_pkt_buf_free_skb() function frees "pkt" so it leads to a
static checker warning:

    drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:1974 brcmf_sdio_readframes()
    error: dereferencing freed memory 'pkt'

It looks like there was supposed to be a continue after we free "pkt".

Fixes: 4754fceeb9a6 ("brcmfmac: streamline SDIO read frame routine")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index de52d826eb248..998a4bd6db78a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -1921,6 +1921,7 @@ static uint brcmf_sdio_readframes(struct brcmf_sdio *bus, uint maxframes)
 					       BRCMF_SDIO_FT_NORMAL)) {
 				rd->len = 0;
 				brcmu_pkt_buf_free_skb(pkt);
+				continue;
 			}
 			bus->sdcnt.rx_readahead_cnt++;
 			if (rd->len != roundup(rd_new.len, 16)) {
-- 
2.20.1

