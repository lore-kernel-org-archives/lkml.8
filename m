Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E89BC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DA220714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgCZThy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:37:54 -0400
Received: from mail.sysgo.com ([176.9.12.79]:47370 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZThy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:37:54 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 15:37:53 EDT
From:   David Engraf <david.engraf@sysgo.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] kbuild: add outputmakefile to no-dot-config-targets
Date:   Thu, 26 Mar 2020 20:29:33 +0100
Message-Id: <20200326192933.14091-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target outputmakefile is used to generate a Makefile
for out-of-tree builds and does not depend on the kernel
configuration.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e56bf7ef182d..45be0e5b0cef 100644
--- a/Makefile
+++ b/Makefile
@@ -255,7 +255,7 @@ clean-targets := %clean mrproper cleandocs
 no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers headers_% archheaders archscripts \
-			 %asm-generic kernelversion %src-pkg
+			 %asm-generic kernelversion %src-pkg outputmakefile
 no-sync-config-targets := $(no-dot-config-targets) install %install \
 			   kernelrelease
 single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.s %.symtypes %/
-- 
2.17.1

