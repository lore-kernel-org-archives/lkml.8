Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08842078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597995792;
	bh=snzhPM8cOWUDWnwq2KTsF9Bnjhly7fQhbcxo/se/pak=;
	h=From:To:Subject:Date:List-ID:From;
	b=oxmUxNHxjWw3GGOG1QFbZartRU9BiRjx6bMQHRULRylG3eQCAo/EHr7tJA9DluqVD
	 3hmUM5xckBaDPYZ2e/PvV4myJL0FEMHwja28LKPimIzPb3OyyqriKP1+jeqBZ+7cmK
	 VApY4SdHNzKMltHHx4Hj5w885aaOqRcKR1do9Zqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHUHnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgHUHnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:43:08 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1022078D;
        Fri, 21 Aug 2020 07:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597995788;
        bh=snzhPM8cOWUDWnwq2KTsF9Bnjhly7fQhbcxo/se/pak=;
        h=From:To:Subject:Date:From;
        b=n/0mfI5N7S+Ofkrfi6HMmkCIBszBlYwspVxEdfmTFUWu8L5oEoOOTakE+JZ0St4TP
         wtQLT5hlmBSpr9oOJKYK+QERc8H4N56d5ZHv3j/m8rL/I//tLXEBVw0fyjYzBPajj4
         dXhiJD2bqmQAYXVI5LqgJu6iY3zt9atia8ijt2uc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: s3c: Cleanup from old plat-samsung include
Date:   Fri, 21 Aug 2020 09:42:51 +0200
Message-Id: <20200821074251.26798-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch/arm/plat-samsung/ was removed and merged into
arch/arm/mach-s3c/ so the include path is not needed anymore.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c/Makefile.s3c64xx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c/Makefile.s3c64xx b/arch/arm/mach-s3c/Makefile.s3c64xx
index e06e5356da9b..0c18e31936df 100644
--- a/arch/arm/mach-s3c/Makefile.s3c64xx
+++ b/arch/arm/mach-s3c/Makefile.s3c64xx
@@ -3,8 +3,8 @@
 # Copyright 2008 Openmoko, Inc.
 # Copyright 2008 Simtec Electronics
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
-asflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+asflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 # PM
 
-- 
2.17.1

