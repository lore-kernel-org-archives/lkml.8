Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63C0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917FD20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858839;
	bh=UmWweuILqyIifIPDzc1A/kZuF7BnKE7EItXbgniZkEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUpHvswvEfqIgGUhPkWCKttm49vEU4AbLqPgT2PNHfnQNnyN5P7yb6Nlp0FM8JH23
	 w1wTHBUzzvJbx8CPPkiR2wl/lgtl3xTdgDfAgCvE75//Wul3DjCPhcVutfCzoQbJzu
	 otp/jzpfuwviLZjwBx5D82lrpm2h3RBf2Hu1P6BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbgAXJki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732451AbgAXJkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:40:32 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A86E020838;
        Fri, 24 Jan 2020 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858832;
        bh=UmWweuILqyIifIPDzc1A/kZuF7BnKE7EItXbgniZkEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teZYMS3yyYh8MCCaDjBpWZgdD+ygua5k+kadk+dxDxvNOx+QqGJSRbDpXWkfF9Wo4
         PJmYEmcE2fszz8fJUNjWs4M+gJgx8HD8eKyyrpVb3ZjjCGNOypknhvdFEkl8LRpGXZ
         oBDrAPy3ZT9wW3x7Udby/MwAmHbMIvhkOJSH8y1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 053/102] drm/amdgpu: remove excess function parameter description
Date:   Fri, 24 Jan 2020 10:30:54 +0100
Message-Id: <20200124092814.336074918@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit d0580c09c65cff211f589a40e08eabc62da463fb ]

Fixes gcc warning:

drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:431: warning: Excess function
parameter 'sw' description in 'vcn_v2_5_disable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:550: warning: Excess function
parameter 'sw' description in 'vcn_v2_5_enable_clock_gating'

Fixes: cbead2bdfcf1 ("drm/amdgpu: add VCN2.5 VCPU start and stop")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 395c2259f979b..9d778a0b2c5e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -423,7 +423,6 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Disable clock gating for VCN block
  */
@@ -542,7 +541,6 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
  * vcn_v2_5_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Enable clock gating for VCN block
  */
-- 
2.20.1



