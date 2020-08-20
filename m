Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86496C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF98206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKFOgEgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHTSbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727062AbgHTSbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597948262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DjOACk7+sj9DOgLuw8r03ZTGhj9N7xxOv/mPD0g7leg=;
        b=jKFOgEgxtj5zUqejJmkwQq14dnZsegnG6QD0q6k1jYpWqH7qvraW8EqJ9bw0foIYrs7Vic
        XTZdHniF3LVeHJ+zPdqFydPvcCtnZr6TzEXcQa3DVORb+hsJ/Q678ynPOFEADWSbj8kxiS
        J3dQI5vCgcrWAEa4Ez426egMxmZ2/zA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-cfFYDNkeMYet2_en-uCrtw-1; Thu, 20 Aug 2020 14:30:58 -0400
X-MC-Unique: cfFYDNkeMYet2_en-uCrtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52E83186A580;
        Thu, 20 Aug 2020 18:30:57 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-42.rdu2.redhat.com [10.10.120.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97B265DA7E;
        Thu, 20 Aug 2020 18:30:56 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 11/20] drm/nouveau/kms: Move drm_dp_cec_unset_edid() into nouveau_connector_detect()
Date:   Thu, 20 Aug 2020 14:30:03 -0400
Message-Id: <20200820183012.288794-12-lyude@redhat.com>
In-Reply-To: <20200820183012.288794-1-lyude@redhat.com>
References: <20200820183012.288794-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For whatever reason we currently unset the EDID for DP CEC support when
responding to the connector being unplugged, instead of just doing it in
nouveau_connector_detect() where we set the CEC EDID. This isn't really
needed and could even potentially cause us to forget to unset the EDID
if the connector is removed without a corresponding hpd event, so let's
fix that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index b90591114faaf..4a29f691c08e4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -633,10 +633,11 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 			conn_status = connector_status_connected;
 			goto out;
 		}
-
 	}
 
  out:
+	if (!nv_connector->edid)
+		drm_dp_cec_unset_edid(&nv_connector->aux);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1174,8 +1175,6 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
 		return NVIF_NOTIFY_DROP;
 	}
 
-	if (!plugged)
-		drm_dp_cec_unset_edid(&nv_connector->aux);
 	NV_DEBUG(drm, "%splugged %s\n", plugged ? "" : "un", name);
 
 	drm_helper_hpd_irq_event(connector->dev);
-- 
2.26.2

