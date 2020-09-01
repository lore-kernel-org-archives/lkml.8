Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5230AC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEE520FC3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598958873;
	bh=ou1HFNRhbw08TpIm1gTEODy4ufYIh3ej/qbXWccTuNI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NRNvrkoADGq+9LDiA+SPXhE4MVPCJ8lH3NuRsovtsBw3UFKYkzi8rQsbxapQdmNn/
	 XB7D5bjUbKZeaIEqlkPGKw/O3cmRVTnV/Wygh9Y0AgYa5IDgplbwuK2LzGNM3DfYWj
	 uWt/7jeV1q9yTyLXLSE8ekTI/0GNEb4+GsJRuTFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIALOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgIALOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:14:18 -0400
Received: from localhost.localdomain (unknown [122.172.190.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD7720FC3;
        Tue,  1 Sep 2020 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598958820;
        bh=ou1HFNRhbw08TpIm1gTEODy4ufYIh3ej/qbXWccTuNI=;
        h=From:To:Cc:Subject:Date:From;
        b=Q16auNMUJEcoAh55mDRCCEsaJVhuCzykof8L8S6MdD0Jn+MxlTWTi+4AyuphlTY2a
         FbR+osdQjEbxcz1zF+4Ka7PU2nQxJWs1qpe/KsQ6jjDgdI/BlX3G2Ld5isEwpFADIQ
         18zsvPNGBrVxTVx11OAoPrU1uhVSwIGH0H+xPa00=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] regmap: soundwire: remove unused header mod_devicetable.h
Date:   Tue,  1 Sep 2020 16:43:31 +0530
Message-Id: <20200901111331.641072-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mod_devicetable.h does not seem to be required for this file, so
remove it.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

changes in v2:
  - fix typo in patch subject

 drivers/base/regmap/regmap-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 50a66382d87d..c92d614b4943 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -2,7 +2,6 @@
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/device.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/soundwire/sdw.h>
 #include "internal.h"
-- 
2.26.2

