Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAA72075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="coWKfw7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG2TKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:10:19 -0400
Received: from ale.deltatee.com ([204.191.154.188]:53204 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2TKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ytNmU6XECJ6mse7dyEPBYBvTEidvGF6L8NfDouGCEKo=; b=coWKfw7kgDX6kPpKypL29C8i6c
        2UjCxfqsiR6FV8nDg6idbi7pN84McLwfQFl6SPR6ihkO7AGoiosPTcetEGznhcvc7eB+yP/VZU9TW
        gDRGwiioVibCBct9ai45bsHWxT77Bsx4fBZ5ZYKZmwzJva1pOffp1X2wY0WrX2tNzaQDHqDVLY8be
        fILaR3F8/UFrkDNddHzsIf3dtDF863P+5iIpKBABTygGcYhu1+5ZcRceDSEET3LIeqWs1u+nl9t6j
        cR4J8t1hSdW3dxBV1Y0d3TzaI5m5x7TH4LsV8ghmc8BxNYdzR31VwpAvHqo9mXHmV3SXXIZdYA0/W
        4NQloHhw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0rSz-0007XN-DQ; Wed, 29 Jul 2020 13:10:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0rSt-0001B4-12; Wed, 29 Jul 2020 13:10:11 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 29 Jul 2020 13:10:09 -0600
Message-Id: <20200729191009.4485-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] nvmet-passthru: Reject commands with non-sgl flags set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any command with a non-SGL flag set (like fuse flags) should be
rejected.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---

Note: this patch may be squashed with the patch noted in the fixes
tag, currently in nvme-5.9.

 drivers/nvme/target/passthru.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 89d91dc999a6..f69c3ac82e58 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -326,6 +326,10 @@ static u16 nvmet_setup_passthru_command(struct nvmet_req *req)

 u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
 {
+	/* Reject any commands with non-sgl flags set (ie. fused commands) */
+	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
+		return NVME_SC_INVALID_FIELD;
+
 	switch (req->cmd->common.opcode) {
 	case nvme_cmd_resv_register:
 	case nvme_cmd_resv_report:
@@ -396,6 +400,10 @@ static u16 nvmet_passthru_get_set_features(struct nvmet_req *req)

 u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 {
+	/* Reject any commands with non-sgl flags set (ie. fused commands) */
+	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
+		return NVME_SC_INVALID_FIELD;
+
 	/*
 	 * Passthru all vendor specific commands
 	 */

base-commit: b6cec06d19d90db5dbcc50034fb33983f6259b8b
--
2.20.1
