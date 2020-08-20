Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17376C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BE82072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921783;
	bh=O2qz6wwz+lktnJoO9oih2cVk4uhOOPAXcccpXKQOJsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JPEdEscEdH2vsftEHtq1Iw0ukz0ErfbdZ/L9muPYwiNlUE+aGXVE5JdOngjloNrSq
	 1Cnd9GUxr2LnSaJaAidXo0IPSuyS2LCMfAwIEHd51Goh8ACiDBlXD2SBwTPgdO7Xpo
	 +x0gom+Y074bW/FT6VGPpgEhZuXGuaR1yx8siPro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgHTLJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730852AbgHTKJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:09:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD45C2067C;
        Thu, 20 Aug 2020 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918194;
        bh=O2qz6wwz+lktnJoO9oih2cVk4uhOOPAXcccpXKQOJsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lt76iV6wGbIAgX991aGJdB928efBC1qSwJwTijkx0mS05eVs76JaMDgTRAYn1SDrq
         nfuDD6vtOr4fbz4lQy1BwxXhFhn7rOXNeBpFgTPofByollfujnnRSQXV17qgtag8oM
         BVSCjwPO2bkt+qSNmG/5B6S884W5TBG4s9w3ccc0=
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
Subject: [PATCH 4.14 084/228] video: pxafb: Fix the function used to balance a dma_alloc_coherent() call
Date:   Thu, 20 Aug 2020 11:20:59 +0200
Message-Id: <20200820091611.811982808@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
index 29f00eccdd015..08ee77d5df8b2 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2449,8 +2449,8 @@ static int pxafb_remove(struct platform_device *dev)
 
 	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
 
-	dma_free_wc(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
-		    fbi->dma_buff_phys);
+	dma_free_coherent(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
+			  fbi->dma_buff_phys);
 
 	iounmap(fbi->mmio_base);
 
-- 
2.25.1



