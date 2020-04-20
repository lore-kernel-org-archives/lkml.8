Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E398C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1742C218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgDTQrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:47:22 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43064 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgDTQrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:47:18 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jQZZb-0008F4-BR; Mon, 20 Apr 2020 10:47:12 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jQZZa-0005dl-63; Mon, 20 Apr 2020 10:47:06 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 20 Apr 2020 10:46:55 -0600
Message-Id: <20200420164700.21620-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420164700.21620-1-logang@deltatee.com>
References: <20200420164700.21620-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, maxg@mellanox.com, sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v12 4/9] nvmet-passthru: Introduce NVMet passthru Kconfig option
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
---
 drivers/nvme/target/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index d7f48c0fb311..1ef775fa0048 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -15,6 +15,18 @@ config NVME_TARGET
 	  To configure the NVMe target you probably want to use the nvmetcli
 	  tool from http://git.infradead.org/users/hch/nvmetcli.git.
 
+config NVME_TARGET_PASSTHRU
+	bool "NVMe Target Passthrough support"
+	depends on NVME_CORE
+	depends on NVME_TARGET
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

