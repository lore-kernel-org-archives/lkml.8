Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CB8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDAA205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412364;
	bh=ZbDvsitZKVug680HMuCfi9QdtU8FJqA1UEwifLGeEwI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2OWK3NBXj2vwqOAQZ2IJ9K/0b2y3MqFfZnvJdEHLEnB0jffoRPdqbE5mu+CdK/X0a
	 a4/vIF9t/61KQwMZ33Xy7EvvNt530V4qcUC78GtHQkEEK+T/RFHPIQRZ4zEIvL5C6G
	 JYoVjRXtvPEUt7TYbqqerXjZ9Ekri23cyxOTW9Nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgA3T0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbgA3T0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:26:03 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0474205F4;
        Thu, 30 Jan 2020 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412363;
        bh=ZbDvsitZKVug680HMuCfi9QdtU8FJqA1UEwifLGeEwI=;
        h=From:To:Cc:Subject:Date:From;
        b=eEmJYIlpPJgeK5JxTW6UoEVdYNz3V4+HxAQEOz6BPt1abdVJJx4+6zFnXVA8Q9ynO
         B3Yb1GoP5Io4XPu0NwJ6jRnSmrn/hCG9xewvU48BbK1qJOSW+QEWGAgUYj592E29tr
         24H3dNfH/piGmGM/uGY4AhfFax+4x5AbCr6Z4DoA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] s390: Cleanup removed IOSCHED_DEADLINE
Date:   Thu, 30 Jan 2020 20:25:57 +0100
Message-Id: <20200130192557.3320-1-krzk@kernel.org>
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

