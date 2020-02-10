Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0EDC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182C420733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgKtBnK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJLiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:38:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbgBJLiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581334680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=2ZushtPj0Mf6FOFUwvlbWGwy1n8DO8RBRToVDjY41Ks=;
        b=AgKtBnK8yszwvl0J6YlHLu1qK2P9xNFtCiH55dfCvDto8UmtvpKCY6FS1i9x4laMz19Ls7
        koCvWag0ZF5vwmx2ds4/gjiUV8KWjSh7RrzpFyH84Qr9sahDVmw6Zj7FFTiwfJodGKv/bc
        ZN1EoE/19+6RslQjdGylHcWvD0jtwqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-2_OboHYZMlyNc_yP1VF34w-1; Mon, 10 Feb 2020 06:37:58 -0500
X-MC-Unique: 2_OboHYZMlyNc_yP1VF34w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75B62477;
        Mon, 10 Feb 2020 11:37:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29495D9C9;
        Mon, 10 Feb 2020 11:37:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 265949D1E; Mon, 10 Feb 2020 12:37:53 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/qxl: reorder calls in qxl_device_fini().
Date:   Mon, 10 Feb 2020 12:37:51 +0100
Message-Id: <20200210113753.5614-2-kraxel@redhat.com>
In-Reply-To: <20200210113753.5614-1-kraxel@redhat.com>
References: <20200210113753.5614-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder calls in qxl_device_fini().  Cleaning up gem & ttm
might trigger qxl commands, so we should do that before
releaseing command rings.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_kms.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index bfc1631093e9..70b20ee4741a 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -299,12 +299,12 @@ void qxl_device_fini(struct qxl_device *qdev)
 {
 	qxl_bo_unref(&qdev->current_release_bo[0]);
 	qxl_bo_unref(&qdev->current_release_bo[1]);
-	flush_work(&qdev->gc_work);
-	qxl_ring_free(qdev->command_ring);
-	qxl_ring_free(qdev->cursor_ring);
-	qxl_ring_free(qdev->release_ring);
 	qxl_gem_fini(qdev);
 	qxl_bo_fini(qdev);
+	flush_work(&qdev->gc_work);
+	qxl_ring_free(qdev->command_ring);
+	qxl_ring_free(qdev->cursor_ring);
+	qxl_ring_free(qdev->release_ring);
 	io_mapping_free(qdev->surface_mapping);
 	io_mapping_free(qdev->vram_mapping);
 	iounmap(qdev->ram_header);
-- 
2.18.1

