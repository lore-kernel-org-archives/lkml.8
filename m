Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D18C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233FF20659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425355;
	bh=nu12upa2YBED248NaTn+dMF9VDPyyAVLRlkgIW0kpbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NKM1LbzED6DkjOtiNrYtjCe//d/adi0kyhRJP1tqb/K/qBll1JEFp5XYPVWAZ21fS
	 WDO9pFECMMOs9OEXkfKgOBytn5Mbo6jtbe/y7DdWTf1O6Wi1gN15uPS5fERKgZ6odm
	 fxs1aQtItB0jIlZG8QLi8M7S6lRsH1QXYeh1O2y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBWCWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgBWCVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:21:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3650D227BF;
        Sun, 23 Feb 2020 02:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424513;
        bh=nu12upa2YBED248NaTn+dMF9VDPyyAVLRlkgIW0kpbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFusnh3CzMkuJE20xiQaISpWKQAVIlxUn7/8LiscWMEwLj7i8gxgjLIn9LvwlyJEf
         OgwGAep4d4kehdnTv63b4xPqQtKSW5zpAyKyGshYsDYAQa8U+8bW0OE9iZWez8Coj9
         xfFozAzjDADh/MosncP3NYR1Na1/Od8YqrUL0PEg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Kolesa <daniel@octaforge.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 27/58] amdgpu: Prevent build errors regarding soft/hard-float FP ABI tags
Date:   Sat, 22 Feb 2020 21:20:48 -0500
Message-Id: <20200223022119.707-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Kolesa <daniel@octaforge.org>

[ Upstream commit 416611d9b6eebaeae58ed26cc7d23131c69126b1 ]

On PowerPC, the compiler will tag object files with whether they
use hard or soft float FP ABI and whether they use 64 or 128-bit
long double ABI. On systems with 64-bit long double ABI, a tag
will get emitted whenever a double is used, as on those systems
a long double is the same as a double. This will prevent linkage
as other files are being compiled with hard-float.

On ppc64, this code will never actually get used for the time
being, as the only currently existing hardware using it are the
Renoir APUs. Therefore, until this is testable and can be fixed
properly, at least make sure the build will not fail.

Signed-off-by: Daniel Kolesa <daniel@octaforge.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index b864869cc7e3e..6fa7422c51da5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -91,6 +91,12 @@ ifdef CONFIG_DRM_AMD_DC_DCN2_1
 ###############################################################################
 CLK_MGR_DCN21 = rn_clk_mgr.o rn_clk_mgr_vbios_smu.o
 
+# prevent build errors regarding soft-float vs hard-float FP ABI tags
+# this code is currently unused on ppc64, as it applies to Renoir APUs only
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn21/rn_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
+endif
+
 AMD_DAL_CLK_MGR_DCN21 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn21/,$(CLK_MGR_DCN21))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN21)
-- 
2.20.1

