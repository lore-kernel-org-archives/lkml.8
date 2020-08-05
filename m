Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF1BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04C721D95
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFCELN3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgHEU7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:59:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46154 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgHEU72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596661167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jAIXysMz+ztRK+9IphGR8JksjwMIkYoVzpw6WZkH4eA=;
        b=ZFCELN3r8CfGVKMCC6xm4dmTk3B7ZmFqDPU9ETeLF/YZ/wL6PCIouvPMN71ZWHzlaQqzc/
        samppKUp+Hhe/Yot0vQGT1uaV4UPbz8Y408fGD8HL8Eo5cNvFSyICjVpywSxCX0JlWwkSU
        ZNrNjMw3gOK0/jhD4oL033wI1OXTNn0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-0kcvxPAVNCOxW5vtBbPMYQ-1; Wed, 05 Aug 2020 16:59:23 -0400
X-MC-Unique: 0kcvxPAVNCOxW5vtBbPMYQ-1
Received: by mail-qk1-f197.google.com with SMTP id 3so31961510qkv.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 13:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jAIXysMz+ztRK+9IphGR8JksjwMIkYoVzpw6WZkH4eA=;
        b=dFWcr81grE7kDg0Na5rOk3EggRS4KntWElqLxSDjnX4TmZ7D6I6/7bdjwKCpHqtCSs
         u3MycoYAQH5GXmVHdfIKs1s7diE+oRsB6cjSwkgCGBJGcnhMlqqFt7MaOyhXpmsrOqHz
         XUY9RGwvb6K0u4YPjFiCM9fjwNCiWLnUl054FTD4iuUixZmxKkl4HyHByRs0XsIvi72M
         lCg5+adfx/ZBirp8zT8MFteXboM656tI4KtCJGJSVuP5On3hUsqVhj/LbB/XlotBgXF/
         ox6NcQXnayImrDi/9YSjJ3h3eH87ft/cNBYlXKlWL5v5B/SclIBiq+m4YfT/TxrhRipc
         lhXw==
X-Gm-Message-State: AOAM5300DShFbtOvDcNbN4acQ1g0j5Aa1Chz1Zd40nj/VKK2W/rO4/ue
        oEsMyV55t0APyQUT0tnT3fBfXYxdLTGQFlwvr92EYspBUilc8pIPb7e4Z9y+e0c6UJZ0uSkI5P5
        70+NiXBuDWEHsxJOHuvco0VSw
X-Received: by 2002:a37:84c:: with SMTP id 73mr5330200qki.464.1596661163155;
        Wed, 05 Aug 2020 13:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMeglqrJbSFSxjPBAaJs2BV5HNNaqoHH3sQfpvvAW+bLdrzYALcTYC6CF/kqo4ivso2fbfUg==
X-Received: by 2002:a37:84c:: with SMTP id 73mr5330186qki.464.1596661162880;
        Wed, 05 Aug 2020 13:59:22 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c21sm2346084qka.9.2020.08.05.13.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 13:59:22 -0700 (PDT)
From:   trix@redhat.com
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        airlied@redhat.com, yakui.zhao@intel.com, alan@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/gma500: fix error check
Date:   Wed,  5 Aug 2020 13:59:11 -0700
Message-Id: <20200805205911.20927-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Reviewing this block of code in cdv_intel_dp_init()

ret = cdv_intel_dp_aux_native_read(gma_encoder, DP_DPCD_REV, ...

cdv_intel_edp_panel_vdd_off(gma_encoder);
if (ret == 0) {
	/* if this fails, presume the device is a ghost */
	DRM_INFO("failed to retrieve link info, disabling eDP\n");
	drm_encoder_cleanup(encoder);
	cdv_intel_dp_destroy(connector);
	goto err_priv;
} else {

The (ret == 0) is not strict enough.
cdv_intel_dp_aux_native_read() returns > 0 on success
otherwise it is failure.

So change to <=

Fixes: d112a8163f83 ("gma500/cdv: Add eDP support")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index f41cbb753bb4..720a767118c9 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -2078,7 +2078,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 					       intel_dp->dpcd,
 					       sizeof(intel_dp->dpcd));
 		cdv_intel_edp_panel_vdd_off(gma_encoder);
-		if (ret == 0) {
+		if (ret <= 0) {
 			/* if this fails, presume the device is a ghost */
 			DRM_INFO("failed to retrieve link info, disabling eDP\n");
 			drm_encoder_cleanup(encoder);
-- 
2.18.1

