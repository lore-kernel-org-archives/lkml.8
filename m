Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0CB2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgG1Vlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:41:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:14223 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbgG1Vlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:41:44 -0400
IronPort-SDR: UCQwPBO/6AHfF05V73ReJtrDGIb2ZK1asmUr8DmD8/etRg7xNaYQYZzj4K2cYvNUiRxEVdm8LK
 rOcDStFtbj3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="149171233"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="149171233"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 14:41:43 -0700
IronPort-SDR: Wc1QHnhPXg8oYrSvCwBZZPpcuuYFGs2lNOilOAMyc93z6v5vlP6bP/F5T3f3kSxgTa+SuZ8o6V
 E1uKEbJ26vbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="286301610"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2020 14:41:41 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [char-misc-next] Revert "mei: hdcp: Replace one-element array with flexible-array member"
Date:   Wed, 29 Jul 2020 00:41:39 +0300
Message-Id: <20200728214139.3129532-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg please revert, this commit it changes size of
struct wired_cmd_repeater_auth_stream_req_in, this is
not what firmware is expecting.
I really do not appreciate that the code is bypassing
driver maintaner review, I think this is a minimum
we can ask for, this is not for a first time.

This reverts commit c56967d674e361ebe716e66992e3c5332b25ac1f.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
 drivers/misc/mei/hdcp/mei_hdcp.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index d1d3e025ca0e..e6c3dc595617 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -572,7 +572,7 @@ static int mei_hdcp_verify_mprime(struct device *dev,
 	       HDCP_2_2_MPRIME_LEN);
 	drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data->seq_num_m);
 	memcpy(verify_mprime_in.streams, data->streams,
-	       array_size(data->k, sizeof(*data->streams)));
+	       (data->k * sizeof(struct hdcp2_streamid_type)));
 
 	verify_mprime_in.k = cpu_to_be16(data->k);
 
diff --git a/drivers/misc/mei/hdcp/mei_hdcp.h b/drivers/misc/mei/hdcp/mei_hdcp.h
index 834757f5e072..18ffc773fa18 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.h
+++ b/drivers/misc/mei/hdcp/mei_hdcp.h
@@ -358,7 +358,7 @@ struct wired_cmd_repeater_auth_stream_req_in {
 	u8				seq_num_m[HDCP_2_2_SEQ_NUM_LEN];
 	u8				m_prime[HDCP_2_2_MPRIME_LEN];
 	__be16				k;
-	struct hdcp2_streamid_type	streams[];
+	struct hdcp2_streamid_type	streams[1];
 } __packed;
 
 struct wired_cmd_repeater_auth_stream_req_out {
-- 
2.25.4

