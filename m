Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9338C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29DF20781
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDFJNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:13:46 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:46888 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgDFJNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:13:46 -0400
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id PMDk2200C5USYZQ01MDknH; Mon, 06 Apr 2020 11:13:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jLNpA-00062N-7t; Mon, 06 Apr 2020 11:13:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jLNpA-0005WV-5m; Mon, 06 Apr 2020 11:13:44 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] exfat: Improve wording of EXFAT_DEFAULT_IOCHARSET config option
Date:   Mon,  6 Apr 2020 11:13:43 +0200
Message-Id: <20200406091343.21190-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Use consistent capitalization for "exFAT".
  - Fix grammar,
  - Split long sentence.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/exfat/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
index 2d3636dc5b8c3106..96ad26214ae4b7e0 100644
--- a/fs/exfat/Kconfig
+++ b/fs/exfat/Kconfig
@@ -16,6 +16,7 @@ config EXFAT_DEFAULT_IOCHARSET
 	depends on EXFAT_FS
 	help
 	  Set this to the default input/output character set to use for
-	  converting between the encoding is used for user visible filename and
-	  UTF-16 character that exfat filesystem use, and can be overridden with
-	  the "iocharset" mount option for exFAT filesystems.
+	  converting between the encoding that is used for user visible
+	  filenames, and the UTF-16 character encoding that the exFAT
+	  filesystem uses.  This can be overridden with the "iocharset" mount
+	  option for the exFAT filesystems.
-- 
2.17.1

