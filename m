Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA88C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2659217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608451;
	bh=VhDtzwFYkeTirnxA9yvluMvQsQ2um76FjEg+WXz6Pcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1vBaQ8SYZQg6zBlYmrjiYiypoqb0p/lWVn+f3Hmabnv7DjLrOlhIPkaL7jgI+m5AX
	 N/j8bEbVgnHXHkctDUyszeUspSYyDhFNOdjh1HGzYtuVfPjjTM3aIgVVPnVtYmyDBJ
	 2fdmxzKw5JXR0Y7kB0dw4wZHzfIQu3nwhO/uf0mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgBMPku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:40:50 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:48165 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbgBMPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:40:47 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 01DFdZHX005809;
        Fri, 14 Feb 2020 00:39:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01DFdZHX005809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581608378;
        bh=IlwdwKMAl2Y7tol907IK801j7CE31/4yLlpyncvGYes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLcZQrzTMOdJOuMTafwrQ7IZiK6NZOr3c+6c42sh+n4IrIeonrmLFPM/yBMIXd5uj
         i2jCRD80XdltMSpGR9KjT+ypoF9CFA37E8iFR6rLXgelgwUPXHwOFqwTnSOsMyVOi/
         07+ewsRRDXgQz6cNUfMZ0UDkPyCCZRtPcHJnNq8aG8sJxUGPy23r5QDlYkzt8hBw0G
         GxdhNCIRbG0w+h+kbmew+LeNeKv/cljCEGCa5/qJ/780rdudasBQZz12N8X1DQSh1V
         AxhItSv6F3mFRYV8c3FbxEFMVGOJIh0E9onqMqEtB5dg9HJhNWWQqYNlgk8cwRJBBe
         lsBZbP8V7xUFg==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=8F=AB=D3nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/radeon: use pattern rule to avoid code duplication in Makefile
Date:   Fri, 14 Feb 2020 00:39:26 +0900
Message-Id: <20200213153928.28407-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213153928.28407-1-masahiroy@kernel.org>
References: <20200213153928.28407-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Makefile repeats similar build rules. Use a pattern rule.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/radeon/Makefile | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index fda115cefe4d..480a8d4a3c82 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -9,34 +9,7 @@ targets := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300
 quiet_cmd_mkregtable = MKREGTABLE $@
       cmd_mkregtable = $(obj)/mkregtable $< > $@
 
-$(obj)/rn50_reg_safe.h: $(src)/reg_srcs/rn50 $(obj)/mkregtable FORCE
-	$(call if_changed,mkregtable)
-
-$(obj)/r100_reg_safe.h: $(src)/reg_srcs/r100 $(obj)/mkregtable FORCE
-	$(call if_changed,mkregtable)
-
-$(obj)/r200_reg_safe.h: $(src)/reg_srcs/r200 $(obj)/mkregtable FORCE
-	$(call if_changed,mkregtable)
-
-$(obj)/rv515_reg_safe.h: $(src)/reg_srcs/rv515 $(obj)/mkregtable FORCE
-	$(call if_changed,mkregtable)
-
-$(obj)/r300_reg_safe.h: $(src)/reg_srcs/r300 $(obj)/mkregtable FORCE
-	$(call if_changed,mkregtable)
-
-$(obj)/r420_reg_safe.h: $(src)/reg_srcs/r420 $(obj)/mkregtable FORCE
-	$(call if_changed,mkregtable)
-
-$(obj)/rs600_reg_safe.h: $(src)/reg_srcs/rs600 $(obj)/mkregtable FORCE
-	$(call if_changed,mkregtable)
-
-$(obj)/r600_reg_safe.h: $(src)/reg_srcs/r600 $(obj)/mkregtable FORCE
-	$(call if_changed,mkregtable)
-
-$(obj)/evergreen_reg_safe.h: $(src)/reg_srcs/evergreen $(obj)/mkregtable FORCE
-	$(call if_changed,mkregtable)
-
-$(obj)/cayman_reg_safe.h: $(src)/reg_srcs/cayman $(obj)/mkregtable FORCE
+$(obj)/%_reg_safe.h: $(src)/reg_srcs/% $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
 $(obj)/r100.o: $(obj)/r100_reg_safe.h $(obj)/rn50_reg_safe.h
-- 
2.17.1

