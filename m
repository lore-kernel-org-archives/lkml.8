Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1821C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F6C22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgH0OwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgH0NZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:25:02 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8192C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:24:47 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id LdQc2300V4C55Sk01dQcsW; Thu, 27 Aug 2020 15:24:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kBHtM-0000fB-LC; Thu, 27 Aug 2020 15:24:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kBHtM-0006Ul-JF; Thu, 27 Aug 2020 15:24:36 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] nds32: Fix bogus reference to <asm/procinfo.h>
Date:   Thu, 27 Aug 2020 15:24:34 +0200
Message-Id: <20200827132435.24925-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andestech(nds32) never had <asm/procinfo.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/nds32/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index a066efbe53c0c098..3671129e205852b7 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(elf_hwcap);
 
 /*
  * The following string table, must sync with HWCAP_xx bitmask,
- * which is defined in <asm/procinfo.h>
+ * which is defined above
  */
 static const char *hwcap_str[] = {
 	"mfusr_pc",
-- 
2.17.1

