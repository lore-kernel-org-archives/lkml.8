Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CB4C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819192187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl2+RkZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgBNGai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:30:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41530 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgBNGah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:30:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so8414259oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 22:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntwhmb838HNdG68VgBkMbYUyn9XVt7puNK0dtc2mxiU=;
        b=Bl2+RkZv0uKfnpwqzGIIxsKeThJkZXZ76VITQy9giZ6bgEBu0UV9/krz+5ZD7iRrHd
         /CoK51Nxbh2tquNgg0zTxh2q1hdt3NNU7A/fxgt8EcnYN3MPsTw1HLaPjRxZ7NC16/FH
         IDjt5ByQBiqH3d3tI9HIvlQHf2iQNmUwvG0Wk8JOFBczVwsx7iM6LVAmrWDQH8YZFhTG
         y5I6hGBQwm4WwgQzD6yX85fJO/Es1hEEyQerjlTe40XRO8x4FCsh7VrcBiV9ktIloURp
         MBv8JOvEoD2D+GMtAhl2GSfaWZlJEmc/+Hz1W1zXy6xkyYs/nzU+bRMp6yT/aoN2Luxz
         QWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntwhmb838HNdG68VgBkMbYUyn9XVt7puNK0dtc2mxiU=;
        b=Ro33QpPbPHT6jDB1GQCslVLpJL+QcZedd6mQlVCBFv27PvisqYYWhu/Sv9Ne8tFG6n
         W2f5gCA25ttzGXEd5ybS9XCpzAaynFtHMLYQcYQouc1S6CThfSGeCyfS+hjNf81ZmodB
         LuC985nDglYscacztijChr/EMeGcdUHoGR20ktrDSz7UaNPScjA4qVlHegY8WAFMh7uk
         fyiqlE/cLuQdgVflJQpHZAK1yWvIm7MKsSs1NZS1wS1f/XYy/e4+JTlp2yX2qwb7gOnt
         DZUlOU+vLxD3a1NSVHMpElAM0jvSGDFtvjUt2NG6R6O7NpUdpYUKPoWcV7YNhutTfwTG
         6ciA==
X-Gm-Message-State: APjAAAUDgvR7dBKhr5L2xXhUizPZY1I0suh3i/8rXfWFtDGe7/jsZh59
        qcGKJF4uZKeENybK7mBfyfk=
X-Google-Smtp-Source: APXvYqxxXnIoySUdm4W+GhJ2vz7rNqEhAKOFi0tphwN1shGVUp6HVae+n1bLo3B19UkUchCoRll9/g==
X-Received: by 2002:aca:6542:: with SMTP id j2mr873096oiw.69.1581661836582;
        Thu, 13 Feb 2020 22:30:36 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c123sm1483599oib.34.2020.02.13.22.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 22:30:36 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Don't take the address of skip_scdc_overwrite in dc_link_detect_helper
Date:   Thu, 13 Feb 2020 23:29:51 -0700
Message-Id: <20200214062950.14151-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:980:36:
warning: address of 'sink->edid_caps.panel_patch.skip_scdc_overwrite'
will always evaluate to 'true' [-Wpointer-bool-conversion]
                if (&sink->edid_caps.panel_patch.skip_scdc_overwrite)
                ~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
1 warning generated.

This is probably not what was intended so remove the address of
operator, which matches how skip_scdc_overwrite is handled in the rest
of the driver.

While we're here, drop an extra newline after this if block.

Fixes: a760fc1bff03 ("drm/amd/display: add monitor patch to disable SCDC read/write")
Link: https://github.com/ClangBuiltLinux/linux/issues/879
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

As an aside, I don't see skip_scdc_overwrite assigned a value anywhere,
is this working as intended?

 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 24d99849be5e..a3bfa05c545e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -977,10 +977,9 @@ static bool dc_link_detect_helper(struct dc_link *link,
 		if ((prev_sink != NULL) && ((edid_status == EDID_THE_SAME) || (edid_status == EDID_OK)))
 			same_edid = is_same_edid(&prev_sink->dc_edid, &sink->dc_edid);
 
-		if (&sink->edid_caps.panel_patch.skip_scdc_overwrite)
+		if (sink->edid_caps.panel_patch.skip_scdc_overwrite)
 			link->ctx->dc->debug.hdmi20_disable = true;
 
-
 		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
 			sink_caps.transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 			/*
-- 
2.25.0

