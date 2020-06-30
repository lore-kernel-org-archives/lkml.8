Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CEEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BC12068F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MUSFN5Ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgF3Sq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:46:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:29726 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgF3Sq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:46:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593542785; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pCxMGoAE11mzNnegsROvEKZ7dz7oA11oMEGTQyVjkqw=; b=MUSFN5ChhpeBfzbx/3ev0COh3s97muyZqWB9g+zCxhl4aB/KWS6Y9CN+COd/uEgyltXNhXFG
 gEYBJrIQ1LZxbUE0pGD+H3tTYhheS7LabvOUC9aOxwHbS9UNYkEvTua5TMNMechf2w7TzsSH
 yi6weF47bkY42MuPr7lTaBDPJtU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5efb88806bebe35deb4d03fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jun 2020 18:46:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 504ADC433CB; Tue, 30 Jun 2020 18:46:24 +0000 (UTC)
Received: from linuxdisplay-lab-04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tanmay)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31A94C433C6;
        Tue, 30 Jun 2020 18:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31A94C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tanmay@codeaurora.org
From:   Tanmay Shah <tanmay@codeaurora.org>
To:     robh+dt@kernel.org, swboyd@chromium.org, sam@ravnborg.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, seanpaul@chromium.org,
        robdclark@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        aravindh@codeaurora.org, abhinavk@codeaurora.org,
        chandanu@codeaurora.org, varar@codeaurora.org,
        Tanmay Shah <tanmay@codeaurora.org>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v8 2/6] drm: add constant N value in helper file
Date:   Tue, 30 Jun 2020 11:45:03 -0700
Message-Id: <20200630184507.15589-3-tanmay@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630184507.15589-1-tanmay@codeaurora.org>
References: <20200630184507.15589-1-tanmay@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chandan Uddaraju <chandanu@codeaurora.org>

The constant N value (0x8000) is used by i915 DP
driver. Define this value in dp helper header file
to use in multiple Display Port drivers. Change
i915 driver accordingly.

Change in v6: Change commit message

Signed-off-by: Chandan Uddaraju <chandanu@codeaurora.org>
Signed-off-by: Vara Reddy <varar@codeaurora.org>
Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 2 +-
 include/drm/drm_dp_helper.h                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index c1836095ea38..81c461aeb3ba 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -8085,7 +8085,7 @@ static void compute_m_n(unsigned int m, unsigned int n,
 	 * which the devices expect also in synchronous clock mode.
 	 */
 	if (constant_n)
-		*ret_n = 0x8000;
+		*ret_n = DP_LINK_CONSTANT_N_VALUE;
 	else
 		*ret_n = min_t(unsigned int, roundup_pow_of_two(n), DATA_LINK_N_MAX);
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 1165ec105638..73dae5bd6048 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1134,6 +1134,7 @@
 #define DP_MST_PHYSICAL_PORT_0 0
 #define DP_MST_LOGICAL_PORT_0 8
 
+#define DP_LINK_CONSTANT_N_VALUE 0x8000
 #define DP_LINK_STATUS_SIZE	   6
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

