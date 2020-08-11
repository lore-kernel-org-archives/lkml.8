Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF638C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9BA20786
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRCjda59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHKUHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:07:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27901 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726948AbgHKUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597176412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2RiZk4OnV40D+B+CBO8SNNqSCNKf8gxT9xQ710UwP5I=;
        b=iRCjda59fTKJGUqm5/vxySPwtKwfTqdhM5WAzNP0dtHQ05sWU6lMKoxgHHjkVj7TejUaMH
        mgYMTKr1pOQqjgIvsn7r1ChxNc6r5GVMqWYmRAndu0xD6GcEN2EXPTFwRTWs2HyLrZ7kn3
        jzMt2THGRvuw2pmLUcW+KyPgTklcvys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-n8Pp2CcHNxSvRbp3E4RR7Q-1; Tue, 11 Aug 2020 16:06:48 -0400
X-MC-Unique: n8Pp2CcHNxSvRbp3E4RR7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F48F106B246;
        Tue, 11 Aug 2020 20:06:45 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35D525D9D7;
        Tue, 11 Aug 2020 20:06:43 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 16/20] drm/i915/dp: Extract drm_dp_get_sink_count()
Date:   Tue, 11 Aug 2020 16:04:53 -0400
Message-Id: <20200811200457.134743-17-lyude@redhat.com>
In-Reply-To: <20200811200457.134743-1-lyude@redhat.com>
References: <20200811200457.134743-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And of course, we'll also need to read the sink count from other drivers
as well if we're checking whether or not it's supported. So, let's
extract the code for this into another helper.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c         | 20 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 17 +++++------------
 include/drm/drm_dp_helper.h             |  1 +
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 05bb47e589731..0ff2959c8f8e8 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -722,6 +722,26 @@ bool drm_dp_has_sink_count(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_dp_has_sink_count);
 
+/**
+ * drm_dp_get_sink_count() - Retrieve the sink count for a given sink
+ * @aux: The DP AUX channel to use
+ *
+ * Returns: The current sink count reported by @aux, or a negative error code
+ * otherwise.
+ */
+int drm_dp_get_sink_count(struct drm_dp_aux *aux)
+{
+	u8 count;
+	int ret;
+
+	ret = drm_dp_dpcd_readb(aux, DP_SINK_COUNT, &count);
+	if (ret < 1)
+		return -EIO;
+
+	return DP_GET_SINK_COUNT(count);
+}
+EXPORT_SYMBOL(drm_dp_get_sink_count);
+
 /*
  * I2C-over-AUX implementation
  */
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 35a4779a442e2..e343965a483df 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4648,6 +4648,8 @@ intel_dp_has_sink_count(struct intel_dp *intel_dp)
 static bool
 intel_dp_get_dpcd(struct intel_dp *intel_dp)
 {
+	int ret;
+
 	if (!intel_dp_read_dpcd(intel_dp))
 		return false;
 
@@ -4664,20 +4666,10 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
 	}
 
 	if (intel_dp_has_sink_count(intel_dp)) {
-		u8 count;
-		ssize_t r;
-
-		r = drm_dp_dpcd_readb(&intel_dp->aux, DP_SINK_COUNT, &count);
-		if (r < 1)
+		ret = drm_dp_get_sink_count(&intel_dp->aux);
+		if (ret < 0)
 			return false;
 
-		/*
-		 * Sink count can change between short pulse hpd hence
-		 * a member variable in intel_dp will track any changes
-		 * between short pulse interrupts.
-		 */
-		intel_dp->sink_count = DP_GET_SINK_COUNT(count);
-
 		/*
 		 * SINK_COUNT == 0 and DOWNSTREAM_PORT_PRESENT == 1 implies that
 		 * a dongle is present but no display. Unless we require to know
@@ -4685,6 +4677,7 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
 		 * downstream port information. So, an early return here saves
 		 * time from performing other operations which are not required.
 		 */
+		intel_dp->sink_count = ret;
 		if (!intel_dp->sink_count)
 			return false;
 	}
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index a1413a531eaf4..0c141fc81aaa8 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1635,6 +1635,7 @@ struct drm_dp_desc;
 bool drm_dp_has_sink_count(struct drm_connector *connector,
 			   const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 			   const struct drm_dp_desc *desc);
+int drm_dp_get_sink_count(struct drm_dp_aux *aux);
 
 void drm_dp_remote_aux_init(struct drm_dp_aux *aux);
 void drm_dp_aux_init(struct drm_dp_aux *aux);
-- 
2.26.2

