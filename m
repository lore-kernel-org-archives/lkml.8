Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B8AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13F820731
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgEBMAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 08:00:06 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:49869 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgEBMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 08:00:05 -0400
Received: from localhost.localdomain ([92.140.215.114])
        by mwinf5d67 with ME
        id Znzt220022Ug2Sc03nztS6; Sat, 02 May 2020 14:00:01 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 May 2020 14:00:01 +0200
X-ME-IP: 92.140.215.114
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, tglx@linutronix.de, maddy@linux.vnet.ibm.com,
        cclaudio@linux.ibm.com, zhangshaokun@hisilicon.com,
        atrajeev@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] powerpc/powernv: Fix a warning message
Date:   Sat,  2 May 2020 13:59:49 +0200
Message-Id: <20200502115949.139000-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a cut'n'paste error in a warning message. This should be
'cpu-idle-state-residency-ns' to match the property searched in the
previous 'of_property_read_u32_array()'

Fixes: 9c7b185ab2fe ("powernv/cpuidle: Parse dt idle properties into global structure")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/platforms/powernv/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 78599bca66c2..2dd467383a88 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -1270,7 +1270,7 @@ static int pnv_parse_cpuidle_dt(void)
 	/* Read residencies */
 	if (of_property_read_u32_array(np, "ibm,cpu-idle-state-residency-ns",
 				       temp_u32, nr_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-residency-ns in DT\n");
 		rc = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

