Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BF1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD2820706
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580020;
	bh=VYWenzQ8i2lLQM7eSA2bTGMvfrUBJTLf4bOKdgHsOGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ceubGmDxnKw/prSQy8xotOJMkOaOl16wgYPvzzIjInonmuGA+1SY5CPu92NA8Zlql
	 xitrXAFiHDyBoz6Mcs1Thl0BvK+QOK6te44lxSG8OVioLGJEax80YTr/aw1iSejHfs
	 jazYKAYX68s0NeqzPEZd3ANzeE1lwsyctL+K+sC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392676AbgFSPUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392539AbgFSPRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:17:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0C221974;
        Fri, 19 Jun 2020 15:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579865;
        bh=VYWenzQ8i2lLQM7eSA2bTGMvfrUBJTLf4bOKdgHsOGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9KOmD3Q7GuexOmFzap0XH+H2Ja8vZA5XxGxBLlpOOW4a9B5N4vfyuYcwn4DqSsGm
         YHi95wR48dOd9vGGokDQQ+Ft7rhJ72lvnk/C5tZQHBnp1uSIWqb6W7q4lYhyuVdztZ
         pINNqnJ1zbVqHDXNr638pfW8DR0m8VLXCSVw1hzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 033/376] rtw88: fix an issue about leak system resources
Date:   Fri, 19 Jun 2020 16:29:11 +0200
Message-Id: <20200619141711.920673038@linuxfoundation.org>
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

From: Dejin Zheng <zhengdejin5@gmail.com>

[ Upstream commit 191f6b08bfef24e1a9641eaac96ed030a7be4599 ]

the related system resources were not released when pci_iomap() return
error in the rtw_pci_io_mapping() function. add pci_release_regions() to
fix it.

Fixes: e3037485c68ec1a ("rtw88: new Realtek 802.11ac driver")
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200504083442.3033-1-zhengdejin5@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 1af87eb2e53a..d735f3127fe8 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1091,6 +1091,7 @@ static int rtw_pci_io_mapping(struct rtw_dev *rtwdev,
 	len = pci_resource_len(pdev, bar_id);
 	rtwpci->mmap = pci_iomap(pdev, bar_id, len);
 	if (!rtwpci->mmap) {
+		pci_release_regions(pdev);
 		rtw_err(rtwdev, "failed to map pci memory\n");
 		return -ENOMEM;
 	}
-- 
2.25.1



