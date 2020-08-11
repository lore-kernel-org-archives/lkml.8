Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91292C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6368920756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHKJ3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:29:38 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:44249 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728224AbgHKJ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:29:37 -0400
Received: from ersatz.molgen.mpg.de (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F1A95206462B4;
        Tue, 11 Aug 2020 11:29:35 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] init/Kconfig: Increase default log buffer size from 128 KB to 512 KB
Date:   Tue, 11 Aug 2020 11:29:24 +0200
Message-Id: <20200811092924.6256-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811092924.6256-1-pmenzel@molgen.mpg.de>
References: <20200811092924.6256-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f17a32e97e (let LOG_BUF_SHIFT default to 17) from 2008 was the
last time, the the default log buffer size bump was increased.

Machines have evolved, and on current hardware, enough memory is
present, and some devices have over 200 PCI devices, like a two socket
Skylake-E server, resulting a lot of lines.

Therefore, increase the default from 128 KB to 512 KB. Anyone, with
limited memory, can still lower it.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org
---
v2: New patch in series.

Is sending it to linux-kernel enough? If not, who to send it also to?

 init/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9dc607e3806f..13df63517cc2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -681,9 +681,9 @@ config IKHEADERS
 	  kheaders.ko is built which can be loaded on-demand to get access to headers.
 
 config LOG_BUF_SHIFT
-	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
+	int "Kernel log buffer size (17 => 128KB, 19 => 512KB)"
 	range 12 25
-	default 17
+	default 19
 	depends on PRINTK
 	help
 	  Select the minimal kernel log buffer size as a power of 2.
@@ -692,6 +692,8 @@ config LOG_BUF_SHIFT
 	  by "log_buf_len" boot parameter.
 
 	  Examples:
+		     19 => 512 KB
+		     18 => 256 KB
 		     17 => 128 KB
 		     16 => 64 KB
 		     15 => 32 KB
@@ -718,7 +720,7 @@ config LOG_CPU_MAX_BUF_SHIFT
 	  with more CPUs. Therefore this value is used only when the sum of
 	  contributions is greater than the half of the default kernel ring
 	  buffer as defined by LOG_BUF_SHIFT. The default values are set
-	  so that more than 16 CPUs are needed to trigger the allocation.
+	  so that more than 64 CPUs are needed to trigger the allocation.
 
 	  Also this option is ignored when "log_buf_len" kernel parameter is
 	  used as it forces an exact (power of two) size of the ring buffer.
-- 
2.28.0

