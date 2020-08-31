Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A322C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF34C2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FnR1bS7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgHaTwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:52:54 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14835 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbgHaTwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:52:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d55030002>; Mon, 31 Aug 2020 12:52:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 12:52:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 12:52:49 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 19:52:49 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 19:52:49 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.173.243]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4d55110000>; Mon, 31 Aug 2020 12:52:49 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <sakari.ailus@iki.fi>,
        <hverkuil@xs4all.nl>, <luca@lucaceresoli.net>,
        <leonl@leopardimaging.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] media: i2c: imx274: Fix Y_OUT_SIZE register setting
Date:   Mon, 31 Aug 2020 12:52:35 -0700
Message-ID: <1598903558-9691-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598903558-9691-1-git-send-email-skomatineni@nvidia.com>
References: <1598903558-9691-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598903556; bh=7eG8er5DakEQLU4K41aXrq57p9hJvRNjoRAVrC46VL0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FnR1bS7erlxqJsX6qB/2TMIfCH6KAQc49FTc1yRdKVnjW+TPFijVT0GBCp5y2mYs6
         3IJtX29q7B1OPZUP8iozX6bHugQ07yXnjArrkOxjyINoO3b/tzQBZeC0xFKTY3mC9y
         Tclh6muEbkAhV1urqwnwleD44gicwLSqXN3Qd4x2mPszcUoCh01I1B00BK6uQQFg65
         nRQT+ah4p7QA6pqOJDVt6/F+8wjHBxv7I3ayIwiJxLNEDcmFFiu/l0BA+x8fV1nB8B
         HXa2wOqS7rFbgyqCIJNOryeIjDDSp37q+y1GR1UZ7rrAvhOwc9xsPCBmo650+CAG4z
         izC2zd0MVTmgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Sony IMX274 Y_OUT_SIZE should be the height of effective
image output from the sensor which are the actual total lines
sent over MIPI CSI to receiver.

So, Y_OUT_SIZE should be same as crop height and this patch fixes it.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/media/i2c/imx274.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index 6011cec..a4b9dfd 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -1163,7 +1163,7 @@ static int imx274_apply_trimming(struct stimx274 *imx274)
 		(-imx274->crop.top / 2) : (imx274->crop.top / 2);
 	v_cut = (IMX274_MAX_HEIGHT - imx274->crop.height) / 2;
 	write_v_size = imx274->crop.height + 22;
-	y_out_size   = imx274->crop.height + 14;
+	y_out_size   = imx274->crop.height;
 
 	err = imx274_write_mbreg(imx274, IMX274_HMAX_REG_LSB, hmax, 2);
 	if (!err)
-- 
2.7.4

