Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D34C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC97322B49
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916082;
	bh=wp8G5LoikT6tMvWTrOAsmUvkum57qThOs0SmGsnDMmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1imSAE/iME2WLIDHd6t9lh9cKUMCLtGlI9y8TCAa2sJJTo639QHaIeK2CkMT9rJ42
	 244xbhdbbffJ31qFpalyJ7ci9IK5Ehi1Lg7fU+OGRvAXPx2hwSi/45cClJ8ejJfepN
	 xeB0TKXoXLUUB8GcykRE8Z7lRP6r6uqYEnbl4Glw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgHTJeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbgHTJbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:31:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9337122B3F;
        Thu, 20 Aug 2020 09:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915898;
        bh=wp8G5LoikT6tMvWTrOAsmUvkum57qThOs0SmGsnDMmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHg4W3l6z93G80sxfHYFssGiWTOf3pRCVpzsSvJJ+mbowONt1j7a8A6MXS4iME8eC
         wCz2rMzYrPi3ocl34AOQn9vWdzMwLTpWYnvYpMbZNB1fuXpzVCc0C31nQcxdOURNDa
         QkbI3mgPQugCXO42e1tMkmcEfbT24rW2TH6x3U7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhihao Cheng <chengzhihao1@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        syzbot+d9aab50b1154e3d163f5@syzkaller.appspotmail.com,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 174/232] ubi: fastmap: Dont produce the initial next anchor PEB when fastmap is disabled
Date:   Thu, 20 Aug 2020 11:20:25 +0200
Message-Id: <20200820091621.246072260@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit 3b185255bb2f34fa6927619b9ef27f192a3d9f5a ]

Following process triggers a memleak caused by forgetting to release the
initial next anchor PEB (CONFIG_MTD_UBI_FASTMAP is disabled):
1. attach -> __erase_worker -> produce the initial next anchor PEB
2. detach -> ubi_fastmap_close (Do nothing, it should have released the
   initial next anchor PEB)

Don't produce the initial next anchor PEB in __erase_worker() when fastmap
is disabled.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Fixes: f9c34bb529975fe ("ubi: Fix producing anchor PEBs")
Reported-by: syzbot+d9aab50b1154e3d163f5@syzkaller.appspotmail.com
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/ubi/wl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 27636063ed1bb..42cac572f82dc 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1086,7 +1086,8 @@ static int __erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk)
 	if (!err) {
 		spin_lock(&ubi->wl_lock);
 
-		if (!ubi->fm_next_anchor && e->pnum < UBI_FM_MAX_START) {
+		if (!ubi->fm_disabled && !ubi->fm_next_anchor &&
+		    e->pnum < UBI_FM_MAX_START) {
 			/* Abort anchor production, if needed it will be
 			 * enabled again in the wear leveling started below.
 			 */
-- 
2.25.1



