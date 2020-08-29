Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D628C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3759420848
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598697602;
	bh=xH+2+81KD+9EvlFYr/lFeBRmflSJRA4u9K/v+gTsJ4E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Uk0C8soyCUjKzPe2/XAN8K/IWxFPSJUv0ZlSn6vpjS2oANqfKijzPRQBSXH8k50yb
	 PNeTroXI5f7iNGXjw/kU08PaKu7PTBMoF/lHC0Cz/zxUS51FCXzPoD2R9Ws3BIrx4f
	 xhaYjitZgP8cwgxqMKAbXzOGjdQbf2Hsdqy1F49s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgH2Kj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgH2Kjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:39:52 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F122076D;
        Sat, 29 Aug 2020 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598697591;
        bh=xH+2+81KD+9EvlFYr/lFeBRmflSJRA4u9K/v+gTsJ4E=;
        h=From:To:Cc:Subject:Date:From;
        b=UBnUPUxeV/cXXVxFA/AHJ9U0RIqMcCzmu7AwAppMwXK6rVpi+EUXz8wDpN24+UDIm
         PJ0M8zc5YpV+DhLFI5lS/qp+fR/FM74sJYZHfC6QnmE9BO1zzi2D1NIQpQOji+BQA9
         I8pfRHeWAv2KIM3HaVMispF/L9Hc+oiEBYg65YRw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: soundwire: remove unsed header mod_devicetable.h
Date:   Sat, 29 Aug 2020 16:09:39 +0530
Message-Id: <20200829103939.4007097-1-vkoul@kernel.org>
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

