Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4430EC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0644F2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="k3TcKpX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBZVNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:13:15 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.107]:45314 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727446AbgBZVNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:13:14 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id C69D1275E2D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:13:12 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 73zUj5BcdEfyq73zUjAxRi; Wed, 26 Feb 2020 15:13:12 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pfFaUhKSUuPWQQ+x7EmGEX71Qn52caOX7mUsVR1i56k=; b=k3TcKpX0wC75g73VOp+k8/+Zua
        ZmtyCoIJ5MoTfpVsIiL5SQ7A4S4rNmaaWpTAz6IqbxsNckv9U34qFm5Ix0Mi9lYp5hfiiVdMca8HL
        Cn1xFqYYFTXW72pwea3mMqvG80ROLNZ6g1Z/+UW/7CI/ikI5cjrwHt9t8Mpe3CHAepiRsgqlhsSs+
        EW1xe2jdTe+uhX3tAFPXsvjikT9Sx1AQUI+4YKZjbzpIVaDBbWcFyV90Hx5OxpoGmT0WGauaxxE9B
        tX/A4yChTXLHNMePpE2iTJ8yipIMoupKVQOj2kLyWwvdOUYtrC73eaiC4bH4I05UlwbMXMWo0b76i
        5n0RpuvA==;
Received: from [200.39.29.129] (port=47544 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j73zS-000iA7-Nm; Wed, 26 Feb 2020 15:13:11 -0600
Date:   Wed, 26 Feb 2020 15:16:02 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] nvme: Replace zero-length array with flexible-array member
Message-ID: <20200226211602.GA18590@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.39.29.129
X-Source-L: No
X-Exim-ID: 1j73zS-000iA7-Nm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.39.29.129]:47544
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/nvme/host/fc.c       | 2 +-
 drivers/nvme/host/lightnvm.c | 2 +-
 include/linux/nvme.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5a70ac395d53..6806a19707fb 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -96,7 +96,7 @@ struct nvme_fc_fcp_op {
 struct nvme_fcp_op_w_sgl {
 	struct nvme_fc_fcp_op	op;
 	struct scatterlist	sgl[NVME_INLINE_SG_CNT];
-	uint8_t			priv[0];
+	uint8_t			priv[];
 };
 
 struct nvme_fc_lport {
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index ec46693f6b64..3002bf972c6b 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -171,7 +171,7 @@ struct nvme_nvm_bb_tbl {
 	__le32	tdresv;
 	__le32	thresv;
 	__le32	rsvd2[8];
-	__u8	blk[0];
+	__u8	blk[];
 };
 
 struct nvme_nvm_id20_addrf {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d5189f46cb1..6ee80a44ed4f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1177,7 +1177,7 @@ struct nvmf_disc_rsp_page_hdr {
 	__le64		numrec;
 	__le16		recfmt;
 	__u8		resv14[1006];
-	struct nvmf_disc_rsp_page_entry entries[0];
+	struct nvmf_disc_rsp_page_entry entries[];
 };
 
 enum {
-- 
2.25.0

