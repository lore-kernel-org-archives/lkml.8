Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087E7C43446
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B49206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="rrkCWecP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgGXRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:25:51 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58606 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgGXRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9t8ChRbXN1OVDkyC3IRxGbWR7S5dFVtwk8MI6eaiLG0=; b=rrkCWecPS9ayj762CdT2JJ2fZl
        ZKDSfv0fwdzi+6YdlFRsaiGe3PuKO3E1d4Mf3+Ea/Y4Z8HE9Xr+eTcC53Tv4UQ7kdtJvlV75J4/zk
        6xYpxwxH5hUy7+8nm1AI9n7wkLwQxo/35GTPBvJimYeG07iGWOTc+D65hr8d1sSgvwJqIFJFU04CB
        iCYGvsxCdwj55/OC2jrXUzew16x/8T0/Q0IqsOh+3GfYEIsyUN3Up8YFe3sWExGg+Rvprfn+3n0SD
        J+gjXhBA49JvoJYFMX6NYlf8sZ4N8f7pVa09GIjIT/bnPBCsywYAgGDD+z+BaMUTvzcAO/GkQMEMt
        UeLfi1YA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jz1Rn-0006yp-9q; Fri, 24 Jul 2020 11:25:30 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jz1Ri-0004GU-W5; Fri, 24 Jul 2020 11:25:23 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 24 Jul 2020 11:25:20 -0600
Message-Id: <20200724172520.16318-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724172520.16318-1-logang@deltatee.com>
References: <20200724172520.16318-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, maxg@mellanox.com, sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 9/9] nvmet-passthru: Introduce NVMet passthru Kconfig option
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch updates KConfig file for the NVMeOF target where we add new
option so that user can selectively enable/disable passthru code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[logang@deltatee.com: fixed some of the wording in the help message]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 4474952d64c6..8056955e652c 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -16,6 +16,18 @@ config NVME_TARGET
 	  To configure the NVMe target you probably want to use the nvmetcli
 	  tool from http://git.infradead.org/users/hch/nvmetcli.git.
 
+config NVME_TARGET_PASSTHRU
+	bool "NVMe Target Passthrough support"
+	depends on NVME_TARGET
+	depends on NVME_CORE=y || NVME_CORE=NVME_TARGET
+	help
+	  This enables target side NVMe passthru controller support for the
+	  NVMe Over Fabrics protocol. It allows for hosts to manage and
+	  directly access an actual NVMe controller residing on the target
+	  side, incuding executing Vendor Unique Commands.
+
+	  If unsure, say N.
+
 config NVME_TARGET_LOOP
 	tristate "NVMe loopback device support"
 	depends on NVME_TARGET
-- 
2.20.1

