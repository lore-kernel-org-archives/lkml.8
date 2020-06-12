Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F417C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B25207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgFLIKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:10:30 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:48099 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgFLIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:10:29 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 04:10:29 EDT
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id D3673580075;
        Fri, 12 Jun 2020 10:05:26 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     lorenzo@kernel.org, linux-kernel@vger.kernel.org,
        kvalo@codeaurora.org, nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mt76: fix include in pci.h
Date:   Fri, 12 Jun 2020 10:05:23 +0200
Message-Id: <20200612080523.250247-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> found the following issue
and Kalle Valo forwarded it to Linux wireless.

drivers/net/wireless/mediatek/mt76/pci.c:8:6:
warning: no previous prototype for 'mt76_pci_disable_aspm'

Fix this by adding the missing include of mt76.h as Kalle
suggested.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/pci.c b/drivers/net/wireless/mediatek/mt76/pci.c
index 04c5a692bc85..4c1c159fbb62 100644
--- a/drivers/net/wireless/mediatek/mt76/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/pci.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2019 Lorenzo Bianconi <lorenzo@kernel.org>
  */
 
+#include "mt76.h"
 #include <linux/pci.h>
 
 void mt76_pci_disable_aspm(struct pci_dev *pdev)
-- 
2.27.0

