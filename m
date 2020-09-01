Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6384C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFFF206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975677;
	bh=vVSSsP3Y/XVFbh6ozpW5G50KZzeYxxXkjl3o/olR8ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NSvzXs0aDFxzNAp7XAoS6Np45Jfli4U1WvM9IewljB6ehtNGSNvQdnLcB0eg/EAVK
	 oNAMn3FMfHOp45e9k0cDDFVyKPau6vbGpKnqmScBQQ2oUZxMo0e4l0/05n2OIztu03
	 ybr9Lcy2HW8mKEPft5WO4z4ZmEcsELGjAE8Sjebk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbgIAPyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbgIAPq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:46:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91123206FA;
        Tue,  1 Sep 2020 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975188;
        bh=vVSSsP3Y/XVFbh6ozpW5G50KZzeYxxXkjl3o/olR8ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uW+FNuo0nVkIA3EEVzUUenrkbTgBTQ7TlhcmHn33Bo+jvfvqX7LugxgEnhxh8ovDL
         ItRpAPVfYKM31jMiIVxM1Y3Sreopp4nBTLNsWw54n0LknsgAPfDoQ9maBDrqoWzW2s
         nRtK92CLHyPg0P15+fLKTxBTnt7eFzyZxVjpFxUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiansong Chen <Jiansong.Chen@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.8 216/255] drm/amdgpu/gfx10: refine mgcg setting
Date:   Tue,  1 Sep 2020 17:11:12 +0200
Message-Id: <20200901151011.055356425@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiansong Chen <Jiansong.Chen@amd.com>

commit de7a1b0b8753e1b0000084f0e339ffab295d27ef upstream.

1. enable ENABLE_CGTS_LEGACY to fix specviewperf11 random hang.
2. remove obsolete RLC_CGTT_SCLK_OVERRIDE workaround.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6854,10 +6854,8 @@ static void gfx_v10_0_update_medium_grai
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
-			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK);
-
-		/* only for Vega10 & Raven1 */
-		data |= RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK;
+			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK |
+			  RLC_CGTT_MGCG_OVERRIDE__ENABLE_CGTS_LEGACY_MASK);
 
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);


