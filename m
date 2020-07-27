Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DDFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B5F20792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W3rWk6qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgG0GDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgG0GDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:03:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAD5C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:03:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so8517975pje.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9TrPMv1GvqaxejuDsYKgVYNmiSWdV8LyIQoXnPdKOE=;
        b=W3rWk6qRg7TGPltuV7Z/y+yOnPBOVX1t0cfZ7MaptJLterQPzGHxkjU6asEbZXIiGX
         vmBh7oRYHuh3e2AOiYyMh96t39Nx+F43u7MjgiPGlbeDXc9hMpCiKoj+oHkBgYzoa9lG
         l3NYOawcxMOhS5ToJw28afbcD+NAdrVc77NZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9TrPMv1GvqaxejuDsYKgVYNmiSWdV8LyIQoXnPdKOE=;
        b=TsXS9QADdGDDnAN32l1l0iDOape3UNmkWxq/eVZ8ECu9AQub+DbwYYBxrpsij55Pmw
         kRoCZ9KO+oSBysoY9R9fkXkg6Sh7LhT6O3F3NnnoMD73wNMdEbM4hg/KZywdxQf2youD
         A5CWpm913xVL0vKPOJGhebPrYb98l4bf8Cim9uRTWpBXSPTDKw5bJ8zMAmLilALKayjU
         jsvqk+HyYJ/9mK1V63+KflrMKNARM8eaVx6ekMPJG6G9TDmayZnRq9yOduuUfFT4Nmpe
         q8Q37+Ja091LFMuKRGO1ep1uBkhUTVYUWROESk03eEpwKFbZNAE1s7+t699dYYHE9Fnn
         XrMg==
X-Gm-Message-State: AOAM532ogOFfxNBFZczkTYxzsEJPYxHdCyjbHw/LHKX6b25AKJbuOfWe
        j5xmWyGQSKBtyACFeRzPq7pAZCqnUjA=
X-Google-Smtp-Source: ABdhPJwrAeZdDRuy+aZSso7QE+3e2VEeiDQ3/nePIPbOq9zUfvDfaIi12TAdsuSIdXoJ1Vt7o1ob2Q==
X-Received: by 2002:a17:902:d702:: with SMTP id w2mr6582165ply.159.1595829824834;
        Sun, 26 Jul 2020 23:03:44 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id 137sm13802617pgg.72.2020.07.26.23.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 23:03:43 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sam McNally <sammc@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/dp_mst: Support remote i2c writes
Date:   Mon, 27 Jul 2020 16:03:37 +1000
Message-Id: <20200727160225.1.I4e95a534de051551cd143e6cb83d4c5a9b0ad1cd@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For DP MST outputs, the i2c device currently only supports transfers
that can be implemented using remote i2c reads. Such transfers must
consist of zero or more write transactions followed by one read
transaction. DDC/CI commands require standalone write transactions and
hence aren't supported.

Since each remote i2c write is handled as a separate transfer, remote
i2c writes can support transfers consisting of write transactions, where
all but the last have I2C_M_STOP set. According to the DDC/CI 1.1
standard, DDC/CI commands only require a single write or read
transaction in a transfer, so this is sufficient.

For i2c transfers meeting the above criteria, generate and send a remote
i2c write message for each transaction. Add the trivial remote i2c write
reply parsing support so remote i2c write acks bubble up correctly.

Signed-off-by: Sam McNally <sammc@chromium.org>
---

 drivers/gpu/drm/drm_dp_mst_topology.c | 106 ++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 09b32289497e..1ac874e4e7a1 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -961,6 +961,8 @@ static bool drm_dp_sideband_parse_reply(struct drm_dp_sideband_msg_rx *raw,
 		return drm_dp_sideband_parse_remote_dpcd_write(raw, msg);
 	case DP_REMOTE_I2C_READ:
 		return drm_dp_sideband_parse_remote_i2c_read_ack(raw, msg);
+	case DP_REMOTE_I2C_WRITE:
+		return true; /* since there's nothing to parse */
 	case DP_ENUM_PATH_RESOURCES:
 		return drm_dp_sideband_parse_enum_path_resources_ack(raw, msg);
 	case DP_ALLOCATE_PAYLOAD:
@@ -5326,29 +5328,29 @@ static bool remote_i2c_read_ok(const struct i2c_msg msgs[], int num)
 		msgs[num - 1].len <= 0xff;
 }
 
-/* I2C device */
-static int drm_dp_mst_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
-			       int num)
+static bool remote_i2c_write_ok(const struct i2c_msg msgs[], int num)
+{
+	int i;
+
+	for (i = 0; i < num - 1; i++) {
+		if (msgs[i].flags & I2C_M_RD || !(msgs[i].flags & I2C_M_STOP) ||
+		    msgs[i].len > 0xff)
+			return false;
+	}
+
+	return !(msgs[num - 1].flags & I2C_M_RD) && msgs[num - 1].len <= 0xff;
+}
+
+static int drm_dp_mst_i2c_read(struct drm_dp_mst_branch *mstb,
+			       struct drm_dp_mst_port *port,
+			       struct i2c_msg *msgs, int num)
 {
-	struct drm_dp_aux *aux = adapter->algo_data;
-	struct drm_dp_mst_port *port = container_of(aux, struct drm_dp_mst_port, aux);
-	struct drm_dp_mst_branch *mstb;
 	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
 	unsigned int i;
 	struct drm_dp_sideband_msg_req_body msg;
 	struct drm_dp_sideband_msg_tx *txmsg = NULL;
 	int ret;
 
-	mstb = drm_dp_mst_topology_get_mstb_validated(mgr, port->parent);
-	if (!mstb)
-		return -EREMOTEIO;
-
-	if (!remote_i2c_read_ok(msgs, num)) {
-		DRM_DEBUG_KMS("Unsupported I2C transaction for MST device\n");
-		ret = -EIO;
-		goto out;
-	}
-
 	memset(&msg, 0, sizeof(msg));
 	msg.req_type = DP_REMOTE_I2C_READ;
 	msg.u.i2c_read.num_transactions = num - 1;
@@ -5389,6 +5391,78 @@ static int drm_dp_mst_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs
 	}
 out:
 	kfree(txmsg);
+	return ret;
+}
+
+static int drm_dp_mst_i2c_write(struct drm_dp_mst_branch *mstb,
+				struct drm_dp_mst_port *port,
+				struct i2c_msg *msgs, int num)
+{
+	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
+	unsigned int i;
+	struct drm_dp_sideband_msg_req_body msg;
+	struct drm_dp_sideband_msg_tx *txmsg = NULL;
+	int ret;
+
+	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
+	if (!txmsg) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < num; i++) {
+		memset(&msg, 0, sizeof(msg));
+		msg.req_type = DP_REMOTE_I2C_WRITE;
+		msg.u.i2c_write.port_number = port->port_num;
+		msg.u.i2c_write.write_i2c_device_id = msgs[i].addr;
+		msg.u.i2c_write.num_bytes = msgs[i].len;
+		msg.u.i2c_write.bytes = msgs[i].buf;
+
+		memset(txmsg, 0, sizeof(*txmsg));
+		txmsg->dst = mstb;
+
+		drm_dp_encode_sideband_req(&msg, txmsg);
+		drm_dp_queue_down_tx(mgr, txmsg);
+
+		ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
+		if (ret > 0) {
+			if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {
+				ret = -EREMOTEIO;
+				goto out;
+			}
+		} else {
+			goto out;
+		}
+	}
+	ret = num;
+out:
+	kfree(txmsg);
+	return ret;
+}
+
+/* I2C device */
+static int drm_dp_mst_i2c_xfer(struct i2c_adapter *adapter,
+			       struct i2c_msg *msgs, int num)
+{
+	struct drm_dp_aux *aux = adapter->algo_data;
+	struct drm_dp_mst_port *port =
+		container_of(aux, struct drm_dp_mst_port, aux);
+	struct drm_dp_mst_branch *mstb;
+	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
+	int ret;
+
+	mstb = drm_dp_mst_topology_get_mstb_validated(mgr, port->parent);
+	if (!mstb)
+		return -EREMOTEIO;
+
+	if (remote_i2c_read_ok(msgs, num)) {
+		ret = drm_dp_mst_i2c_read(mstb, port, msgs, num);
+	} else if (remote_i2c_write_ok(msgs, num)) {
+		ret = drm_dp_mst_i2c_write(mstb, port, msgs, num);
+	} else {
+		DRM_DEBUG_KMS("Unsupported I2C transaction for MST device\n");
+		ret = -EIO;
+	}
+
 	drm_dp_mst_topology_put_mstb(mstb);
 	return ret;
 }
-- 
2.28.0.rc0.142.g3c755180ce-goog

