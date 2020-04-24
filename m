Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08085C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3C020857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wn6FFTWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgDXTHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:07:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbgDXTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587755252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2jnvEsORNgR7b9vWe7xevtJyvEa+IeRDZ+hvY7I0CUI=;
        b=Wn6FFTWp6msZXdJAPODbTYfA0uUAvFgIpDv7Nz+j5GFJznzfFNWTc9kaBf3SOaeGl6OLjF
        JqxvlmjHru+lMKLAQ0c5AgdZy9E1RhWklus+JvGCYq9UGI45juJUxZiVvRxcH88CF2vJ5M
        t7DOsbCyfoJuPJXAhvaVkhFzPo7ooco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-RATWQOPrMG61uMefhhjxoA-1; Fri, 24 Apr 2020 15:07:30 -0400
X-MC-Unique: RATWQOPrMG61uMefhhjxoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A487800C78;
        Fri, 24 Apr 2020 19:07:28 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-115-210.rdu2.redhat.com [10.10.115.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7A8460F8D;
        Fri, 24 Apr 2020 19:07:26 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp_mst: Fix drm_dp_send_dpcd_write() return code
Date:   Fri, 24 Apr 2020 15:07:22 -0400
Message-Id: <20200424190722.775284-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_dp_mst_wait_tx_reply() returns > 1 if time elapsed in
wait_event_timeout() before check_txmsg_state(mgr, txmsg) evaluated to
true. However, we make the mistake of returning this time from
drm_dp_send_dpcd_write() on success instead of returning the number of
bytes written - causing spontaneous failures during link probing:

[drm:drm_dp_send_link_address [drm_kms_helper]] *ERROR* GUID check on
10:01 failed: 3975

Yikes! So, fix this by returning the number of bytes written on success
instead.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: cb897542c6d2 ("drm/dp_mst: Fix W=3D1 warnings")
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 03a1496f6120..21dc78cb4ba6 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3436,8 +3436,12 @@ static int drm_dp_send_dpcd_write(struct drm_dp_ms=
t_topology_mgr *mgr,
 	drm_dp_queue_down_tx(mgr, txmsg);
=20
 	ret =3D drm_dp_mst_wait_tx_reply(mstb, txmsg);
-	if (ret > 0 && txmsg->reply.reply_type =3D=3D DP_SIDEBAND_REPLY_NAK)
-		ret =3D -EIO;
+	if (ret > 0) {
+		if (txmsg->reply.reply_type =3D=3D DP_SIDEBAND_REPLY_NAK)
+			ret =3D -EIO;
+		else
+			ret =3D size;
+	}
=20
 	kfree(txmsg);
 fail_put:
--=20
2.25.3

