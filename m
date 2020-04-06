Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7002AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497BA206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1GhoI9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDFTeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:34:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20008 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbgDFTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586201650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BSgez8GiaPB88s5mIg8AyQPW/mDw6g5wVL3NjzNhkP8=;
        b=R1GhoI9D+CL1pYmwVal4mEzRU4RnkHKqp3zI50Ayi2pUz91q15YoMi7/qkYnnl/mcuGDCc
        U541Z3Z5IrVUkktlB6vSsb/UZOCI8XMoe4ob9XJWeOet5KZRm35Zex+CuWvluev6mLXQNJ
        EJd0JO+VaqkQhU+Zi3ZoPBkruia8ukw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-7sVfS2VFNe6hrJBroCNwkQ-1; Mon, 06 Apr 2020 15:34:07 -0400
X-MC-Unique: 7sVfS2VFNe6hrJBroCNwkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12EE0190B2A0;
        Mon,  6 Apr 2020 19:34:02 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-117-12.rdu2.redhat.com [10.10.117.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A7E962697;
        Mon,  6 Apr 2020 19:33:59 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Wayne Lin <Wayne.Lin@amd.com>, Wayne Lin <waynelin@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp_mst: Fix NULL deref in drm_dp_get_one_sb_msg()
Date:   Mon,  6 Apr 2020 15:33:52 -0400
Message-Id: <20200406193352.1245985-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we don't need this function to store an mstb anywhere for UP
requests since we process them asynchronously, we do need to make sure
that we don't try to write to **mstb for UP requests otherwise we'll
cause a NULL pointer deref:

    RIP: 0010:drm_dp_get_one_sb_msg+0x4b/0x460 [drm_kms_helper]
    Call Trace:
     ? vprintk_emit+0x16a/0x230
     ? drm_dp_mst_hpd_irq+0x133/0x1010 [drm_kms_helper]
     drm_dp_mst_hpd_irq+0x133/0x1010 [drm_kms_helper]
     ? __drm_dbg+0x87/0x90 [drm]
     ? intel_dp_hpd_pulse+0x24b/0x400 [i915]
     intel_dp_hpd_pulse+0x24b/0x400 [i915]
     i915_digport_work_func+0xd6/0x160 [i915]
     process_one_work+0x1a9/0x370
     worker_thread+0x4d/0x3a0
     kthread+0xf9/0x130
     ? process_one_work+0x370/0x370
     ? kthread_park+0x90/0x90
     ret_from_fork+0x35/0x40

So, fix this.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: fbc821c4a506 ("drm/mst: Support simultaneous down replies")
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Wayne Lin <waynelin@amd.com>
Cc: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 1ff49547b2e8..8751278b3941 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3703,7 +3703,8 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst=
_topology_mgr *mgr, bool up,
 	int basereg =3D up ? DP_SIDEBAND_MSG_UP_REQ_BASE :
 			   DP_SIDEBAND_MSG_DOWN_REP_BASE;
=20
-	*mstb =3D NULL;
+	if (!up)
+		*mstb =3D NULL;
 	*seqno =3D -1;
=20
 	len =3D min(mgr->max_dpcd_transaction_bytes, 16);
--=20
2.25.1

