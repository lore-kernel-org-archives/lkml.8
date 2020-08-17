Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E195FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C034D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684563;
	bh=wZTTDXN94OPRSyIKRJ0VX5ReB40jjaAt7edMTIPRpWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uf2eJ8z/qhUhqXVZM7HMcn2QjdaNVQnuovSpCVb9A+M/BQuem+q0iofvYGZJubtwX
	 motpetQp4+49FECsy4rUcRQN0qeXthxKZWXDEiazlTqGu2QdC+S26DFU/g0YCBlqvU
	 Xj9tzS4tcEmtunbLHZchOa6ggZa1SftpvgyVe9p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbgHQRPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388743AbgHQQNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:13:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D166A22CAD;
        Mon, 17 Aug 2020 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680786;
        bh=wZTTDXN94OPRSyIKRJ0VX5ReB40jjaAt7edMTIPRpWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQ3M8ENCRXT6E6smqUWlLOVGdat/b3Kl1gR5oOcDsfSQufg4FZ+NS7HWs/J4XUuTy
         wBKCVdT/2PCPh84APKjj5VP54pqZ/eXksI49+9a+g3w6/fl9HKY5bU1mfwTCqEzeof
         E2UYjdI4Y1xzN/SSxwS0vJi+snxznmBRtDPaJhoA=
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
Subject: [PATCH 4.19 056/168] video: fbdev: sm712fb: fix an issue about iounmap for a wrong address
Date:   Mon, 17 Aug 2020 17:16:27 +0200
Message-Id: <20200817143736.554430842@linuxfoundation.org>
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
index f1dcc6766d1ef..1781ca697f66b 100644
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



