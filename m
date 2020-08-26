Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FA6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2272224D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHZOYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:24:43 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:58546 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgHZOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:24:33 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id C5F30A22F5;
        Wed, 26 Aug 2020 22:24:22 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P32155T139859905738496S1598451859689366_;
        Wed, 26 Aug 2020 22:24:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f83766c1e70417d8c8c857082aeefd14>
X-RL-SENDER: algea.cao@rock-chips.com
X-SENDER: algea.cao@rock-chips.com
X-LOGIN-NAME: algea.cao@rock-chips.com
X-FST-TO: mripard@kernel.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Algea Cao <algea.cao@rock-chips.com>
To:     mripard@kernel.org, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        daniel@ffwll.ch, linux-rockchip@lists.infradead.org
Cc:     Algea Cao <algea.cao@rock-chips.com>
Subject: [PATCH] drm: Parse Colorimetry data block from EDID
Date:   Wed, 26 Aug 2020 22:23:28 +0800
Message-Id: <20200826142328.131144-1-algea.cao@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CEA 861.3 spec adds colorimetry data block for HDMI.
Parsing the block to get the colorimetry data from
panel.

Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
---

 drivers/gpu/drm/drm_edid.c  | 45 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h |  3 +++
 include/drm/drm_edid.h      | 14 ++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 31496b6cfc56..67e607c04492 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3223,6 +3223,7 @@ add_detailed_modes(struct drm_connector *connector, struct edid *edid,
 #define VIDEO_BLOCK     0x02
 #define VENDOR_BLOCK    0x03
 #define SPEAKER_BLOCK	0x04
+#define COLORIMETRY_DATA_BLOCK		0x5
 #define HDR_STATIC_METADATA_BLOCK	0x6
 #define USE_EXTENDED_TAG 0x07
 #define EXT_VIDEO_CAPABILITY_BLOCK 0x00
@@ -4309,6 +4310,48 @@ static void fixup_detailed_cea_mode_clock(struct drm_display_mode *mode)
 	mode->clock = clock;
 }
 
+static bool cea_db_is_hdmi_colorimetry_data_block(const u8 *db)
+{
+	if (cea_db_tag(db) != USE_EXTENDED_TAG)
+		return false;
+
+	if (db[1] != COLORIMETRY_DATA_BLOCK)
+		return false;
+
+	if (cea_db_payload_len(db) < 2)
+		return false;
+
+	return true;
+}
+
+static void
+drm_parse_colorimetry_data_block(struct drm_connector *connector, const u8 *db)
+{
+	struct drm_hdmi_info *info = &connector->display_info.hdmi;
+
+	if (db[2] & DRM_EDID_CLRMETRY_xvYCC_601)
+		info->colorimetry |= DRM_EDID_CLRMETRY_xvYCC_601;
+	if (db[2] & DRM_EDID_CLRMETRY_xvYCC_709)
+		info->colorimetry |= DRM_EDID_CLRMETRY_xvYCC_709;
+	if (db[2] & DRM_EDID_CLRMETRY_sYCC_601)
+		info->colorimetry |= DRM_EDID_CLRMETRY_sYCC_601;
+	if (db[2] & DRM_EDID_CLRMETRY_ADBYCC_601)
+		info->colorimetry |= DRM_EDID_CLRMETRY_ADBYCC_601;
+	if (db[2] & DRM_EDID_CLRMETRY_ADB_RGB)
+		info->colorimetry |= DRM_EDID_CLRMETRY_ADB_RGB;
+	if (db[2] & DRM_EDID_CLRMETRY_BT2020_CYCC)
+		info->colorimetry |= DRM_EDID_CLRMETRY_BT2020_CYCC;
+	if (db[2] & DRM_EDID_CLRMETRY_BT2020_YCC)
+		info->colorimetry |= DRM_EDID_CLRMETRY_BT2020_YCC;
+	if (db[2] & DRM_EDID_CLRMETRY_BT2020_RGB)
+		info->colorimetry |= DRM_EDID_CLRMETRY_BT2020_RGB;
+	/* Byte 4 Bit 7: DCI-P3 */
+	if (db[3] & BIT(7))
+		info->colorimetry |= DRM_EDID_CLRMETRY_DCI_P3;
+
+	DRM_DEBUG_KMS("Supported Colorimetry 0x%x\n", info->colorimetry);
+}
+
 static bool cea_db_is_hdmi_hdr_metadata_block(const u8 *db)
 {
 	if (cea_db_tag(db) != USE_EXTENDED_TAG)
@@ -4994,6 +5037,8 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 			drm_parse_vcdb(connector, db);
 		if (cea_db_is_hdmi_hdr_metadata_block(db))
 			drm_parse_hdr_metadata_block(connector, db);
+		if (cea_db_is_hdmi_colorimetry_data_block(db))
+			drm_parse_colorimetry_data_block(connector, db);
 	}
 }
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index af145608b5ed..d599c3b9e881 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -207,6 +207,9 @@ struct drm_hdmi_info {
 
 	/** @y420_dc_modes: bitmap of deep color support index */
 	u8 y420_dc_modes;
+
+	/* @colorimetry: bitmap of supported colorimetry modes */
+	u16 colorimetry;
 };
 
 /**
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index cfa4f5af49af..98fa78c2f82d 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -229,6 +229,20 @@ struct detailed_timing {
 				    DRM_EDID_YCBCR420_DC_36 | \
 				    DRM_EDID_YCBCR420_DC_30)
 
+/*
+ * Supported Colorimetry from colorimetry data block
+ * as per CEA 861-G spec
+ */
+#define DRM_EDID_CLRMETRY_xvYCC_601   (1 << 0)
+#define DRM_EDID_CLRMETRY_xvYCC_709   (1 << 1)
+#define DRM_EDID_CLRMETRY_sYCC_601    (1 << 2)
+#define DRM_EDID_CLRMETRY_ADBYCC_601  (1 << 3)
+#define DRM_EDID_CLRMETRY_ADB_RGB     (1 << 4)
+#define DRM_EDID_CLRMETRY_BT2020_CYCC (1 << 5)
+#define DRM_EDID_CLRMETRY_BT2020_YCC  (1 << 6)
+#define DRM_EDID_CLRMETRY_BT2020_RGB  (1 << 7)
+#define DRM_EDID_CLRMETRY_DCI_P3      (1 << 15)
+
 /* ELD Header Block */
 #define DRM_ELD_HEADER_BLOCK_SIZE	4
 
-- 
2.25.1



