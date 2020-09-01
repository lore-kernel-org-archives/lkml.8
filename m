Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA0DC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8572071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HOlq1yYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgIAGWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAGWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:22:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE82C0612AC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:22:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mm21so107860pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhLdqliPfynJAiD7/3YXz7Gp09SJzpU1HbkYzOvkmgQ=;
        b=HOlq1yYIeUL+dWUZOuj6ufRG2WgU1lgJm3H3P0ucojnvC8gEnJ2XHuODPRAZteFRw+
         4JHYhlocD0X4WXdWcOogIK4k78R5FediQh89mujqO3BJO5tfVSDLMliisMSacD+9j1Md
         Rw+laVnBl6qev64cCE4eZXb4cD8PKw/gg5CpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhLdqliPfynJAiD7/3YXz7Gp09SJzpU1HbkYzOvkmgQ=;
        b=F2Dc5q1vqX1HKYR4AbGEpSMbTChgr/O7bklgiqKYJ6bfeaHvKNF42LBiVkShaJTs3a
         DGPc6nxMMGW/uc+PEboWC1caj7nZN4I4ER4Q1blNenAI+RqUFwYX3xErM0gtYEbzp8jG
         AYPRIbaxVRf+ad6IgqMLCp3WQL/sFRzVYpt/lj/EFEdHpIRxgqTEGxSiTELJfwcPRkQ/
         D6GpiJ+VvL7eXBNysTU72oCOtotpHRDOJ1VhrHj26+2B3bOkM2t6snJWCjZ7wU7pet9p
         Z6CaL6fUidoRJ5HqOxrQuMfjGXQrqzA8fR96WB+EHKFeDtpogVZTPb4/ZYmNllsSsvu9
         cUvw==
X-Gm-Message-State: AOAM533J6FcpjOSv6l2160F+hVy10J7M1911PgQWfoMiscyqze6nS1SU
        ZlYCy2Ll175yRz1PY6yeYA8X41nHW3C1LA==
X-Google-Smtp-Source: ABdhPJzd76J+XsuHIgb7R5FqGvKf1M7ffquE/FEbXOhkojG1KVbRpLbYvVVZPLksvnly9EPZJTH7EA==
X-Received: by 2002:a17:902:b7cc:: with SMTP id v12mr77694plz.105.1598941350792;
        Mon, 31 Aug 2020 23:22:30 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id w82sm271119pfc.183.2020.08.31.23.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 23:22:30 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sam McNally <sammc@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/5] dp/dp_mst: Add support for sink event notify messages
Date:   Tue,  1 Sep 2020 16:22:15 +1000
Message-Id: <20200901162133.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sink event notify messages are used for MST CEC IRQs. Add parsing
support for sink event notify messages in preparation for handling MST
CEC IRQs.

Signed-off-by: Sam McNally <sammc@chromium.org>
---

 drivers/gpu/drm/drm_dp_mst_topology.c | 37 ++++++++++++++++++++++++++-
 include/drm/drm_dp_mst_helper.h       | 14 ++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 17dbed0a9800..15b6cc39a754 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1027,6 +1027,30 @@ static bool drm_dp_sideband_parse_resource_status_notify(struct drm_dp_sideband_
 	return false;
 }
 
+static bool drm_dp_sideband_parse_sink_event_notify(
+	struct drm_dp_sideband_msg_rx *raw,
+	struct drm_dp_sideband_msg_req_body *msg)
+{
+	int idx = 1;
+
+	msg->u.sink_event.port_number = (raw->msg[idx] & 0xf0) >> 4;
+	idx++;
+	if (idx > raw->curlen)
+		goto fail_len;
+
+	memcpy(msg->u.sink_event.guid, &raw->msg[idx], 16);
+	idx += 16;
+	if (idx > raw->curlen)
+		goto fail_len;
+
+	msg->u.sink_event.event_id = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
+	idx++;
+	return true;
+fail_len:
+	DRM_DEBUG_KMS("sink event notify parse length fail %d %d\n", idx, raw->curlen);
+	return false;
+}
+
 static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
 				      struct drm_dp_sideband_msg_req_body *msg)
 {
@@ -1038,6 +1062,8 @@ static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
 		return drm_dp_sideband_parse_connection_status_notify(raw, msg);
 	case DP_RESOURCE_STATUS_NOTIFY:
 		return drm_dp_sideband_parse_resource_status_notify(raw, msg);
+	case DP_SINK_EVENT_NOTIFY:
+		return drm_dp_sideband_parse_sink_event_notify(raw, msg);
 	default:
 		DRM_ERROR("Got unknown request 0x%02x (%s)\n", msg->req_type,
 			  drm_dp_mst_req_type_str(msg->req_type));
@@ -3875,6 +3901,8 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 			guid = msg->u.conn_stat.guid;
 		else if (msg->req_type == DP_RESOURCE_STATUS_NOTIFY)
 			guid = msg->u.resource_stat.guid;
+		else if (msg->req_type == DP_SINK_EVENT_NOTIFY)
+			guid = msg->u.sink_event.guid;
 
 		if (guid)
 			mstb = drm_dp_get_mst_branch_device_by_guid(mgr, guid);
@@ -3948,7 +3976,8 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
 
 	if (up_req->msg.req_type != DP_CONNECTION_STATUS_NOTIFY &&
-	    up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY) {
+	    up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY &&
+	    up_req->msg.req_type != DP_SINK_EVENT_NOTIFY) {
 		DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
 			      up_req->msg.req_type);
 		kfree(up_req);
@@ -3976,6 +4005,12 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 		DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n",
 			      res_stat->port_number,
 			      res_stat->available_pbn);
+	} else if (up_req->msg.req_type == DP_SINK_EVENT_NOTIFY) {
+		const struct drm_dp_sink_event_notify *sink_event =
+			&up_req->msg.u.sink_event;
+
+		DRM_DEBUG_KMS("Got SEN: pn: %d event_id %d\n",
+			      sink_event->port_number, sink_event->event_id);
 	}
 
 	up_req->hdr = mgr->up_req_recv.initial_hdr;
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 6ae5860d8644..c7c79e0ced18 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -402,6 +402,19 @@ struct drm_dp_resource_status_notify {
 	u16 available_pbn;
 };
 
+#define DP_SINK_EVENT_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR	BIT(0)
+#define DP_SINK_EVENT_PANEL_REPLAY_RFB_STORAGE_ERROR		BIT(1)
+#define DP_SINK_EVENT_DSC_RC_BUFFER_UNDER_RUN			BIT(2)
+#define DP_SINK_EVENT_DSC_RC_BUFFER_OVERFLOW			BIT(3)
+#define DP_SINK_EVENT_DSC_CHUNK_LENGTH_ERROR			BIT(4)
+#define DP_SINK_EVENT_CEC_IRQ_EVENT				BIT(5)
+
+struct drm_dp_sink_event_notify {
+	u8 port_number;
+	u8 guid[16];
+	u16 event_id;
+};
+
 struct drm_dp_query_payload_ack_reply {
 	u8 port_number;
 	u16 allocated_pbn;
@@ -413,6 +426,7 @@ struct drm_dp_sideband_msg_req_body {
 		struct drm_dp_connection_status_notify conn_stat;
 		struct drm_dp_port_number_req port_num;
 		struct drm_dp_resource_status_notify resource_stat;
+		struct drm_dp_sink_event_notify sink_event;
 
 		struct drm_dp_query_payload query_payload;
 		struct drm_dp_allocate_payload allocate_payload;
-- 
2.28.0.402.g5ffc5be6b7-goog

