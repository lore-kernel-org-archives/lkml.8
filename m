Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76798C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EF32063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686528;
	bh=O5VLB5HlxRSKccKG8hvZ2d/JkccpA0XWcovhGW9fpqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+trE15YculHYFvrP6ZaQkFLzm7JrcwqmQX2XbiBU1CoISlvmvNnhB9neMN0oUrh1
	 jbuvQw5jI/yeWtkLPeQsgji/mJuBTOzQP35EQsfOIvyc33yizLBLexB+0G9CPCW0V3
	 RC53+cy+K0XJCE/G15x6OHpQlIpFd/jz/S0nufVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390122AbgHQRsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388745AbgHQQNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:13:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA2820748;
        Mon, 17 Aug 2020 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680791;
        bh=O5VLB5HlxRSKccKG8hvZ2d/JkccpA0XWcovhGW9fpqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xs7/X9FGqNVIgX8Btqw9jnSUWiw+sIU0tK9U4XSZynaRwVp4VbjJarxLAT+pXunQY
         9cqijqv3331Lie5FyaAxC2B6xql8XjUJ7ayJgVtntpnbg2j/ltZ9JdxIN2dPs9Ja9e
         x0ISkty0p2zXT3IGOuJSRlkQTy3JH7/VVKn0aLPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Miao <eric.miao@marvell.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/168] video: pxafb: Fix the function used to balance a dma_alloc_coherent() call
Date:   Mon, 17 Aug 2020 17:16:29 +0200
Message-Id: <20200817143736.642841519@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 499a2c41b954518c372873202d5e7714e22010c4 ]

'dma_alloc_coherent()' must be balanced by a call to 'dma_free_coherent()'
not 'dma_free_wc()'.
The correct dma_free_ function is already used in the error handling path
of the probe function.

Fixes: 77e196752bdd ("[ARM] pxafb: allow video memory size to be configurable")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jani Nikula <jani.nikula@intel.com>
cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Eric Miao <eric.miao@marvell.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200429084505.108897-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/pxafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index d59c8a59f5827..90dee3e6f8bc7 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2446,8 +2446,8 @@ static int pxafb_remove(struct platform_device *dev)
 
 	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
 
-	dma_free_wc(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
-		    fbi->dma_buff_phys);
+	dma_free_coherent(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
+			  fbi->dma_buff_phys);
 
 	return 0;
 }
-- 
2.25.1



