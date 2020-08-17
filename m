Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B01C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175F620772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597680632;
	bh=kuKbBbIW1D6iNkwGTnt8x0BsK8vTtVUUYTADUevJW/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JIs31kraaubx517FqECgCrHAww6DPjGZYxNjBhEQ0VmdbocXym+OL+ML37KewewVT
	 ZXnsEQaIBjmp8v3+sCBs2i6+KAkS+ku1yDm9qJ7S1joHNi3hPll00MEQt+7pNuFEyG
	 TMXsbetP0DurnBKI5hxSMiIvS7yGVunmOF9HwJIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbgHQQKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgHQPqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:46:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA752065D;
        Mon, 17 Aug 2020 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679163;
        bh=kuKbBbIW1D6iNkwGTnt8x0BsK8vTtVUUYTADUevJW/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaqoZXv1hkF6QxIsMRZDkFV0+JBnNFy/vP1gNWychXQhIAcL5CnWhDBqXkuLeCekV
         Iak7YZ1DSmmrLcAV3QjiThA36QghldKfiqPYM3X7l5o59HdMaaY6uuyX6TDa2kXiwQ
         Z6BrXWYNXv26eZ3/mzCr1v3kbkBVykQmggo+tfSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 090/393] drm/radeon: disable AGP by default
Date:   Mon, 17 Aug 2020 17:12:20 +0200
Message-Id: <20200817143823.997323672@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit ba806f98f868ce107aa9c453fef751de9980e4af ]

Always use the PCI GART instead. We just have to many cases
where AGP still causes problems. This means a performance
regression for some GPUs, but also a bug fix for some others.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 0cf0b00a0623e..6f0d1971099b7 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -171,12 +171,7 @@ int radeon_no_wb;
 int radeon_modeset = -1;
 int radeon_dynclks = -1;
 int radeon_r4xx_atom = 0;
-#ifdef __powerpc__
-/* Default to PCI on PowerPC (fdo #95017) */
 int radeon_agpmode = -1;
-#else
-int radeon_agpmode = 0;
-#endif
 int radeon_vram_limit = 0;
 int radeon_gart_size = -1; /* auto */
 int radeon_benchmarking = 0;
-- 
2.25.1



