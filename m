Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FEC207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OP9Jakpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgG2VhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:37:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24195 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727867AbgG2VhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596058641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ni+bhhrvnhO+vPSmEBRMLPrBAn7VL14+CgNJhQOWM7U=;
        b=OP9JakpxZR3xjCQhaU/82CzA8phKSleWe3gzsddoxyL5NM5ScjN8p3sSXocY7QkYgRSqP7
        ygNRfCQkCKw/GRuh8k50f2d+5S7XTlJzV4Y6FG/P997OeZrA4y+X+RiRLTNbg0pJr9/D/J
        PtMlkexJRqjGQ5rVLRJRGCIieU0m83I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-W7gAal89OdORW5FgRep-Dg-1; Wed, 29 Jul 2020 17:37:19 -0400
X-MC-Unique: W7gAal89OdORW5FgRep-Dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47FC391270;
        Wed, 29 Jul 2020 21:37:18 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-146.rdu2.redhat.com [10.10.119.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CA6D619B5;
        Wed, 29 Jul 2020 21:37:17 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/9] drm/nouveau/kms: Invert conditionals in nouveau_display_acpi_ntfy()
Date:   Wed, 29 Jul 2020 17:37:01 -0400
Message-Id: <20200729213703.119137-8-lyude@redhat.com>
In-Reply-To: <20200729213703.119137-1-lyude@redhat.com>
References: <20200729213703.119137-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes here, just a drive-by cleanup.

Signed-off-by: Lyude Paul <lyude@redhat.com>
[cc'd to stable since the next fix needs this patch to apply]
Fixes: 79e765ad665d ("drm/nouveau/drm/nouveau: Prevent handling ACPI HPD events too early")
Cc: stable@vger.kernel.org
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.19+
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 50 +++++++++++------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index cdc5a2200f95e..96c9e7f550537 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -457,34 +457,32 @@ nouveau_display_acpi_ntfy(struct notifier_block *nb, unsigned long val,
 	struct acpi_bus_event *info = data;
 	int ret;
 
-	if (!strcmp(info->device_class, ACPI_VIDEO_CLASS)) {
-		if (info->type == ACPI_VIDEO_NOTIFY_PROBE) {
-			ret = pm_runtime_get(drm->dev->dev);
-			if (ret == 1 || ret == -EACCES) {
-				/* If the GPU is already awake, or in a state
-				 * where we can't wake it up, it can handle
-				 * it's own hotplug events.
-				 */
-				pm_runtime_put_autosuspend(drm->dev->dev);
-			} else if (ret == 0) {
-				/* This may be the only indication we receive
-				 * of a connector hotplug on a runtime
-				 * suspended GPU, schedule hpd_work to check.
-				 */
-				NV_DEBUG(drm, "ACPI requested connector reprobe\n");
-				schedule_work(&drm->hpd_work);
-				pm_runtime_put_noidle(drm->dev->dev);
-			} else {
-				NV_WARN(drm, "Dropped ACPI reprobe event due to RPM error: %d\n",
-					ret);
-			}
-
-			/* acpi-video should not generate keypresses for this */
-			return NOTIFY_BAD;
-		}
+	if (strcmp(info->device_class, ACPI_VIDEO_CLASS) ||
+	    info->type != ACPI_VIDEO_NOTIFY_PROBE)
+		return NOTIFY_DONE;
+
+	ret = pm_runtime_get(drm->dev->dev);
+	if (ret == 1 || ret == -EACCES) {
+		/* If the GPU is already awake, or in a state
+		 * where we can't wake it up, it can handle
+		 * it's own hotplug events.
+		 */
+		pm_runtime_put_autosuspend(drm->dev->dev);
+	} else if (ret == 0) {
+		/* This may be the only indication we receive
+		 * of a connector hotplug on a runtime
+		 * suspended GPU, schedule hpd_work to check.
+		 */
+		NV_DEBUG(drm, "ACPI requested connector reprobe\n");
+		schedule_work(&drm->hpd_work);
+		pm_runtime_put_noidle(drm->dev->dev);
+	} else {
+		NV_WARN(drm, "Dropped ACPI reprobe event due to RPM error: %d\n",
+			ret);
 	}
 
-	return NOTIFY_DONE;
+	/* acpi-video should not generate keypresses for this */
+	return NOTIFY_BAD;
 }
 #endif
 
-- 
2.26.2

