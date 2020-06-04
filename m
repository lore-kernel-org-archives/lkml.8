Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C363C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED87206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgFDJke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgFDJke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:40:34 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2644C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 02:40:33 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c96f:783c:a430:4a5a])
        by andre.telenet-ops.be with bizsmtp
        id mxgX2200t0MBGRv01xgXJU; Thu, 04 Jun 2020 11:40:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jgmMR-0001SK-Rn; Thu, 04 Jun 2020 11:40:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jgmMR-0003xi-Qh; Thu, 04 Jun 2020 11:40:31 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] media: Remove superfluous dependency for MEDIA_SUPPORT_FILTER
Date:   Thu,  4 Jun 2020 11:40:30 +0200
Message-Id: <20200604094030.14564-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MEDIA_SUPPORT_FILTER configuration option is located inside a block
protected by "#if MEDIA_SUPPORT", so there is no need to have an
explicit dependency on MEDIA_SUPPORT.  Drop it.

Fixes: c6774ee035dcb878 ("media: Kconfig: make filtering devices optional")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/media/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index a6d073f2e036aa34..6222b3ae220ba85b 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -24,7 +24,6 @@ if MEDIA_SUPPORT
 
 config MEDIA_SUPPORT_FILTER
 	bool "Filter media drivers"
-	depends on MEDIA_SUPPORT
 	default y if !EMBEDDED && !EXPERT
 	help
 	   Configuring the media subsystem can be complex, as there are
-- 
2.17.1

