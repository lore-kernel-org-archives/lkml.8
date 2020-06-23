Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9538C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC5B20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933922;
	bh=dWj/02JCFhcZIyCPN78y8G/mcwUuHQlsXctOb05YzsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGulwlAEWmoqO1XABZcBzbehQRWrFjmzy1LLCN66+EtAuqDvS1XV+wGnel+tSbl3f
	 FoR74O0o32aoj0QR1iCUHp3D5DWrxSoVapQafpxIjcz5oF/OWyBo9nsiZulcBGJnRO
	 9qv0KhCt+412y91MzYgFEC8Caw2GHeGQ+/wrRbNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbgFWRgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387595AbgFWRgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:36:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA33820781;
        Tue, 23 Jun 2020 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933794;
        bh=dWj/02JCFhcZIyCPN78y8G/mcwUuHQlsXctOb05YzsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhEqhvEyIsflmQ80fUMyz8f9fcUWDkyEpdYhy/54ePeHFyRKye5Ih51tqUgK73EaJ
         43hiNxRQtXOrG2NekPpEHDITSx9yTBcM1G7oYZBcF6kQD0isvcbu0IsSnIf/7SjSVl
         AuKDNvOnOJowL7Cj6yo7aJNFcC4eXXRLk4/kAwSg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 03/15] drm/amd/display: Use kfree() to free rgb_user in calculate_user_regamma_ramp()
Date:   Tue, 23 Jun 2020 13:36:18 -0400
Message-Id: <20200623173630.1355971-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173630.1355971-1-sashal@kernel.org>
References: <20200623173630.1355971-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

[ Upstream commit 43a562774fceba867e8eebba977d7d42f8a2eac7 ]

Use kfree() instead of kvfree() to free rgb_user in
calculate_user_regamma_ramp() because the memory is allocated with
kcalloc().

Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 962900932beed..11ea1a0e629bd 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1561,7 +1561,7 @@ bool calculate_user_regamma_ramp(struct dc_transfer_func *output_tf,
 
 	kfree(rgb_regamma);
 rgb_regamma_alloc_fail:
-	kvfree(rgb_user);
+	kfree(rgb_user);
 rgb_user_alloc_fail:
 	return ret;
 }
-- 
2.25.1

