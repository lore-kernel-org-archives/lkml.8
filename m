Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36412C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1112E21835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879249;
	bh=yUeqqtw92TMd9QVAQWtIq+r0VD45Nr+xnNAHOagDNJU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TPnOCW46X51JZxvaoxkGtt44h41UzxbWT5mbg+FNeSBGuyNO5w6UJsQvvGrwvX//Z
	 lbecKiLpcfMWQ4WQoq+4HvLOi9bZY6HPmqhg+uEWxqdigj/+OEBSdpiu92GCC3+ROK
	 RNAr/+UqnRRDrYKFKXrqncimm8hKTiVkGhPAO/gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgEGTUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgEGTUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:20:46 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8020208D6;
        Thu,  7 May 2020 19:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879246;
        bh=yUeqqtw92TMd9QVAQWtIq+r0VD45Nr+xnNAHOagDNJU=;
        h=Date:From:To:Cc:Subject:From;
        b=oVKuosy/ZXzrS2uzu7QnZP4w33E0rmSrAfBKo+Bj/eWcD/oESVEZrXc637mDt8Ub0
         ECQVP+zUL8Eg6hKxnx+XQxnv35gKvmBKF47w3BWhFPzEEEFOURH0V5vAoFkFG+Uh7U
         0SR6kMHKkR8G4r6cb90zB8mCE2Cq3c+obYyLoEEk=
Date:   Thu, 7 May 2020 14:25:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: tegra-apb: Replace zero-length array with
 flexible-array
Message-ID: <20200507192512.GA16537@embeddedor>
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
 drivers/dma/tegra20-apb-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index f6a2f42ffc51..a42c0b4d14ac 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -225,7 +225,7 @@ struct tegra_dma {
 	u32				global_pause_count;
 
 	/* Last member of the structure */
-	struct tegra_dma_channel channels[0];
+	struct tegra_dma_channel channels[];
 };
 
 static inline void tdma_write(struct tegra_dma *tdma, u32 reg, u32 val)

