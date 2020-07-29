Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847FAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610CC207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctMqLb+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgG2Vh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:37:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59992 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727867AbgG2Vh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596058645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JQ8H1qRxbeXJCsAhz3cMJuwqIVhTmvjHZPRWUqAC/M=;
        b=ctMqLb+1hRhWmniNszp+QXTQrdJQFi4Rkrj3D0mxpHBwO1Efpyb1vQfYYMc/XFkt+7meBe
        EU3edq9drgnmmHm9+Ljja6Bgg4dpdo51CHKCGROBfizha/UB0lC/l7pEI39FpM1IchR6XI
        fCw9VcX3IGFK19HW5e2CO1bgUMbKrFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-4TTm5EAfO5GE5eT5ojlLqQ-1; Wed, 29 Jul 2020 17:37:21 -0400
X-MC-Unique: 4TTm5EAfO5GE5eT5ojlLqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DD9191271;
        Wed, 29 Jul 2020 21:37:20 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-146.rdu2.redhat.com [10.10.119.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFF3B61176;
        Wed, 29 Jul 2020 21:37:19 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 9/9] drm/nouveau/kms: Handle -EINPROGRESS in nouveau_display_acpi_ntfy()
Date:   Wed, 29 Jul 2020 17:37:03 -0400
Message-Id: <20200729213703.119137-10-lyude@redhat.com>
In-Reply-To: <20200729213703.119137-1-lyude@redhat.com>
References: <20200729213703.119137-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't an error, this just means there's multiple asynchronous
resume requests going at the same time. Treat it like a success.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 79e765ad665d ("drm/nouveau/drm/nouveau: Prevent handling ACPI HPD events too early")
Cc: stable@vger.kernel.org
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.19+
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index ad63d4f052deb..691bb8d37759e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -462,10 +462,10 @@ nouveau_display_acpi_ntfy(struct notifier_block *nb, unsigned long val,
 		return NOTIFY_DONE;
 
 	ret = pm_runtime_get(drm->dev->dev);
-	if (ret == 1 || ret == -EACCES) {
-		/* If the GPU is already awake, or in a state
-		 * where we can't wake it up, it can handle
-		 * it's own hotplug events.
+	if (ret == 1 || ret == -EACCES || ret == -EINPROGRESS) {
+		/* If the GPU is already awake, is waking up, or is in a state
+		 * where we can't wake it up, it can handle its own hotplug
+		 * events.
 		 */
 		pm_runtime_put_autosuspend(drm->dev->dev);
 	} else if (ret == 0) {
-- 
2.26.2

