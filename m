Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAAAC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3F02070E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpKEoj7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgCFXts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:49:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727599AbgCFXtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583538571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epJiNHcNlXrU/mKy0Mc+3UqF6n++TRVvv4Ahu8/c3RY=;
        b=SpKEoj7SmwtkZnVHqDZlAGWzzva05/4J5qP7uD1j/HA1YVld4j2ydiAlJKAO9v/PBRA+KL
        ZEaxTxmsDqmo31+s6sD/W2rUvyeYlj6Ck77MBUZDVDKcksTkfORdIXH6wtpim1FIoPr5tl
        ZhBS/JbNs023H3AS4gqqoixrwGd7mAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-yc73RDNVM--k6bO1k8rr2A-1; Fri, 06 Mar 2020 18:49:29 -0500
X-MC-Unique: yc73RDNVM--k6bO1k8rr2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D92D48010E8;
        Fri,  6 Mar 2020 23:49:27 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E96491D7A;
        Fri,  6 Mar 2020 23:49:26 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Francis <David.Francis@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/dp_mst: Make drm_dp_mst_dpcd_write() consistent with drm_dp_dpcd_write()
Date:   Fri,  6 Mar 2020 18:49:21 -0500
Message-Id: <20200306234923.547873-2-lyude@redhat.com>
In-Reply-To: <20200306234923.547873-1-lyude@redhat.com>
References: <20200306234923.547873-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while having some problems with hubs sometimes not being
detected on the first plug. Every single dpcd read or write function
returns the number of bytes transferred on success or a negative error
code, except apparently for drm_dp_mst_dpcd_write() - which returns 0 on
success.

There's not really any good reason for this difference that I can tell,
and having the two functions give differing behavior means that
drm_dp_dpcd_write() will end up returning 0 on success for MST devices,
but the number of bytes transferred for everything else.

So, fix that and update the kernel doc.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 2f221a5efed4 ("drm/dp_mst: Add MST support to DP DPCD R/W function=
s")
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 6c62ad8f4414..e421c2d13267 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2063,7 +2063,7 @@ ssize_t drm_dp_mst_dpcd_read(struct drm_dp_aux *aux=
,
  * sideband messaging as drm_dp_dpcd_write() does for local
  * devices via actual AUX CH.
  *
- * Return: 0 on success, negative error code on failure.
+ * Return: number of bytes written on success, negative error code on fa=
ilure.
  */
 ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux *aux,
 			      unsigned int offset, void *buffer, size_t size)
@@ -3428,12 +3428,9 @@ static int drm_dp_send_dpcd_write(struct drm_dp_ms=
t_topology_mgr *mgr,
 	drm_dp_queue_down_tx(mgr, txmsg);
=20
 	ret =3D drm_dp_mst_wait_tx_reply(mstb, txmsg);
-	if (ret > 0) {
-		if (txmsg->reply.reply_type =3D=3D DP_SIDEBAND_REPLY_NAK)
-			ret =3D -EIO;
-		else
-			ret =3D 0;
-	}
+	if (ret > 0 && txmsg->reply.reply_type =3D=3D DP_SIDEBAND_REPLY_NAK)
+		ret =3D -EIO;
+
 	kfree(txmsg);
 fail_put:
 	drm_dp_mst_topology_put_mstb(mstb);
--=20
2.24.1

