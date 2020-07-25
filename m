Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5743C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9102065F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgGYANZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 20:13:25 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:63072 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgGYANZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:13:25 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 278F0580FEE0C14D053A;
        Sat, 25 Jul 2020 08:13:22 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 06P0DLa9078414;
        Sat, 25 Jul 2020 08:13:21 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020072508140226-4388898 ;
          Sat, 25 Jul 2020 08:14:02 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH v2] ARM: milbeaut: Fix possible device node reference leak
Date:   Sat, 25 Jul 2020 08:16:48 +0800
Message-Id: <1595636208-15179-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-07-25 08:14:02,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-25 08:13:26,
        Serialize complete at 2020-07-25 08:13:26
X-MAIL: mse-fl2.zte.com.cn 06P0DLa9078414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

The variable np in function m10v_smp_init takes the return value
of of_find_compatible_node, which gets a node but does not put it. If
this node is not put it may cause a memory leak. Hence put np after its
life has been exhausted.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
Changes in v2: improve the subject and description of this commit.

 arch/arm/mach-milbeaut/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-milbeaut/platsmp.c b/arch/arm/mach-milbeaut/platsmp.c
index 3ea880f..1f1ff21 100644
--- a/arch/arm/mach-milbeaut/platsmp.c
+++ b/arch/arm/mach-milbeaut/platsmp.c
@@ -53,6 +53,7 @@ static void m10v_smp_init(unsigned int max_cpus)
 		return;
 
 	m10v_smp_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!m10v_smp_base)
 		return;
 
-- 
2.9.5

