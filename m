Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8276EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9E421739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220989;
	bh=9x8XvY9h/o1zfRSpFKrBJJBJh19ZlO0NhZjtFOmPxg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N/XqhSDx6kkvm6dVpPeRZU52nnnsSyozubUrnfPrLbGSXz/ao0aco6FsTELLwNLad
	 gRHv9t9ZP9GhFj0a986i7pk7cuDw1/OPC1luy7SzxtC6fQXLspavLHIx7hOBb8yzXw
	 v0gvIfWOC9ZNgcfq3bQcnOsGxZYp6Djytx8RaGxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgA1OQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:16:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbgA1OQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:16:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB94D21739;
        Tue, 28 Jan 2020 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220985;
        bh=9x8XvY9h/o1zfRSpFKrBJJBJh19ZlO0NhZjtFOmPxg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gt4qAC3MFC4DcpEAVhjjVS9ragpB/3EcavrUAPF6XdIJfk2NDWyIRmm4mfYYqhL17
         R0XA2V8lKVwwrLc15nVLo3C/CFmk7N51UmmnFvdOklJ2j5Lm/fnesFcmcq8rDDSAkL
         SvtX2gFDj4Co/E32rDPqG5oUgoBGvh7m1qc195GM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 043/271] media: s5p-jpeg: Correct step and max values for V4L2_CID_JPEG_RESTART_INTERVAL
Date:   Tue, 28 Jan 2020 15:03:12 +0100
Message-Id: <20200128135855.860416870@linuxfoundation.org>
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

From: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>

[ Upstream commit 19c624c6b29e244c418f8b44a711cbf5e82e3cd4 ]

This commit corrects max and step values for v4l2 control for
V4L2_CID_JPEG_RESTART_INTERVAL. Max should be 0xffff and step should be 1.
It was found by using v4l2-compliance tool and checking result of
VIDIOC_QUERY_EXT_CTRL/QUERYMENU test.
Previously it was complaining that step was bigger than difference
between max and min.

Fixes: 15f4bc3b1f42 ("[media] s5p-jpeg: Add JPEG controls support")

Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index c89922fb42cef..a63f4eec366eb 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -1963,7 +1963,7 @@ static int s5p_jpeg_controls_create(struct s5p_jpeg_ctx *ctx)
 
 		v4l2_ctrl_new_std(&ctx->ctrl_handler, &s5p_jpeg_ctrl_ops,
 				  V4L2_CID_JPEG_RESTART_INTERVAL,
-				  0, 3, 0xffff, 0);
+				  0, 0xffff, 1, 0);
 		if (ctx->jpeg->variant->version == SJPEG_S5P)
 			mask = ~0x06; /* 422, 420 */
 	}
-- 
2.20.1



