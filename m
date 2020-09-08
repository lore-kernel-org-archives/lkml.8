Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4ECC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146CF2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599586100;
	bh=8yhRxylJ2GFyiDRs0r5TljFZQH5xX43Jd5wLm6fNRi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EDwgcNPtGb7rEu2pU/sBMdiSqXrsaQv4EFN25g/QPfNNKFY32gY7DsEjs/HoZnYV5
	 7h2DR7pBWkhkxTQ+5shcAMcUzG3pTC+WxwY5pjBZ05REIGppdUZfDLm+xaDsGJiWNT
	 0s14BvAoHeqK02dbCELW7uZ52Mce8d46Bln4v8Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgIHR2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57345 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731721AbgIHQQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:16:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254BB24815;
        Tue,  8 Sep 2020 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579819;
        bh=8yhRxylJ2GFyiDRs0r5TljFZQH5xX43Jd5wLm6fNRi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WO4TT44/PxkRUmHo1OHB70kNPphNUdj+BS1JLBV7vYT4u0IH/GGMBpYKFmxcTbZIv
         1Z/voALipP5BWqTd4NgikGcGLpycDjQxsIXqcz9/KMjF3OOrrnBe17BjJ0KcqDSvik
         Hkr7gcSXF5OWx4fxWk/awvE4YSrud8KOTD8qQ+Xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Furquan Shaikh <furquan@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 017/129] drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps object to 0 in amdgpu_dm_update_backlight_caps
Date:   Tue,  8 Sep 2020 17:24:18 +0200
Message-Id: <20200908152230.565628646@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Furquan Shaikh <furquan@google.com>

[ Upstream commit 5896585512e5156482335e902f7c7393b940da51 ]

In `amdgpu_dm_update_backlight_caps()`, there is a local
`amdgpu_dm_backlight_caps` object that is filled in by
`amdgpu_acpi_get_backlight_caps()`. However, this object is
uninitialized before the call and hence the subsequent check for
aux_support can fail since it is not initialized by
`amdgpu_acpi_get_backlight_caps()` as well. This change initializes
this local `amdgpu_dm_backlight_caps` object to 0.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Furquan Shaikh <furquan@google.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 247f53d41993d..3d131f21e5ab2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2064,6 +2064,8 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 #if defined(CONFIG_ACPI)
 	struct amdgpu_dm_backlight_caps caps;
 
+	memset(&caps, 0, sizeof(caps));
+
 	if (dm->backlight_caps.caps_valid)
 		return;
 
-- 
2.25.1



