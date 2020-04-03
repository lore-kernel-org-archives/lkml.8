Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A89CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70758206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2WSo8DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgDCUIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:08:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727958AbgDCUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585944496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKsSricBHipqeqS0u1MchokqfR4S8U9l6GCrFWtjiM4=;
        b=F2WSo8DKZDYnuAWIbiYKD4HpWrtyUfKiqkZwpGETq7LpeN2FrwMzCv87H5LbQbMOhQJ3g/
        bAi7+1tCkyieV9nUqmdc0HxFV8HX0iAt9UEeSNf1qb096ul/OHILEW/h6B9Ypk0zdrKXQN
        k3kH0Qb45lA1gJPX5/H065xZr0bLvpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-vyb4GsmyMQaIUUh3H_ynEA-1; Fri, 03 Apr 2020 16:08:14 -0400
X-MC-Unique: vyb4GsmyMQaIUUh3H_ynEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1752E8017CE;
        Fri,  3 Apr 2020 20:08:13 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-117-203.rdu2.redhat.com [10.10.117.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AC615C541;
        Fri,  3 Apr 2020 20:08:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/dp_mst: Print errors on ACT timeouts
Date:   Fri,  3 Apr 2020 16:07:56 -0400
Message-Id: <20200403200757.886443-5-lyude@redhat.com>
In-Reply-To: <20200403200757.886443-1-lyude@redhat.com>
References: <20200403200757.886443-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although it's not unexpected for drm_dp_check_act_status() to fail due
to DPCD read failures (as the hub may have just been unplugged
suddenly), timeouts are a bit more worrying as they either mean we need
a longer timeout value, or we aren't setting up payload allocations
properly. So, let's start printing errors on timeouts.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index f313407374ed..3d0d373f6f91 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4494,6 +4494,10 @@ int drm_dp_check_act_status(struct drm_dp_mst_topo=
logy_mgr *mgr)
 					DP_PAYLOAD_TABLE_UPDATE_STATUS,
 					&status);
 		if (ret < 0) {
+			/*
+			 * Failure here isn't unexpected - the hub may have
+			 * just been unplugged
+			 */
 			DRM_DEBUG_KMS("failed to read payload table status %d\n",
 				      ret);
 			return ret;
@@ -4505,8 +4509,8 @@ int drm_dp_check_act_status(struct drm_dp_mst_topol=
ogy_mgr *mgr)
 	} while (jiffies < timeout);
=20
 	if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
-		DRM_DEBUG_KMS("failed to get ACT bit %d after %dms\n",
-			      status, timeout_ms);
+		DRM_ERROR("Failed to get ACT after %dms, last status: %02x\n",
+			  timeout_ms, status);
 		return -EINVAL;
 	}
 	return 0;
--=20
2.25.1

