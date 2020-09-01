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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78111C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F012071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bbjai8uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIAGWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAGWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:22:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91786C0612AC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:22:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g6so116160pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRIHcVNxVGPyHgfpqDwa33OIPQovgsuZYgCyV3RsN4U=;
        b=bbjai8uAfQTONaD7KIS+VvI0y9gAklINsoRx4g7eLrbLP5Af077ZQYThvPgH1KaxaN
         lSiUGHPyy1Ixzsi835Q19YIiFeVyTpA3jXFhHIKdctbYgjH8x7OLJGCTPjg7aYrhaRhu
         /yEHG7bSgsx5cpODbWFnyTcusm++jPyWGxmKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRIHcVNxVGPyHgfpqDwa33OIPQovgsuZYgCyV3RsN4U=;
        b=loQjCOGgeVRYYdRaF8uerTZQ7D5sXsGIbBMGbbH1WElcvqZbdLLK1SkPCoY9A33sKN
         /n8PFCeziAcvikYhP/vF0SAfhFii7PfIylAe3CGqSBti4Aj0RHFH9ztMkgLa8RN5UKTH
         TOWL++5NoYqQKT9N1s6UkzVhnW5mzUHyVIhlDO7+Z2U18dmZXJMJX3Pv5k+5XbBw4eb8
         uR91Cx1z0fnI7VaDkgb+uT8pmr/HkFMjJMv4QuYbHM1UCaS//SBh3lCmPkuSUJ/Jykgr
         egjwr/AOwOzzqDsTX59fehjBuuqj2MUwdVll+BEklA6kj1/USrCyquvrJdzwXyJ61CO2
         iGuQ==
X-Gm-Message-State: AOAM530mh6CubBqVxYJOK0Hn4QQFixwAgxncsEXKYAxKe4UZU+DlL/4e
        YzmDFCG2KKOFtSWT8uNu+90j50dMliq0JA==
X-Google-Smtp-Source: ABdhPJzcdZL4p0b4GPPuCv+/lxRBzo2wGELTyfZ/HfU5w9m3LhPY2jVp17FziATH/kJ+fkOyP2la1Q==
X-Received: by 2002:a17:90b:282:: with SMTP id az2mr144138pjb.66.1598941356873;
        Mon, 31 Aug 2020 23:22:36 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id n1sm372069pfu.2.2020.08.31.23.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 23:22:36 -0700 (PDT)
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
Subject: [PATCH 2/5] drm_dp_mst_topology: use correct AUX channel
Date:   Tue,  1 Sep 2020 16:22:16 +1000
Message-Id: <20200901162133.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200901162133.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
References: <20200901162133.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

For adapters behind an MST hub use the correct AUX channel.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
[sammc@chromium.org: rebased, removing redundant changes]
Signed-off-by: Sam McNally <sammc@chromium.org>
---

 drivers/gpu/drm/drm_dp_mst_topology.c | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 15b6cc39a754..0d753201adbd 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2255,6 +2255,9 @@ drm_dp_mst_topology_unlink_port(struct drm_dp_mst_topology_mgr *mgr,
 	drm_dp_mst_topology_put_port(port);
 }
 
+static ssize_t
+drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg);
+
 static struct drm_dp_mst_port *
 drm_dp_mst_add_port(struct drm_device *dev,
 		    struct drm_dp_mst_topology_mgr *mgr,
@@ -2271,9 +2274,13 @@ drm_dp_mst_add_port(struct drm_device *dev,
 	port->port_num = port_number;
 	port->mgr = mgr;
 	port->aux.name = "DPMST";
+	mutex_init(&port->aux.hw_mutex);
+	mutex_init(&port->aux.cec.lock);
 	port->aux.dev = dev->dev;
 	port->aux.is_remote = true;
 
+	port->aux.transfer = drm_dp_mst_aux_transfer;
+
 	/* initialize the MST downstream port's AUX crc work queue */
 	drm_dp_remote_aux_init(&port->aux);
 
@@ -3503,6 +3510,35 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
 	return 0;
 }
 
+static ssize_t
+drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
+{
+	struct drm_dp_mst_port *port =
+		container_of(aux, struct drm_dp_mst_port, aux);
+	int ret;
+
+	switch (msg->request & ~DP_AUX_I2C_MOT) {
+	case DP_AUX_NATIVE_WRITE:
+	case DP_AUX_I2C_WRITE:
+	case DP_AUX_I2C_WRITE_STATUS_UPDATE:
+		ret = drm_dp_send_dpcd_write(port->mgr, port, msg->address,
+					     msg->size, msg->buffer);
+		break;
+
+	case DP_AUX_NATIVE_READ:
+	case DP_AUX_I2C_READ:
+		ret = drm_dp_send_dpcd_read(port->mgr, port, msg->address,
+					    msg->size, msg->buffer);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
 {
 	if (dp_link_bw == 0 || dp_link_count == 0)
-- 
2.28.0.402.g5ffc5be6b7-goog

