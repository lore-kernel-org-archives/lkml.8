Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6AAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1954720829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825601;
	bh=Uegwi40m6VKoo3qYz46wXwuY83tyEhWX7RHlaRpzbXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HgSnvG5FmFOV1AV3XOp36le8M7G8LTUu0095o6uMQfQ7E0H4pmzTHAt4WAFah5Y+n
	 yNniAgFGYpeynJqghJ+VTWLwK68RVsgrxzvIdxx6K2orrbSnWUxXpC3j9tmuQTvI9e
	 SNQpivPFdwoXoG5O5fPfWwbsCCE3AubWwg8Npb+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbgERSNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732498AbgERSCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:02:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D862086A;
        Mon, 18 May 2020 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824941;
        bh=Uegwi40m6VKoo3qYz46wXwuY83tyEhWX7RHlaRpzbXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zfBff8ZEQg1QohqnCS7yWAtSILvFmsPMWXArok+l6meqeMr+Q0x96O0rOOxf9Lj4d
         iyGq2WLK4D3ZiBDCM8ZkoXozgoLYtTed5ryKTvEBTgc9okzczruvJoRlzUTXpbEWnv
         mmAtJAta05eKToveP7C85axeVPxHiJgh5lEE5e6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 065/194] drm/qxl: lost qxl_bo_kunmap_atomic_page in qxl_image_init_helper()
Date:   Mon, 18 May 2020 19:35:55 +0200
Message-Id: <20200518173537.137141979@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 5b5703dbafae74adfbe298a56a81694172caf5e6 ]

v2: removed TODO reminder

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Link: http://patchwork.freedesktop.org/patch/msgid/a4e0ae09-a73c-1c62-04ef-3f990d41bea9@virtuozzo.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/qxl/qxl_image.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
index 43688ecdd8a04..60ab7151b84dc 100644
--- a/drivers/gpu/drm/qxl/qxl_image.c
+++ b/drivers/gpu/drm/qxl/qxl_image.c
@@ -212,7 +212,8 @@ qxl_image_init_helper(struct qxl_device *qdev,
 		break;
 	default:
 		DRM_ERROR("unsupported image bit depth\n");
-		return -EINVAL; /* TODO: cleanup */
+		qxl_bo_kunmap_atomic_page(qdev, image_bo, ptr);
+		return -EINVAL;
 	}
 	image->u.bitmap.flags = QXL_BITMAP_TOP_DOWN;
 	image->u.bitmap.x = width;
-- 
2.20.1



