Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F205CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004A220575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363544;
	bh=IZM81WLlvh0/dPfb23etI7Ae/UROhw9c2iDXJF2NLxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OyixGp1SpZLVNuakar70eLd5b4ywE7wK650KMQ9F7+Ty2l/QhAFAscMi4GCMYQG27
	 1N7HZwb3pTgQpBQ+WYXvdGjyjYB5n8WxXWxP3HH84rxfhOgXbVAG5GqsfvrMDuIViu
	 73UbkYR0ynAkrc+ebBKqt9nG6VDXgcBih8cDJ7i8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbgEMJwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387780AbgEMJwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:52:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE5720575;
        Wed, 13 May 2020 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363538;
        bh=IZM81WLlvh0/dPfb23etI7Ae/UROhw9c2iDXJF2NLxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ufn1QnwBN8HuyH1sYVHtc14yu1CwZ2wrpdmAZmfCyUuJOxsr65As/q4JUxqq4ug86
         ByKB1+EHwZ7d7Ydqo9oavLxtI6CoA12ATI0Lgs6+o7I+5na6WziOmP/OXb692RZb3s
         0XLVAtf9c/wRXMfrKtB5Pb5i8tzyPIzMLoBIZ/rQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 003/118] drm/amdgpu: move kfd suspend after ip_suspend_phase1
Date:   Wed, 13 May 2020 11:43:42 +0200
Message-Id: <20200513094417.921191057@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit c457a273e118bb96e1db8d1825f313e6cafe4258 ]

This sequence change should be safe as what did in ip_suspend_phase1
is to suspend DCE only. And this is a prerequisite for coming
redundant cg/pg ungate dropping.

Fixes: 487eca11a321ef ("drm/amdgpu: fix gfx hang during suspend with video playback (v2)")
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f184cdca938de..1ddf2460cf834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3328,12 +3328,12 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	amdgpu_amdkfd_suspend(adev);
-
 	amdgpu_ras_suspend(adev);
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 
+	amdgpu_amdkfd_suspend(adev);
+
 	/* evict vram memory */
 	amdgpu_bo_evict_vram(adev);
 
-- 
2.20.1



