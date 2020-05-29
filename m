Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B97EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5087620776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438262AbgE2BAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:00:22 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:27221 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438243AbgE2BAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:00:17 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id A9EB6564EFBEC90C84D5;
        Fri, 29 May 2020 09:00:13 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 04T105YD060302;
        Fri, 29 May 2020 09:00:05 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020052909003964-3735731 ;
          Fri, 29 May 2020 09:00:39 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] powerpc/nvram: Replace kmalloc with kzalloc in the error message
Date:   Fri, 29 May 2020 09:02:15 +0800
Message-Id: <1590714135-15818-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-05-29 09:00:39,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-05-29 09:00:10,
        Serialize complete at 2020-05-29 09:00:10
X-MAIL: mse-fl1.zte.com.cn 04T105YD060302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Use kzalloc instead of kmalloc in the error message according to
the previous kzalloc() call.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
 arch/powerpc/kernel/nvram_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index fb4f610..c3a0c8d 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -892,7 +892,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
 	/* Create our OS partition */
 	new_part = kzalloc(sizeof(*new_part), GFP_KERNEL);
 	if (!new_part) {
-		pr_err("%s: kmalloc failed\n", __func__);
+		pr_err("%s: kzalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 
-- 
2.9.5

