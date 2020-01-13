Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC9FC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2C72075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAMRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:21:17 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39865 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMRVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:21:17 -0500
X-Originating-IP: 84.44.14.226
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 75805FF802;
        Mon, 13 Jan 2020 17:21:13 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] media: davinci: remove self assignment in vpfe
Date:   Mon, 13 Jan 2020 20:20:39 +0300
Message-Id: <20200113172038.99689-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a self assignment which has no effect.

Removed self assignment.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 drivers/media/platform/davinci/vpfe_capture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
index 916ed743d716..089648665cdf 100644
--- a/drivers/media/platform/davinci/vpfe_capture.c
+++ b/drivers/media/platform/davinci/vpfe_capture.c
@@ -879,7 +879,6 @@ static int vpfe_enum_fmt_vid_cap(struct file *file, void  *priv,
 	/* Fill in the information about format */
 	pix_fmt = vpfe_lookup_pix_format(pix);
 	if (pix_fmt) {
-		fmt->pixelformat = fmt->pixelformat;
 		return 0;
 	}
 	return -EINVAL;
--
2.24.1

