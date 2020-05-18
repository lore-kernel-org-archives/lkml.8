Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8012CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BB520835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823607;
	bh=hrN4jo85YX8bUHMiL0SJw51uMtj6bE77uz+J0atkXvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tRAwwo66aLhFxTFqN4K/x4OvoonhKnpI7TpujT72QRUKFK/WL24SC8x5ByF85VBBp
	 NnkF6x38n5tPUWuSjPwfEjbRPrJx/tL9L8PenttRc0E7haJmJcnDtLDRgfnPOLGmDv
	 3dI4LxqZzaQOzRMDS/p7Jp6V5wR0Yeolh7sOALew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgERRkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbgERRj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:39:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82B72086A;
        Mon, 18 May 2020 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823598;
        bh=hrN4jo85YX8bUHMiL0SJw51uMtj6bE77uz+J0atkXvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sO4chUVCWxUPo2SuA1tlol2k9+SUYwImgZzdCXp/wt4hToriQRPvpD+UCQH1pUHDu
         zCFY2D7zviBwm5a3wFcty6PPPuFYfzNgtV0CJ7R6wZUgt5WI3YMbfsIPPCBX+uDZ1D
         j8Pueh54EtkvBWdNg+xz4brnMsMLVCJvL9hDHztQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 45/86] drm/qxl: lost qxl_bo_kunmap_atomic_page in qxl_image_init_helper()
Date:   Mon, 18 May 2020 19:36:16 +0200
Message-Id: <20200518173459.716638047@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
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
index 7fbcc35e8ad35..c89c10055641e 100644
--- a/drivers/gpu/drm/qxl/qxl_image.c
+++ b/drivers/gpu/drm/qxl/qxl_image.c
@@ -210,7 +210,8 @@ qxl_image_init_helper(struct qxl_device *qdev,
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



