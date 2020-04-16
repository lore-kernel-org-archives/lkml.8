Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945B021D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587049524;
	bh=CImT4A8W+bDgMXzHhYQ9uztQmGjlbf3XrDJF5jnPrRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tkt0O+Bml72ENXIJmP3bl/cvYlt77SugMaK9wNooWN0NXu4fQ4oMbYLY/qQIrg7eL
	 tjCOMlGEaCySm0EBVb6N2R156Rt3GAhB13kFX6Fbl/KV1y4U0Uzno+9DDeIJ0kcn3O
	 PIB8ALIvOphTGtXi4QyJaJYx3TU1b6TyhW6XpZZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394862AbgDPPFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441685AbgDPNwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:52:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C30F72063A;
        Thu, 16 Apr 2020 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045161;
        bh=CImT4A8W+bDgMXzHhYQ9uztQmGjlbf3XrDJF5jnPrRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSVxdG1hxQH92HQlhVnBteg5VXNHcqAUQAaSdlMmLLKJAnnShkyblv34UN8k4M9BX
         TbSs6Avv6XMpqQe0wnG3p2E3KBZXktSaCJgyZ2SttznjOLIsaVJps5Xgv+W/2ubfTh
         cttbewUBIxt27aB3VpXkPQI7gkMwMtBGS/qyCqgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 022/254] media: imx: imx7_mipi_csis: Power off the source when stopping streaming
Date:   Thu, 16 Apr 2020 15:21:51 +0200
Message-Id: <20200416131328.594360724@linuxfoundation.org>
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

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 770cbf89f90b0663499dbb3f03aa81b3322757ec ]

The .s_stream() implementation incorrectly powers on the source when
stopping the stream. Power it off instead.

Fixes: 7807063b862b ("media: staging/imx7: add MIPI CSI-2 receiver subdev for i.MX7")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index 383abecb3bec0..0053e8b0b88e5 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -577,7 +577,7 @@ static int mipi_csis_s_stream(struct v4l2_subdev *mipi_sd, int enable)
 		state->flags |= ST_STREAMING;
 	} else {
 		v4l2_subdev_call(state->src_sd, video, s_stream, 0);
-		ret = v4l2_subdev_call(state->src_sd, core, s_power, 1);
+		ret = v4l2_subdev_call(state->src_sd, core, s_power, 0);
 		mipi_csis_stop_stream(state);
 		state->flags &= ~ST_STREAMING;
 		if (state->debug)
-- 
2.20.1



