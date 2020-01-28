Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC556C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8099F21739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222125;
	bh=8orLhuFIKCTmCuHn0jZkptaYn0P8z9slfFmXhwYYDt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fje44qOd9rrz9X6g/4teu3WJybNEpip8w+oMCVR8r5tE69f/ilGrv6f1wX1fhlgV3
	 QQi+4AjOATKZIqfzxgYqm5fY/qhAjD6IzX2MdpWTXCDnNfw9ZwcJRh2MLeR2nytxrF
	 mlJiDDgecSHkJz3Zzw10ypWuwjiL0kOQ5821yZjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbgA1OfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:35:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387502AbgA1OfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:35:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBBC524687;
        Tue, 28 Jan 2020 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580222123;
        bh=8orLhuFIKCTmCuHn0jZkptaYn0P8z9slfFmXhwYYDt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6QxWcj7jg20+wxVrWiXQrDFeuny+JG/x6ZIIbxFS9/NtHgUhaZDvvWx+n6MLjX5p
         iZAXW0x4gtnDzOCCTOytEdf12L78wDuPBK6DvzwtT0o9H73LsO19E2tZ2qxwBSHqIB
         Npb5B7umE41AigLfA82W32jjQwinnkLkc9ignRrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 120/271] media: ov2659: fix unbalanced mutex_lock/unlock
Date:   Tue, 28 Jan 2020 15:04:29 +0100
Message-Id: <20200128135901.524354371@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 384538bda10913e5c94ec5b5d34bd3075931bcf4 ]

Avoid returning with mutex locked.

Fixes: fa8cb6444c32 ("[media] ov2659: Don't depend on subdev API")

Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index ade3c48e2e0cf..18546f950d792 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -1137,7 +1137,7 @@ static int ov2659_set_fmt(struct v4l2_subdev *sd,
 		mf = v4l2_subdev_get_try_format(sd, cfg, fmt->pad);
 		*mf = fmt->format;
 #else
-		return -ENOTTY;
+		ret = -ENOTTY;
 #endif
 	} else {
 		s64 val;
-- 
2.20.1



