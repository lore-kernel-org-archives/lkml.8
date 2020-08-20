Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA29BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946E4207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927920;
	bh=GtoAiz2dXQyGy3F3OjN1t/VVSZB76SNZaVG7ljVY/TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aPrTXohPjktAylvbZqbXUltgreVG5cpM3JG4iw9DlUXT6dIa0yrPCfcUBkaMH32k+
	 TrBKV8ZtNtGQlvmYBv7OCccxdSC6W6SvdXyYKh2F7XWKXP/sJ/zF4gMvTiQCV6GclZ
	 0YJ2tUv9C6w0o1jTdEeNgVRHOb+kp6ZAA0R/2xBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgHTMv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgHTJnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:43:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18BF9207DE;
        Thu, 20 Aug 2020 09:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916631;
        bh=GtoAiz2dXQyGy3F3OjN1t/VVSZB76SNZaVG7ljVY/TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqZmmG1EPIUX2/57H/Pb/0sNIQHsxkuhIUJA0BXleK7wfCh53+hpPoJpnMGs4DDtN
         6gigje0heGsppsRQ9Gdn3ILdmhwHSeGTt1IbpoKSzlePQez6OOYh2kfD0O1J7joQZW
         PBQAuJ1AasKGbmvluvl7E172uQI6YnU2x8qZ4MaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 5.7 197/204] drm/amdgpu: fix ordering of psp suspend
Date:   Thu, 20 Aug 2020 11:21:34 +0200
Message-Id: <20200820091616.019837757@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexdeucher@gmail.com>

The ordering of psp_tmr_terminate() and psp_asd_unload()
got reversed when the patches were applied to stable.

This patch does not exist in Linus' tree because the ordering
is correct there.  It got reversed when the patches were applied
to stable.  This patch is for stable only.

Fixes: 22ff658396b446 ("drm/amdgpu: asd function needs to be unloaded in suspend phase")
Fixes: 2c41c968c6f648 ("drm/amdgpu: add TMR destory function for psp")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 5.7.x
Cc: Huang Rui <ray.huang@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1679,15 +1679,15 @@ static int psp_suspend(void *handle)
 		}
 	}
 
-	ret = psp_tmr_terminate(psp);
+	ret = psp_asd_unload(psp);
 	if (ret) {
-		DRM_ERROR("Falied to terminate tmr\n");
+		DRM_ERROR("Failed to unload asd\n");
 		return ret;
 	}
 
-	ret = psp_asd_unload(psp);
+	ret = psp_tmr_terminate(psp);
 	if (ret) {
-		DRM_ERROR("Failed to unload asd\n");
+		DRM_ERROR("Falied to terminate tmr\n");
 		return ret;
 	}
 


