Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B01C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E7F20825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGWJmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:42:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGWJmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:42:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42675AEFA;
        Thu, 23 Jul 2020 09:42:44 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     tsbogend@alpha.franken.de
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-mips@vger.kernel.org
Subject: [PATCH] mips: traps, add __init to parity_protection_init
Date:   Thu, 23 Jul 2020 11:42:35 +0200
Message-Id: <20200723094235.12706-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It references __initdata and is called only from an __init function:
trap_init. This avoids section mismatches (which I am seeing with gcc
10).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f655af68176c..702143ad7b47 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1680,7 +1680,7 @@ __setup("nol2par", nol2parity);
  * Some MIPS CPUs can enable/disable for cache parity detection, but do
  * it different ways.
  */
-static inline void parity_protection_init(void)
+static inline __init void parity_protection_init(void)
 {
 #define ERRCTL_PE	0x80000000
 #define ERRCTL_L2P	0x00800000
-- 
2.27.0

