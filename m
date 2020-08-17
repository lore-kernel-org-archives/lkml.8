Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF1F2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692742;
	bh=3LUiod+Cqih3pYIxq7RAyAbqMyx3soGj+1jvyCfTdb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDON9/OqimQjTN4r2Mw8jmyaZCc5o6Or4qeMekjErHU4UOHYWdSA5Gxal8maOn8QX
	 OIfJQskLKzyf4D0BTebDt5RxQP+/D2T8Vp2NgOtGxBMVfWxHUCLYAZikHOGooTv3vL
	 MoHrsEw6Phu1r5KMJRdaN7g9ry9fEHQrpXpYxXM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbgHQTcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730209AbgHQPb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:31:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDCAC208E4;
        Mon, 17 Aug 2020 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678289;
        bh=3LUiod+Cqih3pYIxq7RAyAbqMyx3soGj+1jvyCfTdb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUcElCwNrQ9SFD2xFBjPO70j3Ir+jFsktnMIYYAvuyDg2j2lVVZoOYJnjfCQ08ERo
         wcugE2fM/Wi2ZbnEJE22Hfo7i/fDPse9GUKVJntcNFCzbnT+FNPVfpYuSX0Iqt/u2g
         RfAZncn4guDvzTs+Pjj3NLecNo3RFo8ZnSJm567A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 281/464] powerpc/spufs: Fix the type of ret in spufs_arch_write_note
Date:   Mon, 17 Aug 2020 17:13:54 +0200
Message-Id: <20200817143847.216343777@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7c7ff885c7bce40a487e41c68f1dac14dd2c8033 ]

Both the ->dump method and snprintf return an int.  So switch to an
int and properly handle errors from ->dump.

Fixes: 5456ffdee666 ("powerpc/spufs: simplify spufs core dumping")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200610085554.5647-1-hch@lst.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 3b75e8f60609c..014d1c045bc3c 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -105,7 +105,7 @@ static int spufs_arch_write_note(struct spu_context *ctx, int i,
 	size_t sz = spufs_coredump_read[i].size;
 	char fullname[80];
 	struct elf_note en;
-	size_t ret;
+	int ret;
 
 	sprintf(fullname, "SPU/%d/%s", dfd, spufs_coredump_read[i].name);
 	en.n_namesz = strlen(fullname) + 1;
-- 
2.25.1



