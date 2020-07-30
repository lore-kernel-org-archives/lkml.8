Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3C1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C303A20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgG3Sy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:54:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:45250 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgG3Sy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:54:59 -0400
IronPort-SDR: Bba3eUPvpZyOiXXjjaZNfQkNmAqoekLvZaobyQgjvU3+IYv0fGE1u0Pb593pfV3M7UwpBpiDQv
 aBYumfti8pSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="216138421"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="216138421"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 11:54:58 -0700
IronPort-SDR: tYoiNIPxjbrsOvLRQOl+uYAL1LacBy+JzM0T9tJkGdCJXiffwL/3VyNuZ6x3uXaiRi8+lhRIg4
 Fs9yRb7Px1Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="435153652"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2020 11:54:55 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ramalingam C <ramalingam.c@intel.com>, stable@vger.kernel.org
Subject: [char-misc-next V3] mei: hdcp: fix mei_hdcp_verify_mprime() input paramter
Date:   Thu, 30 Jul 2020 21:54:51 +0300
Message-Id: <20200730185451.3621108-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wired_cmd_repeater_auth_stream_req_in has a variable
length array at the end. we use struct_size() overflow
macro to determine the size for the allocation and sending
size.
This also fixes bug in case number of streams is > 0 in the original
submission. This bug was not triggered as the number of streams is
always one.

Fixes: c56967d674e3 (mei: hdcp: Replace one-element array with flexible-array member)
Fixes: 0a1af1b5c18d ("misc/mei/hdcp: Verify M_prime")
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Ramalingam C <ramalingam.c@intel.com>
Cc: <stable@vger.kernel.org> v5.1+
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3:
1. Fix commit message with more info and another patch it fixes (Gustavo)
2. Target stable. (Gustavo)
V2: Check for allocation failure.
 drivers/misc/mei/hdcp/mei_hdcp.c | 40 +++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index d1d3e025ca0e..f1205e0060db 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -546,38 +546,46 @@ static int mei_hdcp_verify_mprime(struct device *dev,
 				  struct hdcp_port_data *data,
 				  struct hdcp2_rep_stream_ready *stream_ready)
 {
-	struct wired_cmd_repeater_auth_stream_req_in
-					verify_mprime_in = { { 0 } };
+	struct wired_cmd_repeater_auth_stream_req_in *verify_mprime_in;
 	struct wired_cmd_repeater_auth_stream_req_out
 					verify_mprime_out = { { 0 } };
 	struct mei_cl_device *cldev;
 	ssize_t byte;
+	size_t cmd_size;
 
 	if (!dev || !stream_ready || !data)
 		return -EINVAL;
 
 	cldev = to_mei_cl_device(dev);
 
-	verify_mprime_in.header.api_version = HDCP_API_VERSION;
-	verify_mprime_in.header.command_id = WIRED_REPEATER_AUTH_STREAM_REQ;
-	verify_mprime_in.header.status = ME_HDCP_STATUS_SUCCESS;
-	verify_mprime_in.header.buffer_len =
+	cmd_size = struct_size(verify_mprime_in, streams, data->k);
+	if (cmd_size == SIZE_MAX)
+		return -EINVAL;
+
+	verify_mprime_in = kzalloc(cmd_size, GFP_KERNEL);
+	if (!verify_mprime_in)
+		return -ENOMEM;
+
+	verify_mprime_in->header.api_version = HDCP_API_VERSION;
+	verify_mprime_in->header.command_id = WIRED_REPEATER_AUTH_STREAM_REQ;
+	verify_mprime_in->header.status = ME_HDCP_STATUS_SUCCESS;
+	verify_mprime_in->header.buffer_len =
 			WIRED_CMD_BUF_LEN_REPEATER_AUTH_STREAM_REQ_MIN_IN;
 
-	verify_mprime_in.port.integrated_port_type = data->port_type;
-	verify_mprime_in.port.physical_port = (u8)data->fw_ddi;
-	verify_mprime_in.port.attached_transcoder = (u8)data->fw_tc;
+	verify_mprime_in->port.integrated_port_type = data->port_type;
+	verify_mprime_in->port.physical_port = (u8)data->fw_ddi;
+	verify_mprime_in->port.attached_transcoder = (u8)data->fw_tc;
+
+	memcpy(verify_mprime_in->m_prime, stream_ready->m_prime, HDCP_2_2_MPRIME_LEN);
+	drm_hdcp_cpu_to_be24(verify_mprime_in->seq_num_m, data->seq_num_m);
 
-	memcpy(verify_mprime_in.m_prime, stream_ready->m_prime,
-	       HDCP_2_2_MPRIME_LEN);
-	drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data->seq_num_m);
-	memcpy(verify_mprime_in.streams, data->streams,
+	memcpy(verify_mprime_in->streams, data->streams,
 	       array_size(data->k, sizeof(*data->streams)));
 
-	verify_mprime_in.k = cpu_to_be16(data->k);
+	verify_mprime_in->k = cpu_to_be16(data->k);
 
-	byte = mei_cldev_send(cldev, (u8 *)&verify_mprime_in,
-			      sizeof(verify_mprime_in));
+	byte = mei_cldev_send(cldev, (u8 *)&verify_mprime_in, cmd_size);
+	kfree(verify_mprime_in);
 	if (byte < 0) {
 		dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
 		return byte;
-- 
2.25.4

