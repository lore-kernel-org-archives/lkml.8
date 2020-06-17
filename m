Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F56C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A249E206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgFQUMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:12:22 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:31903 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFQUMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:12:21 -0400
Received: from localhost.localdomain ([93.23.15.97])
        by mwinf5d07 with ME
        id sLCH2200K25enVZ03LCJWz; Wed, 17 Jun 2020 22:12:20 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 17 Jun 2020 22:12:20 +0200
X-ME-IP: 93.23.15.97
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tony.luck@intel.com, fenghua.yu@intel.com, walken@google.com,
        vbabka@suse.cz, tglx@linutronix.de, namit@vmware.com,
        afzal.mohd.ma@gmail.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ia64: Fix a typo in a comment
Date:   Wed, 17 Jun 2020 22:12:14 +0200
Message-Id: <20200617201214.733262-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/permfon/perfmon/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/ia64/kernel/perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 971f166873aa..e8e30a408946 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -4555,7 +4555,7 @@ pfm_exit_thread(struct task_struct *task)
 }
 
 /*
- * functions MUST be listed in the increasing order of their index (see permfon.h)
+ * functions MUST be listed in the increasing order of their index (see perfmon.h)
  */
 #define PFM_CMD(name, flags, arg_count, arg_type, getsz) { name, #name, flags, arg_count, sizeof(arg_type), getsz }
 #define PFM_CMD_S(name, flags) { name, #name, flags, 0, 0, NULL }
-- 
2.25.1

