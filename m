Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E9C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD562173E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588878028;
	bh=R5UAo0X2wUIkcPu2bAHYaMr9+zALVRcFirsDyRQuvAA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eK8sukP9kkFw9KEMzcKj9r5Cfnp3yZvrZipvQaaihnyzSevjylya6jD6rSZnV5E68
	 n08YfCTXxbevUJntpC09NJI6YBDSt7IrtAinId71Bi5OBgAVvtzqXR797kRXGnNlwN
	 iWK/reS45d9sLiqLLgDSydCdPxDlh1YA8SVEa2cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEGTA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:00:26 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672612083B;
        Thu,  7 May 2020 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878025;
        bh=R5UAo0X2wUIkcPu2bAHYaMr9+zALVRcFirsDyRQuvAA=;
        h=Date:From:To:Cc:Subject:From;
        b=qn6cRKwYPaaWKY02MVF/8V8omrkz4xrVRvn2mw1GgLEW7gI9lUssG9pLlKKk2VhXv
         5lnk1EO5WSRyv2MHzvSJVPLTRNEPsu7qB/FSmbaEWWBcjh6O7k+szJmk8I8vkNwwhZ
         wlNH83fi8M3q2rmCoHlvy3jMpsr/dYfz/ln8iMIc=
Date:   Thu, 7 May 2020 14:04:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: Replace zero-length array with flexible-array
Message-ID: <20200507190452.GA15449@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nvme/host/lightnvm.c |    2 +-
 include/linux/nvme.h         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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

