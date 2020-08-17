Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2BAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B42823C3F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678157;
	bh=vSmbqkIxhcGcQn3a2A2tY4h80W1wyonKyRhHieL1P9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MzCbP6VfZfbYIpuisuupiGdptSIg0/YDXVbEHqMVaAxOm/s2Oi4+hf2Kn/pDz77r2
	 WpfmfTHexzUtrOPFSDQOtaycXmQdIJiLZgojOuuv+SNNMle0IYxYAgLgqdkDX9FQpS
	 XZ70UGvZDkCSXdHIlOBZW6fP2nOpAHk+zGz78R5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgHQP3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729845AbgHQP1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:27:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45C423B30;
        Mon, 17 Aug 2020 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678027;
        bh=vSmbqkIxhcGcQn3a2A2tY4h80W1wyonKyRhHieL1P9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTo8vTSIWvLUw0aRAYbwgKewW+g4ptARmiLkFh89v0Dihovb29vkoah9Pbo35836O
         3NzSWmwb3G3QgpSU6BYoa4AitBDEjyMcb79C/f11cN8/jjH3LIDiUhPyL4wYvlvf6z
         TnsT5UjDJNG9PLciFZJdv6JV2L43NfNlkPm968kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 194/464] drm/amdgpu: ensure 0 is returned for success in jpeg_v2_5_wait_for_idle
Date:   Mon, 17 Aug 2020 17:12:27 +0200
Message-Id: <20200817143843.115247097@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 57f01856645afe4c3d0f9915ee2bb043e8dd7982 ]

In the cases where adev->jpeg.num_jpeg_inst is zero or the condition
adev->jpeg.harvest_config & (1 << i) is always non-zero the variable
ret is never set to an error condition and the function returns
an uninitialized value in ret.  Since the only exit condition at
the end if the function is a success then explicitly return
0 rather than a potentially uninitialized value in ret.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 14f43e8f88c5 ("drm/amdgpu: move JPEG2.5 out from VCN2.5")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 713c325604453..25ebf8f19b85a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -462,7 +462,7 @@ static int jpeg_v2_5_wait_for_idle(void *handle)
 			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int jpeg_v2_5_set_clockgating_state(void *handle,
-- 
2.25.1



