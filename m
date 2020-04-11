Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7260C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7253215A4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646655;
	bh=JKifc22C2UL+b3jQWkj/4fHSC1WFMr8V0XiS/e49728=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ELSXZYYh3Kq41HRsQYP8Lv7sJFDrL/qRCwS1puYvbGg+sOCAvs6ANmFBFNEd4H94O
	 Y1bDazHrDyRXSQUL9ZXpJGKJzmJ+53yW4NViv3DSVhRpiw7FcDqSAnS3i6E3taC3qw
	 BHyZmbscm8hBdF/hnbR5YHfmNQW9ICed6P9SzI/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgDKXKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbgDKXKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:10:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5357A21924;
        Sat, 11 Apr 2020 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646652;
        bh=JKifc22C2UL+b3jQWkj/4fHSC1WFMr8V0XiS/e49728=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+S58iBHl+TaPsMDf5PfA7GxFAGfx3ah7gPrivEnyAL8i+m5HRCUYzX+m5wZ60bfU
         hTyRantXQfcm8EMGNnVIBDpFpbd6Z3wfUOB3uVOcuQ4g4ZBa/xXftbiCOcoeRm03cb
         4uLFUoXIi9Q7AmRX/czaf3/ZQXSpzIkK9KSDyr9I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peikang Zhang <peikang.zhang@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 055/108] drm/amd/display: dc_get_vmid_use_vector() crashes when get called
Date:   Sat, 11 Apr 2020 19:08:50 -0400
Message-Id: <20200411230943.24951-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peikang Zhang <peikang.zhang@amd.com>

[ Upstream commit 68bbca15e7062f4ae16531e29893f78d0b4840b6 ]

[Why]
int i can go out of boundary which will cause crash

[How]
Fixed the maximum value of i to avoid i going out of boundary

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index a96d8de9380e6..f2b39ec35c898 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -62,7 +62,7 @@ int dc_get_vmid_use_vector(struct dc *dc)
 	int i;
 	int in_use = 0;
 
-	for (i = 0; i < dc->vm_helper->num_vmid; i++)
+	for (i = 0; i < MAX_HUBP; i++)
 		in_use |= dc->vm_helper->hubp_vmid_usage[i].vmid_usage[0]
 			| dc->vm_helper->hubp_vmid_usage[i].vmid_usage[1];
 	return in_use;
-- 
2.20.1

