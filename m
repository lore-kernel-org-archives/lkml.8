Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1754C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AACF420724
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="SawHkKa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgGADLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGADL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:11:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AEDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:11:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so10286674qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPKcsn1Zg7byMoVV6H8vhXEqRTFirUJz5P7vuG1x+2o=;
        b=SawHkKa/kuqLOkRUBkvd8HoYa9gml32y4fAI3rpF/uzqhtlUwhUqBi8NemMpM7NfiG
         rU2R+qjmF65r98Xkm7raD2/qmh71x5R+vkhQuv/a296LccDmG6MWwEMVYnukMiAKin/3
         Pd+N1xuniy/hXXCqxxrUr75pEABwzRr6u+ar/0OkaDQhAi1o1ddZe+h8wlwENpJmkbCf
         kNLbYzC6KzVwPPIvBR1oqXT0T6k6o4Ls8/JRRcxyFKKO6KCTaN4qp7dK7QGonljLmyqQ
         Lui1NDOyvqZ0G3agm+1Bwc5AVU89OKTbcBiDRCH9Wwev5Raa4rKXNCED80HjVLE4esv/
         +8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPKcsn1Zg7byMoVV6H8vhXEqRTFirUJz5P7vuG1x+2o=;
        b=KUI7J480lazITims4S2KDBQDBqRmmZiIs7Udsuxe9Rj3RVNPzJGxeN6BEtN8N8DGaq
         5483VHuI3bwBLxH6Xo7zVYuJjXOtQxRr7NnwWf2jP+fZs1cjvcmlOk+vNpT6Aid0c79h
         7Zt6fKPjYCq/CPHo79Z3NdwHc7RWR1MRDR0N5NjvX+sUpekoelFvHXoeB/lsk4o6DZjB
         4zLNUSxzhK/htzfTSwAdPtKyZfawlDKZZAZaP5nnoP1w1oJRN/DK0jYCOjcaD9yzlSpb
         r6wbapbiA/vzykQji7zmMcXvtwehtWxlW7+FQe+4yMIs5QignNWpZciEFiDRcduI8NgH
         M9tg==
X-Gm-Message-State: AOAM5303hHQiwJmbAZDpoxZU2bxIqIOsWDCv2Z4srNPqSQkHeKS4/WkW
        mef1+KQBCzc6fbPKS/ZWaqJm9w==
X-Google-Smtp-Source: ABdhPJxWhEMsOmrKUaIJxfYdW3ssU1UbLHlNNxkCQp8/6PkQ9tPWrmggcT57mh7M1RuZuG/g7eOfDg==
X-Received: by 2002:a37:b83:: with SMTP id 125mr22257396qkl.96.1593573088847;
        Tue, 30 Jun 2020 20:11:28 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id d14sm4728530qti.41.2020.06.30.20.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 20:11:28 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        kbuild test robot <lkp@intel.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: add build_bw_table for A640/A650
Date:   Tue, 30 Jun 2020 23:09:57 -0400
Message-Id: <20200701030958.24466-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets up bw tables for A640/A650 similar to A618/A630, 0 DDR bandwidth
vote, and the CNOC vote. A640 has the same CNOC addresses as A630 and was
working, but this is required for A650 to work.

Eventually the bw table should be filled by querying the interconnect
driver for each BW in the dts, but use these dummy tables for now.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 9921e632f1ca..ccd44d0418f8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -281,6 +281,76 @@ static void a618_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 	msg->cnoc_cmds_data[1][0] =  0x60000001;
 }
 
+static void a640_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
+{
+	/*
+	 * Send a single "off" entry just to get things running
+	 * TODO: bus scaling
+	 */
+	msg->bw_level_num = 1;
+
+	msg->ddr_cmds_num = 3;
+	msg->ddr_wait_bitmask = 0x01;
+
+	msg->ddr_cmds_addrs[0] = 0x50000;
+	msg->ddr_cmds_addrs[1] = 0x5003c;
+	msg->ddr_cmds_addrs[2] = 0x5000c;
+
+	msg->ddr_cmds_data[0][0] =  0x40000000;
+	msg->ddr_cmds_data[0][1] =  0x40000000;
+	msg->ddr_cmds_data[0][2] =  0x40000000;
+
+	/*
+	 * These are the CX (CNOC) votes - these are used by the GMU but the
+	 * votes are known and fixed for the target
+	 */
+	msg->cnoc_cmds_num = 3;
+	msg->cnoc_wait_bitmask = 0x01;
+
+	msg->cnoc_cmds_addrs[0] = 0x50034;
+	msg->cnoc_cmds_addrs[1] = 0x5007c;
+	msg->cnoc_cmds_addrs[2] = 0x5004c;
+
+	msg->cnoc_cmds_data[0][0] =  0x40000000;
+	msg->cnoc_cmds_data[0][1] =  0x00000000;
+	msg->cnoc_cmds_data[0][2] =  0x40000000;
+
+	msg->cnoc_cmds_data[1][0] =  0x60000001;
+	msg->cnoc_cmds_data[1][1] =  0x20000001;
+	msg->cnoc_cmds_data[1][2] =  0x60000001;
+}
+
+static void a650_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
+{
+	/*
+	 * Send a single "off" entry just to get things running
+	 * TODO: bus scaling
+	 */
+	msg->bw_level_num = 1;
+
+	msg->ddr_cmds_num = 3;
+	msg->ddr_wait_bitmask = 0x01;
+
+	msg->ddr_cmds_addrs[0] = 0x50000;
+	msg->ddr_cmds_addrs[1] = 0x50004;
+	msg->ddr_cmds_addrs[2] = 0x5007c;
+
+	msg->ddr_cmds_data[0][0] =  0x40000000;
+	msg->ddr_cmds_data[0][1] =  0x40000000;
+	msg->ddr_cmds_data[0][2] =  0x40000000;
+
+	/*
+	 * These are the CX (CNOC) votes - these are used by the GMU but the
+	 * votes are known and fixed for the target
+	 */
+	msg->cnoc_cmds_num = 1;
+	msg->cnoc_wait_bitmask = 0x01;
+
+	msg->cnoc_cmds_addrs[0] = 0x500a4;
+	msg->cnoc_cmds_data[0][0] =  0x40000000;
+	msg->cnoc_cmds_data[1][0] =  0x60000001;
+}
+
 static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 {
 	/* Send a single "off" entry since the 630 GMU doesn't do bus scaling */
@@ -327,6 +397,10 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 
 	if (adreno_is_a618(adreno_gpu))
 		a618_build_bw_table(&msg);
+	else if (adreno_is_a640(adreno_gpu))
+		a640_build_bw_table(&msg);
+	else if (adreno_is_a650(adreno_gpu))
+		a650_build_bw_table(&msg);
 	else
 		a6xx_build_bw_table(&msg);
 
-- 
2.26.1

