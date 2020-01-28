Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D390CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5EC20702
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222405;
	bh=tfwD6ef79rDoiFi7GYGxjXc3Q/jOMh8vwLLV4P+xwt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dRPE88cbiHiNOHM6ZCDD3lcaqs3ff8RxI39mtvLZv/uhbEH3v14ra0OatprWshEID
	 Olyp+GqnlAc1N7jae68JK8skud4q+FApkMY9epjxfjQnO9xSJKuc3lkjvkXWaI3KLZ
	 fo4xSZC2JyGz6gUcQvdyud1CMMJf33JpKhnS3534=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgA1OkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgA1OQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:16:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61DB92071E;
        Tue, 28 Jan 2020 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220982;
        bh=tfwD6ef79rDoiFi7GYGxjXc3Q/jOMh8vwLLV4P+xwt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJUO7raOfS97GVnThevJvGWhC4lUFq7D8TckpbvLNUlH4xuN210KIbaTcO6vPqr3S
         WJlGOi0O0gi7lztp6JNJh5lzGrnPvGOtIMZUkmHr1dy1oohDoV34G63msr6j1/uKHn
         d629lwd2AuiZK+O009+nXfA6ld9Vx4vvkoTbU2A8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 042/271] drm/etnaviv: NULL vs IS_ERR() buf in etnaviv_core_dump()
Date:   Tue, 28 Jan 2020 15:03:11 +0100
Message-Id: <20200128135855.789943960@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f8261c376e7f8cb9024af5a6c54be540c7f9108e ]

The etnaviv_gem_get_pages() never returns NULL.  It returns error
pointers on error.

Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_dump.c b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
index 2bef501d4a172..5af7c2594a79e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_dump.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
@@ -206,7 +206,7 @@ void etnaviv_core_dump(struct etnaviv_gpu *gpu)
 		mutex_lock(&obj->lock);
 		pages = etnaviv_gem_get_pages(obj);
 		mutex_unlock(&obj->lock);
-		if (pages) {
+		if (!IS_ERR(pages)) {
 			int j;
 
 			iter.hdr->data[0] = bomap - bomap_start;
-- 
2.20.1



