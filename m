Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E999DC35E0B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAEF218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="KMBo+P8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgBYP2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:28:21 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35836 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbgBYP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582644498; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=yVuOmBJWZzHIWYiiB34lmWOpjCeJmYGne24gcLJDlVM=;
        b=KMBo+P8WR/EsI4REQQa6i/hMnhdZLGpmKN0BoygmdCNNKWXnfmmZDsXTlk0O5nFhC74Ect
        CP32nuhtD9W2KrI8dR9+KrfEni6KlVrif6CcvMHHE9a1dzskuHUxjkjcVIb+e424oJpklS
        K9+xsOFz5dBVH6JX+oGsYSJ2qYOHh/g=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org
Subject: [PATCH] MIPS: Fix CONFIG_MIPS_CMDLINE_DTB_EXTEND handling
Date:   Tue, 25 Feb 2020 12:28:09 -0300
Message-Id: <20200225152810.45048-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_MIPS_CMDLINE_DTB_EXTEND option is used so that the kernel
arguments provided in the 'bootargs' property in devicetree are extended
with the kernel arguments provided by the bootloader.

The code was broken, as it didn't actually take any of the kernel
arguments provided in devicetree when that option was set.

Fixes: 7784cac69735 ("MIPS: cmdline: Clean up boot_command_line
initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 1ac2752fb791..a7b469d89e2c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -605,7 +605,8 @@ static void __init bootcmdline_init(char **cmdline_p)
 	 * If we're configured to take boot arguments from DT, look for those
 	 * now.
 	 */
-	if (IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB))
+	if (IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB) ||
+	    IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND))
 		of_scan_flat_dt(bootcmdline_scan_chosen, &dt_bootargs);
 #endif
 
-- 
2.25.0

