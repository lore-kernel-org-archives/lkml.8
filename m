Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C52C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DE820801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581958535;
	bh=ZbDvsitZKVug680HMuCfi9QdtU8FJqA1UEwifLGeEwI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DjS5Wre3RlxCatGjUh/8IT0EqWi3kqff7KTOk/OgLVkDRVyWLwDv2YKl4l2nRhU62
	 M17QLHjn0049MS23lq0McNfXSMCcw4HxMnCed5iVeX3xScNQFGJ/8DpnnA7tvvTQvW
	 lBwie4bT6ZqA6xMOTJ2FvzlRjkd8Ek7ZgzzYZyA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgBQQze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgBQQzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:55:33 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A5620801;
        Mon, 17 Feb 2020 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581958533;
        bh=ZbDvsitZKVug680HMuCfi9QdtU8FJqA1UEwifLGeEwI=;
        h=From:To:Cc:Subject:Date:From;
        b=CDoNZ/mYKCPwxXnj8sI/VX4G/k6rX5qBx6Ppz6IaRh8cszA/HvIq2/dswof5dMJup
         WoPot9vdkQA7yumZPxY4ttzY234gGybTPny2xIIRajyuz83Q679gRtyM0KvNNr8nQY
         UUUTOGW2UytdHo93odjJkN3PQEpvhRiB9HyVx4wo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] s390: Cleanup removed IOSCHED_DEADLINE
Date:   Mon, 17 Feb 2020 17:55:25 +0100
Message-Id: <20200217165525.5187-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
remove legacy IO schedulers").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/s390/block/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index a8682f69effc..1f06b19cb290 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -26,7 +26,7 @@ config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
 	depends on CCW && BLOCK
-	select IOSCHED_DEADLINE
+	select MQ_IOSCHED_DEADLINE
 	help
 	  Enable this option if you want to access DASDs directly utilizing
 	  S/390s channel subsystem commands. This is necessary for running
-- 
2.17.1

