Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0BBC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AED20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtliMg4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHZS0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:26:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26940 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727080AbgHZSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598466355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ5kpt/WAEIymxMLjU7/mIu1Y5rO6SXEfMby99xIlTM=;
        b=ZtliMg4qAst50+UyCQ5LHLg17aCG8GZtJU8e4paYkna1R77FxWWUlHpOQ04UHGJ5Yu/Qdy
        8v7YQMNP6DCJHJla6yqEb9BsgXPNWK3unjgdiSN+1hCC17zn4T1KFT4JzVOgz4iAPHhc7J
        CGHOM1wKgi/nSNS4aYjAf5tw5ye+eKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-03i35tn7N4WZM9wlukLHow-1; Wed, 26 Aug 2020 14:25:53 -0400
X-MC-Unique: 03i35tn7N4WZM9wlukLHow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D30F7189E618;
        Wed, 26 Aug 2020 18:25:50 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-119-77.rdu2.redhat.com [10.10.119.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E159B100238E;
        Wed, 26 Aug 2020 18:25:48 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Subject: [PATCH v5 13/20] drm/i915/dp: Extract drm_dp_read_downstream_info()
Date:   Wed, 26 Aug 2020 14:24:49 -0400
Message-Id: <20200826182456.322681-14-lyude@redhat.com>
In-Reply-To: <20200826182456.322681-1-lyude@redhat.com>
References: <20200826182456.322681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to be doing the same probing process in nouveau for
determining downstream DP port capabilities, so let's deduplicate the
work by moving i915's code for handling this into a shared helper:
drm_dp_read_downstream_info().

Note that when we do this, we also do make some functional changes while
we're at it:
* We always clear the downstream port info before trying to read it,
  just to make things easier for the caller
* We skip reading downstream port info if the DPCD indicates that we
  don't support downstream port info
* We only read as many bytes as needed for the reported number of
  downstream ports, no sense in reading the whole thing every time

v2:
* Fixup logic for calculating the downstream port length to account for
  the fact that downstream port caps can be either 1 byte or 4 bytes
  long. We can actually skip fixing the max_clock/max_bpc helpers here
  since they all check for DP_DETAILED_CAP_INFO_AVAILABLE anyway.
* Fix ret code check for drm_dp_dpcd_read
v5:
* Change name from drm_dp_downstream_read_info() to
  drm_dp_read_downstream_info()
* Also, add "See Also" sections for the various downstream info
  functions (drm_dp_read_downstream_info(), drm_dp_downstream_max_clock(),
  drm_dp_downstream_max_bpc())

Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>

squash! drm/i915/dp: Extract drm_dp_read_downstream_info()

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c         | 62 ++++++++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_dp.c | 14 +-----
 include/drm/drm_dp_helper.h             |  3 ++
 3 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 4c21cf69dad5a..f3643894ad951 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -423,6 +423,56 @@ bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
 }
 EXPORT_SYMBOL(drm_dp_send_real_edid_checksum);
 
+static u8 drm_dp_downstream_port_count(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	u8 port_count = dpcd[DP_DOWN_STREAM_PORT_COUNT] & DP_PORT_COUNT_MASK;
+
+	if (dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE && port_count > 4)
+		port_count = 4;
+
+	return port_count;
+}
+
+/**
+ * drm_dp_read_downstream_info() - read DPCD downstream port info if available
+ * @aux: DisplayPort AUX channel
+ * @dpcd: A cached copy of the port's DPCD
+ * @downstream_ports: buffer to store the downstream port info in
+ *
+ * See also:
+ * drm_dp_downstream_max_clock()
+ * drm_dp_downstream_max_bpc()
+ *
+ * Returns: 0 if either the downstream port info was read successfully or
+ * there was no downstream info to read, or a negative error code otherwise.
+ */
+int drm_dp_read_downstream_info(struct drm_dp_aux *aux,
+				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
+				u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS])
+{
+	int ret;
+	u8 len;
+
+	memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
+
+	/* No downstream info to read */
+	if (!drm_dp_is_branch(dpcd) ||
+	    dpcd[DP_DPCD_REV] < DP_DPCD_REV_10 ||
+	    !(dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_PRESENT))
+		return 0;
+
+	len = drm_dp_downstream_port_count(dpcd);
+	if (dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE)
+		len *= 4;
+
+	ret = drm_dp_dpcd_read(aux, DP_DOWNSTREAM_PORT_0, downstream_ports, len);
+	if (ret < 0)
+		return ret;
+
+	return ret == len ? 0 : -EIO;
+}
+EXPORT_SYMBOL(drm_dp_read_downstream_info);
+
 /**
  * drm_dp_downstream_max_clock() - extract branch device max
  *                                 pixel rate for legacy VGA
@@ -431,7 +481,11 @@ EXPORT_SYMBOL(drm_dp_send_real_edid_checksum);
  * @dpcd: DisplayPort configuration data
  * @port_cap: port capabilities
  *
- * Returns max clock in kHz on success or 0 if max clock not defined
+ * See also:
+ * drm_dp_read_downstream_info()
+ * drm_dp_downstream_max_bpc()
+ *
+ * Returns: Max clock in kHz on success or 0 if max clock not defined
  */
 int drm_dp_downstream_max_clock(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 				const u8 port_cap[4])
@@ -462,7 +516,11 @@ EXPORT_SYMBOL(drm_dp_downstream_max_clock);
  * @dpcd: DisplayPort configuration data
  * @port_cap: port capabilities
  *
- * Returns max bpc on success or 0 if max bpc not defined
+ * See also:
+ * drm_dp_read_downstream_info()
+ * drm_dp_downstream_max_clock()
+ *
+ * Returns: Max bpc on success or 0 if max bpc not defined
  */
 int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 			      const u8 port_cap[4])
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 4c7314b7a84e4..9c4b806af8c79 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4685,18 +4685,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
 			return false;
 	}
 
-	if (!drm_dp_is_branch(intel_dp->dpcd))
-		return true; /* native DP sink */
-
-	if (intel_dp->dpcd[DP_DPCD_REV] == 0x10)
-		return true; /* no per-port downstream info */
-
-	if (drm_dp_dpcd_read(&intel_dp->aux, DP_DOWNSTREAM_PORT_0,
-			     intel_dp->downstream_ports,
-			     DP_MAX_DOWNSTREAM_PORTS) < 0)
-		return false; /* downstream port status fetch failed */
-
-	return true;
+	return drm_dp_read_downstream_info(&intel_dp->aux, intel_dp->dpcd,
+					   intel_dp->downstream_ports) == 0;
 }
 
 static bool
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 5c28199248626..b8716b200666f 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1613,6 +1613,9 @@ int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
 				    u8 real_edid_checksum);
 
+int drm_dp_read_downstream_info(struct drm_dp_aux *aux,
+				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
+				u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS]);
 int drm_dp_downstream_max_clock(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 				const u8 port_cap[4]);
 int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
-- 
2.26.2

