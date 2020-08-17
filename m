Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B808C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B2B20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693449;
	bh=FAWNIdyvFpKy3gLuGZk3l1aE1ffiq5S95HtYP5TCpc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bWaZGc8Pi9Uht3+MMfXev5B7p9Ub9BSQmFq1DCSsi0tUGPMakTx4eSZsKSANThjRF
	 b7m/WuIFGgJBMadP95Y54IWO2MC/jYSRDXgurOyrL3AfqVJW/cHiQjoNEMSoef4TSg
	 ZuVbcwuMv4HYR4nUkLzOBk6Nqak88DlKlb7yZ9Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgHQToI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbgHQPXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:23:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BD123109;
        Mon, 17 Aug 2020 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677783;
        bh=FAWNIdyvFpKy3gLuGZk3l1aE1ffiq5S95HtYP5TCpc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwbWnupcXDiOIVg4dca5qhMe8ZEBCqGBGs/OqgepCWMOaJqVc/pT0d2IQY5ZEJZ9i
         Qq5SGt/26RHJytrTPfLoKe7y5tsCU8xrOJixGlSX/ZAr3fnXdW52fI/RuZ4ZtDhLvC
         LJ66bEMyDc8ELqnrgVKmcOh52enemJOPzxq5HrqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 106/464] drm/radeon: disable AGP by default
Date:   Mon, 17 Aug 2020 17:10:59 +0200
Message-Id: <20200817143838.874655870@linuxfoundation.org>
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
index 62b5069122cc4..4cd30613fa1dd 100644
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



