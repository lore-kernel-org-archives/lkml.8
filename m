Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D12C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B09220772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgHKJ3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:29:31 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38383 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728224AbgHKJ3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:29:31 -0400
Received: from ersatz.molgen.mpg.de (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5470E206462B4;
        Tue, 11 Aug 2020 11:29:29 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] init/Kconfig: Fix CPU number in LOG_CPU_MAX_BUF_SHIFT description
Date:   Tue, 11 Aug 2020 11:29:23 +0200
Message-Id: <20200811092924.6256-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, LOG_BUF_SHIFT defaults to 17, which is 2 ^ 17 bytes = 128 KB,
and LOG_CPU_MAX_BUF_SHIFT defaults to 12, which is 2 ^ 12 bytes = 4 KB.

Half of 128 KB is 64 KB, so more than 16 CPUs are required for the value
to be used, as then the sum of contributions is greater than 64 KB for
the first time. My guess is, that the description was written with the
configuration values used in the SUSE in mind.

Fixes: 23b2899f7f ("printk: allow increasing the ring buffer depending on the number of CPUs")
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Add Reviewed-by tag

 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index d6a0b31b13dc..9dc607e3806f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -718,7 +718,7 @@ config LOG_CPU_MAX_BUF_SHIFT
 	  with more CPUs. Therefore this value is used only when the sum of
 	  contributions is greater than the half of the default kernel ring
 	  buffer as defined by LOG_BUF_SHIFT. The default values are set
-	  so that more than 64 CPUs are needed to trigger the allocation.
+	  so that more than 16 CPUs are needed to trigger the allocation.
 
 	  Also this option is ignored when "log_buf_len" kernel parameter is
 	  used as it forces an exact (power of two) size of the ring buffer.
-- 
2.28.0

