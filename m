Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F1EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A394E20829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733529;
	bh=AzfBO0Ss+lFPbvaEERr2Q/V9+PF3Xyj5zsEjaRJSj2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OxcKZCIb3vfTYmFTXXcDNOROVhEndECpa+IGHXX1wZf4NYTC6KfyFhgpYxg5Ur4Z/
	 bJDNKpym5QE5431TNujUsRndXz2uB0aREbJDDkAfII9xgwtV5Hm6gEiCV8NqrBHfmb
	 JUnbl41COXZrnWXBXbrARMoRO8tZwNLa0BvEESrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgIJKZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbgIJKYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:15 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8888A21D80;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=AzfBO0Ss+lFPbvaEERr2Q/V9+PF3Xyj5zsEjaRJSj2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIGrwLVvOVD7xTN/ngOAHU9zsi4SOCRj0XVAIKxDMKDiAcHnNLig+JmEL7/M0Bpt1
         ElaTlRikyulmpIhy4lFnHLjCxyWFsKjyGZCOsu98YORGwf3PZnp5aSg/haE2ddfKXL
         s5qRhfrkBReucvaASqbseXsTuKZzP+i0XkXcMGbw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EIO6-MG; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] drm/amd/display: kernel-doc: document force_timing_sync
Date:   Thu, 10 Sep 2020 12:24:04 +0200
Message-Id: <e781bbcaf3484958f846640499eef44b93455ca7.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned when running "make htmldocs":

	./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:345: warning: Function parameter or member 'force_timing_sync' not described in 'amdgpu_display_manager'

This new struct member was not documented at kernel-doc markup.

Fixes: 3d4e52d0cf24 ("drm/amd/display: Add debugfs for forcing stream timing sync")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a7856ae2e5f5..e00bd967bda4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -149,6 +149,8 @@ struct amdgpu_dm_backlight_caps {
  * @cached_state: Caches device atomic state for suspend/resume
  * @cached_dc_state: Cached state of content streams
  * @compressor: Frame buffer compression buffer. See &struct dm_comressor_info
+ * @force_timing_sync: set via debugfs. When set, indicates that all connected
+ *		       displays will be forced to synchronize.
  */
 struct amdgpu_display_manager {
 
-- 
2.26.2

