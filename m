Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FB1C3F34E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11B524688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811165;
	bh=djrylqynmlxVfb1NigsjuAumrzZme2zHlypxM5eLteM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XacCN+7pr1AIL2eGqPb8D6NBj6S6XRYf0DJ1y/pdD7YU9UyF42lNBbld/zPbZdR2B
	 4LqInTg3HdNStMWzLYT9sPWr4JrOnT8tW9Wyy98uQRTduE9S1+zujLH7FpB6Ch9kmj
	 f0fstdE7nWWgckGNva/oV8F2MM9ZuLP5pM6BNZrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgB0NqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbgB0Np7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:45:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3200324688;
        Thu, 27 Feb 2020 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811158;
        bh=djrylqynmlxVfb1NigsjuAumrzZme2zHlypxM5eLteM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWKDwCZG+hNVUffP/4YxkwriTs9IWsS4w9AwpExT+zwhIX8rsX0eLN0waQl0w6qGY
         pNtOwT6QkFiEPGqRgYJmDhhBXYb/xtf/5F14C2C0sJg1ZmwX/Sbeqgu6V9z2UvOX74
         aTjSF+nxhXbCQQty0qMo7AarJ3sjI6TojlvJGPuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 024/165] brcmfmac: Fix use after free in brcmf_sdio_readframes()
Date:   Thu, 27 Feb 2020 14:34:58 +0100
Message-Id: <20200227132234.483539628@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



