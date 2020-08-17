Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7023AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F8D20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597680717;
	bh=bXOSpFUr15VAm3bVAU/GBKdHAAr5b+vERnYtChHHRIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jhgIkgQgC8hnH5A8legfChBMifvlmrj4hGs9BWM/BrySYQVRLQvUmRZkvmFBjcf0Q
	 njO8W1MTAxPK1S7LDd3OwixOE6J0C+b2CQ/X7Nr+ip/yoi0420nj1LGsZokBwxOSew
	 2oSgLB5E/WFdeJiYGVb1lbZ1rPdJChS3HB5gAHoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbgHQQLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387545AbgHQPqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:46:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37A32067C;
        Mon, 17 Aug 2020 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679201;
        bh=bXOSpFUr15VAm3bVAU/GBKdHAAr5b+vERnYtChHHRIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxZFeGXB0kKwMqAVY2cF6xu/lQOiUnk6b8klVdyrHVb7KDoohKOUb7McAYwAWMcpn
         a0tdZVfW/yBhJIVJaq54S/lxz+1PT0walA2U9lWvDrlIEYVKhB0OxUJf8TK7mdwptW
         gspuaxdpiRBgulauzfKArHOc77zonkUNcpsP2pZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 131/393] video: fbdev: sm712fb: fix an issue about iounmap for a wrong address
Date:   Mon, 17 Aug 2020 17:13:01 +0200
Message-Id: <20200817143825.963891853@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dejin Zheng <zhengdejin5@gmail.com>

[ Upstream commit 98bd4f72988646c35569e1e838c0ab80d06c77f6 ]

the sfb->fb->screen_base is not save the value get by iounmap() when
the chip id is 0x720. so iounmap() for address sfb->fb->screen_base
is not right.

Fixes: 1461d6672864854 ("staging: sm7xxfb: merge sm712fb with fbdev")
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200422160719.27763-1-zhengdejin5@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sm712fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 6a1b4a853d9ee..8cd655d6d6280 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1429,6 +1429,8 @@ static int smtc_map_smem(struct smtcfb_info *sfb,
 static void smtc_unmap_smem(struct smtcfb_info *sfb)
 {
 	if (sfb && sfb->fb->screen_base) {
+		if (sfb->chip_id == 0x720)
+			sfb->fb->screen_base -= 0x00200000;
 		iounmap(sfb->fb->screen_base);
 		sfb->fb->screen_base = NULL;
 	}
-- 
2.25.1



