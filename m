Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7B8C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016F32081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579106875;
	bh=Wo3VvGdgYgOnlotGPGTZ3ecuBSDmuAqHMz6pbLgoclo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=a5K/oxmF49RG+XFekh34vdll/PSrY+mWnu/cR7619LTlkKt50wheyS4CSU9t4I5Vl
	 8MRo7n4Zn2W8jp0sll+4mIiAXaviU0DVbaudf0rm5Yjju+nMtadaQuYu6DZ33sfsWl
	 0z9M2vhAu8XF6aHbGrgH3LU5/keuG1m/MM7O9UFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAOQry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgAOQrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:47:52 -0500
Received: from linux-8ccs.suse.de (x2f7fcc1.dyn.telefonica.de [2.247.252.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE7624679;
        Wed, 15 Jan 2020 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579106872;
        bh=Wo3VvGdgYgOnlotGPGTZ3ecuBSDmuAqHMz6pbLgoclo=;
        h=From:To:Cc:Subject:Date:From;
        b=DOTUaiCItx4UxdrtsbeVi+zw6Shrw/f7zthwJ9eXxzdIK7799k3icz7s5rcBT+gSa
         s7IfeiSBlQZHiIm1rHPKh+wtvKw4xKI0GNrZxB/b2S+yeHyNP/sB7cgbcumno+B7AQ
         vI9S1acyXaSTHqbErYhQmiWZ8QUMma3hA8zhNnQ4=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] modsign: print module name along with error message
Date:   Wed, 15 Jan 2020 17:47:27 +0100
Message-Id: <20200115164727.12797-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to know which module failed signature verification, so
print the module name along with the error message.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
This patch was sent last year, but apparently I forgot to pursue getting it
merged (it had a dependency on the lockdown patchset). Now that's merged,
I'm resending it.

[1] https://lore.kernel.org/lkml/20180530090830.20737-4-jeyu@kernel.org/

 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index d4d876172e9d..2b5f9c4748bc 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2882,7 +2882,7 @@ static int module_sig_check(struct load_info *info, int flags)
 		reason = "Loading of module with unavailable key";
 	decide:
 		if (is_module_sig_enforced()) {
-			pr_notice("%s is rejected\n", reason);
+			pr_notice("%s: %s is rejected\n", info->name, reason);
 			return -EKEYREJECTED;
 		}
 
-- 
2.16.4

