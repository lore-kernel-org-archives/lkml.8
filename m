Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F996C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5268320CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412153;
	bh=fr+r1JFKwTNHUZAlTHUgAmBUgo5GF6Vj/doAxVu5rqg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1JwO5ad98TA4aZI0dKBde/Xk2LNstC14QPdas/txaxACqYSVGLz3olzxjaoTrHYLn
	 cLSTMyG9PyFk7Bwrqqgn3pj7jmbXyD7G3smC+9iN9+Og53U1D/cJ8x85ctjgbEYQNG
	 vztVMLy7vmcAU/rEl2uFIeznGixdh04QJblF6UDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgA3TWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgA3TWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:22:32 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D26205F4;
        Thu, 30 Jan 2020 19:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412151;
        bh=fr+r1JFKwTNHUZAlTHUgAmBUgo5GF6Vj/doAxVu5rqg=;
        h=From:To:Cc:Subject:Date:From;
        b=JbYeKvXcGD1dWDYC/V36ABinagP1DJ+J9e9MclGDhtvsSB7JfsdTGMv7jW+RKkN7p
         gaamCRKnr1suSZkgVZFouBNW6d+fGDVvSmCt3hkv0uUJzMO1+eQIhdndiqkuYEatx6
         XMhDWjAUxOmUdzhTOrKE3R+Hx/r5TJlrWzReBInA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] um: configs: Cleanup CONFIG_IOSCHED_CFQ
Date:   Thu, 30 Jan 2020 20:22:26 +0100
Message-Id: <20200130192226.2776-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IOSCHED_CFQ is since commit f382fb0bcef4 ("block: remove legacy
IO schedulers").

The IOSCHED_BFQ seems to replace IOSCHED_CFQ so select it in configs
previously choosing the latter.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/um/configs/i386_defconfig   | 2 +-
 arch/um/configs/x86_64_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index 73e98bb57bf5..fb51bd206dbe 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -26,7 +26,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_IOSCHED_CFQ=m
+CONFIG_IOSCHED_BFQ=m
 CONFIG_SSL=y
 CONFIG_NULL_CHAN=y
 CONFIG_PORT_CHAN=y
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 3281d7600225..477b87317424 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -24,7 +24,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_IOSCHED_CFQ=m
+CONFIG_IOSCHED_BFQ=m
 CONFIG_SSL=y
 CONFIG_NULL_CHAN=y
 CONFIG_PORT_CHAN=y
-- 
2.17.1

