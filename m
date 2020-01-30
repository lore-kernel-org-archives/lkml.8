Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89073C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BF8205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412270;
	bh=NBmeSGcdxsiaLrLjTo819rqp5ZrQrZg1Z0uuujHZgGM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pT2n2aygU1qJdPGTrW5ZVqV4PpgKQxFufdDVXkfzUgSVkCRnK6+K6tTrOtMwLwnJB
	 T/vRr6eZkSvpbDgNI70PxFq82tPnRHbUKREJVANkp6EJTUb/8H7Xmpw6CQCPTuDCi+
	 tdVa3hGCHKw85/lU7C7BNuH+0FR4pJ4gp++m4z7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgA3TY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:24:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgA3TY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:24:27 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16992082E;
        Thu, 30 Jan 2020 19:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412267;
        bh=NBmeSGcdxsiaLrLjTo819rqp5ZrQrZg1Z0uuujHZgGM=;
        h=From:To:Cc:Subject:Date:From;
        b=S31CxaTz/mHrsa1CVYVDFy+sVdwwk/evOUvXtUNVtoxPI73B0tjMGnJ9wVL11tzKq
         JIsIKF3fos/4f7ftCzXWJE4vDgkvFdUBa7+0R7Jm2GbiOpjvX6OShfRqO6BM3ifl0d
         nMeFqnT6rU6tSSxHvfG3zhzWQtNt3IbbYbrVCN8c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] init: Cleanup ANON_INODES and old IO schedulers options
Date:   Thu, 30 Jan 2020 20:24:19 +0100
Message-Id: <20200130192419.3026-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ANON_INODES is gone since commit 5dd50aaeb185 ("Make anon_inodes
unconditional").

CONFIG_CFQ_GROUP_IOSCHED was replaced with CONFIG_BFQ_GROUP_IOSCHED in
commit f382fb0bcef4 ("block: remove legacy IO schedulers").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 init/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 92229457dc7f..a45f38f4c200 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -882,7 +882,7 @@ config BLK_CGROUP
 	This option only enables generic Block IO controller infrastructure.
 	One needs to also enable actual IO controlling logic/policy. For
 	enabling proportional weight division of disk bandwidth in CFQ, set
-	CONFIG_CFQ_GROUP_IOSCHED=y; for enabling throttling policy, set
+	CONFIG_BFQ_GROUP_IOSCHED=y; for enabling throttling policy, set
 	CONFIG_BLK_DEV_THROTTLING=y.
 
 	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
@@ -1549,7 +1549,6 @@ config AIO
 
 config IO_URING
 	bool "Enable IO uring support" if EXPERT
-	select ANON_INODES
 	select IO_WQ
 	default y
 	help
-- 
2.17.1

