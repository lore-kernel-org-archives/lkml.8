Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9706CC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4B72078C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgEFWSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:18:06 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45370 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgEFWSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:18:06 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2020 18:18:05 EDT
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id C2AFDCD460;
        Thu,  7 May 2020 01:10:06 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Subject: [PATCH] EDAC/amd64: Dump registers before checking ECC
Date:   Wed,  6 May 2020 22:06:42 +0000
Message-Id: <20200506220642.32717-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move dump_misc_regs earlier so decoded register contents are shown
even if ECC cannot be enabled. The dump gives info such as number of
memory controllers, so it serves as a sensible smoke-check even on
platforms without ECC memory.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org
---

Hi,

I used this patch when testing EDAC on AMD Family 17h Model 60h CPU,
which needs another patch (adding PCI ids) that I intend to send
shortly. I think it would be useful to have this upstream. 

 drivers/edac/amd64_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f91f3bc1e0b2..1136500c5f53 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3533,6 +3533,8 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
+	dump_misc_regs(pvt);
+
 	if (!ecc_enabled(pvt)) {
 		ret = -ENODEV;
 
@@ -3559,8 +3561,6 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	dump_misc_regs(pvt);
-
 	return ret;
 
 err_enable:
-- 
2.26.2

