Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48A9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AB8207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbgGWBUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:20:49 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:39278 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbgGWBUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:20:48 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 7199DB71BF8CE8DB887D;
        Thu, 23 Jul 2020 09:20:46 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 06N1KcUm028418;
        Thu, 23 Jul 2020 09:20:38 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020072309210422-4367468 ;
          Thu, 23 Jul 2020 09:21:04 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] ARM: milbeaut: Add missing of_node_put()
Date:   Thu, 23 Jul 2020 09:24:10 +0800
Message-Id: <1595467450-13488-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-07-23 09:21:04,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-23 09:20:42,
        Serialize complete at 2020-07-23 09:20:42
X-MAIL: mse-fl1.zte.com.cn 06N1KcUm028418
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

After finishing using device node got from of_find_compatible_node(),
of_node_put() needs to be called.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
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

