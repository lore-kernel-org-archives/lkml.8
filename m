Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F94C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E6020716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693046;
	bh=NC2wQCkyKXqJ+OccUDOoa9h1+j4lhGQf6dnygT8nk94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fR/1VufH2rpLl4DGvP7GG/phyywd5sn5AXFJXilP99L09xsd7rv6SiemdPcxlS+k6
	 DFax4HWH6AvANikERC7Q9J/ZgcD4t8hcy1ANawPesAWNM4EawpqQbo37lUC4AklOSr
	 FvKLN6A4hDXHtL5cBdvYIL8bWRtT21nDbyaihMJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgHQThZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbgHQP1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:27:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC17205CB;
        Mon, 17 Aug 2020 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678068;
        bh=NC2wQCkyKXqJ+OccUDOoa9h1+j4lhGQf6dnygT8nk94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoaOZ+K0y6kZMT3n8Lgopq1IaIFFp2EnLkrt4ydZSPDuNGls/15EOp8wawkxVz9ao
         u8Yen8d+/pPEZS/82eKpG4/k3i0WFLUo+yOOZO952hahC6im+dGLcXXhj/sajQmInw
         l3nV0SXsT98bT+y3krCFQdewkpYwwyTTMCVt/jvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helen Koike <helen.koike@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 207/464] media: staging: rkisp1: rsz: fix resolution limitation on sink pad
Date:   Mon, 17 Aug 2020 17:12:40 +0200
Message-Id: <20200817143843.729819074@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

[ Upstream commit 906dceb48dfa1e7c99c32e6b25878d47023e916b ]

Resizer sink pad is limited by what the ISP can generate.
The configurations describes what the resizer can produce.

This was tested on a Scarlet device with ChromiumOs, where the selfpath
receives 2592x1944 and produces 1600x1200 (which isn't possible without
this fix).

Fixes: 56e3b29f9f6b2 ("media: staging: rkisp1: add streaming paths")
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rkisp1/rkisp1-resizer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-resizer.c b/drivers/staging/media/rkisp1/rkisp1-resizer.c
index d64c064bdb1d2..e188944941b58 100644
--- a/drivers/staging/media/rkisp1/rkisp1-resizer.c
+++ b/drivers/staging/media/rkisp1/rkisp1-resizer.c
@@ -553,11 +553,11 @@ static void rkisp1_rsz_set_sink_fmt(struct rkisp1_resizer *rsz,
 	src_fmt->code = sink_fmt->code;
 
 	sink_fmt->width = clamp_t(u32, format->width,
-				  rsz->config->min_rsz_width,
-				  rsz->config->max_rsz_width);
+				  RKISP1_ISP_MIN_WIDTH,
+				  RKISP1_ISP_MAX_WIDTH);
 	sink_fmt->height = clamp_t(u32, format->height,
-				   rsz->config->min_rsz_height,
-				   rsz->config->max_rsz_height);
+				  RKISP1_ISP_MIN_HEIGHT,
+				  RKISP1_ISP_MAX_HEIGHT);
 
 	*format = *sink_fmt;
 
-- 
2.25.1



