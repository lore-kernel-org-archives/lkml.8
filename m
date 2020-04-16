Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C686BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FBE2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052115;
	bh=gWKi+M4ukqnEuUHDdXxPRoNAqrcK8KTNaaTDcH/tEEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aojq+WMjtpM03JHcAvssQl2BCnh77zX0bvlBfR57DPn0ujbRwx/guUvnQ8QjGOPNw
	 ZGJXNhFgvr5IDPLXChGnLPDekAtlbddTA+E/ZywYgf+vcfFEsoUC4hGqyajAtYQtSh
	 f31WGpZHKHBozjbSHkrVmxoLvARLzJw1M59A7FL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442581AbgDPPsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895523AbgDPNdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:33:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D194221EB;
        Thu, 16 Apr 2020 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043998;
        bh=gWKi+M4ukqnEuUHDdXxPRoNAqrcK8KTNaaTDcH/tEEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JK0nfIseRhXHI9zy12AQjyxIZRyUkCrJ2P0zC4whU77wE0uLZ9n3Mp/rccHwH25C
         hIEO5DFsExolnBnmgoJYdRrKBE/gi1Bjx6/R9sBeWdNCB4hqOm2v/LjwaoxiTZmezp
         ap11LwFeNrQ27Z8PyZlBJZfCIeGUoC9egxjq4peE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 040/257] media: imx: imx7_mipi_csis: Power off the source when stopping streaming
Date:   Thu, 16 Apr 2020 15:21:31 +0200
Message-Id: <20200416131330.947376055@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
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
index 99166afca071b..aa1749b1e28fc 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -579,7 +579,7 @@ static int mipi_csis_s_stream(struct v4l2_subdev *mipi_sd, int enable)
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



