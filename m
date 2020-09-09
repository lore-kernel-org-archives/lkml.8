Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A12C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B533D21973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dHllD90s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgIIHVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgIIHVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:21:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:21:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b16so900341pjp.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLPtTuLpMmqGcI18AHosC8t8jX+F5LJliVXfFXGdRzo=;
        b=dHllD90sWsIvfpw8cEKg4udYXNwUKGh2aJJesDyELYXYfTm6NHaITmgFkGFmy0HCjF
         1IhK/ljvkIzPQ0KnPfH4w/kpgG4MprLjzPzItFCHI9CiTLhFsvTLo8FJn3MNYeRaUhN/
         7tVvgDzaoWCkVlYgeasCYE6KCO3NFOsmShzEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLPtTuLpMmqGcI18AHosC8t8jX+F5LJliVXfFXGdRzo=;
        b=uSnoaDUKOY9bwWE/f+3YW19EJbj+w8bp5E84998k2xOZyb1NQw1KAHvm2X51wI1hMj
         jWkxgWLXw5NPZFSV72IUGaujVQcb5CJirHFESUXkrLkVaEJGe9sKqB0y+PhjCS6fcHO6
         a/GxQv2mAms2pOiJx3eT1JR13PTxEId7/PjoIAf74WG7g4c14aX5wDHpDmGB3P5+VB9d
         nzIBCXoNigyiIE9cLIRZIM1biOTjrf15SfND9QsrnXaSqMpWLs5ikxP6hT2F8aaElpeI
         HsXa9POC5PUroSe/A0tZe1MzC7NDs1vfFDxwsNMeuy554t39uZNShQzrJh+s9e7JD+Kt
         716w==
X-Gm-Message-State: AOAM532WYxjDtXmmtPKfvi1uKH0A2QUsmFvVapfmzXoGymIc62H5DISU
        V6/0neICefpUEp8tq22ovsfWWEqQ6vUxuA==
X-Google-Smtp-Source: ABdhPJzX1jP/qLLmt+a0xk0JgMFrrGWSt76WDoxrpIvUrtVywETiK7WFFc5/T+f1+qlCLVLotGekjA==
X-Received: by 2002:a17:90a:104f:: with SMTP id y15mr212144pjd.45.1599636082099;
        Wed, 09 Sep 2020 00:21:22 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id q34sm1304145pgl.28.2020.09.09.00.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 00:21:21 -0700 (PDT)
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
Subject: [PATCH v2 2/4] drm_dp_mst_topology: use correct AUX channel
Date:   Wed,  9 Sep 2020 17:20:50 +1000
Message-Id: <20200909172023.v2.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200909172023.v2.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
References: <20200909172023.v2.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
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

(no changes since v1)

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
2.28.0.526.ge36021eeef-goog

