Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96372C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651B92087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592705;
	bh=R4RDt6MB6w6jlYYnXl0Sp5AbezBpq9SsMLs9+AC9t24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PqfjsQ4SlqF4GBO18M328KxgRYA6OQD2YxxpBGU5GI0Hs8SD1nYU4NZAJjOvjMHNk
	 0JXRG23FDwmEE3FzxlFf+mnreakW+0yc6Vgm+A98Qu6iZoOKQItp0WzeXqVMrNVtQd
	 7JiCR5m9Hgg7toupN6thuwZmTDfCs22wl/TMkv/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgIHTSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731140AbgIHQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:02:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFCF823EF1;
        Tue,  8 Sep 2020 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579478;
        bh=R4RDt6MB6w6jlYYnXl0Sp5AbezBpq9SsMLs9+AC9t24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uj2DTWBH77JI6Hk5bvkYkRb3PfVd7aB4c5+8hQxEz6vB06W+B+aDWKTr2+FVQLqIq
         x9eT2iHwkEJDMKTuacMCE7MmZPS76LzLqkyacp4017Lp5suXRE4eD8xYX5Dc6Tq6Zp
         RKyC7bskXGgjz2ME62i++kDv4aesZ2QrbUuA4vTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 077/186] media: cedrus: Add missing v4l2_ctrl_request_hdl_put()
Date:   Tue,  8 Sep 2020 17:23:39 +0200
Message-Id: <20200908152245.381408480@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

[ Upstream commit b30063976f29fc221a99d18d37d22ca035068aa9 ]

The check for a required control in the request was missing a call to
v4l2_ctrl_request_hdl_put() in the error path. Fix it.

Fixes: 50e761516f2b8c ("media: platform: Add Cedrus VPU decoder driver")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index bc27f9430eeb1..7c6b91f0e780a 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -199,6 +199,7 @@ static int cedrus_request_validate(struct media_request *req)
 	struct v4l2_ctrl *ctrl_test;
 	unsigned int count;
 	unsigned int i;
+	int ret = 0;
 
 	list_for_each_entry(obj, &req->objects, list) {
 		struct vb2_buffer *vb;
@@ -243,12 +244,16 @@ static int cedrus_request_validate(struct media_request *req)
 		if (!ctrl_test) {
 			v4l2_info(&ctx->dev->v4l2_dev,
 				  "Missing required codec control\n");
-			return -ENOENT;
+			ret = -ENOENT;
+			break;
 		}
 	}
 
 	v4l2_ctrl_request_hdl_put(hdl);
 
+	if (ret)
+		return ret;
+
 	return vb2_request_validate(req);
 }
 
-- 
2.25.1



