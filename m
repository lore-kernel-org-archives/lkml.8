Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC72C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 20:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5C3206F7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 20:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgDDUaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 16:30:13 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:7079 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDDUaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 16:30:13 -0400
From:   Thomas Backlund <tmb@mageia.org>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thomas Backlund <tmb@mageia.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH] exfat: add missing MODULE_ALIAS_FS()
Date:   Sat, 4 Apr 2020 23:29:43 +0300
Message-ID: <20200404202943.367023-1-tmb@mageia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Backlund <tmb@mageia.org>
Cc: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 16ed202ef527..b4a4063a0272 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -717,6 +717,7 @@ static void __exit exit_exfat_fs(void)
 module_init(init_exfat_fs);
 module_exit(exit_exfat_fs);
 
+MODULE_ALIAS_FS("exfat");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("exFAT filesystem support");
 MODULE_AUTHOR("Samsung Electronics Co., Ltd.");
-- 
2.26.0

