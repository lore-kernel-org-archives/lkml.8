Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A718C3F340
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F1920578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582810951;
	bh=kqobUzNIK0zbxE3SOKiTCuJq60wEzhM2JkGtXbIxiek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kuWFsSBAUEjwxTrzq6TwClHFKJaMiS0Hy3DFDUHCeMs224gAcn8Km9kcZOQ9UutSe
	 RwMW6wGPoWI+lBc+PmYsyo+XYSPZt3zfOfPe0wZTyNXuULr0Opu9v+beJpGpFDrTyW
	 9JlVxm1omoYFshNLmCR53TThCwD51nuK30ZpqOLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgB0Nma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729405AbgB0Nm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:42:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B06420726;
        Thu, 27 Feb 2020 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582810947;
        bh=kqobUzNIK0zbxE3SOKiTCuJq60wEzhM2JkGtXbIxiek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VELWjLah64bOEGfb93o7s5kT2GOWSIDX6QP7XBpdNu6JYZgsYPKUzS81UGoajXprZ
         gMaiwGMV5ah+JuyPmF17meeOg+j/UPXgW8wakY8w/Q/kZlZ7A2EJGApSzLRpfUeZru
         yx5Ua0Sm09785nYah9cDpujNQJPhmrkuMhIRrFLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 020/113] brcmfmac: Fix use after free in brcmf_sdio_readframes()
Date:   Thu, 27 Feb 2020 14:35:36 +0100
Message-Id: <20200227132214.894649720@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
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
 drivers/net/wireless/brcm80211/brcmfmac/sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
index 9954e641c943d..8bb028f740fd8 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
@@ -2027,6 +2027,7 @@ static uint brcmf_sdio_readframes(struct brcmf_sdio *bus, uint maxframes)
 					       BRCMF_SDIO_FT_NORMAL)) {
 				rd->len = 0;
 				brcmu_pkt_buf_free_skb(pkt);
+				continue;
 			}
 			bus->sdcnt.rx_readahead_cnt++;
 			if (rd->len != roundup(rd_new.len, 16)) {
-- 
2.20.1



