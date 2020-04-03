Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10A9C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A94206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDaWEnWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgDCUI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:08:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46622 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbgDCUIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585944491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMriJrQ1riXNc8bvUY/SAdc3wYKQUG6oet7C9PfKLgg=;
        b=VDaWEnWaHywJsluI3ZyD/K3Gl26vLkh84/Lrf/M8TtVSQjoW1efsdd4KFjfoI/5aw4vpta
        9qQRYDJSSnFX0z9V7qQf8oSss6NekdtiJa5syddTCGp4fU8Ya9fOrGqje8EtHe6E3GSyvp
        +RuyqUVBqitNPu+rNpJwoAR4KjD/uAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-fQ1kpNknOHOzZ_y8xkbZXw-1; Fri, 03 Apr 2020 16:08:07 -0400
X-MC-Unique: fQ1kpNknOHOzZ_y8xkbZXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43D3B8017F4;
        Fri,  3 Apr 2020 20:08:06 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-117-203.rdu2.redhat.com [10.10.117.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFA675C64E;
        Fri,  3 Apr 2020 20:08:04 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/dp_mst: Improve kdocs for drm_dp_check_act_status()
Date:   Fri,  3 Apr 2020 16:07:53 -0400
Message-Id: <20200403200757.886443-2-lyude@redhat.com>
In-Reply-To: <20200403200757.886443-1-lyude@redhat.com>
References: <20200403200757.886443-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 10d0315af513..2b9ce965f044 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4462,10 +4462,14 @@ static int drm_dp_dpcd_write_payload(struct drm_d=
p_mst_topology_mgr *mgr,
=20
=20
 /**
- * drm_dp_check_act_status() - Check ACT handled status.
+ * drm_dp_check_act_status() - Polls for ACT handled status.
  * @mgr: manager to use
  *
- * Check the payload status bits in the DPCD for ACT handled completion.
+ * Tries waiting for the MST hub to finish updating it's payload table b=
y
+ * polling for the ACT handled bit.
+ *
+ * Returns:
+ * 0 if the ACT was handled in time, negative error code on failure.
  */
 int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
 {
--=20
2.25.1

