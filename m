Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A492C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F59206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587049315;
	bh=fpNrlUUTJSSi/PQgLIPLo6vQitr48svphV9IQte/vuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v4yC8NyRiuucN25GvCclhFBEfUexGE6uzOljzlUKmqFG6/85FURd98ExqAynhWhqn
	 OX7uFNdghzL3QRjq3ih1SMBFxjiTDtAABJ9xHAm9QP23kM6gRV0k7eexQeAQre9QmO
	 /wzasYsYif+br4kiW4VjD+OF/3RoTpPUw0T9bqcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409382AbgDPPBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408077AbgDPNyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:54:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863CA2076D;
        Thu, 16 Apr 2020 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045254;
        bh=fpNrlUUTJSSi/PQgLIPLo6vQitr48svphV9IQte/vuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzPgZpUIoBWh+C44cDJvJ5jpPORKSVmdEkEJL+pWFFNrHsYx19X+GroAHB3u65E3Z
         kP7yVi+etXDl75Vx86CSU4N5jyes2H/Lw5w6hjqeeBYauz+eazJCU5hbgSAp9ysiAR
         bfRs+PHkGCuxRVnRe/tMX0i7OTFIjMiDBzGIXd2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 008/254] media: staging: rkisp1: use consistent bus_info string for media_dev
Date:   Thu, 16 Apr 2020 15:21:37 +0200
Message-Id: <20200416131326.784707488@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

[ Upstream commit 12d3d8090bc5e8cdda2f56caed2a2a0d70009456 ]

Media device is using a slightly different bus_info string
"platform: rkisp1" (with a space) instead of "platform:rkisp1" used by
the rest of rkisp1 code.
This causes errors when using v4l2-util tools that uses the bus_info
string to identify the device.

Fixes: d65dd85281fb ("media: staging: rkisp1: add Rockchip ISP1 base driver")
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rkisp1/rkisp1-dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-dev.c b/drivers/staging/media/rkisp1/rkisp1-dev.c
index 558126e66465c..9b47f41b36e94 100644
--- a/drivers/staging/media/rkisp1/rkisp1-dev.c
+++ b/drivers/staging/media/rkisp1/rkisp1-dev.c
@@ -502,8 +502,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 	strscpy(rkisp1->media_dev.model, RKISP1_DRIVER_NAME,
 		sizeof(rkisp1->media_dev.model));
 	rkisp1->media_dev.dev = &pdev->dev;
-	strscpy(rkisp1->media_dev.bus_info,
-		"platform: " RKISP1_DRIVER_NAME,
+	strscpy(rkisp1->media_dev.bus_info, RKISP1_BUS_INFO,
 		sizeof(rkisp1->media_dev.bus_info));
 	media_device_init(&rkisp1->media_dev);
 
-- 
2.20.1



