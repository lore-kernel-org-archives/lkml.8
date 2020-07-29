Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1116C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F22720838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKiB/NQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgG2VhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:37:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727824AbgG2VhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596058636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhkCWwPB9RkgFRVKaewK6/9aoLErXC4RnUkvrrja2Pw=;
        b=fKiB/NQJftA5RUH0ded5GHzlhPqErXXPhHfpzcUfoUrTM/0EnFee94qw6E1zVMKRWGqmvB
        Sx3mfki6nqEy3wzhnYKYeJX0PlMUiZvzI6fUFM0YhBOkGYP+okqWOi3TyPvGhLQXJImErm
        BAqNMnSnKleRVW9S1TiHwSvjSqAklZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-GtqNS00LNMKFdWOJ8hygRQ-1; Wed, 29 Jul 2020 17:37:12 -0400
X-MC-Unique: GtqNS00LNMKFdWOJ8hygRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4E1A1005504;
        Wed, 29 Jul 2020 21:37:10 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-146.rdu2.redhat.com [10.10.119.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9E9A60C84;
        Wed, 29 Jul 2020 21:37:08 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Karol Herbst <kherbst@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/9] drm/nouveau/kms: Handle -EINPROGRESS in nouveau_connector_hotplug()
Date:   Wed, 29 Jul 2020 17:36:55 -0400
Message-Id: <20200729213703.119137-2-lyude@redhat.com>
In-Reply-To: <20200729213703.119137-1-lyude@redhat.com>
References: <20200729213703.119137-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like that we forgot to handle -EINPROGRESS being returned by
pm_runtime_get(), which can happen if multiple callers try to
asynchronously resume the GPU before it wakes up. This is perfectly
normal and OK, so fix this by treating -EINPROGRESS as success.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 3e1a12754d4d ("drm/nouveau: Fix deadlocks in nouveau_connector_detect()")
Cc: stable@vger.kernel.org
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.19+
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 7674025a4bfe8..38e226b8cfd05 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1173,7 +1173,7 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
 	}
 
 	ret = pm_runtime_get(drm->dev->dev);
-	if (ret == 0) {
+	if (ret == 0 || ret == -EINPROGRESS) {
 		/* We can't block here if there's a pending PM request
 		 * running, as we'll deadlock nouveau_display_fini() when it
 		 * calls nvif_put() on our nvif_notify struct. So, simply
-- 
2.26.2

