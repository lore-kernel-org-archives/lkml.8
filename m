Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C539EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B7D2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgENOeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:34:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgENOeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:34:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F6BCAE63;
        Thu, 14 May 2020 14:34:09 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: Don't include objects twice
Date:   Thu, 14 May 2020 16:34:00 +0200
Message-Id: <20200514143401.66888-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the change of platform file inclusion object were included via
platform-y and core-y. Remove the core-y part to fix it.

Fixes: 26bff9eb49201aeb ("MIPS: Only include the platformfile needed")
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/ralink/Platform | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/ralink/Platform b/arch/mips/ralink/Platform
index 6095fcc334f4..02ee0791481d 100644
--- a/arch/mips/ralink/Platform
+++ b/arch/mips/ralink/Platform
@@ -1,7 +1,6 @@
 #
 # Ralink SoC common stuff
 #
-core-$(CONFIG_RALINK)		+= arch/mips/ralink/
 cflags-$(CONFIG_RALINK)		+= -I$(srctree)/arch/mips/include/asm/mach-ralink
 
 #
-- 
2.16.4

