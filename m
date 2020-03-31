Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53D3C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D8A207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+OEVQmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgCaU6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:58:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54280 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728428AbgCaU6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585688291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpM1XxT0yKaKGYgf2gGKRTmepGnz6nJa59IN7BPPkTY=;
        b=f+OEVQmhuu6eWUitWHhzZWqCAQOjC1OMS7D4bYVQWvSEhlngDS1PJltKp77zH7L4rfz4CM
        85gkgBol9YEPRCnVhDW8U9U8rk7Ez/ht846+omo0T9+nufHvN8f+NGTMoMt4T33KqL1fsG
        d5FynTSne/C4+tj3i07upJwryaY1u2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-_8ieoBgKMOu3PpoyXoV6Rw-1; Tue, 31 Mar 2020 16:58:04 -0400
X-MC-Unique: _8ieoBgKMOu3PpoyXoV6Rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B89E6192296B;
        Tue, 31 Mar 2020 20:58:02 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CCE199DE2;
        Tue, 31 Mar 2020 20:58:00 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/dp_mst: Remove drm_dp_mst_topology_cbs.destroy_connector
Date:   Tue, 31 Mar 2020 16:57:37 -0400
Message-Id: <20200331205740.135525-5-lyude@redhat.com>
In-Reply-To: <20200331205740.135525-1-lyude@redhat.com>
References: <20200331205740.135525-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've removed the last user of this callback, get rid of it and
drm_dp_destroy_connector().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 16 +++-------------
 include/drm/drm_dp_mst_helper.h       |  2 --
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 31b7a8f5309d..e235b2b29f59 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4692,23 +4692,13 @@ static void drm_dp_tx_work(struct work_struct *wo=
rk)
 	mutex_unlock(&mgr->qlock);
 }
=20
-static inline void drm_dp_destroy_connector(struct drm_dp_mst_port *port=
)
+static inline void
+drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
 {
-	if (!port->connector)
-		return;
-
-	if (port->mgr->cbs->destroy_connector) {
-		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
-	} else {
+	if (port->connector) {
 		drm_connector_unregister(port->connector);
 		drm_connector_put(port->connector);
 	}
-}
-
-static inline void
-drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
-{
-	drm_dp_destroy_connector(port);
=20
 	drm_dp_port_set_pdt(port, DP_PEER_DEVICE_NONE, port->mcs);
 	drm_dp_mst_put_port_malloc(port);
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_hel=
per.h
index 13461db1444a..7af51c947b81 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -488,8 +488,6 @@ struct drm_dp_mst_topology_mgr;
 struct drm_dp_mst_topology_cbs {
 	/* create a connector for a port */
 	struct drm_connector *(*add_connector)(struct drm_dp_mst_topology_mgr *=
mgr, struct drm_dp_mst_port *port, const char *path);
-	void (*destroy_connector)(struct drm_dp_mst_topology_mgr *mgr,
-				  struct drm_connector *connector);
 };
=20
 #define DP_MAX_PAYLOAD (sizeof(unsigned long) * 8)
--=20
2.25.1

