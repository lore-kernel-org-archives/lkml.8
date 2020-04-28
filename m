Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638E5C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3370820661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588051755;
	bh=+MASbMAFoVDVqn70ipcjJMgyPLucXXXOL49rTrnKaew=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Kp2tCJ5Bi0f/QK7hGXBQJRAgU+txTMkBtUxNfIQHK+eqrz2j18a9K5H5J/GE6TIP5
	 32C3Er8jI1siT4mLhI/5+Sipo7+3sGAr19m+pkK1SGJsSteamMGiPVm5aZL0TvmgkC
	 3a8cFt06D5Q05QJ5AzWj6QxEdpCnTl/160STCQxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD1F3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgD1F3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:29:14 -0400
Received: from vkoul-mobl.Dlink (unknown [106.51.110.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B062206B9;
        Tue, 28 Apr 2020 05:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588051753;
        bh=+MASbMAFoVDVqn70ipcjJMgyPLucXXXOL49rTrnKaew=;
        h=From:To:Cc:Subject:Date:From;
        b=R2PXTZeeqiO+LIVD7OJcciyQW5IQMu57uIcXE4JdHSckpqW66GcUMoAMypb9+saBK
         hkLoDn9dfLLHjLhvgfKwJN3GLI0MomSAjXEzezn+CyhoAyZSIPCSdRMyvppXJfrde3
         /UiKzX3Vbp2qzdFXdHgkbXFKlqhLWwMafphaNFVA=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] MAINTAINERS: Move the linux-phy git
Date:   Tue, 28 Apr 2020 10:59:06 +0530
Message-Id: <20200428052906.384158-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I am co-maintaining the Generic phy subsystem, move the linux-phy
git to new shared location.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14de34c8153f..6c7adc14c389 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7118,7 +7118,7 @@ M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Vinod Koul <vkoul@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
 F:	Documentation/devicetree/bindings/phy/
 F:	drivers/phy/
 F:	include/linux/phy/
-- 
2.25.3

