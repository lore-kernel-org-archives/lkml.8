Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1ADC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F1920675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608462;
	bh=21MFFf//RtKaIZLcaKrDCdFNzKFVWXXoj5VMt6EwnhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1AJIR03XS36O4thqvO7BVrDXiqv9jqeTWTdKcyqSCZKFJe08qaFa6gojC4+Dpcdww
	 ihalV/ghC5EwDU5y+BB5yPMCQnDWNvLXXsx94nB1v//uCBreKmQWgwP+s9D8qC+eNH
	 ZDMyhsAFiRyj5eCT36nDSoYoJUIBXcu8FB1hNOsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgBMPlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:41:01 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:48168 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgBMPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:40:48 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 01DFdZHW005809;
        Fri, 14 Feb 2020 00:39:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01DFdZHW005809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581608377;
        bh=CfJCXYbZyd9BrXzzHCGYQJ2nq7lm/XIX9LdBbFyn7y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsBBbauoUybEtrfn3+2H3+F41G0+jLVrnwKEsgjcE45ITaP0X56kk+pfz0PvDxtp0
         C7BqfP6FkxlOTo5PpU0Dbl5q0YcA7mayQ1npkdr7HLjzJ8m1PXwv8TBMoEFgcSHuvl
         hn1hVn/1fEw/XnOSdsG1bMd34N1CrefL5TKMo1LamM1ILdJG0nANYBx4oEtVHCKfmY
         oWHC4Oq9MyB0sOfEgOB15ADba8/ZFXSEwami3fhbGycBki9yzERT+iN2Nb7ZH7OW7w
         z8eKE/t7QLxGqAYV/doWA8/I5Yg+IYhThyO/bWGFLv7tX8LJYOs2qMuno1xRa0vd7W
         oAAbFf/RfEe+Q==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=8F=AB=D3nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/radeon: fix build rules of *_reg_safe.h
Date:   Fri, 14 Feb 2020 00:39:25 +0900
Message-Id: <20200213153928.28407-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213153928.28407-1-masahiroy@kernel.org>
References: <20200213153928.28407-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if_changed must have FORCE as a prerequisite, and the targets must be
added to 'targets'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/radeon/Makefile | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index 9d5d3dc1011f..fda115cefe4d 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -4,39 +4,39 @@
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
 hostprogs := mkregtable
-clean-files := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
+targets := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
 
 quiet_cmd_mkregtable = MKREGTABLE $@
       cmd_mkregtable = $(obj)/mkregtable $< > $@
 
-$(obj)/rn50_reg_safe.h: $(src)/reg_srcs/rn50 $(obj)/mkregtable
+$(obj)/rn50_reg_safe.h: $(src)/reg_srcs/rn50 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r100_reg_safe.h: $(src)/reg_srcs/r100 $(obj)/mkregtable
+$(obj)/r100_reg_safe.h: $(src)/reg_srcs/r100 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r200_reg_safe.h: $(src)/reg_srcs/r200 $(obj)/mkregtable
+$(obj)/r200_reg_safe.h: $(src)/reg_srcs/r200 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/rv515_reg_safe.h: $(src)/reg_srcs/rv515 $(obj)/mkregtable
+$(obj)/rv515_reg_safe.h: $(src)/reg_srcs/rv515 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r300_reg_safe.h: $(src)/reg_srcs/r300 $(obj)/mkregtable
+$(obj)/r300_reg_safe.h: $(src)/reg_srcs/r300 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r420_reg_safe.h: $(src)/reg_srcs/r420 $(obj)/mkregtable
+$(obj)/r420_reg_safe.h: $(src)/reg_srcs/r420 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/rs600_reg_safe.h: $(src)/reg_srcs/rs600 $(obj)/mkregtable
+$(obj)/rs600_reg_safe.h: $(src)/reg_srcs/rs600 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r600_reg_safe.h: $(src)/reg_srcs/r600 $(obj)/mkregtable
+$(obj)/r600_reg_safe.h: $(src)/reg_srcs/r600 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/evergreen_reg_safe.h: $(src)/reg_srcs/evergreen $(obj)/mkregtable
+$(obj)/evergreen_reg_safe.h: $(src)/reg_srcs/evergreen $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/cayman_reg_safe.h: $(src)/reg_srcs/cayman $(obj)/mkregtable
+$(obj)/cayman_reg_safe.h: $(src)/reg_srcs/cayman $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
 $(obj)/r100.o: $(obj)/r100_reg_safe.h $(obj)/rn50_reg_safe.h
-- 
2.17.1

