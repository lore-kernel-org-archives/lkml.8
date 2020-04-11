Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7BEC2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E098820787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607318;
	bh=m4etkLiEepcr0k8zXYpPGtfTEbrDtzPIjZMv44ZiuqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y40WRM4gTa1JdoDZLEWccSZk4SDOcLdbu17sS+7QIlb8+2fuUETGOCOxIQ9Q70N7b
	 kqTHCRu9rBZavQxymng2l6MeJX+/3MUHIYlyjytj/gv0bhv88plvXybViMF9ZoBD5J
	 p5XYInCWZ1cQGhfHz8WuGbadCGc9vXsBiFXejWN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgDKMPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgDKMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:15:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF6520787;
        Sat, 11 Apr 2020 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607313;
        bh=m4etkLiEepcr0k8zXYpPGtfTEbrDtzPIjZMv44ZiuqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tr3H90ue1nrpMqLIEj6Ti50zFEmp22djcfbk7KbdrhmbPvhH2uObIhZG75dan4JgU
         TLXnC1JvEzZWATlMmFCj8oUX5zBZVrRo6xOvyP5/CkSBbF4eI3wUXSU1/k8uNIrTw1
         2stHBb9AL0RTP/2yAdx3aeHY2gK0x6IBz1RetIWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Zhu <James.Zhu@amd.com>,
        Leo Liu <leo.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/54] drm/amdgpu: fix typo for vcn1 idle check
Date:   Sat, 11 Apr 2020 14:08:51 +0200
Message-Id: <20200411115509.193111462@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
References: <20200411115508.284500414@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Zhu <James.Zhu@amd.com>

[ Upstream commit acfc62dc68770aa665cc606891f6df7d6d1e52c0 ]

fix typo for vcn1 idle check

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 4f8f3bb218320..a54f8943ffa34 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -857,7 +857,7 @@ static int vcn_v1_0_set_clockgating_state(void *handle,
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (vcn_v1_0_is_idle(handle))
+		if (!vcn_v1_0_is_idle(handle))
 			return -EBUSY;
 		vcn_v1_0_enable_clock_gating(adev);
 	} else {
-- 
2.20.1



