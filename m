Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A799AC3F342
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810FC2469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811651;
	bh=+zIrdqNPkEd6fY5EVhJZkgvBuBmEdUWSwmsgVa5DgUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CROaqMRNaFAvkhFFizaIaLfkKmSdWOnNF+1omDvkJlPRifK/D7prCLr/8lOR0sUgz
	 8L4AAzUvqlRLOE4qVhTF+fmaBOsXZRq30w1Vio+ZQtLV+ElxEe6jtKGtaokHK+HLzU
	 Kx+LJ9Hunp13C3xU5eG0vrzPdDMishi5tjfG36Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgB0NyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:54:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731279AbgB0NyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:54:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC91120801;
        Thu, 27 Feb 2020 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811645;
        bh=+zIrdqNPkEd6fY5EVhJZkgvBuBmEdUWSwmsgVa5DgUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbHxjfiYBS47XWSxUSHabfjUPzomGGP0tXOOHZb6fuCaOgMQBwvCwu9Hunt5guPh+
         Xmj7P3H4MBKmK/6g75y0PQqsBtJ9U68siBxBtGQys5LK2g3QO7ZaOdY6ouIz1gc/ml
         87D4PeH2d2Op3BZ7swfSsMOyAWBriEmPQ2QsJPbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lubomir Rintel <lkundrak@v3.sk>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 047/237] pxa168fb: Fix the function used to release some memory in an error handling path
Date:   Thu, 27 Feb 2020 14:34:21 +0100
Message-Id: <20200227132300.170429950@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 3c911fe799d1c338d94b78e7182ad452c37af897 ]

In the probe function, some resources are allocated using 'dma_alloc_wc()',
they should be released with 'dma_free_wc()', not 'dma_free_coherent()'.

We already use 'dma_free_wc()' in the remove function, but not in the
error handling path of the probe function.

Also, remove a useless 'PAGE_ALIGN()'. 'info->fix.smem_len' is already
PAGE_ALIGNed.

Fixes: 638772c7553f ("fb: add support of LCD display controller on pxa168/910 (base layer)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>
CC: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190831100024.3248-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/pxa168fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index d059d04c63acd..20195d3dbf088 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -769,8 +769,8 @@ failed_free_cmap:
 failed_free_clk:
 	clk_disable_unprepare(fbi->clk);
 failed_free_fbmem:
-	dma_free_coherent(fbi->dev, info->fix.smem_len,
-			info->screen_base, fbi->fb_start_dma);
+	dma_free_wc(fbi->dev, info->fix.smem_len,
+		    info->screen_base, fbi->fb_start_dma);
 failed_free_info:
 	kfree(info);
 
@@ -804,7 +804,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 
-	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
+	dma_free_wc(fbi->dev, info->fix.smem_len,
 		    info->screen_base, info->fix.smem_start);
 
 	clk_disable_unprepare(fbi->clk);
-- 
2.20.1



