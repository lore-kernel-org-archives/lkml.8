Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D3BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DE4208A9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNKskWGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHYTve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:51:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51285 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726619AbgHYTvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598385082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DjOACk7+sj9DOgLuw8r03ZTGhj9N7xxOv/mPD0g7leg=;
        b=QNKskWGXtKlj3M4JRu/o4q6v4/8a+eFk0S1bf9hgZp+XI8h/RtelI8ok4N5hFCu4uRHvdq
        ipMYNwPxEcUtBYwdKUmHPklMAoS6wXtAuUVmHaHa2le4zMnq8LE0DsoLoxDY7KBAj4HdfX
        Nufgxc6tjpLjfVxckt4ydf9d+ETS13E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-QU7l26KmMSyEh_jOWaA2_A-1; Tue, 25 Aug 2020 15:51:18 -0400
X-MC-Unique: QU7l26KmMSyEh_jOWaA2_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 260BA80EF8C;
        Tue, 25 Aug 2020 19:51:17 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-227.rdu2.redhat.com [10.10.120.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 694DC5D9D3;
        Tue, 25 Aug 2020 19:51:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v4 11/20] drm/nouveau/kms: Move drm_dp_cec_unset_edid() into nouveau_connector_detect()
Date:   Tue, 25 Aug 2020 15:50:18 -0400
Message-Id: <20200825195027.74681-12-lyude@redhat.com>
In-Reply-To: <20200825195027.74681-1-lyude@redhat.com>
References: <20200825195027.74681-1-lyude@redhat.com>
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

