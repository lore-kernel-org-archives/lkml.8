Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A5AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B520809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596044722;
	bh=faoLPenJ+jsG/EOurd6pdwdRUYNqxkrOE0dBjSfVSn4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=a8A4lPSI8Vmri0uEppW9oJbd2sL/6Q+PHttAWKw4nptqhAjHmJLJT8wGik0cl77UJ
	 mCthz76XWt+QsZUwDCXHpdZECHiXfg7Nx8AH/yll2afZEutmTCJoTRIh1TY0Viuram
	 Yb7Yxw4Ka9yujj9ynH9RP8UljuQEBGokpDFS/Sqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgG2RpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2RpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:45:20 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4C4B2075F;
        Wed, 29 Jul 2020 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596044720;
        bh=faoLPenJ+jsG/EOurd6pdwdRUYNqxkrOE0dBjSfVSn4=;
        h=From:To:Cc:Subject:Date:From;
        b=oOUaLFt8N1EEKQkijbyUXGEDxihtcH5tRWQWKmiMVmPyIa+ZxuhAQwnRQ11FTxOzS
         VCguvzLvw5ZVBk57GLBbAeiWy5yjbUF9xndHcI3P9AYjz83r0UhNzmqpIsu//4uefW
         Jcy13Nnep8krZDSLe9d8GdJ1Ede3N7+xr5ULvbQM=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-edac@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        thor.thayer@linux.intel.com
Subject: [PATCH] MAINTAINERS: edac: socfpga: transfer SoCFPGA EDAC maintainership
Date:   Wed, 29 Jul 2020 12:45:11 -0500
Message-Id: <20200729174511.4256-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thor Thayer is leaving Intel and will no longer be able to maintain the
EDAC for SoCFPGA, thus transfer maintainership to Dinh Nguyen.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0569cf304ca..c53fc9febf12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2466,7 +2466,7 @@ S:	Maintained
 F:	drivers/clk/socfpga/
 
 ARM/SOCFPGA EDAC SUPPORT
-M:	Thor Thayer <thor.thayer@linux.intel.com>
+M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/edac/altera_edac.
 
-- 
2.17.1

