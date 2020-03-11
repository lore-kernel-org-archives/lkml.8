Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1968C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D4C21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583929745;
	bh=gJT5naPN5Xn9NuiSUHLGKB78VjoNV2j8Vc4s7/Pwl3Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=O8LCEpuxwq0OPvH9/daDrjJTyV0fY42dxQZLR0kLZgvSNK/Wfb4mSLUXjyGBgDVI/
	 N52Pc6CPFy3ezcIveUdOTY02jXXylo+HOf8WaBeJGDV/GL0YZXGVvXdnf02pAIm9ZK
	 yVomk0YL8EaswwfBZyzNVmUxqDgBJKRvLUCAPEKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgCKM3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbgCKM3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:29:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474DC20873;
        Wed, 11 Mar 2020 12:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583929744;
        bh=gJT5naPN5Xn9NuiSUHLGKB78VjoNV2j8Vc4s7/Pwl3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=2r9ZdH/Uf9CHWt6Dwx4soOHyCz1JoKpNbGK2MFzoWA3SLuuDdjBf+kYA51lz8dQ1x
         jSvHq7u56KXQG61STSP5VXR4VXVWX2n1c7Qe++IxxTT2K4MG06IuRdVtNmv3VISrWB
         5wBtQQmnQWGCnaGq2yHTmWJwLkBXwN0A2sFP+HRs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: [PATCH rdma-next] MAINTAINERS: Clean RXE section and add Zhu as RXE maintainer
Date:   Wed, 11 Mar 2020 14:28:56 +0200
Message-Id: <20200311122856.16716-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Zhu Yanjun contributed many patches to RXE and expressed genuine
interest in improve RXE even more. Let's add him as a maintainer.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6fbdf354d34..83b420d76f43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15418,11 +15418,9 @@ F:	drivers/infiniband/sw/siw/
 F:	include/uapi/rdma/siw-abi.h

 SOFT-ROCE DRIVER (rxe)
-M:	Moni Shoua <monis@mellanox.com>
+M:	Zhu Yanjun <yanjunz@mellanox.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	https://github.com/SoftRoCE/rxe-dev/wiki/rxe-dev:-Home
-Q:	http://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/sw/rxe/
 F:	include/uapi/rdma/rdma_user_rxe.h

--
2.24.1

