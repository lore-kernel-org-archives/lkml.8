Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2CEC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0729720675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608455;
	bh=4kU2l7D79767FLsowTTcUcH8yKi2GKNgMTWK72m02X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M47N6s6tzjR3mKGTfMLOROW2ex7khZ7lpAvtInRZV6ANzhB9UUeX/xzd09mpQScvz
	 NYFnhe6b7RN7vOWlL9P3Em9wIqoMG/Kiu8c80a1Cp/B1WMC5wk5GLAyFOwB+eS4uE3
	 PSF/bdYUfWBT7rFWdEdyXNAngOPytE5tWzd93Go8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgBMPky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:40:54 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:48166 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgBMPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:40:48 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 01DFdZHY005809;
        Fri, 14 Feb 2020 00:39:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01DFdZHY005809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581608379;
        bh=mUXWSCOUhmEqCqZ+TwM1+NYP6yh2Anh0WoMXN2qQ3Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjoOjoPDyjlxgE30NXzuz2035Uk/UrfOBulP31p7kYSGDl0fDCvGDT6Ta5pYhtzJP
         X5m4LllyJfotrdVbuyp/oio2EbEP1ABXpKQUaR19zjHrsMvpSemmcqi9Id1VCSm3W4
         VWcyYisjaAsi5lCpfHcNaAjlxO1uKsGDBxV2d7pDk6zReCaqAREj6yq+5izqvS6upq
         Sie9lX9l+gSP439Q2zyk4imA+XOGMhRrreyhRhZPF8ydWS1rE+UT12jAkcjUqe7hol
         LYRVf2NVA/B7XHERPhoNwAB3SQqfEsKulmJTR35gp3cf0E/scVM9XTS8eL0bMWIe2l
         mA6VHKdSbBRNg==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=8F=AB=D3nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/radeon: align short build log
Date:   Fri, 14 Feb 2020 00:39:27 +0900
Message-Id: <20200213153928.28407-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213153928.28407-1-masahiroy@kernel.org>
References: <20200213153928.28407-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This beautifies the build log.

[Before]

  HOSTCC  drivers/gpu/drm/radeon/mkregtable
  MKREGTABLE drivers/gpu/drm/radeon/r100_reg_safe.h
  MKREGTABLE drivers/gpu/drm/radeon/rn50_reg_safe.h
  CC [M]  drivers/gpu/drm/radeon/r100.o
  MKREGTABLE drivers/gpu/drm/radeon/r300_reg_safe.h
  CC [M]  drivers/gpu/drm/radeon/r300.o

[After]

  HOSTCC  drivers/gpu/drm/radeon/mkregtable
  MKREG   drivers/gpu/drm/radeon/r100_reg_safe.h
  MKREG   drivers/gpu/drm/radeon/rn50_reg_safe.h
  CC [M]  drivers/gpu/drm/radeon/r100.o
  MKREG   drivers/gpu/drm/radeon/r300_reg_safe.h
  CC [M]  drivers/gpu/drm/radeon/r300.o

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/radeon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index 480a8d4a3c82..11c97edde54d 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -6,7 +6,7 @@
 hostprogs := mkregtable
 targets := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
 
-quiet_cmd_mkregtable = MKREGTABLE $@
+quiet_cmd_mkregtable = MKREG   $@
       cmd_mkregtable = $(obj)/mkregtable $< > $@
 
 $(obj)/%_reg_safe.h: $(src)/reg_srcs/% $(obj)/mkregtable FORCE
-- 
2.17.1

