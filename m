Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382CFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118002074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592262625;
	bh=7RV+LZohdXGjxU20nhjS42pqNFlJCzFWcJTRRTFiDDc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sCiwkubSIjevkCmwlHaRly5ZbWptywe8Gai7Orrp+V7U61cfCe9PR/HjzaRxPahAQ
	 RZ6C/cWaGr7zREVwUiruSImdzyEB3DnHcC9YIW2X/iPPYF9s4ApWacP1+SN8Yrx9Lx
	 /c1fHHfDaQbNa12awAfn0Oo1wEM+UntquFWygBZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFOXKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:10:23 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51EC2068E;
        Mon, 15 Jun 2020 23:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592262623;
        bh=7RV+LZohdXGjxU20nhjS42pqNFlJCzFWcJTRRTFiDDc=;
        h=Date:From:To:Cc:Subject:From;
        b=CEs4aLG5bPIwZbrsvC2dSFTmKvPInHk5eson9VqbhFdXVH0XydZjGHGGolJ1XST+g
         mlNkDLx5IU3HQg59/H7h47facnlBhyRq+gX3NcxcZ6UcYuXoBExfajLH22hE+PRHfu
         BpG1T8V0uj1NWRhG3TsLNA7PQU73D1kX15FUM8YM=
Date:   Mon, 15 Jun 2020 18:15:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] fbcon: Use array3_size() helper in scr_memcpyw()
Message-ID: <20200615231542.GA20470@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array3_size() helper instead of the open-coded version in scr_memcpyw()
and scr_memsetw(). These sorts of multiplication factors need to be wrapped
in array3_size().

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9d28a8e3328f..6af2734f2a7b 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -639,7 +639,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 			       GFP_KERNEL);
 		if (save) {
 			int i = cols < new_cols ? cols : new_cols;
-			scr_memsetw(save, erase, logo_lines * new_cols * 2);
+			scr_memsetw(save, erase, array3_size(logo_lines, new_cols, 2));
 			r = q - step;
 			for (cnt = 0; cnt < logo_lines; cnt++, r += i)
 				scr_memcpyw(save + cnt * new_cols, r, 2 * i);
@@ -676,7 +676,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		q = (unsigned short *) (vc->vc_origin +
 					vc->vc_size_row *
 					rows);
-		scr_memcpyw(q, save, logo_lines * new_cols * 2);
+		scr_memcpyw(q, save, array3_size(logo_lines, new_cols, 2));
 		vc->vc_y += logo_lines;
 		vc->vc_pos += logo_lines * vc->vc_size_row;
 		kfree(save);
-- 
2.27.0

